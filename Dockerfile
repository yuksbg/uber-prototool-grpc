FROM golang:1.15-alpine as builder

RUN apk add --update --no-cache build-base curl git upx && \
  rm -rf /var/cache/apk/*

RUN go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway && \
    go get -u github.com/favadi/protoc-go-inject-tag

FROM uber/prototool:latest

COPY --from=builder /go/bin/protoc-* /usr/local/bin/
COPY --from=builder /go/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis /go/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis
COPY --from=builder /go/src/google.golang.org/genproto/googleapis /go/src/google.golang.org/genproto/googleapis
