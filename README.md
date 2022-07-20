# terraform-module-authentik-tenant

Terraform module which configures the default [authentik](https://goauthentik.io/docs/tenants) tenant.

Authentik comes with predefined resources. 
The anchor is the default tenant, which is marked as 
to be used for each domain that doesn't have a dedicated tenant.

As a consequence with the 
[terraform provider authentik](https://registry.terraform.io/providers/goauthentik/authentik) 
it is not possible to create a new tenant
to be used for each domain that doesn't have a dedicated tenant,
since there could only be one tenant with this characteristic.

This module changes the default tenant by a direct API call.

The following code changes the default tenant to 
not be used for each domain that doesn't have a dedicated tenant.

```
module "tenant" {
  source                   = "l-with/authentik-tenant/module"
  version                  = "0.0.2"
  authentik_url            = var.authentik_url
  authentik_token          = var.authentik_bootstrap_token
  authentik_tenant_default = false
}
 ```

The tenant is selected by the input variable `authentik_tenant_domain`.