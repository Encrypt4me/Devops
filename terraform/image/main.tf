resource "docker_image" "nodered_image" { #docker iamge is the resource, and nodered_image is the spefic resource i am calling
  name = var.image_in
}