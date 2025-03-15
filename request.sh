#!/bin/bash

# 设置目标 URL
TARGET_URL="ecs-shutdown-test.ecs-test:8000/"
TARGET_HOST="ecs-shutdown-test.ecs-test"

echo "开始持续请求 $TARGET_URL"
echo "按 Ctrl+C 停止脚本"

# 计数器
count=1

# 无限循环发送请求
while true; do
    # 解析目标域名的 IP 地址
    resolved_ip=$(dig +short $TARGET_HOST || nslookup $TARGET_HOST | grep -i address | tail -n1 | awk '{print $2}')
    
    echo "请求 #$count - $(date) - 目标 IP: $resolved_ip"
    
    # 发送请求并显示结果
    response=$(curl -s "$TARGET_URL")
    echo "响应: $response"
    
    # 增加计数器
    count=$((count+1))
    
    # 短暂暂停，避免请求过于频繁
    sleep 1
done