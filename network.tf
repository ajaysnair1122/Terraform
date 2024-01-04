resource "aws_vpc" "my-vpc" {
  cidr_block       = var.vpc_cid

  tags = {
    Name = "${local.common_tags.project}-vpc"
  }
}


resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "${local.common_tags.project}-igw"
  }
}


resource "aws_subnet" "subnet" {
  count                   = local.subnet_count
  vpc_id                  = aws_vpc.my-vpc.id
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = cidrsubnet(var.vpc_cidr, 4, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "${local.common_tags.project}-Subnet-public${count.index}"
  }
}


resource "aws_security_group" "my-sg" {
  name        = "Terraform_SG"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.my-vpc.id

  ingress {
    description      = "SSH Port"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

    ingress {
    description      = "Jenkins Port"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.common_tags.project}-SG"
  }
}