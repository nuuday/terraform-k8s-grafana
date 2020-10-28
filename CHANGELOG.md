
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
