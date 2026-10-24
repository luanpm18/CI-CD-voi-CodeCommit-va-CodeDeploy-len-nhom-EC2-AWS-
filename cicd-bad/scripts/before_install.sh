#!/bin/bash
# ==============================================================================
# Hook: BeforeInstall
# Tác dụng: Chuẩn bị môi trường hệ thống trước khi CodeDeploy copy các file mới vào.
# Các công việc:
#   1. Đảm bảo gói httpd (Apache) đã được cài đặt trên máy EC2.
#   2. Xóa sạch các file cũ trong /var/www/html để tránh xung đột hoặc rác mã nguồn cũ.
# 'set -e': Nếu có bất kỳ lệnh nào bị lỗi, script sẽ dừng ngay lập tức và báo fail.
# ==============================================================================

set -e

echo "Cai dat httpd (neu chua co)..."
dnf install -y httpd

echo "Don sach thu muc web cu /var/www/html..."
rm -rf /var/www/html/*
