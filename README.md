# az-cosmosdb-tf
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.6.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.104 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.104 |
| <a name="provider_azurerm.logs"></a> [azurerm.logs](#provider\_azurerm.logs) | ~> 3.104 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_cosmosdb_account.cosmosdb_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_account) | resource |
| [azurerm_cosmosdb_sql_database.cosmosdb_sql_db](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/cosmosdb_sql_database) | resource |
| [azurerm_monitor_diagnostic_setting.cosmosdb_account_diagnostics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_private_endpoint.private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_log_analytics_workspace.logs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_key_metadata_writes_enabled"></a> [access\_key\_metadata\_writes\_enabled](#input\_access\_key\_metadata\_writes\_enabled) | Allow writes to metadata resources using access keys | `bool` | `false` | no |
| <a name="input_analytical_storage_enabled"></a> [analytical\_storage\_enabled](#input\_analytical\_storage\_enabled) | Enable analytical storage | `bool` | `true` | no |
| <a name="input_analytical_storage_schema_type"></a> [analytical\_storage\_schema\_type](#input\_analytical\_storage\_schema\_type) | Type of analytical storage | `string` | `"FullFidelity"` | no |
| <a name="input_automatic_failover_enabled"></a> [automatic\_failover\_enabled](#input\_automatic\_failover\_enabled) | Enable auto failover | `bool` | `true` | no |
| <a name="input_backup"></a> [backup](#input\_backup) | BAckup Properties | <pre>object(<br>    {<br>      type                = string<br>      tier                = optional(string)<br>      interval_in_minutes = optional(number)<br>      retention_in_hours  = optional(number)<br>      storage_redundancy  = string<br>    }<br>  )</pre> | n/a | yes |
| <a name="input_capabilities"></a> [capabilities](#input\_capabilities) | Capablilites of the Cosmos DB | `list(string)` | n/a | yes |
| <a name="input_consistency_policy"></a> [consistency\_policy](#input\_consistency\_policy) | Replication consistency | <pre>object(<br>    {<br>      consistency_level       = optional(string, "Session")<br>      max_interval_in_seconds = optional(number)<br>      max_staleness_prefix    = optional(number)<br>    }<br>  )</pre> | n/a | yes |
| <a name="input_cors_rule"></a> [cors\_rule](#input\_cors\_rule) | CORS properties | <pre>object(<br>    {<br>      allowed_headers    = list(string)<br>      allowed_methods    = list(string)<br>      allowed_origins    = list(string)<br>      exposed_headers    = list(string)<br>      max_age_in_seconds = number<br>    }<br>  )</pre> | `null` | no |
| <a name="input_cosmosdb_account_name"></a> [cosmosdb\_account\_name](#input\_cosmosdb\_account\_name) | Cosmos DB account name | `string` | n/a | yes |
| <a name="input_create_mode"></a> [create\_mode](#input\_create\_mode) | Creation mode, Default or Restore | `string` | `"Default"` | no |
| <a name="input_free_tier_enabled"></a> [free\_tier\_enabled](#input\_free\_tier\_enabled) | Enable free tier | `bool` | `false` | no |
| <a name="input_geo_locations"></a> [geo\_locations](#input\_geo\_locations) | Locations for failover | <pre>list(object({<br>    location          = string<br>    failover_priority = number<br>    zone_redundant    = optional(bool, true)<br>  }))</pre> | `[]` | no |
| <a name="input_ip_range_filter"></a> [ip\_range\_filter](#input\_ip\_range\_filter) | Allowed IP addresses on firewall | `string` | `null` | no |
| <a name="input_is_virtual_network_filter_enabled"></a> [is\_virtual\_network\_filter\_enabled](#input\_is\_virtual\_network\_filter\_enabled) | Filter access from subnets | `bool` | `true` | no |
| <a name="input_key_vault_key_id"></a> [key\_vault\_key\_id](#input\_key\_vault\_key\_id) | Key Vault ID for CMK | `string` | `null` | no |
| <a name="input_kind"></a> [kind](#input\_kind) | Kind of Cosmos DB, GlobalDocumentDB, MongoDB or Parse | `string` | `"GlobalDocumentDB"` | no |
| <a name="input_local_authentication_disabled"></a> [local\_authentication\_disabled](#input\_local\_authentication\_disabled) | Only allow auth from Entra ID | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | Resource Group name to deploy to | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | Name of Log Analytics Workspace to send diagnostics | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_resource_group_name"></a> [log\_analytics\_workspace\_resource\_group\_name](#input\_log\_analytics\_workspace\_resource\_group\_name) | Resource Group of Log Analytics Workspace to send diagnostics | `string` | n/a | yes |
| <a name="input_mongo_server_version"></a> [mongo\_server\_version](#input\_mongo\_server\_version) | Version of Mongo | `string` | `null` | no |
| <a name="input_multiple_write_locations_enabled"></a> [multiple\_write\_locations\_enabled](#input\_multiple\_write\_locations\_enabled) | Enable writes to multiple locations | `bool` | `true` | no |
| <a name="input_network_acl_bypass_for_azure_services"></a> [network\_acl\_bypass\_for\_azure\_services](#input\_network\_acl\_bypass\_for\_azure\_services) | Bypass network rules for trusted Azure services | `bool` | `false` | no |
| <a name="input_network_acl_bypass_ids"></a> [network\_acl\_bypass\_ids](#input\_network\_acl\_bypass\_ids) | List of resource IDs for network ACLs | `list(string)` | `null` | no |
| <a name="input_partition_merge_enabled"></a> [partition\_merge\_enabled](#input\_partition\_merge\_enabled) | Enable partition merging | `bool` | `false` | no |
| <a name="input_private_endpoints"></a> [private\_endpoints](#input\_private\_endpoints) | Cosmos DB private endpoints | <pre>list(object({<br>    name                            = string<br>    location                        = string<br>    subnet_id                       = string<br>    subresource_names               = list(string)<br>    private_service_connection_name = string<br>    private_dns_zone_ids            = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Enable access from public network | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource Group name to deploy to | `string` | n/a | yes |
| <a name="input_restore"></a> [restore](#input\_restore) | CORS properties | <pre>object(<br>    {<br>      source_cosmosdb_account_id = string<br>      restore_timestamp_in_utc   = string<br>      database = optional(object({<br>        name             = string<br>        collection_names = optional(list(string))<br>      }))<br>      gremlin_database = optional(object({<br>        name        = string<br>        graph_names = optional(list(string))<br>      }))<br>      tables_to_restore = list(string)<br>    }<br>  )</pre> | `null` | no |
| <a name="input_sql_databases"></a> [sql\_databases](#input\_sql\_databases) | Cosmos Db SQL databases | <pre>list(object({<br>    name       = string<br>    throughput = optional(number)<br>    autoscale_settings = optional(object({<br>      max_throughput = number<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply | `map(string)` | n/a | yes |
| <a name="input_total_throughput_limit"></a> [total\_throughput\_limit](#input\_total\_throughput\_limit) | Max RU throughput | `number` | n/a | yes |
| <a name="input_virtual_network_rules"></a> [virtual\_network\_rules](#input\_virtual\_network\_rules) | Virtual network rules | <pre>map(object(<br>    {<br>      id                                   = string<br>      ignore_missing_vnet_service_endpoint = optional(bool, false)<br>    }<br>  ))</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->