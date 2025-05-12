variable cluster_name {
  type        = string
  default     = "eks-cluster-dileep-may-12"
  description = "Cluster name "
}

variable project_name {
  type        = string
  default     = "testing-dileep"
  description = "Project name"
}
variable region {
  type        = string
  default     = "us-west-2"
  description = "AWS region"
}

variable blueprint{
  type = string
}

variable blueprint_version{
  type = string
}
