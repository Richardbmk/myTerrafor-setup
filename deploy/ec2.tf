resource "aws_instance" "example" {
  # Find the ami for the region you are deploying in the AWS Console
  ami           = "ami-07a0844029df33d7d"
  instance_type = "t2.micro"

  tags = {
    Name = "My first EC2 using Terraform"
  }
}