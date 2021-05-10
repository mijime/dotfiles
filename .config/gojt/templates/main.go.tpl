package main

import (
	"bufio"
	"fmt"
	"io"
	"os"
)

func resolve(stdin io.Reader) string {
	fmt.Fscan(stdin)

	return ""
}

func main() {
	in := bufio.NewReader(os.Stdin)
	out := bufio.NewWriter(os.Stdout)

	defer out.Flush()

	fmt.Fprintln(out, resolve(in))
}
