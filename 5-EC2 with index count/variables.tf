variable "instance_name" {
  type = list(string)
  default = [ "web-instance", "db-instance", "devops-instance" ]
}
variable "aws_region" {
  type = string
  default = "us-east-1"
}
variable "inst" {
  type = list(string)
  default = [ "t2.nano", "t2.micro", "t2.small" ]
}