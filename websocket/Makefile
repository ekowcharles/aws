.PHONY: bucket package

setup:
	aws s3api create-bucket --bucket flyingstates --acl private --region us-east-1
	terraform init

run:
	terraform plan
	terraform apply

package_function:
	rm -rf ./${FUNCTION}/target/bin
	mkdir -p ./${FUNCTION}/target/bin
	GOPATH=`pwd`/${FUNCTION} go get -u github.com/aws/aws-lambda-go/cmd/build-lambda-zip
	GOPATH=`pwd`/${FUNCTION} GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -ldflags="-d -s -w" -o `pwd`/${FUNCTION}/target/bin/main ./${FUNCTION}/src/main.go
	chmod +x ${FUNCTION}/target/bin/main
	zip -j ${FUNCTION}/target/bin/${FUNCTION}.zip ${FUNCTION}/target/bin/main

package:
	$(MAKE) FUNCTION=on-connect package_function
	$(MAKE) FUNCTION=on-send package_function

destroy:
	terraform destroy