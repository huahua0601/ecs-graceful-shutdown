#!/bin/bash

# 设置目标 URL
TARGET_URL="ecs-shutdown-test.ecs-test:8000/"

echo "开始持续请求 $TARGET_URL"
echo "按 Ctrl+C 停止脚本"

# 计数器
count=1

# 无限循环发送请求
while true; do
    echo "请求 #$count - $(date)"
    
    # 发送请求并显示结果
    response=$(curl -s "$TARGET_URL")
    echo "响应: $response"
    
    # 增加计数器
    count=$((count+1))
    
    # 短暂暂停，避免请求过于频繁
    sleep 1
done