provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_user" "muser" {
  for_each = toset(var.iamuser)

  name = each.value
  
}

resource "aws_iam_user_login_profile" "user" {
  for_each                   = aws_iam_user.muser
  user                       = each.value.name
  
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
