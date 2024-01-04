variable "project" {
  default     = "test"
  description = "project name"
}


variable "region" {
  default     = "ap-south-1"
  description = "project region"
}

variable "access_key" {
  default = "XXXXXXXXXXXXXX"
  description = "access key"
}

variable "secret_key" {
  default = "XXXXXXXXXXXXXXXXXXXXXXXX"
  description = "secret key"
}

variable "instance_ami" {
  default = "ami-03f4878755434977f"
}

variable "instance_type" {
  default = "t2.micro"
}

locals {
  subnet_count = length(data.aws_availability_zones.available.names)
}

variable "vpc_cidr" {
  default = "172.32.0.0/16"
  description = "cidr block to create vpc"
}

locals {
  common_tags = {
    project     = var.project
  }
}
