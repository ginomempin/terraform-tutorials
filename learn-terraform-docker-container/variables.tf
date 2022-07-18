variable "container_name" {
  description = "The name of the Docker container"
  type        = string
  default     = "TestContainer"
}

variable "container_labels" {
  description = "The labels to apply to the container (to be set by tfvars file)"
  type        = map(string)

  validation {
    condition     = contains(["dev", "stg", "prod"], var.container_labels["env"])
    error_message = "Invalid label for env: ${var.container_labels["env"]}"
  }
}

variable "privileged" {
  description = "Whether the container runs in privileged mode"
  type        = bool
  default     = false
}

variable "internal_port" {
  description = "The internal port"
  type        = number
  default     = 80
}

variable "external_port" {
  description = "The external port"
  type        = list(number)
  default = [
    8000,
    8080
  ]
}

variable "env_vars" {
  description = "Set of environment variables"
  type        = set(string)
  default     = ["AAA=1", "BBB=2", "CCC=3"]
}
