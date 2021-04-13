package main

import (
	"bufio"
	"flag"
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
	"time"
)

func main() {
	var (
		sep   string
		col   int
		scale int64
	)

	flag.StringVar(&sep, "sep", "\t", "")
	flag.IntVar(&col, "col", 1, "")
	flag.Int64Var(&scale, "scale", 1000, "")
	flag.Parse()

	sc := bufio.NewScanner(os.Stdin)

	for sc.Scan() {
		txt := sc.Text()
		records := strings.Split(txt, sep)

		eventedAtMS, err := strconv.ParseInt(strings.Trim(records[col-1], " "), 10, 64)
		if err != nil {
			log.Println(err)
			fmt.Fprintln(os.Stdout, txt)

			continue
		}

		eventedAt := time.Unix(eventedAtMS/scale, eventedAtMS%scale).In(time.UTC)
		newRecords := append(records[:col-1], append([]string{eventedAt.Format(time.RFC3339)}, records[col:]...)...)
		fmt.Fprintln(os.Stdout, strings.Join(newRecords, sep))
	}
}
