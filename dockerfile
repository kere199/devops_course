# Build stage
FROM golang:1.24.1-bullseye AS builder
WORKDIR /app
COPY main.go go.mod ./
RUN go build -o main -ldflags '-s -w' main.go

# Final stage
FROM debian:trixie-slim
WORKDIR /app
COPY --from=builder /app/main /main
EXPOSE 4444
CMD ["/main"]
