provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAW3MD6SVLL6CHZIOU"
  secret_key = "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"
}

resource "aws_eip" "lb" {
  domain = "vpc"
}


resource "aws_security_group" "allow_tls" {
  name        = "attribute firewall"
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "${aws_eip.lb.public_ip}/32" # string interpolation used here #${...}       
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

