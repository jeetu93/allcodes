provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAW3MD6SVLKJAJC4PM"
  secret_key = "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"
}

resource "aws_eip" "lb" {
  domain   = "vpc"
}

