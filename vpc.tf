provider "aws" {
  region  = "us-east-1"
  profile = "default"
}
resource "aws_vpc" "ws1" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}
resource "aws_subnet" "ps1" {
  vpc_id     = aws_vpc.ws1.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "main"
  }
}
resource "aws_subnet" "pvts1" {
  vpc_id     = aws_vpc.ws1.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "main"
  }
}
resource "aws_internet_gateway" "ps1gw" {
  vpc_id = aws_vpc.ws1.id

  tags = {
    Name = "main"
  }
}
resource "aws_route_table" "ws1_rt" {
  vpc_id = aws_vpc.ws1.id

  route {
                   
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ps1gw.id
  }

  tags = {
    Name = "main"
  }
}
resource "aws_route_table_association" "rt_ws1" {
  subnet_id      = aws_subnet.ps1.id
  route_table_id = aws_route_table.ws1_rt.id
}
resource "aws_instance" "myws1" {
  ami           = "ami-07eaf2ea4b73a54f6"
  instance_type = "t2.micro"
}
                                                                                                                      10,1          Top
