SRC = $(wildcard requirements/*.in)
OPT =

requirements.txt: $(SRC)
	pip-compile $(OPT) --output-file $@ $^
	pip-sync $@

setup:
	pip install $(OPT) setuptools pip pip-tools
