data "aws_ami" "ubuntu" {   # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/instance
  most_recent = true

  owners = ["amazon"]   # if We have our own AMIs then we can go with [self] also.
  filter {
    name = "name"
    values = [ "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20230516" ]   # take reference from AWS console to select the ami
  }
}

output "ubuntu_ami_id" {
  value = data.aws_ami.ubuntu
}

resource "aws_instance" "server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  tags = {
    Name = "ubuntu_instance"
  }
}