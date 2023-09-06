# aws keys
variable "aws_accesskey" {
  default     = ""
  description = "Enter Access Key"
}
variable "aws_secretkey" {
  default     = ""
  description = "Enter Secrete Key"
}
########################### env
variable "environment" {
  default = "development"
}
variable "tag_project" {
  default = "k"
}
########################### region
variable "apac_region" {
  default = "ap-east-1"
}
########################### VPC network
variable "cidr_blocks" {
  default = "0.0.0.0/0"
}
# Network Mask - 255.255.255.0 Addresses Available - 256
variable "vpc_cidr" {
  default = "10.0.1.0/24"
}
# Subnet 	Start Address 	End Address 	Network Address 	Broadcast Address
# 10.0.1.0/28	10.0.1.1	10.0.1.14	10.0.1.0	10.0.1.15
# 10.0.1.16/28	10.0.1.17	10.0.1.30	10.0.1.16	10.0.1.31
# 10.0.1.32/28	10.0.1.33	10.0.1.46	10.0.1.32	10.0.1.47
# 10.0.1.48/28	10.0.1.49	10.0.1.62	10.0.1.48	10.0.1.63
# 10.0.1.64/28	10.0.1.65	10.0.1.78	10.0.1.64	10.0.1.79
# 10.0.1.80/28	10.0.1.81	10.0.1.94	10.0.1.80	10.0.1.95
# 10.0.1.96/28	10.0.1.97	10.0.1.110	10.0.1.96	10.0.1.111
# 10.0.1.112/28	10.0.1.113	10.0.1.126	10.0.1.112	10.0.1.127
# 10.0.1.128/28	10.0.1.129	10.0.1.142	10.0.1.128	10.0.1.143
# 10.0.1.144/28	10.0.1.145	10.0.1.158	10.0.1.144	10.0.1.159
# 10.0.1.160/28	10.0.1.161	10.0.1.174	10.0.1.160	10.0.1.175
# 10.0.1.176/28	10.0.1.177	10.0.1.190	10.0.1.176	10.0.1.191
# 10.0.1.192/28	10.0.1.193	10.0.1.206	10.0.1.192	10.0.1.207
# 10.0.1.208/28	10.0.1.209	10.0.1.222	10.0.1.208	10.0.1.223
# 10.0.1.224/28	10.0.1.225	10.0.1.238	10.0.1.224	10.0.1.239
# 10.0.1.240/28	10.0.1.241	10.0.1.254	10.0.1.240	10.0.1.255
variable "public_cidr" {
  default = "10.0.1.0/28"
}
variable "private_cidr" {
  default = "10.0.1.16/28"
}
############################ instance type
variable "instance_type_jenkins" {
  default = "c5.xlarge"
}

variable "instance_type_gitlab" {
  default = "c5.xlarge"
}
############################ security group
variable "vpc_security_group_ids" {
  description = "security group"
  type        = list(string)
  default     = []
}
############################ key pairs
variable "key_name_jenkins" {
  description = "The key name that should be used for the jenkins instance"
  default     = "k-jenkins"
}
variable "key_name_gitlab" {
  description = "The key name that should be used for the gitlab instance"
  default     = "k-gitlab"
}