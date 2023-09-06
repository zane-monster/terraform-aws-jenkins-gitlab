# Ingress Security Port 22 (Inbound)
# Provides a security group rule resource
resource "aws_security_group_rule" "ssh_ingress_access" {
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.sg_allow_ssh_http.id
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = [var.cidr_blocks]
}
# Ingress Security Port 80 (Inbound)
resource "aws_security_group_rule" "http_ingress_access" {
  from_port         = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.sg_allow_ssh_http.id
  to_port           = 80
  type              = "ingress"
  cidr_blocks       = [var.cidr_blocks]
}
# Ingress Security Port 8080 (Inbound)
resource "aws_security_group_rule" "http8080_ingress_access" {
  from_port         = 8080
  protocol          = "tcp"
  security_group_id = aws_security_group.sg_allow_ssh_http.id
  to_port           = 8080
  type              = "ingress"
  cidr_blocks       = [var.cidr_blocks]
}
# Egress Security (Outbound)
resource "aws_security_group_rule" "egress_access" {
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.sg_allow_ssh_http.id
  to_port           = 0
  type              = "egress"
  cidr_blocks       = [var.cidr_blocks]
}
########################### Provides a security group resource
resource "aws_security_group" "sg_allow_ssh_http" {
  vpc_id = aws_vpc.devVPC.id
  name   = "${var.tag_project}_vpc_allow_ssh_http"
  tags = {
    Name    = "${var.tag_project}_sg_allow_ssh_http"
    project = var.tag_project
  }
}
