# terraform-module-authentik-tenant

Terraform module which configures the default [authentik](https://goauthentik.io/docs/tenants) tenant.

Authentik comes with predefined resources. 
The anchor is the default tenant, which is marked as 
to be used for each domain that doesn't have a dedicated tenant.

As a consequence the 
[terraform-provider authentik](https://registry.terraform.io/providers/goauthentik/authentik) 
can not create a new tenant
to be used for each domain that doesn't have a dedicated tenant,
since there could only be one tenant with this characteristic.

This module changes the default tenant by a direct API call by 
[local-exec](https://www.terraform.io/language/resources/provisioners/local-exec) 
in a [null_resource](https://registry.terraform.io/providers/hashicorp/null).

The following code changes the default tenant to 
not be used for each domain that doesn't have a dedicated tenant.

```
module "tenant" {
  source                   = "l-with/authentik-tenant/module"
  version                  = ">= 0.0.3"
  authentik_url            = var.authentik_url
  authentik_token          = var.authentik_bootstrap_token
  authentik_tenant_default = false
}
 ```

The tenant is selected by the input variable `authentik_tenant_domain` which default value is `"authentik-default"`.

The module provides an output value `authentik_module_tenant_dummy` 
that depends on the null_resource with the local-exec.
The value is `""`.
You can use it to create an implicit dependency in every resource with a string value, 
for example a new 
[resource authentik_tenant](https://registry.terraform.io/providers/goauthentik/authentik/latest/docs/resources/tenant):

```
resource "authentik_tenant" "default" {
  domain           =  "${module.tenant.authentik_module_tenant_dummy}."
  default          = true
  branding_logo    = "/static/dist/assets/icons/icon_left_brand.svg"
  branding_favicon = "/static/dist/assets/icons/icon.png"
}
```