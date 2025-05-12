resource "rafay_namespace"  "my-new-namespace2" {
  
  metadata {
    name = var.namespace
    project = var.project_name
  }
  spec {
    drift {
      enabled = false
    }
    placement {
      labels {
        key   = "rafay.dev/clusterName"
        value = var.cluster_name
      }
    }
  }
}


resource "rafay_eks_cluster" "eks-cluster-1" {
  cluster {
    kind = "Cluster"
    metadata {
      name    = var.cluster_name
      project = var.project_name
    }
    spec {
      type           = "eks"
      blueprint      = var.blueprint
      blueprint_version = var.blueprint_version
      cloud_provider = "dileep-aws"
      cni_provider   = "aws-cni"
      proxy_config   = {}
    }
  }
  cluster_config {
    apiversion = "rafay.io/v1alpha5"
    kind       = "ClusterConfig"
    metadata {
      name    = var.cluster_name
      region  = var.region
      version = "1.31"
    }
    iam {
      with_oidc = true
      service_accounts {
        metadata {
          name = "test-irsa"
          namespace = "default"
        }
        attach_policy = <<EOF
        {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": "ec2:Describe*",
          "Resource": "*"
        },
        {
          "Effect": "Allow",
          "Action": "ec2:AttachVolume",
          "Resource": "*"
        },
        {  
          "Effect": "Allow",
          "Action": "ec2:DetachVolume",
          "Resource": "*"
        },
        {
          "Effect": "Allow",
          "Action": ["ec2:*"],
          "Resource": ["*"]
            },
        {
          "Effect": "Allow",
          "Action": ["elasticloadbalancing:*"],
          "Resource": ["*"]
         }
       ]
    }
    EOF
      }
    }
    vpc {
      cidr = "192.168.0.0/16"
      cluster_endpoints {
        private_access = true
        public_access  = false
      }
      nat {
        gateway = "Single"
      }
    }
    node_groups {
      name       = "testing-dileep"
      ami_family = "AmazonLinux2"
      iam {
        iam_node_group_with_addon_policies {
          image_builder = true
          auto_scaler   = true
        }
      }
      instance_type    = "t3.large"
      desired_capacity = 1
      min_size         = 1
      max_size         = 2
      max_pods_per_node = 50
      version          = "1.31"
      volume_size      = 100
      volume_type      = "gp3"
      private_networking = true
    }
    addons {
      name = "vpc-cni"
      version = "latest"
    }
    addons {
      name = "kube-proxy"
      version = "latest"

    }
    addons {
      name = "coredns"
      version = "latest"
    }
  }
}
