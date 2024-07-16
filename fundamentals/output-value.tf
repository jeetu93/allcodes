provider "aws" {
  region     = "us-east-1"
}

resource "aws_eip" "lb" {
  domain   = "vpc"
}

### this will give us the desired output value along with resource creation
output "public_ip" {
  value = aws_eip.lb.public_ip
}

output "public_url" {
  value = "https://${aws_eip.lb.public_ip}:8080"
}

output "public_elb" {
  value = aws_eip.lb
}