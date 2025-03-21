variable "ingress_port" {
  type = list(number)
  default = [ 22, 443, 80, 8080 ]
}

variable "egress_port" {
  type = list(number)
  default = [ 443, 8080, 80, 81 ]
}