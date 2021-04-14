package main

import (
	"fmt"
	"io"
	"os"
)

func resolve(stdin io.Reader) string {
	fmt.Fscan(stdin)

	return ""
}

func main() {
	fmt.Fprintln(os.Stdout, resolve(os.Stdin))
}
