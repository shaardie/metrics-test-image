# syntax=docker/dockerfile:1

FROM golang:1.18-bullseye as build
WORKDIR /app
COPY go.mod ./
COPY go.sum ./
RUN go mod download
COPY main.go ./
RUN go build -v -o /metrics-test

FROM gcr.io/distroless/base-debian11
WORKDIR /
COPY --from=build /metrics-test /metrics-test
USER nonroot:nonroot
ENTRYPOINT ["/metrics-test"]
