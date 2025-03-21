variable "aws_region" {
  type = string
  default = "us-east-1"
}
variable "vpc_cidr" {
  type = string
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
variable "business_divsion" {
  default = "myapp"
}
variable "environment" {
  type = string
  default = "dev"
}
variable "inst" {
  type = string
  default = "t2.micro"
  description = "This is the instance type of EC2"
  
}