BIN := drone-plugin-bash
IMG := geoplex/$(BIN)

docker: $(BIN) Dockerfile
	docker build --rm=true -t $(IMG) .

push: $(BIN)
	docker push $(IMG)

$(BIN): $(wildcard *.go)
	GOOS=linux GOARCH=amd64 go build

# additional flavors

docker-%: Dockerfile %/Dockerfile
	docker build --rm=true -t $(IMG)-$* ./$*

push-%: Dockerfile %/Dockerfile
	docker push $(IMG)-$*
