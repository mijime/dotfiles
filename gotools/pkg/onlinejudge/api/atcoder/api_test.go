package atcoder

import (
	"bytes"
	_ "embed"
	"io"
	"reflect"
	"testing"

	"github.com/mijime/dotfiles/gotools/pkg/onlinejudge"
)

//go:embed _test/abc196.html
var contestHTML []byte

func Test_parseContest(t *testing.T) {
	type args struct {
		r io.Reader
	}
	tests := []struct {
		name    string
		args    args
		want    []string
		wantErr bool
	}{
		{
			args: args{
				r: bytes.NewReader(contestHTML),
			},
			want: []string{
				"abc196/tasks/abc196_a",
				"abc196/tasks/abc196_b",
				"abc196/tasks/abc196_c",
				"abc196/tasks/abc196_d",
				"abc196/tasks/abc196_e",
				"abc196/tasks/abc196_f",
			},
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			got, err := parseContest(tt.args.r)
			if (err != nil) != tt.wantErr {
				t.Errorf("parseContest() error = %+v, wantErr %+v", err, tt.wantErr)
				return
			}
			if !reflect.DeepEqual(got, tt.want) {
				t.Errorf("parseContest() = %+v, want %+v", got, tt.want)
			}
		})
	}
}

//go:embed _test/abc196_a.html
var problemHTML []byte

func Test_parseProblem(t *testing.T) {
	type args struct {
		r io.Reader
	}
	tests := []struct {
		name    string
		args    args
		want    onlinejudge.Problem
		wantErr bool
	}{
		{
			args: args{
				r: bytes.NewReader(problemHTML),
			},
			want: onlinejudge.Problem{
				Text: `# 問題文

整数 a, b, c, d が与えられます。
a ≤ x ≤ b,\ c ≤ y ≤ d となるように整数 x, y を選ぶとき、 x - y の最大値を求めてください。

# 入力

入力は以下の形式で標準入力から与えられる。
a b
c d

# 出力

答えを出力せよ。

# 制約

入力は全て整数
-100 ≤ a ≤ b ≤ 100
-100 ≤ c ≤ d ≤ 100`,
				SampleTestCase: []onlinejudge.TestCase{
					{
						Input: `0 10
0 10`,
						Output: `10`,
					},
					{
						Input: `-100 -100
100 100`,
						Output: `-200`,
					},
					{
						Input: `-100 100
-100 100`,
						Output: `200`,
					},
				},
			},
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			got, err := parseProblem(tt.args.r)
			if (err != nil) != tt.wantErr {
				t.Errorf("parseProblem() error = %+v, wantErr %+v", err, tt.wantErr)
				return
			}
			if !reflect.DeepEqual(got, tt.want) {
				t.Errorf("parseProblem() = %+v, want %+v", got, tt.want)
			}
		})
	}
}
