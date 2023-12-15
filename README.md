# Terraform for provisioning on AWS

## what will created
- checking `tf.apply.txt` for the latest info
- a ami of jenkins
- a vpc with public/private subnetworks
- a jenkins instance with SG, eip
- a gitlab instance with SG, eip

## Important
- Backup EFS before destroy.
  - EFS work with Jenkins for Site Reliability.
  - EFS **can not** work with Gitlab, because of IOPS performance.

## key pair
- **Do not** using terraform `tls_private_key` because of the private key in terrafrom status
- generate keys by aws web or `key-gen`

## Base Ami
- Current: Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type
  - `ami-0e5` (64-bit (x86))
- Deprecated: amzn2-ami-kernel-5.10-hvm-2.0.20230221.0-x86_64-gp2
  - `ami-068` - Owner: 9***
- Jenkins ami build by packer
- Gitlab ami form AWS AMI Market by Gitlab

## aws user authorized to perform 
- User: arn:aws:iam::9***:user/zane
- EFS
- iam:ListUsers
- iam:ListRoles
- iam:ListPolicies
- iam:ListEntitiesForPolicy
- iam:GetUser
- iam:GetGroup
- iam:RemoveUserFromGroup
- iam:DetachGroupPolicy
- iam:ListGroupsForUser
- iam:DeleteGroup
- iam:DeleteUser
- iam:CreateGroup
- iam:CreateUser
- iam:AddUserToGroup
- iam:GetPolicy
- iam:AttachGroupPolicy
- aws-marketplace:ViewSubscriptions
- iam:DetachUserPolicy

## 1 creat AMI for jenkins
1. run command
```sh
packer build -var "aws_access_key=" -var "aws_secret_key=" jenkins-ec2-ami-packer.json
```
2. Verify the output of packer command execution, and note the AMI ID:
```
==> Wait completed after 4 minutes 43 seconds
==> Builds finished. The artifacts of successful builds are:
--> amazon-ebs: AMIs were created:
ap-e***-1: ami-04b
```
## 2 create key paires for jenkins instances
  - key pair nemed `terraform-jenkins`
  - EC2 dashboard: `Network & Security` -> `Key Pairs` -> `Create key pair`, and save `terraform-jenkins.pem`

## 3 create a jenkins instance and a EFS
TODO: create EFS in a pre stage, for destroying independly
```sh
terraform fmt
terraform init
terraform validate
terraform plan -out tf.plan
terraform show -json tf.plan
terraform apply "tf.plan" > tf.apply.txt
terraform graph
```
## 4 mount EFS in jenkins instance
TODO: mount EFS by terrform userdata.tpl
TODO: add EFS to tab for restarting
```sh
# ssh to jenkins instance
ssh -i "terraform-jenkins.pem" ec2-user@ec2-<xxx>.ap-<xxx>.compute.amazonaws.com
sudo -s
sudo yum install -y nfs-utils amazon-efs-utils
# install aws cli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws configure
#Mount EFS Mount Access point
sudo mkdir /var/lib/jenkins
# sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 \
# fs-<efs-id>.efs.<region>.amazonaws.com:/ /var/lib/jenkins
# sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 fs-010ec00d25f66b895.efs.ap-east-1.amazonaws.com:/ /var/lib/jenkins
sudo mount -t efs -o tls,accesspoint=fsap-0e0de fs-010e:/ /var/lib/jenkins
echo "fs-010ec:/ /var/lib/jenkins efs _netdev,noresvport,tls,iam,accesspoint=fsap-0e0 0 0" >> /etc/fstab
mount -fav # test fstab, successfully
chown jenkins:jenkins /var/lib/jenkins/
chown jenkins:jenkins /var/log/jenkins/
chown jenkins:jenkins /var/cache/jenkins/
df -h
```

## 5 jenkins status
```sh
service jenkins status
service jenkins start
service jenkins status
# http://ec2-<xxx>.<xxx>.compute.amazonaws.com:8080
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```
- select jenkins plugins
- set jenkins key at local 

## 6 gitlab ce
- user of unbunt linux: ubuntu
- in gitlab, Username is root, password is your instance ID, click Sign in.

### ssl

### add a user
1. create a user
2. set user's password
3. when user first sign in, change password