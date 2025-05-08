
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

resource "docker_network" "custom_net" {
  name = "ping_network"
}

resource "docker_image" "alpine" {
  name = "alpine:latest"
}

resource "docker_container" "linux_a" {
  name  = "linux_a"
  image = docker_image.alpine.name
  networks_advanced {
    name = docker_network.custom_net.name
  }
  volumes {
    host_path      = abspath("${path.module}/logs")
    container_path = "/logs"
  }
  entrypoint = ["/bin/sh", "-c"]
  command = [
    <<-EOT
      apk add --no-cache iputils busybox-suid &&
      echo '* * * * * /ping.sh linux_b >> /logs/node_a_$(date +\%Y\%m\%d\%H\%M\%S).txt' | crontab - &&
      cp /ping.sh /ping_runner.sh &&
      chmod +x /ping_runner.sh &&
      crond -f
    EOT
  ]
  upload {
    content        = file("${path.module}/ping.sh")
    file           = "/ping.sh"
    executable     = true
  }
}

resource "docker_container" "linux_b" {
  name  = "linux_b"
  image = docker_image.alpine.name
  networks_advanced {
    name = docker_network.custom_net.name
  }
  volumes {
    host_path      = abspath("${path.module}/logs")
    container_path = "/logs"
  }
  entrypoint = ["/bin/sh", "-c"]
  command = [
    <<-EOT
      apk add --no-cache iputils busybox-suid &&
      echo '* * * * * /ping.sh linux_a >> /logs/node_b_$(date +\%Y\%m\%d\%H\%M\%S).txt' | crontab - &&
      cp /ping.sh /ping_runner.sh &&
      chmod +x /ping_runner.sh &&
      crond -f
    EOT
  ]
  upload {
    content        = file("${path.module}/ping.sh")
    file           = "/ping.sh"
    executable     = true
  }
}
