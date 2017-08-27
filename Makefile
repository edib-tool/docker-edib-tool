all: build

build:
	docker build -t local/edib-dev:latest .
