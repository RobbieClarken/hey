FROM golang:1.13.0-alpine3.10 AS builder
WORKDIR /app
COPY vendor ./vendor
COPY requester ./requester
COPY go.mod go.sum hey.go hey_test.go Makefile ./
RUN GOOS=linux GOARCH=amd64 go build -o ./bin/hey

FROM golang:1.13.0-alpine3.10
COPY --from=builder /app/bin/hey /app/hey
ENTRYPOINT ["/app/hey"]
