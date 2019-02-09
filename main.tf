provider "aws" {
    region  = "us-east-1"
    sassume_role = "${var.workspace_iam_roles[terraform.workspace]}"
}

data "aws_caller_identity" "current" {}

data "template_file" "readonly-policy-template" {
  template = "${file("policies/dome9-readonly-policy.json.tpl")}"
}

resource "aws_iam_policy" "readonly-policy" {
  description = "Read only policy for Dome9"
  name = "dome9-readonly-policy"
  path = "${var.iam_path}"
  policy = "${data.template_file.readonly-policy-template.rendered}"
}

data "template_file" "write-policy-template" {
  template = "${file("policies/dome9-write-policy.json.tpl")}"
}

resource "aws_iam_policy" "write-policy" {
  description = "Write policy for Dome9"
  name = "dome9-write-policy"
  path = "${var.iam_path}"
  policy = "${data.template_file.write-policy-template.rendered}"
}

# Trust relationships policy document
data "aws_iam_policy_document" "doc" {
  statement = {
    sid = "AllowAssumeRoleForAnotherAccount"
    actions = [
      "sts:AssumeRole"]

    principals = {
      type = "AWS"
      identifiers = [
        "${var.dome9_account_id}"]
    }

    condition = [
      {
        test = "StringEquals"
        variable = "sts:ExternalId"

        values = [
          "${var.dome9_external_id}"]
      },
    ]
  }
}

resource "aws_iam_role" "Dome9-Connect" {
  name = "Dome9-Connect"
  path = "${var.iam_path}"
  description = "IAM Role for Dome9"

  assume_role_policy = "$data.aws_iam_policy_document.doc.json}"
}

resource "aws_iam_role_policy_attachment" "SecurityAudit" {
  policy_arn = "arn:aws:iam::aws:policy/SecurityAudit"
  role = "${aws_iam_role.Dome9-Connect.name}"
}

resource "aws_iam_role_policy_attachment" "AmazonInspectorReadOnlyAccess" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonInspectorReadOnlyAccess"
  role = "${aws_iam_role.Dome9-Connect.name}"
}


resource "aws_iam_role_policy_attachment" "dome9-readonly-policy" {
  policy_arn = "${aws_iam_policy.readonly-policy.arn}"
  role = "${aws_iam_role.Dome9-Connect.name}"
}

resource "aws_iam_role_policy_attachment" "dome9-write-policy" {
  policy_arn = "${aws_iam_policy.write-policy.arn}"
  role = "${aws_iam_role.Dome9-Connect.name}"
}

output "role_arn" {
  value = "${aws_iam_role.Dome9-Connect.arn}"
}