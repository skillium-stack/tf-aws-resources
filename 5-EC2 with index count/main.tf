resource "aws_instance" "web" {
  ami           = "ami-0f34c5ae932e6f0e4"
  #instance_type = "t2a.micro" => for every instance with same instance type
  instance_type = var.inst[count.index]  # for evry instnace different instance type
  tags = {
    # Name = "my-instance-${count.index}" => my-instance-0, my-instance-1, my-instance-2
    # Name = "my-instance-${count.index + 1}" => my-instance-1, my-instance-2, my-instance-3
    Name = var.instance_name[count.index] # Name => web-instance, db-instance, devops-instance
  }
  count = 3
}