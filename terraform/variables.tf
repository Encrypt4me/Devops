# variable "env" {
#   type        = string
#   default     = "dev"
#   description = "environment to delpoy to"
# }

variable "image" { # desribing the images for containers for different environments 
  type        = map
  description = "image for container"
  default = {
    dev  = "nodered/node-red:latest"
    prod = "nodered/node-red:latest-minimal"
  }

}

variable "ext_port" { #Specifing the variable for the external port of the container
  type = map
  validation { # helps gives a condition and error message if we need some restrictions to the code for example the port mapping
    condition     = max(var.ext_port["dev"]...) <= 65535 && min(var.ext_port["dev"]...) >= 1980
    error_message = "The external port must be in range 0 - 65535."
  }
  validation { # helps gives a condition and error message if we need some restrictions to the code for example the port mapping
    condition     = max(var.ext_port["prod"]...) < 1980 && min(var.ext_port["prod"]...) >= 1880
    error_message = "The external port must be in range 0 - 65535."
  }
}

variable "int_port" {
  type    = number
  default = 1880
#   validation {
#     condition     = var.int_port == 1880
#     error_message = "The internal port must be 1880."
#   }
}

locals {
  container_count = length(lookup(var.ext_port, terraform.workspace))
}