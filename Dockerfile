FROM golang:1.22-bookworm as builder

WORKDIR /code

COPY go.mod go.sum ./
RUN go mod download

COPY cmd cmd
COPY Makefile Makefile

RUN LINK_STATICALLY=true make build

# --------------------------------------------------------
FROM alpine:3.19

COPY --from=builder /code/build/mock-da /usr/bin/mock-da

CMD ["mock-da", "-listen-all"]