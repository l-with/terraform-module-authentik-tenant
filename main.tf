resource "null_resource" "authentik-bootstrap-tenant" {
  provisioner "local-exec" {
    command = "${path.module}/authentik-bootstrap-tenant.sh"
    environment = {
      AUTHENTIK_URL                    = var.authentik_url
      AUTHENTIK_TOKEN                  = var.authentik_token
      AUTHENTIK_DEFAULT_TENANT_DOMAIN  = var.authentik_default_tenant_domain
      AUTHENTIK_DEFAULT_TENANT_DEFAULT = var.authentik_default_tenant_default
    }
  }
}