terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 1.13"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.1"
    }
  }
}

locals {
  chart_name    = "grafana"
  chart_version = var.chart_version
  release_name  = var.release_name
  namespace     = var.namespace
  repository    = "https://grafana.github.io/helm-charts"

  grafana_ini = {
    server = {
      domain         = var.root_domain
      root_url       = "https://${var.root_domain}"
      enforce_domain = true
    }

    database = {
      type     = "postgres"
      host     = "${var.database_host}:${var.database_port}"
      name     = "grafana"
      user     = var.database_user
      ssl_mode = "require"
    }

    auth = {
      disable_login_form = var.auth_disable_login_form
      oauth_auto_login   = var.oauth_auto_login
    }

    "auth.basic" = {
      enabled = var.auth_enable_basic
    }

    "external_image_storage.${var.external_image_storage_type}" = var.external_image_storage

    users = {
      viewers_can_edit = true
    }
  }


  values = {
    ingress = {
      enabled = var.ingress_enabled
      hosts   = var.ingress_hostnames

      annotations = {
        "kubernetes.io/ingress.class" : var.ingress_class
        "cert-manager.io/cluster-issuer" : var.ingress_cluster_issuer
        "nginx.ingress.kubernetes.io/proxy-read-timeout" : "${var.ingress_read_timeout}"
      }

      tls = [
        {
          hosts      = var.ingress_hostnames
          secretName = "grafana-ingress-cert"
        }
      ]
    }

    envFromSecret = kubernetes_secret.grafana.metadata[0].name

    serviceAccount = {
      annotations = var.eks_iam_role_arn != null ? {
        "eks.amazonaws.com/role-arn" = var.eks_iam_role_arn
      } : {}
    }

    plugins = var.plugins

    datasources = {
      "datasources.yaml" = {
        apiVersion = 1
        datasources : var.datasources
      }
    }

    "grafana.ini" = merge(local.grafana_ini, var.oauth_config)
  }
}

resource "kubernetes_namespace" "grafana" {
  count = local.namespace == "kube-system" ? 0 : 1

  metadata {
    name = local.namespace
    annotations = {
      "ingress-whitelist" = join(",", var.ingress_hostnames)
    }
    labels = {
      "role/grafana" : "true"
      "role/system" : "true"
    }
  }
}

resource "kubernetes_secret" "grafana" {
  metadata {
    name      = "${local.release_name}-credentials"
    namespace = local.namespace
  }

  data = merge({
    GF_DATABASE_PASSWORD = var.database_password
  }, var.config_secrets)

  depends_on = [kubernetes_namespace.grafana]
}

data "kubernetes_secret" "grafana_secret" {
  depends_on = [helm_release.grafana-deploy]
  metadata {
    namespace = kubernetes_namespace.grafana[0].metadata[0].name
    name      = "grafana"
  }
}

resource "kubernetes_job" "grafana_createdb" {
  metadata {
    name      = "grafana-createdb"
    namespace = local.namespace
  }

  spec {
    template {
      metadata {
        annotations = {
          "sidecar.istio.io/inject" = "false"
        }
      }

      spec {
        container {
          name  = "grafana-createdb"
          image = "postgres:alpine"

          env {
            name  = "PGHOST"
            value = var.database_host
          }

          env {
            name  = "PGPORT"
            value = var.database_port
          }

          env {
            name  = "PGDATABASE"
            value = "postgres"
          }

          env {
            name  = "PGUSER"
            value = var.database_user
          }

          env {
            name = "PGPASSWORD"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.grafana.metadata[0].name
                key  = "GF_DATABASE_PASSWORD"
              }
            }
          }

          command = ["/bin/sh", "-c", "psql -tc \"SELECT 1 FROM pg_database WHERE datname = 'grafana'\" | grep -q 1 || psql -c 'CREATE DATABASE grafana'"]
        }
      }
    }
  }

  depends_on = [kubernetes_namespace.grafana]
}

resource "helm_release" "grafana-deploy" {
  name             = local.release_name
  chart            = local.chart_name
  version          = local.chart_version
  repository       = local.repository
  namespace        = local.namespace
  create_namespace = true

  wait   = var.wait
  values = [yamlencode(local.values), yamlencode(var.chart_values)]

  depends_on = [kubernetes_namespace.grafana]
}
