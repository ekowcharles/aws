resource "aws_iam_role" "allow_function" {
  name = "allow-${var.name}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "allow_function_to_dynamo_db" {
  name = "allow-${var.name}-to-dynamo-db"
  role = "${aws_iam_role.allow_function.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "dynamodb:BatchWriteItem"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:dynamodb:us-east-1:*:table/flyingchat"
    }
  ]
}
EOF
}

resource "aws_lambda_function" "function" {
  filename      = "./${var.name}/target/bin/${var.name}.zip"
  function_name = var.name
  role          = "${aws_iam_role.allow_function.arn}"
  handler       = "main"

  source_code_hash = "${filebase64sha256("./${var.name}/target/bin/${var.name}.zip")}"

  runtime = "go1.x"
}