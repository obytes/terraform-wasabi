data "aws_iam_policy_document" "prod_wasabi_statement" {
  statement {
    actions = [
      "ec2:DescribeInstances",
    ]

    resources = [
      "*",
    ]
  }
}

data "aws_iam_policy_document" "prod_wasabi_assume_statement" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "Service"

      identifiers = [
        "ec2.amazonaws.com",
      ]
    }
  }
}

module "prod_wasabi_policy" {
  source = "../../../modules/aws/iam/policy"
  name   = "${var.environment}-wasabi-policy"
  policy = "${data.aws_iam_policy_document.prod_wasabi_statement.json}"
}

module "prod_wasabi_role" {
  source             = "../../../modules/aws/iam/role"
  name               = "${var.environment}-wasabi-role"
  policy_to_attach   = "${module.prod_wasabi_policy.arn}"
  assume_role_policy = "${data.aws_iam_policy_document.prod_wasabi_assume_statement.json}"
}

module "prod_wasabi_profile" {
  source = "../../../modules/aws/iam/profile"
  name   = "${var.environment}-wasabi-profile"
  role   = "${module.prod_wasabi_role.name}"
}
