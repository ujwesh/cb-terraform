provider "aws" {

}

resource "aws_iam_user" "uk" {
  name  = "ujwesh${count.index + 1}"
  count = 5

  tags = {
    tag-key = "bejafry"
  }
}

resource "aws_iam_user_policy_attachment" "uk_admin_policy" {
  count      = 5
  user       = aws_iam_user.uk[count.index].name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}



# provider "aws" {

# }


# variable "user_name" {
#     type = list(string)
#     default = ["ujwesh", "ujwesh1", "ujwesh3", "ujwesh4", "ujwesh5"]
# }


# resource "aws_iam_user" "uk" {
#   name  = var.user_name[count.index]
#   count = 5

#     tags = {
#     tag-key = "bejafry"
#   }
# }


# resource "aws_iam_user_policy_attachment" "uk_admin_policy" {
#   count      = 5
#   user       = aws_iam_user.uk[count.index].name
#   policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
# }