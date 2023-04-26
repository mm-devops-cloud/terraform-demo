resource "local_file" "my_file" {
  content  = var.content
  filename = "./mm.txt"

}

output "content" {
  value = local_file.my_file.content

}



#----------------------------------------------------------------
variable "environment" {
  type    = string
  default = "dev"
}
# Start a container
resource "docker_container" "webserver" {
  for_each = {
    # here i use for_each to put multiple versions of image to test my application on it 
    cont1 = {
      name  = "nginx-latest"
      image = "linuxserver/nginx:latest"
    }

    cont2 = {
      name  = "nginx-1.22.1"
      image = "linuxserver/nginx:1.22.1"
    }
  }

  name  = join("-", [var.environment, each.value.name]) # here i edit name to be form for_each and use join to add "-" and use variables to make easy to change between dev and production environments
  image = each.value.image
  # count = var.container_count < 2 ? 2 : var.container_count # here i said if container count less than 2 put is 2 , if not less than 2 return the variable value for it 
  # https://developer.hashicorp.com/terraform/language/expressions/conditionals
}

# output "container_ip" {
#   value = docker_container.webserver.ip_address
# }

# output "container_id" {
#   value = docker_container.webserver.id
# }