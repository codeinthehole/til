server:
	cd hugosite && hugo server

build:
	rm -rf docs
	cd hugosite && hugo

lint: markdownlint prettier_lint vale

markdownlint:
	markdownlint .

prettier_lint:
	prettier --check .

vale:
	vale .

fix: markdownlint_fix prettier_fix

markdownlint_fix:
	markdownlint --fix .

prettier_fix:
	prettier --write posts/
	prettier --write *.md

