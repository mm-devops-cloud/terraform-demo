resource "docker_container" "webserver-child" {
  ports {
    external = 8090
    internal = 80
  }
  name  = "my-container-child"
  image = "nginx:latest"
}