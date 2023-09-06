#!/bin/bash
sudo yum update -y
sudo yum install nfs-utils git amzn-efs-utils -y

#Mount EFS Mount Access point
sudo mkdir /var/lib/jenkins
sudo chown jenkins:jenkins /var/lib/jenkins
echo ${efs_id}
# sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${efs_id}:/ /var/lib/jenkins
sudo mount -t efs -o tls,accesspoint=fsap-0e0de796 fs-010ec00:/ /var/lib/jenkins
# sudo systemctl enable jenkins
# sudo systemctl start jenkins