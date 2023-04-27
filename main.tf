#import child module here
module "child-module" {
  source = "./child-module"
  
}

#----------------------------------------------------------------

# Start a container
resource "docker_container" "webserver" {

  ports {
    external = 8080
    internal = 80
  }
  name  = "my-container"
  image = "nginx:latest"
  # count = var.container_count < 2 ? 2 : var.container_count # here i said if container count less than 2 put is 2 , if not less than 2 return the variable value for it 
  # https://developer.hashicorp.com/terraform/language/expressions/conditionals
}


output "container_ip" {
  value = docker_container.webserver.network_data
}

# output "container_id" {
#   value = docker_container.webserver.bridge
# }