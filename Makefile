BIN := drone-plugin-bash
IMG := crhym3/$(BIN)

docker: $(BIN) Dockerfile
	docker build --rm=true -t $(IMG) .

push: $(BIN)
	docker push $(IMG)

$(BIN): $(wildcard *.go)
	GOOS=linux GOARCH=amd64 go build
