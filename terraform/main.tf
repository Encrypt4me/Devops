
resource "null_resource" "dockervol" { # local-exec - provisioner enables the shell command written below.
  provisioner "local-exec" {
    # command to make the directory for the volume "noderedvol" '||' - this enables the true command - make terraform idempotent. The directory once created does
    # would not be replicated during another destroy and apply. sudo command gives the requierd pemissions to the folder for mounting the volume. 
    command = "mkdir noderedvol/ || true && sudo chmod u+w,o+w,g+r noderedvol/"
  }

}

module "image" {
  source = "./image"
  image_in = var.image[terraform.workspace]
}

# resource "docker_image" "nodered_image" { #docker iamge is the resource, and nodered_image is the spefic resource i am calling
#   name = lookup(var.image, terraform.workspace)
# }

resource "random_string" "random" { # random string to enable the naming sequence without writng all resources you wish to provision. DRY code
  count   = local.container_count
  length  = 4 # length of the integer , below are specifications
  special = false
  upper   = false
}

module "container"  {
  source = "./container"                          #same concepts with the containers
  count = local.container_count                                            # variable for count lsited in the variable file
  depends_on = [null_resource.dockervol]
  name_in  = join("-", ["nodered", terraform.workspace, random_string.random[count.index].result]) #naming sequence - joining nodered with the random count index stated above
  image_in = module.image.image_out #in the container we reference the image module output
  int_port_in = var.int_port #variable file for port allocation
  ext_port_in = lookup(var.ext_port, terraform.workspace)[count.index]
  container_path_in = "/data"                  #maping this volume path to the intended directory below 
  host_path_in     = "${path.cwd}/noderedvol" #path.cwd is interpolation that prints path and attaches to the mention directory - can check with terraform console
  
}
