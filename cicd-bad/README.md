# cicd-bad: bản lỗi CỐ Ý (dùng để test rollback)

Thư mục này chứa bản app-v3-bad. File validate_service.sh được sửa cố ý
để kiểm tra chuỗi "STATUS: BROKEN" nên ValidateService luôn thất bại.

Mục đích: chứng minh CodeDeploy tự rollback về app-v2.zip.
- Deploy lỗi: d-CEH74P1FM (Failed ở ValidateService)
- Rollback tự động: d-PZ1WTY1FM (Succeeded)

KHÔNG deploy bản này lên môi trường thật.