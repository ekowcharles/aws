locals {
  dynamo_db_arn = aws_dynamodb_table.chat.arn
}

module "on-connect" {
  source = "./modules/functions"

  name = "on-connect"
  dynamodb_arn = local.dynamo_db_arn
  dynamo_db_permissions = ["dynamodb:PutItem"]
}

module "on-disconnect" {
  source = "./modules/functions"

  name = "on-disconnect"
  dynamodb_arn = local.dynamo_db_arn
  dynamo_db_permissions = ["dynamodb:DeleteItem"]
}

module "send-message" {
  source = "./modules/functions"

  name = "send-message"
  dynamodb_arn = local.dynamo_db_arn
  dynamo_db_permissions = ["dynamodb:Scan"]
}