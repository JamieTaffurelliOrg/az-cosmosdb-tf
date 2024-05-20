variable "resource_group_name" {
  type        = string
  description = "Resource Group name to deploy to"
}

variable "location" {
  type        = string
  description = "Resource Group name to deploy to"
}

variable "cosmosdb_account_name" {
  type        = string
  description = "Cosmos DB account name"
}

variable "create_mode" {
  type        = string
  default     = "Default"
  description = "Creation mode, Default or Restore"
}

variable "kind" {
  type        = string
  default     = "GlobalDocumentDB"
  description = "Kind of Cosmos DB, GlobalDocumentDB, MongoDB or Parse"
}

variable "ip_range_filter" {
  type        = string
  default     = null
  description = "Allowed IP addresses on firewall"
}

variable "free_tier_enabled" {
  type        = bool
  default     = false
  description = "Enable free tier"
}

variable "analytical_storage_enabled" {
  type        = bool
  default     = true
  description = "Enable analytical storage"
}

variable "automatic_failover_enabled" {
  type        = bool
  default     = true
  description = "Enable auto failover"
}

variable "partition_merge_enabled" {
  type        = bool
  default     = false
  description = "Enable partition merging"
}

variable "public_network_access_enabled" {
  type        = bool
  default     = false
  description = "Enable access from public network"
}

variable "is_virtual_network_filter_enabled" {
  type        = bool
  default     = true
  description = "Filter access from subnets"
}

variable "key_vault_key_id" {
  type        = string
  default     = null
  description = "Key Vault ID for CMK"
}

variable "multiple_write_locations_enabled" {
  type        = bool
  default     = true
  description = "Enable writes to multiple locations"
}

variable "access_key_metadata_writes_enabled" {
  type        = bool
  default     = false
  description = "Allow writes to metadata resources using access keys"
}

variable "mongo_server_version" {
  type        = string
  default     = null
  description = "Version of Mongo"
}

variable "network_acl_bypass_for_azure_services" {
  type        = bool
  default     = false
  description = "Bypass network rules for trusted Azure services"
}

variable "network_acl_bypass_ids" {
  type        = list(string)
  default     = null
  description = "List of resource IDs for network ACLs"
}

variable "local_authentication_disabled" {
  type        = bool
  default     = true
  description = "Only allow auth from Entra ID"
}

variable "consistency_policy" {
  type = object(
    {
      consistency_level       = optional(string, "Session")
      max_interval_in_seconds = optional(number)
      max_staleness_prefix    = optional(number)
    }
  )
  description = "Replication consistency"
}

variable "geo_locations" {
  type = list(object({
    location          = string
    failover_priority = number
    zone_redundant    = optional(bool, true)
  }))
  default     = []
  description = "Locations for failover"
}

variable "capabilities" {
  type        = list(string)
  description = "Capablilites of the Cosmos DB"
}

variable "virtual_network_rules" {
  type = map(object(
    {
      id                                   = string
      ignore_missing_vnet_service_endpoint = optional(bool, false)
    }
  ))
  description = "Virtual network rules"
}

variable "analytical_storage_schema_type" {
  type        = string
  default     = "FullFidelity"
  description = "Type of analytical storage"
}

variable "total_throughput_limit" {
  type        = number
  description = "Max RU throughput"
}

variable "backup" {
  type = object(
    {
      type                = string
      tier                = optional(string)
      interval_in_minutes = optional(number)
      retention_in_hours  = optional(number)
      storage_redundancy  = string
    }
  )
  description = "BAckup Properties"
}

variable "cors_rule" {
  type = object(
    {
      allowed_headers    = list(string)
      allowed_methods    = list(string)
      allowed_origins    = list(string)
      exposed_headers    = list(string)
      max_age_in_seconds = number
    }
  )
  default     = null
  description = "CORS properties"
}

variable "restore" {
  type = object(
    {
      source_cosmosdb_account_id = string
      restore_timestamp_in_utc   = string
      database = optional(object({
        name             = string
        collection_names = optional(list(string))
      }))
      gremlin_database = optional(object({
        name        = string
        graph_names = optional(list(string))
      }))
      tables_to_restore = list(string)
    }
  )
  default     = null
  description = "CORS properties"
}

variable "private_endpoints" {
  type = list(object({
    name                            = string
    location                        = string
    subnet_id                       = string
    subresource_names               = list(string)
    private_service_connection_name = string
    private_dns_zone_ids            = list(string)
  }))
  default     = []
  description = "Cosmos DB private endpoints"
}

variable "sql_databases" {
  type = list(object({
    name       = string
    throughput = optional(number)
    autoscale_settings = optional(object({
      max_throughput = number
    }))
  }))
  default     = []
  description = "Cosmos Db SQL databases"
}

variable "log_analytics_workspace_name" {
  type        = string
  description = "Name of Log Analytics Workspace to send diagnostics"
}

variable "log_analytics_workspace_resource_group_name" {
  type        = string
  description = "Resource Group of Log Analytics Workspace to send diagnostics"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply"
}
