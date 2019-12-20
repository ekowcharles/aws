module "onConnect" {
  source = "./modules/functions"

  path = "on-connect"
  name = "onConnect"
}

module "onSend" {
  source = "./modules/functions"

  path = "on-send"
  name = "onSend"
}