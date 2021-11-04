# output "container_name" {
#   value       = docker_container.nodered_container[*].name
#   description = "The name of the container"
# }

# output "ip_address" { #output with the ip address as the intended , with a specific sequence - ip_adress:port 
#   value       = [for i in docker_container.nodered_container[*] : join(":", [i.ip_address], i.ports[*]["external"])]
#   description = "The ip address of the external port of the container"

# }