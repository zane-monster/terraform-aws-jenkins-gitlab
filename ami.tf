# Get latest AMI ID based on Filter
data "aws_ami" "amis_jenkins" {
  owners      = [""]
  most_recent = true
  filter {
    name   = "name"
    values = ["packer-jenkins*"]
  }
}
data "aws_ami" "amis_gitlabce" {
  owners      = [""]
  most_recent = true
  filter {
    name   = "name"
    values = ["GitLab CE*"]
  }
}
