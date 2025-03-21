variable "aws_region" {
  default = "us-east-1"
}
variable "vpc_cidr" {
  default = "192.168.0.0/23"
}
variable "subnet1" {
  default = "192.168.0.0/25"
}
variable "subnet2" {
  default = "192.168.1.0/27"
}
variable "avzone1" {
  default = "us-east-1a"
}
variable "avzone2" {
  default = "us-east-1b"
}