FROM golang:alpine
# MAINTAINER  Alexey Palazhchenko <alexey.palazhchenko@percona.com>

RUN echo $GOPATH

RUN apk update && apk add --virtual build-dependencies build-base gcc git wget
COPY . /go/src/github.com/percona/mongodb_exporter
WORKDIR /go/src/github.com/percona/mongodb_exporter
RUN make build


FROM alpine:latest
COPY --from=0 /go/src/github.com/percona/mongodb_exporter/mongodb_exporter .
EXPOSE      9216
CMD ["./mongodb_exporter"]