package download

import (
	"io/fs"
	"os"
	"testing"

	"github.com/mijime/dotfiles/gotools/pkg/onlinejudge"
)

type fakeNotExistFS struct {
	osFS
}

func (fakeNotExistFS) Stat(path string) (fs.FileInfo, error) {
	return nil, os.ErrNotExist
}

func TestCommand_generateProblem(t *testing.T) {
	type fields struct {
		contestID string
		problemID string
		srcFS     argsFS
		dstFS     argsFS
	}
	type args struct {
		p         onlinejudge.Problem
		problemID string
		dir       string
	}
	tests := []struct {
		name    string
		fields  fields
		args    args
		wantErr bool
	}{
		{
			fields: fields{
				srcFS: argsFS{FS: osFS("_test/templates")},
				dstFS: argsFS{FS: osFS("_test")},
			},
			args: args{p: onlinejudge.Problem{Text: "NotOverWrite"}, dir: "."},
		},
		{
			fields: fields{
				srcFS: argsFS{FS: osFS("_test/templates")},
				dstFS: argsFS{FS: fakeNotExistFS{osFS: osFS("_test")}},
			},
			args: args{p: onlinejudge.Problem{Text: "OverWrite"}, dir: "."},
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			cmd := &Command{
				contestID: tt.fields.contestID,
				problemID: tt.fields.problemID,
				srcFS:     tt.fields.srcFS,
				dstFS:     tt.fields.dstFS,
			}
			if err := cmd.generateProblem(tt.args.p, tt.args.problemID, tt.args.dir); (err != nil) != tt.wantErr {
				t.Errorf("Command.generateProblem() error = %v, wantErr %v", err, tt.wantErr)
			}
		})
	}
}
