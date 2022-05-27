# Creation of ec2-server
resource "aws_instance" "server-1" {
  ami                    = "ami-0d5eff08a8b6ee632"
  instance_type          = "t2.micro"
  availability_zone      = "us-east-1a"
  vpc_security_group_ids = [aws_security_group.server1-sg.id]
  subnet_id              = aws_subnet.public-subnet.id
  user_data              = file("install_apache.sh")

  tags = {
    Name = "server-1"
  }

}
