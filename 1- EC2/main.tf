provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "Demo" {
  ami           = "ami-04a81a99f5ec58529"
  instance_type = "t2.micro"
  key_name = "mykeypair"
  tags = {
    Name = "demotf"
  }
}
output "ec2_id" {
  value = aws_instance.Demo.id
}