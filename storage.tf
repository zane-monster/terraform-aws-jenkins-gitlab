###########################
# creates EFS and security group for EFS
# Ingress Security Port 2049 (Inbound)
resource "aws_security_group" "sg_jenkins_efs" {
  name_prefix = "sg_jenkins_efs_"
  vpc_id      = aws_vpc.devVPC.id
  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = [var.cidr_blocks]
  }
  tags = {
    project = var.tag_project
  }
}
# Provides an Elastic File System (EFS) File System resource to store JENKINS_HOME
resource "aws_efs_file_system" "jenkins_home_efs" {
  creation_token = "jenkins_home_efs"
  tags = {
    Name    = "${var.tag_project}_jenkins_home"
    project = var.tag_project
  }
}
# Provides an Elastic File System (EFS) mount target
resource "aws_efs_mount_target" "jenkins_mount_target" {
  file_system_id  = aws_efs_file_system.jenkins_home_efs.id
  subnet_id       = aws_subnet.public_subnet.id
  security_groups = [aws_security_group.sg_jenkins_efs.id]
}
# Provides an Elastic File System (EFS) access point
resource "aws_efs_access_point" "jenkins_access_point" {
  file_system_id = aws_efs_file_system.jenkins_home_efs.id
  root_directory {
    path = "/"
  }
  tags = {
    project = var.tag_project
  }
}
