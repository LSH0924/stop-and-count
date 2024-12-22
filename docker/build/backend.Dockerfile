FROM alpine:latest

# 필요한 패키지 설치
RUN apk add --no-cache \
    go \
    git \
    musl-dev \
    gcc

# Go 환경 설정
ENV GOPATH /go
ENV PATH $GOPATH/bin:$PATH

# Delve 디버거 설치
RUN go install github.com/go-delve/delve/cmd/dlv@latest

WORKDIR /go/src/app

# 디버깅을 위한 포트
EXPOSE 8080 40000

# 디버깅 모드로 실행
CMD ["dlv", "debug", "--headless", "--listen=:40000", "--api-version=2", "--accept-multiclient"]
