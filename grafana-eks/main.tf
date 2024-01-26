terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0, < 6.0"
    }
  }
}

locals {
  namespace     = var.namespace
  release_name  = var.release_name
  bucket_prefix = "grafana"
  bucket_name   = module.s3_bucket.s3_bucket_id
  role_name     = local.bucket_name
  provider_url  = replace(var.oidc_provider_issuer_url, "https://", "")
}

data "aws_region" "grafana" {}
data "aws_caller_identity" "grafana" {}

module "iam" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "5.30.1"

  create_role                   = true
  role_name                     = "${local.release_name}-irsa-${random_id.grafana_rds.dec}"
  provider_url                  = local.provider_url
  oidc_fully_qualified_subjects = ["system:serviceaccount:${local.namespace}:${local.release_name}"]
  tags                          = var.tags
}

data "aws_iam_policy_document" "grafana" {
  statement {
    actions = [
      "s3:ListBucket",
      "s3:PutObject",
      "s3:GetObject"
    ]

    resources = [module.s3_bucket.s3_bucket_arn, "${module.s3_bucket.s3_bucket_arn}/*"]
  }
}

resource "aws_iam_role_policy" "grafana" {
  name = local.bucket_name
  role = module.iam.iam_role_name

  policy = data.aws_iam_policy_document.grafana.json
}

resource "aws_iam_role_policy_attachment" "additional" {
  count = length(var.additional_irsa_role_policy_arns)

  role       = module.iam.iam_role_name
  policy_arn = var.additional_irsa_role_policy_arns[count.index]
}

module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.1.0"

  bucket_prefix           = local.bucket_prefix
  force_destroy           = true
  block_public_policy     = true
  restrict_public_buckets = true
  versioning = {
    enabled = false
  }

  tags = var.tags
}

resource "random_id" "grafana_rds" {
  keepers = {
    release_name = local.release_name
  }

  byte_length = 10
}

resource "aws_security_group" "grafana_rds" {
  name_prefix = "grafana-rds"
  vpc_id      = var.vpc_id
}

resource "random_password" "grafana_db_password" {
  length  = 16
  special = false
}

module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "6.1.1"

  identifier                       = "grafana${random_id.grafana_rds.dec}"
  engine                           = "postgres"
  engine_version                   = "15.3"
  instance_class                   = var.database_instance_type
  allocated_storage                = var.database_storage_size
  storage_encrypted                = false
  db_name                          = "grafana${random_id.grafana_rds.dec}"
  username                         = "grafana"
  password                         = random_password.grafana_db_password.result
  manage_master_user_password      = false
  port                             = "5432"
  vpc_security_group_ids           = [aws_security_group.grafana_rds.id]
  maintenance_window               = "Mon:00:00-Mon:03:00"
  backup_window                    = "03:00-06:00"
  backup_retention_period          = 0
  tags                             = var.tags
  enabled_cloudwatch_logs_exports  = ["postgresql", "upgrade"]
  create_db_subnet_group           = true
  subnet_ids                       = var.database_subnets
  family                           = "postgres15"
  major_engine_version             = "15"
  skip_final_snapshot              = var.database_skip_final_snapshot
  final_snapshot_identifier_prefix = var.database_final_snapshot_identifier
  snapshot_identifier              = var.database_snapshot_identifier
  deletion_protection              = false
  auto_minor_version_upgrade       = var.database_auto_minor_version_upgrade
  allow_major_version_upgrade      = true
}

resource "aws_security_group_rule" "grafana-cluster-rules" {
  from_port                = 0
  protocol                 = "tcp"
  security_group_id        = aws_security_group.grafana_rds.id
  to_port                  = module.db.db_instance_port
  type                     = "ingress"
  source_security_group_id = var.source_security_group
}

module "grafana" {
  source = "../grafana"

  namespace                   = local.namespace
  release_name                = local.release_name
  database_host               = module.db.db_instance_address
  database_port               = module.db.db_instance_port
  database_password           = random_password.grafana_db_password.result
  database_user               = module.db.db_instance_username
  external_image_storage_type = "s3"
  external_image_storage = {
    bucket = local.bucket_name
    region = module.s3_bucket.s3_bucket_region
  }
  eks_iam_role_arn        = module.iam.iam_role_arn
  oauth_config            = var.oauth_config
  datasources             = var.datasources
  auth_disable_login_form = var.auth_disable_login_form
  ingress_cluster_issuer  = var.ingress_cluster_issuer
  root_domain             = var.root_domain
  ingress_enabled         = var.ingress_enabled
  ingress_hostnames       = var.ingress_hostnames
  plugins                 = var.plugins
}
