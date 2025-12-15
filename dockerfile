# Build stage
FROM golang:1.24.1-bullseye AS builder
WORKDIR /app
COPY go.mod main.go ./
RUN go build -o app main.go

# Runtime stage
FROM debian:trixie-slim
WORKDIR /app
COPY --from=builder /app/app /app/app
EXPOSE 4444
CMD ["/app/app"]
