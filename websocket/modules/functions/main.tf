locals {
  path = "./${var.name}/target/bin/${var.name}.zip"
}

data "aws_iam_policy_document" "allow_function_to_dynamo_db" {
  statement {
    actions   = ["dynamodb:BatchWriteItem"]
    resources = [var.dynamodb_arn]
  }
}

resource "aws_iam_role_policy" "allow_function_to_dynamo_db" {
  name = "allow-${var.name}-to-dynamo-db"
  role = "${aws_iam_role.allow_function.id}"

  policy = data.aws_iam_policy_document.allow_function_to_dynamo_db.json
}

data "aws_iam_policy_document" "allow_function" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "allow_function" {
  name = "allow-${var.name}"

  assume_role_policy = data.aws_iam_policy_document.allow_function.json
}

resource "aws_lambda_function" "function" {
  filename      = local.path
  function_name = var.name
  role          = "${aws_iam_role.allow_function.arn}"
  handler       = "main"

  source_code_hash = filebase64sha256(local.path)

  runtime = "go1.x"
}