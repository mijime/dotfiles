
.SUFFIXES: .yml .json

.yml.json:
	yaml2json $< > $@
