# Websocket

AWS websocket reference implementation based of the following architecture:

![Websocket Architecture](docs/images/websockets-arch.png)
_https://aws.amazon.com/blogs/compute/announcing-websocket-apis-in-amazon-api-gateway/_

It is a golang rendition of the [Node.js example](https://github.com/aws-samples/simple-websockets-chat-app) alongside terraform configurations.

**_ All components have been implemented here except the *web socket api* component it is [still being added to the aws provider functionalies in terraform](https://github.com/terraform-providers/terraform-provider-aws/issues/7004). _**

## TODO

1. Create API Gateway REST API v2
1. Broadcast message wend _send-message_ function is invoked.

## Usage

Usage assumes you already have terraform (v0.12) and awscli (v2.42) setup and you are in the _websocket_ folder.

Execute the following:

```sh
make init
make package
make run
```

To test `on-connect`, provide the following as params to the function in the AWS UI and inspect the Dynamo DB to confirm a record is inserted:

```json
{
  "connection_id": "fd991532-23b2-11ea-978f-2e728ce88125"
}
```

To test `on-disconnect`, provide the following as params to the function in the AWS UI and inspect the Dynamo DB to confirm the initially created record is removed:

```json
{
  "connection_id": "fd991532-23b2-11ea-978f-2e728ce88125"
}
```

To cleanup everything, run:

```sh
make destroy
```
