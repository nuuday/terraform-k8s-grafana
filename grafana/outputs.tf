output "username" {
  value = lookup(data.kubernetes_secret.grafana_secret.data, "admin-user")
}

output "password" {
  value = lookup(data.kubernetes_secret.grafana_secret.data, "admin-password")
}
