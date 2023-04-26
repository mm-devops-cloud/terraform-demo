variable "path" {
  default = "./"

}

variable "content" {
  default = "MM"

}


variable "container_image" {
  type    = string
  default = "nginx:latest"

}


variable "container_count" {
  type    = number
  default = 3

} 