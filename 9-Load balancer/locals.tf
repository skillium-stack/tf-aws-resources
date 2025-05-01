locals {
  subnets = {
    public-subnet-1 = {
      cidr = var.subnet_cidr[0]
      az   = var.availability_zone[0]
    }
    public-subnet-2 = {
      cidr = var.subnet_cidr[1]
      az   = var.availability_zone[1]
    }
  }
}
