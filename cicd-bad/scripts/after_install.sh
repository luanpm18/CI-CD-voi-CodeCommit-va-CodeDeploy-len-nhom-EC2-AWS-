#!/bin/bash
# ==============================================================================
# Hook: AfterInstall
# Tác dụng: Chạy sau khi CodeDeploy Agent đã copy các file mã nguồn vào /var/www/html.
# Các công việc:
#   1. Phân quyền sở hữu thư mục web cho user/group apache.
#   2. Thiết lập quyền truy cập 755 để web server đọc được file.
#   3. Ghi lại mốc thời gian và tên máy đã triển khai vào file log hệ thống (/var/log/cicd-deploy.log).
# ==============================================================================

set -e

echo "Phan quyen thu muc web..."
chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html

echo "Ghi nhat ky deploy vao log he thong..."
echo "$(date -u +%FT%TZ) deployed on $(hostname)" >> /var/log/cicd-deploy.log
