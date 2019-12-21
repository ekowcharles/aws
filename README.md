# AWS Mini Projects

A compilation of small aws projects used to illustrate certain concepts.

## Websocket

AWS websocket reference implementation based of the following architecture:

![Websocket Architecture](docs/images/websockets-arch.png)
_https://aws.amazon.com/blogs/compute/announcing-websocket-apis-in-amazon-api-gateway/_

It is a golang rendition of the [Node.js example](https://github.com/aws-samples/simple-websockets-chat-app) alongside terraform configurations.

All parts but the `api` component is has not been completed yet because it is [still being added to terraform](https://github.com/terraform-providers/terraform-provider-aws/issues/7004).

### TODO

1. Create API Gateway REST API v2
1. Broadcast message wend _send-message_ function is invoked.

### Usage

Usage assumes you already have terraform (v0.12) and awscli (v2.42) setup and you are in the _websocket_ folder.

Execute the following:

```sh
make init
make package
make run
```

To cleanup everything, run:

```sh
make destroy
```

## Style Guide

Look [here](https://medium.com/@caboadu/terraform-a-style-guide-9b1c0b1f9982) for some principles adopted in creating the terraform configuration.

## Reference

- [https://docs.aws.amazon.com/sdk-for-go/api/](https://docs.aws.amazon.com/sdk-for-go/api/)
