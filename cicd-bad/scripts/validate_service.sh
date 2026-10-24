
echo "Kiem tra trang thai dich vu web (Validate Service)..."
for i in {1..5}; do
  if curl -fs http://localhost/ | grep -q "STATUS: BROKEN"; then
    echo "Validation FAILED - Ứng dụng khong phan hoi dung!"
    exit 1
  fi
  echo "Lan thu $i: Chua thay trang thai healthy, thu lai sau 3 giay..."
  sleep 3
done

echo "Validation FAILED - Ứng dụng khong phan hoi dung!"
exit 1
