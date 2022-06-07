# Creation of ec2-server
resource "aws_instance" "server-1" {
  ami                    = var.ec2_ami
  instance_type          = var.ec2_instance_type
  availability_zone      = "us-east-1a"
  vpc_security_group_ids = [aws_security_group.server1-sg.id]
  subnet_id              = aws_subnet.public-subnet.id

  tags = {
    Name = "server-1"
  }

}
