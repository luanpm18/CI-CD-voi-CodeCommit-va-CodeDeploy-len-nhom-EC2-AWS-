#!/bin/bash
# ==============================================================================
# Hook: ApplicationStart
# Tác dụng: Kích hoạt tự khởi động cùng hệ thống và chạy dịch vụ web server Apache (httpd)
# để website bắt đầu tiếp nhận request của người dùng.
# ==============================================================================

set -e

echo "Kich hoat va bat dich vu httpd..."
systemctl enable httpd
systemctl start httpd
