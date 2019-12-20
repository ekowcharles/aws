resource "aws_dynamodb_table" "chat" {
  name           = "flyingchat"
  billing_mode   = "PAY_PER_REQUEST"

  hash_key       = "RequestID"

  attribute {
    name = "RequestID"
    type = "S"
  }
}