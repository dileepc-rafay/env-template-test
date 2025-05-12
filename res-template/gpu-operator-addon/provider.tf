terraform {
  required_providers {
    rafay = {
      source = "RafaySystems/rafay"
      version = "1.1.46"
    }
  }
}

provider "rafay" {
  provider_config_file = "/Users/dileep/.rafay/cli/config.json"
}