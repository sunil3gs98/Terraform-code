provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_user" "sunil" {
  name = "sunil_123"
                       # creation of user name sunil
}

resource "aws_iam_user_login_profile" "sunil" {
  user    = aws_iam_user.sunil.name
  password_reset_required = true 
                     # enabling user login and reset of the password
}

resource "aws_iam_account_password_policy" "strict" {
  minimum_password_length        = 8
  require_lowercase_characters   = true
  require_numbers                = true                  # requirnments criteria for creation of new password   
  require_uppercase_characters   = true
  require_symbols                = true
  allow_users_to_change_password = true
}
resource "aws_iam_policy" "test" {
  name        = "test_policy"                                #creating a policy for s3 bucket with full access
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

resource "aws_iam_user_policy_attachment" "test" {
  user    = aws_iam_user.sunil.name
  policy_arn = aws_iam_policy.test.arn                 #attaching policy to user sunil 
  
}
