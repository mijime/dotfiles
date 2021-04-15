package atcoder

import (
	"context"
	"errors"
	"io"
	"net/url"
	"strings"

	"github.com/mijime/dotfiles/gotools/pkg/onlinejudge"
)

func resolveLanguageID(lang string) string {
	switch lang {
	case "go":
		return "4026"
	case "python":
		return "4006"
	case "javascript":
		return "4030"
	case "typescript":
		return "4057"
	case "rust":
		return "4050"
	default:
		return ""
	}
}

func (a *API) Submit(ctx context.Context, input onlinejudge.SubmitInput) error {
	ids := strings.SplitN(input.ProblemID, "/", 3)
	if len(ids) != 3 {
		return errors.New("unformaled problem id")
	}

	buf, err := io.ReadAll(input.File)
	if err != nil {
		return err
	}

	contestID := ids[0]
	taskScreenName := ids[2]

	languageID := resolveLanguageID(input.Lang)
	sourceCode := string(buf)

	data := make(url.Values)
	data.Add("data.TaskScreenName", taskScreenName)
	data.Add("data.LanguageId", languageID)
	data.Add("sourceCode", sourceCode)

	u := "https://atcoder.jp/contests/" + contestID + "/submit"

	return a.postForm(ctx, u, data)
}
