.PHONY: bucket package

setup:
	aws s3api create-bucket --bucket flyingstates --acl private --region us-east-1
	terraform init

run:
	terraform plan
	terraform apply -auto-approve

package:
	rm -rf ./on-connect/target/bin
	mkdir -p ./on-connect/target/bin
	GOPATH=`pwd`/on-connect go get -u github.com/aws/aws-lambda-go/cmd/build-lambda-zip
	GOPATH=`pwd`/on-connect GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -ldflags="-d -s -w" -o `pwd`/on-connect/target/bin/main ./on-connect/src/main.go
	chmod +x on-connect/target/bin/main
	zip -j on-connect/target/bin/main.zip on-connect/target/bin/main