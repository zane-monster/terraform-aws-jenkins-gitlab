### zone info
output "availability_zone" {
  value = data.aws_availability_zones.available.names[1]
}
### vpc, gateway, subnet, security_group
output "vpc_id" {
  value = aws_vpc.devVPC.id
}
output "aws_internet_gateway" {
  value = aws_internet_gateway.igw.id
}
output "public_subnet" {
  value = aws_subnet.public_subnet.id
}
output "security_group" {
  value = aws_security_group.sg_allow_ssh_http.id
}
### instance info of jenkins
output "jenkins_private_ips" {
  value = ["${aws_instance.jenkins-instance.*.private_ip}"]
}
output "jenkins_ami" {
  value = data.aws_ami.amis_jenkins.id
}
output "jenkins_instance" {
  value = aws_instance.jenkins-instance.id
}
output "jenkins_eip" {
  value = aws_eip.eip_jenkins.*.public_ip
}
output "jenkins_public_dns" {
  value = aws_instance.jenkins-instance.public_dns
}
### instance info of gitlab
output "gitlab_ips_private_ip" {
  value = ["${aws_instance.gitlabce-instance.*.private_ip}"]
}
output "gitlabce_ami" {
  value = data.aws_ami.amis_gitlabce.id
}
output "gitlabce_instance" {
  value = aws_instance.gitlabce-instance.id
}
output "gitlabce_eip" {
  value = aws_eip.eip_gitlabce.*.public_ip
}
output "gitlabce_public_dns" {
  value = aws_instance.gitlabce-instance.public_dns
}
