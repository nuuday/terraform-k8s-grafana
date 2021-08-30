
<a name="0.7.0"></a>
## [0.7.0](https://github.com/nuuday/terraform-aws-kubernetes-grafana/compare/0.6.11...0.7.0) (2021-08-30)

### Feat

* support Azure and upgrade to latest ([#19](https://github.com/nuuday/terraform-aws-kubernetes-grafana/issues/19))


<a name="0.6.11"></a>
## [0.6.11](https://github.com/nuuday/terraform-aws-kubernetes-grafana/compare/0.6.10...0.6.11) (2021-05-10)

### Chore

* upgrade postgresql rds instance to 12.6 ([#17](https://github.com/nuuday/terraform-aws-kubernetes-grafana/issues/17))


<a name="0.6.10"></a>
## [0.6.10](https://github.com/nuuday/terraform-aws-kubernetes-grafana/compare/0.6.9...0.6.10) (2021-05-03)

### Chore

* upgrade s3 bucket module to make it compatible with terraform 0.15

### Pull Requests

* Merge pull request [#16](https://github.com/nuuday/terraform-aws-kubernetes-grafana/issues/16) from nuuday/terraform-0.15-upgrade


<a name="0.6.9"></a>
## [0.6.9](https://github.com/nuuday/terraform-aws-kubernetes-grafana/compare/0.6.8...0.6.9) (2021-04-06)

### Chore

* move to helm provider 2.1

### Pull Requests

* Merge pull request [#15](https://github.com/nuuday/terraform-aws-kubernetes-grafana/issues/15) from nuuday/chore-helm-2-1


<a name="0.6.8"></a>
## [0.6.8](https://github.com/nuuday/terraform-aws-kubernetes-grafana/compare/0.6.7...0.6.8) (2021-03-12)

### Fix

* Use var.ingress_hostnames for ingress-whitelist annotation

### Pull Requests

* Merge pull request [#14](https://github.com/nuuday/terraform-aws-kubernetes-grafana/issues/14) from nuuday/fix-ingress-whitelist


<a name="0.6.7"></a>
## [0.6.7](https://github.com/nuuday/terraform-aws-kubernetes-grafana/compare/0.6.6...0.6.7) (2021-02-01)

### Fix

* Add ingress-whitelist annotation to the namespace ([#13](https://github.com/nuuday/terraform-aws-kubernetes-grafana/issues/13))


<a name="0.6.6"></a>
## [0.6.6](https://github.com/nuuday/terraform-aws-kubernetes-grafana/compare/0.6.5...0.6.6) (2021-01-29)

### Feat

* label namespace

### Pull Requests

* Merge pull request [#12](https://github.com/nuuday/terraform-aws-kubernetes-grafana/issues/12) from nuuday/label-namespace


<a name="0.6.5"></a>
## [0.6.5](https://github.com/nuuday/terraform-aws-kubernetes-grafana/compare/0.6.4...0.6.5) (2021-01-13)

### Fix

* Bump helm chart provider to 2.0


<a name="0.6.4"></a>
## [0.6.4](https://github.com/nuuday/terraform-aws-kubernetes-grafana/compare/0.6.3...0.6.4) (2020-12-14)

### Fix

* upgraded module versions


<a name="0.6.3"></a>
## [0.6.3](https://github.com/nuuday/terraform-aws-kubernetes-grafana/compare/0.6.2...0.6.3) (2020-12-14)

### Fix

* fixed required providers
* fixed required providers


<a name="0.6.2"></a>
## [0.6.2](https://github.com/nuuday/terraform-aws-kubernetes-grafana/compare/0.6.1...0.6.2) (2020-12-14)

### Fix

* fixed chart_values variable


<a name="0.6.1"></a>
## [0.6.1](https://github.com/nuuday/terraform-aws-kubernetes-grafana/compare/0.6.0...0.6.1) (2020-12-14)

### Fix

* added extra variable to allow freeform helm values


<a name="0.6.0"></a>
## [0.6.0](https://github.com/nuuday/terraform-aws-kubernetes-grafana/compare/0.5.1...0.6.0) (2020-10-28)

### Feat

* Add variable to prevent auto upgrade of database


<a name="0.5.1"></a>
## [0.5.1](https://github.com/nuuday/terraform-aws-kubernetes-grafana/compare/0.5.0...0.5.1) (2020-10-28)


<a name="0.5.0"></a>
## [0.5.0](https://github.com/nuuday/terraform-aws-kubernetes-grafana/compare/0.4.0...0.5.0) (2020-10-19)

### Feat

* added additional config secrets configuration variable


<a name="0.4.0"></a>
## [0.4.0](https://github.com/nuuday/terraform-aws-kubernetes-grafana/compare/0.3.0...0.4.0) (2020-10-19)

### Feat

* Added username and password outputs, and updated postgres engine to 12.3


<a name="0.3.0"></a>
## [0.3.0](https://github.com/nuuday/terraform-aws-kubernetes-grafana/compare/0.2.3...0.3.0) (2020-09-15)

### Feat

* Add wait variable to helm chart


<a name="0.2.3"></a>
## [0.2.3](https://github.com/nuuday/terraform-aws-kubernetes-grafana/compare/0.2.2...0.2.3) (2020-08-18)

### Fix

* don't lookup K8s namespaces to determine namespace creation


<a name="0.2.2"></a>
## [0.2.2](https://github.com/nuuday/terraform-aws-kubernetes-grafana/compare/0.2.1...0.2.2) (2020-08-14)

### Improvement

* allow additional policy ARNs to be attached the IRSA role


<a name="0.2.1"></a>
## [0.2.1](https://github.com/nuuday/terraform-aws-kubernetes-grafana/compare/0.2.0...0.2.1) (2020-08-14)

### Fix

* pin terraform-aws-* modules and support aws provider v3


<a name="0.2.0"></a>
## [0.2.0](https://github.com/nuuday/terraform-aws-kubernetes-grafana/compare/0.1.3...0.2.0) (2020-08-14)

### Feat

* allow data sources to be passed to the chart


<a name="0.1.3"></a>
## [0.1.3](https://github.com/nuuday/terraform-aws-kubernetes-grafana/compare/0.1.2...0.1.3) (2020-08-12)

### Chore

* precision in variable descriptions
* formatting

### Feat

* allow all OAuth configurations to be passed into `grafana.ini`

### Improvement

* only create Grafana namespace if it doesn't exist


<a name="0.1.2"></a>
## [0.1.2](https://github.com/nuuday/terraform-aws-kubernetes-grafana/compare/0.1.1...0.1.2) (2020-07-10)

### Fix

* formatting
* removed lint flow


<a name="0.1.1"></a>
## [0.1.1](https://github.com/nuuday/terraform-aws-kubernetes-grafana/compare/0.1.0...0.1.1) (2020-07-10)

### Fix

* formatting


<a name="0.1.0"></a>
## [0.1.0](https://github.com/nuuday/terraform-aws-kubernetes-grafana/compare/0.0.1...0.1.0) (2020-07-09)

### Feat

* Added configuration options for multiple domains
* Added lint workflow


<a name="0.0.1"></a>
## 0.0.1 (2020-07-06)

### Docs

* Change project title

### Feat

* Added changelog configuration
* added domain configuration
* added release procedure

### Fix

* Disabled special characters for password generation
* documentation
