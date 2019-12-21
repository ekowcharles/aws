locals {
  path = "./${var.name}/target/bin/${var.name}.zip"
}

data "aws_iam_policy_document" "allow_function_to_dynamo_db" {
  statement {
    actions   = var.dynamo_db_permissions
    resources = [var.dynamodb_arn]
  }
}

resource "aws_iam_policy" "allow_function_to_dynamo_db" {
  name = "allow-${var.name}-to-dynamo-db"
  description = "Allow access to dynamo db"

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

resource "aws_iam_role_policy_attachment" "allow_function" {
  role       = "${aws_iam_role.allow_function.name}"
  policy_arn = "${aws_iam_policy.allow_function_to_dynamo_db.arn}"
}

resource "aws_lambda_function" "function" {
  filename      = local.path
  function_name = var.name
  role          = "${aws_iam_role.allow_function.arn}"
  handler       = "main"

  source_code_hash = filebase64sha256(local.path)

  runtime = "go1.x"
}