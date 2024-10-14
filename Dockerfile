FROM golang:1.21.0-alpine AS builder

WORKDIR /app

COPY . .

ENV CGO_ENABLED=0 

RUN go build -ldflags "-s -w" -o meuapp .

# Instala o UPX
RUN apk add upx

# Compacta o executável com UPX
#RUN upx --best --lzma meuapp
RUN upx --ultra-brute --lzma meuapp

FROM scratch

COPY --from=builder /app/meuapp /meuapp

CMD ["/meuapp"]