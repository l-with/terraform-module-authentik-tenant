output "authentik_module_tenant_dummy" {
  description = "dummy output value (\"\") for creating dependencies from this module"
  value       = null_resource.authentik-bootstrap-tenant.triggers.authentik_module_tenant_dummy
}
