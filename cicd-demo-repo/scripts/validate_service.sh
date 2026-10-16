#!/bin/bash
# ==============================================================================
# Hook: ValidateService
# Tác dụng: Kiểm tra tính sẵn sàng và độ ổn định của website sau khi vừa khởi động.
# Cơ chế hoạt động:
#   - Dùng curl gửi HTTP request vào chính máy chủ (localhost) tối đa 5 lần (cách nhau 3s).
#   - Quét tìm dòng chữ 'STATUS: healthy' trong nội dung HTML trả về.
#   - Nếu tìm thấy: trả về exit 0 -> CodeDeploy đánh dấu deployment THÀNH CÔNG (Success).
#   - Nếu sau 5 lần không thấy: trả về exit 1 -> CodeDeploy đánh dấu THẤT BẠI (Failed)
#     và tự động kích hoạt tiến trình Rollback về phiên bản trước.
# ==============================================================================

echo "Kiem tra trang thai dich vu web (Validate Service)..."
for i in {1..5}; do
  if curl -fs http://localhost/ | grep -q "STATUS: healthy"; then
    echo "Validation OK - Ứng dụng hoạt động bình thường!"
    exit 0
  fi
  echo "Lan thu $i: Chua thay trang thai healthy, thu lai sau 3 giay..."
  sleep 3
done

echo "Validation FAILED - Ứng dụng khong phan hoi dung!"
exit 1
