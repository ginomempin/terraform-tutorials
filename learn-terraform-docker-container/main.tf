terraform {
  required_providers {
    docker = {
      source  = "registry.terraform.io/kreuzwerker/docker"
      version = "~> 2.13.0"
    }
  }
}

provider "docker" {}

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
