provider "aws"  {

}


resource "aws_iam_user" "uk-users" {
  count = 5
  name = "ujwesh${count.index + 1}"

  tags = {
    tag-key = "tag-value"
  }

}


resource "aws_iam_group" "uk-group" {
  
  name = "cloudblitz"

}


resource "aws_iam_group_membership" "uk-membership" {
  name = "tf-testing-group-membership"
  count = 5
  users = [
    aws_iam_user.uk-users[count.index].name
  ]

  group = aws_iam_group.uk-group.name
}
