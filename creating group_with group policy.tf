provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_group_membership" "team" {
  name = "Test-Devops"

  users = [
    aws_iam_user.latha.name,
    
  ]

  group = aws_iam_group.group.name
}

resource "aws_iam_group" "group" {
  name = "Devops"
}
resource "aws_iam_user" "latha" {
  name = "latha_123"
  
}

resource "aws_iam_user_login_profile" "latha" {
  user    = aws_iam_user.latha.name
  password_reset_required = true
}

resource "aws_iam_account_password_policy" "strict" {
  minimum_password_length        = 8
  require_lowercase_characters   = true
  require_numbers                = true
  require_uppercase_characters   = true
  require_symbols                = true
  allow_users_to_change_password = true
}
resource "aws_iam_policy" "test" {
  name        = "test_policy"
  description = "My test policy"
  policy=jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:*",
                "s3-object-lambda:*"
            ],
            "Resource": "*"
        }
    ]
})
}

resource "aws_iam_group_policy_attachment" "test" {
  
  group      = aws_iam_group.group.name
  policy_arn = aws_iam_policy.test.arn
  
}
