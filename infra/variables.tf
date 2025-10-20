variable "app_name" {
  type    = string
  default = "ms-saudacoes-aleatorias"
}

variable "service_name" {
  type    = string
  default = "saudacoes-aleatorias"
}

variable "instance_type" {
  type    = string
  default = "free"
}

variable "container_port" {
  type    = number
  default = 8080
}

# ADICIONE ESTA NOVA VARIÁVEL
variable "docker_image" {
  description = "The full name of the docker image, including tag."
  type        = string
}


