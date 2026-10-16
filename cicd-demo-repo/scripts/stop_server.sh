#!/bin/bash
# ==============================================================================
# Hook: ApplicationStop
# Tác dụng: Dừng web server Apache (httpd) để chuẩn bị cập nhật mã nguồn mới.
# Lưu ý quan trọng: Lệnh có thêm '|| true' để tránh bị báo lỗi thất bại ở lần deploy đầu tiên
# khi dịch vụ httpd chưa hề được cài đặt hoặc khởi chạy.
# ==============================================================================

echo "Dang dung dich vu httpd..."
systemctl stop httpd || true
exit 0
