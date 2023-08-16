resource "aws_iam_user" "iam-user" {
  count = length(var.iam-name)
  name = "${var.iam-name[count.index]}-${var.iam-env}"
}

