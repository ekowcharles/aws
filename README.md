# AWS Mini Projects

A compilation of small aws projects used to illustrate certain concepts.

## Websocket

AWS websocket reference implementation based of the following architecture:

![Websocket Architecture](docs/images/websockets-arch.png)
_https://aws.amazon.com/blogs/compute/announcing-websocket-apis-in-amazon-api-gateway/_

### Usage

Usage assumes you already have terraform (v0.12) and awscli (v2.42) setup.

Execute the following:

```sh
make setup
make package
make run
```
