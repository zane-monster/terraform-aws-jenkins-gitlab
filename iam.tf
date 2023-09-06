# Jenkins administrators - IAM group
resource "aws_iam_group" "jenkins-administrators" {
  name = "ky-jenkins-administrators"
}

# Jenkins users - IAM group
resource "aws_iam_group" "jenkins-users" {
  name = "ky-jenkins-users"
}

# jenkins-admin - IAM user
resource "aws_iam_user" "jenkins-admin" {
  name = "ky-jenkins-admin"
}

# jenkins-dev-team - IAM user
resource "aws_iam_user" "jenkins-dev-team" {
  name = "ky-jenkins-dev-team"
}

# jenkins-test-team - IAM user
resource "aws_iam_user" "jenkins-test-team" {
  name = "ky-jenkins-test-team"
}

###############################

#admin user assignment to group - manage IAM Group membership for IAM Users
resource "aws_iam_group_membership" "jenkins-administrators-users-assignment" {
  name  = "ky-jekins-administrators-users"
  users = [aws_iam_user.jenkins-admin.id]
  group = aws_iam_group.jenkins-administrators.id
}

#non-admin users assignment to group
resource "aws_iam_group_membership" "jenkins-users-assignment" {
  name = "ky-jekins-users"
  users = [
    aws_iam_user.jenkins-dev-team.id,
    aws_iam_user.jenkins-test-team.id
  ]
  group = aws_iam_group.jenkins-users.id
}

# Attaches a Managed IAM Policy to user(s), role(s), and/or group(s)
resource "aws_iam_policy_attachment" "jenkins-administrators-policy" {
  name       = "ky-jenkins-administrators-policy"
  groups     = [aws_iam_group.jenkins-administrators.id]
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_policy_attachment" "jenkins-users-policy" {
  name       = "ky-jenkins-users-policy"
  groups     = [aws_iam_group.jenkins-users.id]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}
