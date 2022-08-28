terraform {
  required_providers {
    docker = {
      source  = "registry.terraform.io/kreuzwerker/docker"
      version = "~> 2.20.2"
    }
  }
}

# The default provider configuration
# If the "alias" property is unset, then Terraform assumes
# that this is the default provider to use.
provider "docker" {}

# An alternate provider configuration
# A resource needs to explicitly specify a "provider" property
# to indicate it needs to use this alternate provider config.
# Terraform interprets the first word of the resource type as
# local provider name ("docker_image" => "docker"). If the resource
# does not specify a provider property, Terraform assumes to use
# the default provider configuration.
provider "docker" {
  alias = "local_registry"
}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.latest
  name  = var.container_name

  privileged = var.privileged

  env = var.env_vars

  labels {
    label = "env"
    value = var.container_labels["env"]
  }
  labels {
    label = "version"
    value = var.container_labels["version"]
  }

  ports {
    internal = var.internal_port
    external = var.external_port[0]
  }

  healthcheck {
    test = ["curl localhost:${var.internal_port}"]
  }
}
