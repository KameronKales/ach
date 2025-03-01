FROM golang:1.16-alpine as builder
WORKDIR /go/src/github.com/moov-io/ach
RUN apk add -U make
RUN adduser -D -g '' --shell /bin/false moov
COPY . .
RUN make build
USER moov

FROM scratch
LABEL maintainer="Moov <support@moov.io>"

COPY --from=builder /go/src/github.com/moov-io/ach/bin/server /bin/server

USER moov
EXPOSE 8080
EXPOSE 9090
ENTRYPOINT ["/bin/server"]
