module "on-connect" {
  source = "./modules/functions"

  name = "on-connect"
  dynamodb_arn = aws_dynamodb_table.chat.arn
}

module "on-send" {
  source = "./modules/functions"

  name = "on-send"
  dynamodb_arn = aws_dynamodb_table.chat.arn
}