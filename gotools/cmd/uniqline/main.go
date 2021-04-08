package main

import (
	"bufio"
	"crypto/sha256"
	"fmt"
	"io"
	"log"
	"os"
)

func main() {
	if err := uniqline(os.Stdout, os.Stdin); err != nil {
		log.Fatal(err)
	}
}

func uniqline(out io.Writer, in io.Reader) error {
	sc := bufio.NewScanner(in)
	mem := make(map[[32]byte]struct{}, 1024)

	for sc.Scan() {
		b := sc.Bytes()
		h := sha256.Sum256(b)

		if _, ok := mem[h]; !ok {
			mem[h] = struct{}{}

			if _, err := out.Write(b); err != nil {
				return fmt.Errorf("failed to print: %w", err)
			}

			if _, err := out.Write([]byte{'\n'}); err != nil {
				return fmt.Errorf("failed to print: %w", err)
			}
		}
	}

	return nil
}
