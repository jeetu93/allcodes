provider "aws" {
  region     = "us-east-1"
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


### crearing ec2 instance mapping key_pair and security group to it
### those were already created 
/*
resource "aws_instance" "jkec2_4" {
    ami = "ami-04b70fa74e45c3917"
    instance_type = "t2.micro"
    vpc_security_group_ids = ["sg-01d2b54c02f4f0042"]
    key_name = "trr"
    tags = {
      Name = "testPC1"
  }
}
*/