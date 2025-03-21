resource "aws_instance" "dev" {
  count = var.is_dev_env == true ? 1 : 0  # 1:0 indicates count as 1 if condition is true
  ami           = "ami-0f34c5ae932e6f0e4"
  instance_type = "t2.nano"
  tags = {
    Name = "dev-ec2"
  }
}

resource "aws_instance" "prod" {
  count = var.is_dev_env == false ? 2 : 0  # 2:0 indicates count as 1 if condition is flase
  ami           = "ami-0f34c5ae932e6f0e4"
  instance_type = "t2.large"
  tags = {
    Name = "prod-ec2"
  } 
}


# when we run terraform plan it will ask var.is_dev_env will true and flase, if we put as true then dev instance will deploy
# if we put false then prod instance will deploy