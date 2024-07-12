provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAW3MD6SVLKJAJC4PM"
  secret_key = "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"
}

# user in IAM
# single ec2 instance launches

resource "aws_instance" "jkec2_3" {
    ami = "ami-04b70fa74e45c3917"
    instance_type = "t2.micro"
    tags = {
      Name = "testPC0"
  }
}



# multiple ec2 instance launches
/*
resource "aws_instance" "ec2_instance" {
  count         = 10
  ami           = "ami-04b70fa74e45c3917"
  instance_type = "t2.micro"

  tags = {
    Name = "EC2-Instance-${count.index + 1}"
  }
}
*/

# EC2 instance in that region

# commands used
# terraform plan
# terraform apply
# terraform destroy -target aws_instance.jkec2_0
# terraform apply -destroy
