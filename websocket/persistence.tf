resource "aws_dynamodb_table" "chat" {
  name           = "flying-chat"
  billing_mode   = "PAY_PER_REQUEST"

  hash_key       = "RequestID"

  attribute {
    name = "RequestID"
    type = "S"
  }
}