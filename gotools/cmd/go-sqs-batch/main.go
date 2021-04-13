package main

import (
	"bufio"
	"context"
	"crypto/sha256"
	"flag"
	"fmt"
	"io"
	"log"
	"os"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/sqs"
	"github.com/aws/aws-sdk-go-v2/service/sqs/types"
)

type bufferedSqsClient struct {
	client    *sqs.Client
	queueURL  string
	batchSize int
}

func newBufferedSqsClient(client *sqs.Client, queueURL string, batchSize int) *bufferedSqsClient {
	return &bufferedSqsClient{
		client:    client,
		queueURL:  queueURL,
		batchSize: batchSize,
	}
}

func (c *bufferedSqsClient) sendMessageBatch(ctx context.Context, entities []types.SendMessageBatchRequestEntry) error {
	resp, err := c.client.SendMessageBatch(ctx, &sqs.SendMessageBatchInput{
		QueueUrl: aws.String(c.queueURL),
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

func (c *bufferedSqsClient) ReceiveSendMessageBatchRequestEntry(
	ctx context.Context,
	entities <-chan types.SendMessageBatchRequestEntry,
) error {
	bufferedEntities := make([]types.SendMessageBatchRequestEntry, 0, c.batchSize)

	for entity := range entities {
		bufferedEntities = append(bufferedEntities, entity)
		if len(bufferedEntities) < c.batchSize {
			continue
		}

		if err := c.sendMessageBatch(ctx, bufferedEntities); err != nil {
			return err
		}

		bufferedEntities = make([]types.SendMessageBatchRequestEntry, 0, c.batchSize)
	}

	if len(bufferedEntities) > 0 {
		if err := c.sendMessageBatch(ctx, bufferedEntities); err != nil {
			return err
		}
	}

	return nil
}

func parseSendMessageBatchRequestEntry(r io.Reader, entities chan<- types.SendMessageBatchRequestEntry) error {
	sc := bufio.NewScanner(r)
	for sc.Scan() {
		body := sc.Text()
		hash := sha256.New()

		_, err := io.WriteString(hash, body)
		if err != nil {
			return fmt.Errorf("failed to hash text: %w", err)
		}

		entities <- types.SendMessageBatchRequestEntry{
			Id:                      aws.String(fmt.Sprintf("%x", hash.Sum(nil))),
			MessageBody:             aws.String(body),
			DelaySeconds:            0,
			MessageGroupId:          nil,
			MessageAttributes:       nil,
			MessageDeduplicationId:  nil,
			MessageSystemAttributes: nil,
		}
	}

	return nil
}

func main() {
	var queueURL string

	batchSize := 10

	flag.StringVar(&queueURL, "queue-url", queueURL, "")
	flag.IntVar(&batchSize, "batch-size", batchSize, "")
	flag.Parse()

	if len(queueURL) == 0 {
		log.Fatal("require queue url")
	}

	ctx, cancel := context.WithCancel(context.Background())

	cfg, err := config.LoadDefaultConfig(ctx)
	if err != nil {
		log.Fatalf("failed to load config: %s", err)
	}

	client := newBufferedSqsClient(sqs.NewFromConfig(cfg), queueURL, batchSize)
	entities := make(chan types.SendMessageBatchRequestEntry, batchSize)
	errChan := make(chan error)

	go func() {
		err := client.ReceiveSendMessageBatchRequestEntry(ctx, entities)
		if err != nil {
			errChan <- err
		}
	}()

	go func() {
		err := parseSendMessageBatchRequestEntry(os.Stdin, entities)
		if err != nil {
			errChan <- err
		}

		close(entities)
		close(errChan)
	}()

	if err := <-errChan; err != nil {
		cancel()
		log.Fatal(err)
	}
}
