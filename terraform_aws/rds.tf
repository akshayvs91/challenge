resource "aws_db_instance" "rds-instance" {
  allocated_storage      = 10
  db_subnet_group_name   = aws_db_subnet_group.rds-instance.id
  engine                 = "mysql"
  engine_version         = "8.0.20"
  instance_class         = "db.t2.micro"
  multi_az               = false
  name                   = "mydb"
  username               = "mysql"
  password               = "Pa$$word@123"
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.database-sg.id]
}

resource "aws_db_subnet_group" "rds-instance" {
  name       = "main"
  subnet_ids = [aws_subnet.private-subnet-1.id]

  tags = {
    Name = "DB Subnet Group"
  }
}