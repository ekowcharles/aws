package main

import (
	"fmt"

	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/awserr"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/dynamodb"
)

// Request represents the requested object
type Request struct {
	ConnectionID string `json:"connection_id"`
}

// Response represents the Response object
type Response struct {
	Message string `json:"Message"`
	Ok      bool   `json:"Ok"`
}

// Handler represents the Handler of lambda
func Handler(request Request) (Response, error) {
	ddb := dynamodb.New(session.New())
	input := &dynamodb.PutItemInput{
		Item: map[string]*dynamodb.AttributeValue{
			"ConnectionId": {
				S: aws.String(request.ConnectionID),
			},
		},
		TableName: aws.String("flying-chat"),
	}

	msg := ""
	_, err := ddb.PutItem(input)
	if err != nil {
		if aerr, ok := err.(awserr.Error); ok {
			switch aerr.Code() {
			case dynamodb.ErrCodeConditionalCheckFailedException:
				msg = fmt.Sprint(dynamodb.ErrCodeConditionalCheckFailedException, aerr.Error())
			case dynamodb.ErrCodeProvisionedThroughputExceededException:
				msg = fmt.Sprint(dynamodb.ErrCodeProvisionedThroughputExceededException, aerr.Error())
			case dynamodb.ErrCodeResourceNotFoundException:
				msg = fmt.Sprint(dynamodb.ErrCodeResourceNotFoundException, aerr.Error())
			case dynamodb.ErrCodeItemCollectionSizeLimitExceededException:
				msg = fmt.Sprint(dynamodb.ErrCodeItemCollectionSizeLimitExceededException, aerr.Error())
			case dynamodb.ErrCodeTransactionConflictException:
				msg = fmt.Sprint(dynamodb.ErrCodeTransactionConflictException, aerr.Error())
			case dynamodb.ErrCodeRequestLimitExceeded:
				msg = fmt.Sprint(dynamodb.ErrCodeRequestLimitExceeded, aerr.Error())
			case dynamodb.ErrCodeInternalServerError:
				msg = fmt.Sprint(dynamodb.ErrCodeInternalServerError, aerr.Error())
			default:
				msg = fmt.Sprint(aerr.Error())
			}
		} else {
			msg = fmt.Sprint(err.Error())
		}

		return Response{
			Message: fmt.Sprintf("Process Connection Id %s. Error: %s", request.ConnectionID, msg),
			Ok:      false,
		}, err
	}

	return Response{
		Message: fmt.Sprintf("Process Connection Id %s", request.ConnectionID),
		Ok:      true,
	}, nil
}

func main() {
	lambda.Start(Handler)
}
