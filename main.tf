# resource "aws_instance" "instance" {
#     ami                    = data.aws_ami.centos.id
#     instance_type          = var.Instancetype
#     associate_public_ip_address = "true"
#     monitoring             = "true"
#     key_name = var.key_name
#     subnet_id  = var.subnet_id
#     vpc_security_group_ids = var.vpc_security_group_ids
#     tags = {
#         Name = var.name
#         Environment = var.environment
#         Business_Justification = var.bJustification
#         Reason = var.reason
#     }
#  }



# Create an jenkins instance with latest AMI
resource "aws_instance" "jenkins-instance" {
  ami                    = data.aws_ami.amis_jenkins.id
  instance_type          = var.instance_type_jenkins
  key_name               = var.key_name_jenkins
  vpc_security_group_ids = [aws_security_group.sg_allow_ssh_http.id]
  subnet_id              = aws_subnet.public_subnet.id
  user_data              = data.template_file.init_jenkins.rendered
  tags = {
    Name    = "${var.tag_project}_jenkins_instance"
    project = var.tag_project
  }
  root_block_device {
    volume_size           = "100"
    volume_type           = "gp3"
    delete_on_termination = true
  }
}

# Create an gitlab CE instance with officel AMI
resource "aws_instance" "gitlabce-instance" {
  ami                    = data.aws_ami.amis_gitlabce.id
  instance_type          = var.instance_type_gitlab
  key_name               = var.key_name_gitlab
  vpc_security_group_ids = [aws_security_group.sg_allow_ssh_http.id]
  subnet_id              = aws_subnet.public_subnet.id
  # user_data              = data.template_file.init_gitlab.rendered
  tags = {
    Name    = "${var.tag_project}_gitlab_instance"
    project = var.tag_project
  }
  root_block_device {
    volume_size           = "500"
    volume_type           = "gp3"
    delete_on_termination = true
  }
}