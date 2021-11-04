resource "docker_container" "nodered_container" {                          #same concepts with the containers # variable for count lsited in the variable file
  name  = var.name_in #naming sequence - joining nodered with the random count index stated above
  image = var.image_in #referenced from the root module main.tf 
  ports {
    internal = var.int_port_in #variable file for port allocation
    external = var.ext_port_in
  }
  volumes {
    container_path = var.container_path_in   
    host_path      = var.host_path_in 
  }
}