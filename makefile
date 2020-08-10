server:
	cd hugosite && hugo server

build:
	rm -rf docs
	cd hugosite && hugo
