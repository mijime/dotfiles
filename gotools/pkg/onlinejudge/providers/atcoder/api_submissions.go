package atcoder

import (
	"context"
	"fmt"
	"net/http"

	"github.com/PuerkitoBio/goquery"
	"github.com/mijime/dotfiles/gotools/pkg/onlinejudge"
)

func (a *API) Submissions(ctx context.Context, input onlinejudge.SubmissionsInput) ([]onlinejudge.Submission, error) {
	u := "https://atcoder.jp/contests/" + input.ContestID + "/submissions/me"
	req, err := http.NewRequestWithContext(ctx, http.MethodGet, u, nil)
	if err != nil {
		return nil, fmt.Errorf("failed to create request: %w", err)
	}

	resp, err := a.Client.Do(req)
	if err != nil {
		return nil, fmt.Errorf("failed to get request: %w", err)
	}

	defer resp.Body.Close()

	doc, err := goquery.NewDocumentFromReader(resp.Body)
	if err != nil {
		return nil, fmt.Errorf("failed to parse: %w", err)
	}

	submissions := make([]onlinejudge.Submission, 0)

	records := doc.Find("#main-container div.panel.panel-default.panel-submission div.table-responsive table > tbody > tr")
	records.Each(func(index int, sel *goquery.Selection) {
		problemID, exists := sel.Find("td:nth-child(2) a").Attr("href")
		if !exists {
			return
		}

		submissions = append(submissions, onlinejudge.Submission{
			ProblemID: problemID,
			Status:    sel.Find("td:nth-child(7)").Text(),
		})
	})

	return submissions, nil
}
