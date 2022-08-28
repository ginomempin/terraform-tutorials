output "image_id" {
  description = "ID of the Docker image"
  value       = docker_image.nginx.id
}

output "container_id_and_name" {
  description = "ID of the Docker container"
  value       = "${docker_container.nginx.id}:${docker_container.nginx.name}"
}

output "container_image" {
  description = "IP of the Docker container"
  value       = docker_container.nginx.image
}

output "container_user" {
  description = "USER:GROUP used to run the container"
  value       = docker_container.nginx.user
  sensitive   = true
}

output "container_env_vars" {
  description = "Environment Variables set on the Docker container"
  value       = docker_container.nginx.env
}
