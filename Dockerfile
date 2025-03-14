FROM python:3.12-slim

WORKDIR /app

COPY app.py /app/

# 安装 curl 用于健康检查
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# 暴露 8000 端口
EXPOSE 8000

# 设置健康检查
HEALTHCHECK --interval=5s --timeout=3s --retries=3 CMD curl -f http://localhost:8000/ || exit 1

# 使用 CMD 而不是 ENTRYPOINT 以便更容易被覆盖
CMD ["python3", "app.py"]