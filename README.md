# Grafana running on Kubernetes with RDS and S3 backend
Grafana module for terraform. Grafana has been configured with GitHub Oauth support, and external image store using S3

## Usage
```
module "grafana" {
  source = "github.com/nuuday/terraform-k8s-grafana"

  database_subnets           = [ "database", "subnets" ]
  oauth_github_client_id     = "github-client-id"
  oauth_github_client_secret = "github-client-secret"
  oidc_provider_issuer_url   = ""
  source_security_group      = "security group source for connecting to the database"
  vpc_id                     = "VPC id"
}
```

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/nuuday/terraform-k8s-grafana/tags).

## Authors

* **Steffen F. Qvistgaard** - *Initial work* - [PurpleBooth](https://github.com/qvistgaard)

See also the list of [contributors](https://github.com/nuuday/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone whose code was used
* Inspiration
* etc
