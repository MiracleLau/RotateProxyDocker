# 阶段一：构建阶段
FROM golang:1.21-alpine AS builder

WORKDIR /app

# 1. 进入子模块目录复制 go.mod (路径根据实际子模块结构调整)
# 如果 go.mod 在子模块根目录：
COPY rotateproxy-src/go.mod rotateproxy-src/go.sum ./
RUN go mod download

# 2. 复制子模块所有源码
COPY rotateproxy-src/ .

# 3. 编译（注意此时路径已在 /app 下，即子模块根目录）
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o rotateproxy ./cmd/rotateproxy/main.go

# 阶段二：运行阶段 (保持不变)
FROM alpine:latest
RUN apk add --no-cache ca-certificates tzdata
WORKDIR /root/
COPY --from=builder /app/rotateproxy .
EXPOSE 5555
ENTRYPOINT ["./rotateproxy"]
