# Creation of Allow all traffic Security Group on port 80
resource "aws_security_group" "elb-sg" {
  description = "Allow all HTTP inbound traffic"
  vpc_id      = aws_vpc.challenge-vpc.id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "elb-sg"
  }
}

# Creation of Security Group for ec2-instance server-1

resource "aws_security_group" "server-1-sg" {
  name        = "server-1-sg"
  description = "Allow inbound traffic from ALB"
  vpc_id      = aws_vpc.challenge-vpc.id

  ingress {
    description     = "Allow traffic from web layer"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.elb-sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "server-1-sg"
  }
}

# Creation of Security group for database

resource "aws_security_group" "database-sg" {
  name        = "database-SG"
  description = "Allow inbound traffic from application layer"
  vpc_id      = aws_vpc.challenge-vpc.id

  ingress {
    description     = "Allow traffic from application layer"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.server-1-sg.id]
  }

  egress {
    from_port   = 32768
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "database-sg"
  }
}
