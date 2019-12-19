resource "aws_iam_role" "allow_on_connect" {
  name = "allow-on-connect"

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

resource "aws_lambda_function" "on_connect" {
  filename      = "./on-connect/target/bin/on-connect.zip"
  function_name = "on-connect"
  role          = "${aws_iam_role.allow_on_connect.arn}"
  handler       = "main"

  source_code_hash = "${filebase64sha256("./on-connect/target/bin/on-connect.zip")}"

  runtime = "go1.x"

  environment {
    variables = {
      foo = "bar"
    }
  }
}