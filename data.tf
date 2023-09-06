data "template_file" "init_jenkins" {
  template = file("${path.module}/userdata.tpl")
  vars = {
    efs_id = aws_efs_file_system.jenkins_home_efs.dns_name
  }
}
# Query all avilable Availability Zone
data "aws_availability_zones" "available" {}
# data.aws_availability_zones.available.names[0]
# is "ap-east-1a"
# data.aws_availability_zones.available.names[1]
# is "ap-east-1b"
# data "aws_availability_zone" "k-zone" {
#   name = "ap-east-1a"
# }