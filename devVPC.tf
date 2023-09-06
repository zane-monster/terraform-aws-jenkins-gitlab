##########################
# creates VPC, public and private subnet, 
# internet gateway, public route table, and 
# association between public subnet with public route table.
##########################

# Provides a VPC resource
resource "aws_vpc" "devVPC" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name    = "${var.tag_project}_vpc"
    project = var.tag_project
  }
}
# Public Subnet - Provides an VPC subnet resource
resource "aws_subnet" "public_subnet" {
  cidr_block              = var.public_cidr
  vpc_id                  = aws_vpc.devVPC.id
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[0]
  tags = {
    Name    = "${var.tag_project}_vpc_public_subnet"
    project = var.tag_project
  }
}
# Private Subnet - Provides an VPC subnet resource
resource "aws_subnet" "private_subnet" {
  cidr_block              = var.private_cidr
  vpc_id                  = aws_vpc.devVPC.id
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[0]
  tags = {
    Name    = "${var.tag_project}_vpc_private_subnet"
    project = var.tag_project
  }
}
# Creating Internet Gateway
# Provides a resource to create a VPC Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.devVPC.id
  tags = {
    Name    = "${var.tag_project}_vpc_igw"
    project = var.tag_project
  }
}
# Provides a resource to create a VPC routing table
resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.devVPC.id
  route {
    cidr_block = var.cidr_blocks
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name    = "${var.tag_project}_vpc_public_route"
    project = var.tag_project
  }
}
# Provides a resource to create an association 
# between a Public Route Table and a Public Subnet
resource "aws_route_table_association" "public_subnet_association" {
  route_table_id = aws_route_table.public_route.id
  subnet_id      = aws_subnet.public_subnet.id
  depends_on     = [aws_route_table.public_route, aws_subnet.public_subnet]
}
########### EIP
resource "aws_eip" "eip_jenkins" {
  vpc = true
  tags = {
    project = var.tag_project
  }
}
resource "aws_eip_association" "eip_assoc_jenkins" {
  instance_id   = aws_instance.jenkins-instance.id
  allocation_id = aws_eip.eip_jenkins.id
}
resource "aws_eip" "eip_gitlabce" {
  vpc = true
  tags = {
    project = var.tag_project
  }
}
resource "aws_eip_association" "eip_assoc_gitlab" {
  instance_id   = aws_instance.gitlabce-instance.id
  allocation_id = aws_eip.eip_gitlabce.id
}
########### EBS
# resource "aws_ebs_volume" "ebs_jenkins" {
#   availability_zone = data.aws_availability_zone.k-zone
#   size              = "100"
#   type              = "gp3"
#   throughput        = 125
#   iops              = "3000"
# }
# resource "aws_volume_attachment" "ebs_att_jenkins" {
#   device_name = "/dev/sdh"
#   volume_id   = aws_ebs_volume.ebs_jenkins.id
#   instance_id = aws_instance.jenkins-instance.id
# }
