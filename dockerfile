FROM golang:1.24.1-bullseye AS builder

WORKDIR /app

COPY main.go go.mod go.sum ./

RUN go build -o main -ldflags '-s -w' main.go


FROM debian:trixie-slim

EXPOSE 4444

COPY --from=builder /app/main /main

CMD ["/main"]