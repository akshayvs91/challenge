# Creation of VPC
resource "aws_vpc" "challenge-vpc" {
  cidr_block = "10.0.0.0/16"
  tag = {
    Name = "challege-vpc"
  }
}

# Creation of Public Subnet
resource "aws_subnet" "public-subnet-1" {
  vpc_id = aws_vpc.challenge-vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = "true"
  tag = {
    Name = "public-subnet"
  }
}

# Creation of Public Subnet
resource "aws_subnet" "public-subnet-2" {
  vpc_id = aws_vpc.challenge-vpc.id
  cidr_block = "10.0.10.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = "true"
  tag = {
    Name = "public-subnet"
  }
}

# Creation of Private Subnet
resource "aws_subnet" "private-subnet" {
  vpc_id = aws_vpc.challenge-vpc.id
  cidr_block = "10.0.11.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = "false"
  tag = {
    Name = "public-subnet"
  }
}

# Creation of Internet Gateway
resource "aws_internet_gateway" "challenge-igw" {
  vpc_id = aws_vpc.challenge-vpc.id
  tags = {
    Name = "challenge-igw"
  }
}

# Creation of route-table
resource "aws_route_table" "challenge-rt" {
  vpc_id = "aws_vpc.challenge-vpc.id"
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.challenge-igw.id
    }
  tags = {
    Name = "challenge-rt"
  }
}

# Subnet-Routetable association
resource "aws_route_table_association" "association-1" {
  subnet_id = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.challenge-rt.id
}

resource "aws_route_table_association" "association-2" {
  subnet_id = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.challenge-rt.id
}
