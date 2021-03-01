package main

import (
	"bufio"
	"crypto/sha256"
	"flag"
	"fmt"
	"io"
	"log"
	"os"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/sqs"
)

func main() {
	var queueURL string

	batchSize := 10

	flag.StringVar(&queueURL, "queue-url", queueURL, "")
	flag.IntVar(&batchSize, "batch-size", batchSize, "")
	flag.Parse()

	sess := session.Must(session.NewSession())
	svc := sqs.New(sess)

	entities := make([]*sqs.SendMessageBatchRequestEntry, 0, batchSize)

	sendMessageBatch := func(entities []*sqs.SendMessageBatchRequestEntry) error {
		resp, err := svc.SendMessageBatch(&sqs.SendMessageBatchInput{
			QueueUrl: aws.String(queueURL),
			Entries:  entities,
		})
		if err != nil {
			return fmt.Errorf("failed to send message batch: %w", err)
		}

		if len(resp.Failed) > 0 {
			return fmt.Errorf("failed to send message batch: %+v", resp.Failed)
		}

		return nil
	}

	sc := bufio.NewScanner(os.Stdin)
	for sc.Scan() {
		body := sc.Text()

		hash := sha256.New()

		_, err := io.WriteString(hash, body)
		if err != nil {
			log.Fatalf("failed to write string: %+v", err)
		}

		entities = append(entities, &sqs.SendMessageBatchRequestEntry{
			Id:          aws.String(fmt.Sprintf("%x", hash.Sum(nil))),
			MessageBody: aws.String(body),
		})
		if len(entities) < batchSize {
			continue
		}

		if err := sendMessageBatch(entities); err != nil {
			log.Fatal(err)
		}

		entities = make([]*sqs.SendMessageBatchRequestEntry, 0, batchSize)
	}

	if len(entities) > 0 {
		if err := sendMessageBatch(entities); err != nil {
			log.Fatal(err)
		}
	}
}
