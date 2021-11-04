terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker" # docker provider for the resources - docker images 
      version = "~> 2.15.0"
    }
  }
}
