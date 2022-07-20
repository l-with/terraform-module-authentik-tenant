resource "null_resource" "authentik-bootstrap-tenant" {
  provisioner "local-exec" {
    command = "${path.module}/authentik-bootstrap-tenant.sh"
    environment = {
      AUTHENTIK_URL                    = var.authentik_url
      AUTHENTIK_TOKEN                  = var.authentik_token
      AUTHENTIK_DEFAULT_TENANT_DOMAIN  = var.authentik_tenant_domain
      AUTHENTIK_DEFAULT_TENANT_DEFAULT = var.authentik_tenant_default
    }
  }
  triggers = {
    authentik_url            = var.authentik_url
    authentik_token          = var.authentik_token
    authentik_tenant_domain  = var.authentik_tenant_domain
    authentik_tenant_default = var.authentik_tenant_default
  }
}