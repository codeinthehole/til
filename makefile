server:
	cd hugosite && hugo server

build:
	rm -rf docs
	cd hugosite && hugo

lint: markdownlint_lint prettier_lint

markdownlint_lint:
	markdownlint .

prettier_lint:
	prettier --check .

fix: markdownlint_fix prettier_fix

markdownlint_fix:
	markdownlint --fix .

prettier_fix:
	prettier --write posts/
