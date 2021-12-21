package main

import (
	"bufio"
	"bytes"
	_ "embed"
	"encoding/json"
	"flag"
	"fmt"
	"io"
	"log"
	"os"
	"path"
	"strconv"
	"strings"
)

func main() {
	flag.Parse()

	args := flag.Args()

	var r io.Reader

	if len(args) > 0 {
		r = strings.NewReader(strings.Join(args, " "))
	} else {
		r = os.Stdin
	}

	if err := run(os.Stdout, r); err != nil {
		log.Fatal(err)
	}
}

func run(w io.Writer, r io.Reader) error {
	emojis, err := newEmojiDictFromAssets()
	if err != nil {
		return fmt.Errorf("failed to initialize emoji dict: %w", err)
	}

	bw := bufio.NewWriter(w)
	defer bw.Flush()

	sc := bufio.NewScanner(r)
	sc.Split(emojis.SplitFunc)

	for sc.Scan() {
		if _, err := bw.Write(sc.Bytes()); err != nil {
			return fmt.Errorf("failed to write: %w", err)
		}
	}

	return nil
}

//go:generate curl -o assets/iamcal-emoji.json -sL https://github.com/iamcal/emoji-data/raw/master/emoji.json
//go:embed assets/iamcal-emoji.json
var iamcalEmojiJSON []byte

//go:generate curl -o assets/gh-emoji.json -sL https://api.github.com/emojis
//go:embed assets/gh-emoji.json
var githubEmojiJSON []byte

func newEmojiDictFromAssets() (emojiDict, error) {
	emojis := make(emojiDict)

	var ghEmojis map[string]string

	if err := json.Unmarshal(githubEmojiJSON, &ghEmojis); err != nil {
		return nil, fmt.Errorf("failed to unmarshal gh-emoji: %w", err)
	}

	for name, v := range ghEmojis {
		us := strings.Split(path.Base(v), ".")
		emojis[name] = codepoint2emoji(us[0])
	}

	var iamcalEmojis []struct {
		Unified    string   `json:"unified"`
		ShortNames []string `json:"short_names"`
		Text       string   `json:"text"`
		Texts      []string `json:"texts"`
	}

	if err := json.Unmarshal(iamcalEmojiJSON, &iamcalEmojis); err != nil {
		return nil, fmt.Errorf("failed to unmarshal iamcal-emoji: %w", err)
	}

	for _, v := range iamcalEmojis {
		for _, name := range v.ShortNames {
			emojis[name] = codepoint2emoji(v.Unified)
		}
	}

	return emojis, nil
}

func codepoint2emoji(v string) []byte {
	xs := strings.Split(v, "-")
	r := make([]rune, 0, len(xs))

	for _, x := range xs {
		c, _ := strconv.ParseUint(x, 16, 64)
		r = append(r, rune(c))
	}

	return []byte(string(r))
}

type emojiDict map[string][]byte

func (e emojiDict) SplitFunc(data []byte, atEOF bool) (int, []byte, error) {
	if len(data) == 0 {
		return 0, data, bufio.ErrFinalToken
	}

	if data[0] != ':' {
		idx := bytes.IndexByte(data, ':')
		if idx < 0 {
			return len(data), data, nil
		}

		return idx, data[:idx], nil
	}

	for i := 1; i < len(data); i++ {
		if data[i] == ':' {
			if v, ok := e[string(data[1:i])]; ok {
				return i + 1, v, nil
			}

			return i, data[:i], nil
		}
	}

	return len(data), data, nil
}
