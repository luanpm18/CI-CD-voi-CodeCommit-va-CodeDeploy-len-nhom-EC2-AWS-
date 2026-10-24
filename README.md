# CI/CD với AWS CodeCommit, CodeDeploy và cụm EC2

Dự án xây dựng quy trình triển khai ứng dụng web tự động lên hai máy chủ Amazon EC2 bằng AWS CodeCommit, Amazon S3 và AWS CodeDeploy. Đến hết **Tuần 3**, nhóm đã triển khai Version 2, cấu hình giám sát CloudWatch, kiểm thử rollback và rà soát các thiết lập bảo mật cơ bản.

## Thông tin đồ án

- **Môn học:** Điện toán đám mây
- **Giảng viên hướng dẫn:** TS. Huỳnh Xuân Phụng
- **Sinh viên:** Trần Hải Đạt (24110197), Phạm Minh Luân (24110277)
- **AWS Region:** `us-east-1` (N. Virginia)

## Tiến độ thực hiện

| Tuần | Công việc và kết quả |
| --- | --- |
| **1** | Tìm hiểu CI/CD trên AWS, thiết kế kiến trúc và khởi tạo cụm hai EC2 (`cicd-web-1`, `cicd-web-2`) cùng CodeDeploy Agent. |
| **2** | Tạo CodeCommit repository `cicd-demo-repo`, S3 bucket lưu revision, ứng dụng Version 1, `appspec.yml` và các lifecycle hook; triển khai Version 1 thành công. |
| **3** | Triển khai Version 2; tạo bốn CloudWatch Alarm và gắn vào Deployment Group; kiểm thử triển khai lỗi/rollback và dừng triển khai do alarm; rà soát bảo mật S3 và quyền SSH. |

### Kết quả đã xác nhận trong Tuần 3

- Version 2 hiển thị trạng thái `STATUS: healthy` trên cả hai máy chủ.
- Bốn CloudWatch Alarm ở trạng thái bình thường sau khi cấu hình:
  - `cicd-cpu-web-1` và `cicd-cpu-web-2`: theo dõi `CPUUtilization`, báo động khi trung bình lớn hơn 80% trong 5 phút.
  - `cicd-status-web-1` và `cicd-status-web-2`: theo dõi `StatusCheckFailed`, báo động khi giá trị đạt ít nhất 1 trong 1 phút.
- Deployment Group `cicd-dg-dev` dùng chiến lược `OneAtATime`, gắn các alarm và bật rollback khi deployment thất bại hoặc khi ngưỡng alarm bị kích hoạt.
- **Kiểm thử bản lỗi:** `ValidateService` thất bại với bản cố ý làm sai chuỗi kiểm tra; CodeDeploy tự triển khai lại revision Version 2 thành công. Máy chủ còn lại được bỏ qua trong lượt triển khai lỗi.
- **Kiểm thử alarm:** khi alarm `cicd-cpu-web-1` được chuyển sang trạng thái báo động trong lúc triển khai, deployment đang chạy chuyển sang `Stopped`.
- S3 bật chặn truy cập công khai và mã hóa mặc định SSE-S3; quy tắc SSH được giới hạn theo IP quản trị thay vì mở cho mọi địa chỉ.
- Nhóm đã tìm hiểu Blue/Green Deployment. Dự án hiện dùng In-place theo yêu cầu và giới hạn tài nguyên của AWS Learner Lab; `OneAtATime` không đồng nghĩa với bảo đảm không gián đoạn dịch vụ.

## Báo cáo, tài liệu và phân công Tuần 3

- **Báo cáo tiến độ Tuần 3:** [PDF](./Bao%20Cao%20Tien%20Do/BaoCaoTienDoTuan3DienToanDamMay.pdf) | [Word](./Bao%20Cao%20Tien%20Do/BaoCaoTienDoTuan3DienToanDamMay.docx)
- **Báo cáo các tuần trước:** [Tuần 1 (PDF)](./Bao%20Cao%20Tien%20Do/Bao%20Cao%20Tien%20Do%20Tuan%201.pdf) | [Tuần 2 (PDF)](./Bao%20Cao%20Tien%20Do/BaoCaoTienDoTuan2DienToanDamMay.pdf)
- **Nhật ký công việc:** [WORKLOG.md](./WORKLOG.md)
- **Tài liệu thiết kế:** [Sơ đồ kiến trúc](./docs/Kien%20Truc%20Du%20An%20.png) | [Quy ước gắn tag](./docs/Quy%20uoc%20Tags.md)

Phân công chính trong Tuần 3:

- **Trần Hải Đạt:** triển khai Version 2, thiết lập CloudWatch Alarm và rollback trong Deployment Group, chuẩn bị revision lỗi để kiểm thử và rà soát bảo mật.
- **Phạm Minh Luân:** kiểm tra hạ tầng, xây dựng quy trình triển khai và kiểm thử các kịch bản rollback/alarm, cập nhật README, worklog và báo cáo.

## Kiến trúc và luồng triển khai

```text
AWS CodeCommit
      │ mã nguồn
      ▼
Amazon S3 (các gói revision, bật versioning)
      │ revision .zip
      ▼
AWS CodeDeploy ── Deployment Group: cicd-dg-dev
      │             OneAtATime + CloudWatch Alarms + rollback
      ▼
EC2: cicd-web-1, cicd-web-2
      └── CodeDeploy Agent triển khai ứng dụng Apache HTTP Server
```

Deployment Group nhận diện EC2 bằng tag `Env=dev`. Quy trình triển khai thực hiện lần lượt các lifecycle event:

1. `ApplicationStop` — dừng dịch vụ cũ (`scripts/stop_server.sh`).
2. `BeforeInstall` — cài Apache và chuẩn bị thư mục đích (`scripts/before_install.sh`).
3. `Install` — CodeDeploy chép nội dung từ revision vào `/var/www/html/`.
4. `AfterInstall` — thiết lập quyền và ghi log (`scripts/after_install.sh`).
5. `ApplicationStart` — khởi động Apache (`scripts/start_server.sh`).
6. `ValidateService` — kiểm tra phản hồi có chuỗi `STATUS: healthy` (`scripts/validate_service.sh`).

Nếu hook kiểm tra thất bại, CodeDeploy đánh dấu deployment thất bại và có thể tự khôi phục theo cấu hình rollback. Alarm chuyển sang trạng thái báo động có thể dừng deployment; hành vi rollback do alarm được điều khiển riêng bởi cấu hình trong Deployment Group.

## Cấu trúc repository

```text
.
├── Bao Cao Tien Do/           # Báo cáo Word/PDF theo tuần
├── cicd-demo-repo/
│   ├── appspec.yml
│   ├── src/
│   │   └── index.html
│   └── scripts/
│       ├── stop_server.sh
│       ├── before_install.sh
│       ├── after_install.sh
│       ├── start_server.sh
│       └── validate_service.sh
├── docs/                      # Sơ đồ kiến trúc và quy ước tag
├── WORKLOG.md
└── README.md
```

## Đóng gói và triển khai thủ công

Các lệnh dưới đây chạy trong PowerShell tại thư mục gốc repository. Điền tên bucket đang dùng vào `$BucketName`; không lưu access key hoặc thông tin xác thực trong repository.

```powershell
$BucketName = "ten-bucket-cua-ban"

# Đóng gói với appspec.yml ở thư mục gốc của file ZIP
Push-Location .\cicd-demo-repo
Compress-Archive -Path .\appspec.yml, .\src, .\scripts `
  -DestinationPath ..\app-v2.zip -Force
Pop-Location

# Tải revision lên S3
aws s3 cp .\app-v2.zip "s3://$BucketName/app-v2.zip" --region us-east-1

# Tạo deployment
aws deploy create-deployment `
  --application-name cicd-app `
  --deployment-group-name cicd-dg-dev `
  --s3-location "bucket=$BucketName,key=app-v2.zip,bundleType=zip" `
  --region us-east-1
```

Theo dõi trạng thái deployment trong AWS CodeDeploy trước khi xác nhận ứng dụng trên cả hai EC2. Không triển khai revision lỗi dùng riêng cho kiểm thử rollback vào môi trường sử dụng bình thường.

## Bảo mật và lưu ý vận hành

- Dùng IAM role của môi trường lab; không tạo hoặc commit IAM access key dài hạn.
- Chỉ mở SSH (TCP 22) cho địa chỉ quản trị cần thiết. Chỉ mở HTTP (TCP 80) công khai khi cần phục vụ website.
- Giữ bật S3 Block Public Access, mã hóa mặc định SSE-S3 và versioning cho bucket revision.
- Kiểm tra trạng thái EC2 và CloudWatch Alarm trước khi triển khai. Sau khi mô phỏng alarm để kiểm thử, đưa alarm về trạng thái bình thường.
- Tài nguyên AWS, địa chỉ IP và trạng thái dịch vụ có thể thay đổi hoặc bị thu hồi khi phiên AWS Learner Lab kết thúc.

## Kế hoạch Tuần 4

- Kiểm thử tổng thể lại luồng thành công, rollback khi triển khai lỗi và dừng deployment khi alarm kích hoạt.
- Rà soát chi phí, dọn dẹp tài nguyên sau khi hoàn tất demo.
- Hoàn thiện báo cáo cuối kỳ với kết quả kiểm thử và minh chứng.
- Quay video demo khoảng 10 phút về quy trình CI/CD và các kịch bản phục hồi.
