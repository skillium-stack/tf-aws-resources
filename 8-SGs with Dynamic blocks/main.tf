resource "aws_security_group" "allow_tls" {
  name        = "dev_sg"

  dynamic "ingress" {
    for_each = var.ingress_port
    iterator = port     #method 1 to define from_port and to_port
    content {
        description      = "TLS from VPC"
        from_port        = port.value
        to_port          = port.value
        protocol         = "tcp"
        cidr_blocks      = ["98.87.76.56/32"]
    }
  }

  dynamic "egress" {
    for_each = var.egress_port
    content {
        from_port        = egress.value  #method 2 to define from_port and to_port
        to_port          = egress.value  # here egress.value egress is dynamic block name
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
    }
  }

  tags = {
    Name = "dev_sg"
  }
}