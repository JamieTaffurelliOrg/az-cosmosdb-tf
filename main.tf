resource "azurerm_cosmosdb_account" "cosmosdb_account" {
  name                                  = var.cosmosdb_account_name
  location                              = var.location
  resource_group_name                   = var.resource_group_name
  minimal_tls_version                   = "Tls12"
  offer_type                            = "Standard"
  default_identity_type                 = "SystemAssignedIdentity"
  create_mode                           = var.create_mode
  kind                                  = var.kind
  enable_automatic_failover             = true
  ip_range_filter                       = var.ip_range_filter
  free_tier_enabled                     = var.free_tier_enabled
  analytical_storage_enabled            = var.analytical_storage_enabled
  automatic_failover_enabled            = var.automatic_failover_enabled
  partition_merge_enabled               = var.partition_merge_enabled
  public_network_access_enabled         = var.public_network_access_enabled
  is_virtual_network_filter_enabled     = var.is_virtual_network_filter_enabled
  key_vault_key_id                      = var.key_vault_key_id
  multiple_write_locations_enabled      = var.multiple_write_locations_enabled
  access_key_metadata_writes_enabled    = var.access_key_metadata_writes_enabled
  mongo_server_version                  = var.mongo_server_version
  network_acl_bypass_for_azure_services = var.network_acl_bypass_for_azure_services
  network_acl_bypass_ids                = var.network_acl_bypass_ids
  local_authentication_disabled         = var.local_authentication_disabled

  consistency_policy {
    consistency_level       = var.consistency_policy.consistency_level
    max_interval_in_seconds = var.consistency_policy.max_interval_in_seconds
    max_staleness_prefix    = var.consistency_policy.max_staleness_prefix
  }

  dynamic "geo_location" {
    for_each = { for k in var.geo_locations : k.location => k if k != null }

    content {
      location          = geo_location.location
      failover_priority = geo_location.failover_priority
      zone_redundant    = geo_location.zone_redundant
    }
  }

  dynamic "capabilities" {
    for_each = toset(var.capabilities)
    content {
      name = each.key
    }
  }

  dynamic "virtual_network_rule" {
    for_each = var.virtual_network_rules
    content {
      id                                   = virtual_network_rule.id
      ignore_missing_vnet_service_endpoint = virtual_network_rule.ignore_missing_vnet_service_endpoint
    }

  }

  dynamic "analytical_storage" {
    for_each = var.analytical_storage_enabled == true ? [] : [1]

    content {
      schema_type = var.analytical_storage_schema_type
    }
  }

  capacity {
    total_throughput_limit = var.total_throughput_limit
  }

  backup {
    type                = var.backup.type
    tier                = var.backup.tier
    interval_in_minutes = var.backup.interval_in_minutes
    retention_in_hours  = var.backup.retention_in_hours
    storage_redundancy  = var.backup.storage_redundancy
  }

  dynamic "cors_rule" {
    for_each = var.cors_rule == null ? {} : { "cors_rule" = var.cors_rule }

    content {
      allowed_headers    = cors_rule.value["allowed_headers"]
      allowed_methods    = cors_rule.value["allowed_methods"]
      allowed_origins    = cors_rule.value["allowed_origins"]
      exposed_headers    = cors_rule.value["exposed_headers"]
      max_age_in_seconds = cors_rule.value["max_age_in_seconds"]
    }
  }

  identity {
    type = "SystemAssigned"
  }

  dynamic "restore" {
    for_each = var.create_mode == "Restore" ? [] : [1]

    content {
      source_cosmosdb_account_id = var.restore.source_cosmosdb_account_id
      restore_timestamp_in_utc   = var.restore.restore_timestamp_in_utc

      dynamic "database" {
        for_each = var.restore.database == null ? {} : { "database" = var.restore.database }

        content {
          name             = var.restore.database.name
          collection_names = var.restore.database.collection_names
        }
      }

      dynamic "gremlin_database" {
        for_each = var.restore.gremlin_database == null ? {} : { "database" = var.restore.gremlin_database }

        content {
          name        = var.restore.gremlin_database.name
          graph_names = var.restore.gremlin_database.graph_names
        }
      }
      tables_to_restore = var.restore.tables_to_restore
    }
  }

  tags = var.tags
}

resource "azurerm_monitor_diagnostic_setting" "cosmosdb_account_diagnostics" {
  name                       = "${var.log_analytics_workspace_name}-security-logging"
  target_resource_id         = azurerm_cosmosdb_account.cosmosdb_account.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.logs.id

  enabled_log {
    category = "DataPlaneRequests"
  }

  enabled_log {
    category = "MongoRequests"
  }

  enabled_log {
    category = "QueryRuntimeStatistics"
  }

  enabled_log {
    category = "PartitionKeyStatistics"
  }

  enabled_log {
    category = "PartitionKeyRUConsumption"
  }

  enabled_log {
    category = "ControlPlaneRequests"
  }

  enabled_log {
    category = "CassandraRequests"
  }

  enabled_log {
    category = "GremlinRequests"
  }

  enabled_log {
    category = "TableApiRequests"
  }

  metric {
    category = "Requests"
    enabled  = true
  }
}

resource "azurerm_private_endpoint" "private_endpoint" {
  for_each            = { for k in var.private_endpoints : k.name => k if k != null }
  name                = each.key
  resource_group_name = var.resource_group_name
  location            = each.value["location"]
  subnet_id           = each.value["subnet_id"]

  private_service_connection {
    name                           = each.value["private_service_connection_name"]
    private_connection_resource_id = azurerm_cosmosdb_account.cosmosdb_account.id
    is_manual_connection           = false
    subresource_names              = each.value["subresource_names"]
  }

  private_dns_zone_group {
    name                 = "customdns"
    private_dns_zone_ids = each.value["private_dns_zone_ids"]
  }
}

resource "azurerm_cosmosdb_sql_database" "cosmosdb_sql_db" {
  for_each            = { for k in var.sql_databases : k.name => k if k != null }
  name                = each.value["name"]
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.cosmosdb_account.name
  throughput          = 400

  dynamic "autoscale_settings" {
    for_each = each.value["autoscale_settings"] == null ? {} : { "autoscale_settings" = each.value["autoscale_settings"] }

    content {
      max_throughput = autoscale_settings.value["max_throughput"]
    }
  }
}
