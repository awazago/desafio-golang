FROM golang:1.23.2-alpine AS builder

WORKDIR /app

COPY . .

ENV CGO_ENABLED=0 

RUN go build -ldflags "-s -w" -o meuapp .

# Instala o UPX
RUN apk add --no-cache upx

# Compacta o executável com UPX
RUN upx --best --lzma meuapp

FROM scratch

COPY --from=builder /app/meuapp /meuapp

CMD ["/meuapp"]