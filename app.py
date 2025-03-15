from http.server import HTTPServer, BaseHTTPRequestHandler
import datetime
import signal
import sys
import time
import threading
import socket

class SimpleHTTPRequestHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()
        current_time = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        
        # 获取服务器的 IP 地址
        hostname = socket.gethostname()
        ip_address = socket.gethostbyname(hostname)
        
        response = f'Hello World - {current_time} - Server IP: {ip_address}'
        self.wfile.write(response.encode('utf-8'))

def run(server_class=HTTPServer, handler_class=SimpleHTTPRequestHandler, port=8000):
    server_address = ('', port)
    httpd = server_class(server_address, handler_class)
    print(f'启动服务器在端口 {port}...')
    
    def delayed_shutdown():
        print('等待 20 秒后关闭服务器...')
        time.sleep(20)
        print('20 秒已过，正在关闭服务器...')
        httpd.shutdown()  # 安全地停止服务器
        httpd.server_close()
        sys.exit(0)
    
    def signal_handler(sig, frame):
        print(f'收到 SIGTERM 信号，时间: {datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")}')
        # 创建一个新线程来处理延迟关闭
        shutdown_thread = threading.Thread(target=delayed_shutdown)
        shutdown_thread.daemon = True  # 设置为守护线程，这样主程序退出时它也会退出
        shutdown_thread.start()
    
    signal.signal(signal.SIGTERM, signal_handler)
    print('已注册 SIGTERM 信号处理器')
    
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        print('收到 KeyboardInterrupt，关闭服务器...')
        httpd.server_close()

if __name__ == '__main__':
    run()