FROM golang:1.23.2-alpine AS builder

WORKDIR /app

COPY . .

RUN go build -o meuapp .

FROM scratch

COPY --from=builder /app/meuapp /meuapp

CMD ["/meuapp"]