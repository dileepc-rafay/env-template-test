variable project {
  type        = string
  default     = "testing-dileep"
  description = "project name"
}

variable addon_name {
    type    =  string
    default =  "my-addon-gpu"
    description = "Addon name"

}

variable namespace {
    type = string
    default = "test-rt"
    description = "namespace name"
}

variable addon_version {
    type = string
    default = "v1.0"
    description = "Addon version"
}

variable resource_type {
    type = string
    default = "Helm"
    description = "resource type"
}

variable catalog_data {
    type = string
    default = "default-helm"
    description = "catalog data"
}
variable chart_name {
    type = string
    default = "gpu-operator"
    description = "chart name"
}
variable chart_version {
    type = string
    default = "v25.3.0"
    description = "chart version"
}

variable blueprint_name {
    type = string
    default = "blueprint-rt"
    description = "blueprint name"
}

variable blueprint_version{
    type =  string
    default = "v1.0"
    description = "bleprint version"
}