# {{ .ProblemID }}

{{ .Problem.Text }}

{{- range $i, $v := .Problem.SampleTestCase }}

## 入力例 {{ $i }}

```
{{ $v.Input }}
```

## 出力例 {{ $i }}

```
{{ $v.Output }}
```
{{ end }}
