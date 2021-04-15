package atcoder

import (
	"context"
	"errors"
	"fmt"
	"io"
	"log"
	"net/http"
	"net/url"
	"strconv"
	"strings"

	"github.com/PuerkitoBio/goquery"
	"github.com/jaytaylor/html2text"
	"github.com/mijime/dotfiles/gotools/pkg/onlinejudge"
)

type API struct {
	*http.Client
}

func (a *API) FetchContest(ctx context.Context, contestID string) (onlinejudge.Contest, error) {
	url := strings.Join([]string{"https://atcoder.jp/contests", contestID, "tasks"}, "/")

	req, err := http.NewRequestWithContext(ctx, http.MethodGet, url, nil)
	if err != nil {
		return onlinejudge.Contest{}, fmt.Errorf("%w", err)
	}

	resp, err := a.Do(req)
	if err != nil {
		return onlinejudge.Contest{}, fmt.Errorf("%w", err)
	}

	defer resp.Body.Close()

	taskIDs, err := parseContest(resp.Body)
	if err != nil {
		return onlinejudge.Contest{}, fmt.Errorf("%w", err)
	}

	problems := make(map[string]onlinejudge.Problem, len(taskIDs))

	for _, taskID := range taskIDs {
		problem, err := a.FetchProblem(ctx, taskID)
		if err != nil {
			return onlinejudge.Contest{}, fmt.Errorf("%w", err)
		}

		problems[taskID] = problem
	}

	return onlinejudge.Contest{
		Problems: problems,
	}, nil
}

func (a *API) FetchProblem(ctx context.Context, problemID string) (onlinejudge.Problem, error) {
	url := strings.Join([]string{"https://atcoder.jp/contests", problemID}, "/")

	req, err := http.NewRequestWithContext(ctx, http.MethodGet, url, nil)
	if err != nil {
		return onlinejudge.Problem{}, fmt.Errorf("%w", err)
	}

	resp, err := a.Do(req)
	if err != nil {
		return onlinejudge.Problem{}, fmt.Errorf("%w", err)
	}

	defer resp.Body.Close()

	problem, err := parseProblem(resp.Body)
	if err != nil {
		return onlinejudge.Problem{}, fmt.Errorf("%w", err)
	}

	return problem, nil
}

func (a *API) LoginUseUsernameAndPassword(ctx context.Context, username, password string) error {
	req, err := http.NewRequestWithContext(ctx, http.MethodGet, "https://atcoder.jp/login", nil)
	if err != nil {
		return fmt.Errorf("failed to create request: %w", err)
	}

	respGet, err := a.Client.Do(req)
	if err != nil {
		return fmt.Errorf("failed to get login page: %w", err)
	}

	defer respGet.Body.Close()

	doc, err := goquery.NewDocumentFromReader(respGet.Body)
	if err != nil {
		return fmt.Errorf("failed to read goquery: %w", err)
	}

	csrfToken, exists := doc.Find("form input[name=\"csrf_token\"]").Attr("value")
	if !exists {
		return errors.New("not found csrf token")
	}

	data := make(url.Values)
	data.Add("csrf_token", csrfToken)
	data.Add("username", username)
	data.Add("password", password)

	respPost, err := a.Client.PostForm("https://atcoder.jp/login", data)
	if err != nil {
		return fmt.Errorf("failed to post login page: %w", err)
	}

	defer respPost.Body.Close()

	text, err := html2text.FromReader(respPost.Body)
	if err != nil {
		return fmt.Errorf("failed to parse login page: %w", err)
	}

	log.Println(text)

	if respPost.StatusCode >= http.StatusBadRequest {
		return errors.New("failed to login")
	}

	return nil
}

func parseContest(r io.Reader) ([]string, error) {
	doc, err := goquery.NewDocumentFromReader(r)
	if err != nil {
		return nil, fmt.Errorf("%w", err)
	}

	problemIDs := make([]string, 0)

	doc.Find("#main-container .row table tbody tr").Each(func(i int, s *goquery.Selection) {
		href, exists := s.Find("td:nth-child(2) a").Attr("href")
		if !exists {
			return
		}

		problemIDs = append(problemIDs, strings.TrimPrefix(href, "/contests/"))
	})

	if err != nil {
		return nil, fmt.Errorf("%w", err)
	}

	return problemIDs, nil
}

type problemDetail struct {
	input     string
	output    string
	mondaibun string
	seiyaku   string
}

func (pd problemDetail) Text() string {
	return strings.Join([]string{
		"# 問題文", pd.mondaibun,
		"# 入力", pd.input,
		"# 出力", pd.output,
		"# 制約", pd.seiyaku,
	}, "\n\n")
}

func parseProblem(r io.Reader) (onlinejudge.Problem, error) {
	doc, err := goquery.NewDocumentFromReader(r)
	if err != nil {
		return onlinejudge.Problem{}, fmt.Errorf("%w", err)
	}

	var pd problemDetail

	testcase := make([]onlinejudge.TestCase, 10)
	maxNo := 0

	doc.Find("#task-statement .lang-ja .part section").Each(func(i int, s *goquery.Selection) {
		h3 := s.Find("h3")
		title := h3.Text()
		h3.Remove()

		switch title {
		case "入力":
			pd.input = strings.TrimSpace(s.Text())
		case "出力":
			pd.output = strings.TrimSpace(s.Text())
		case "制約":
			pd.seiyaku = strings.TrimSpace(s.Text())
		case "問題文":
			pd.mondaibun = strings.TrimSpace(s.Text())
		default:
			if strings.HasPrefix(title, "入力例 ") {
				no, _ := strconv.Atoi(strings.SplitN(title, " ", 2)[1])
				testcase[no-1].Input = strings.TrimSpace(s.Find("pre").Text())

				if maxNo < no {
					maxNo = no
				}

				return
			}

			if strings.HasPrefix(title, "出力例 ") {
				no, _ := strconv.Atoi(strings.SplitN(title, " ", 2)[1])
				testcase[no-1].Output = strings.TrimSpace(s.Find("pre").Text())

				if maxNo < no {
					maxNo = no
				}

				return
			}
		}
	})

	if err != nil {
		return onlinejudge.Problem{}, fmt.Errorf("%w", err)
	}

	return onlinejudge.Problem{
		Text:           pd.Text(),
		SampleTestCase: testcase[:maxNo],
	}, nil
}
