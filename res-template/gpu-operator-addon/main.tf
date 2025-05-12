
resource "rafay_addon" "my-addon-gpu" {
  metadata {
    name    = var.addon_name
    project = var.project
    labels = {
      env  = "dev"
      name = "app"
    }
  }
  spec {
    namespace = var.namespace
    version   = var.addon_version
    artifact {
      type = var.resource_type
      artifact {
        catalog = var.catalog_data
        chart_name = var.chart_name
        chart_version = var.chart_version
      }
    }
    sharing {
      enabled = false
    }
  }
}

resource "rafay_blueprint" "my-blueprint-rt" {
    depends_on = [resource.rafay_addon.my-addon-gpu]
  metadata {
    name    = var.blueprint_name
    project = var.project
  }
  spec {
    version = var.blueprint_version
    base {
      name    = "default"
      version = "3.4.0"
    }
    custom_addons {
      name = var.addon_name
      version = var.addon_version
    }
    
    default_addons {
      enable_ingress    = false
      enable_logging    = false
      enable_monitoring = false
      enable_vm         = false
      enable_rook_ceph = false
      enable_cni = false
      monitoring {
        metrics_server {
          enabled = false
        }
        helm_exporter {
          enabled = false
        }
        kube_state_metrics {
          enabled = false
        }
        node_exporter {
          enabled = false
        }
        prometheus_adapter {
          enabled = false
        }
        resources {
          limits {
            cpu = "100m"
            memory= "200Mi"
          }
        }
      }
    }
    drift {
      action  = "Deny"
      enabled = true
    }
    sharing {
      enabled = false
    }
  }
}
