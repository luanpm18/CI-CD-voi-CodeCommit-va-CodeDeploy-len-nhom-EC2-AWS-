# Triển Khai CI/CD Với CodeCommit Và CodeDeploy Lên Cụm EC2 AWS

Tài liệu kỹ thuật và hướng dẫn vận hành hệ thống tích hợp và giao hàng tự động (CI/CD) trên nền tảng Amazon Web Services.

---

## **Thông Tin Sinh Viên & Đồ Án**

### **Môn học**
Điện toán đám mây (Cloud Computing) - Đợt 1

### **Giảng viên hướng dẫn**
**TS. Huỳnh Xuân Phụng**

### **Sinh viên thực hiện**
- **Trần Hải Đạt** — MSSV: **24110197**
- **Phạm Minh Luân** — MSSV: **24110277**

### **AWS Region**
**us-east-1 (N. Virginia)**

---

## **Phân Công Nhiệm Vụ & Đóng Góp Của Từng Thành Viên**

Bảng tổng hợp chi tiết công việc từng thành viên đã thực hiện và liên kết trực tiếp đến sản phẩm, tài liệu tương ứng:

### 👤 **Trần Hải Đạt (MSSV: 24110197)**
- **Thiết kế kiến trúc & Quy chuẩn:**
  - Thiết kế sơ đồ kiến trúc hệ thống luồng CI/CD từ CodeCommit qua S3 đến CodeDeploy và EC2: [`docs/Kien Truc Du An .png`](./docs/Kien%20Truc%20Du%20An%20.png)
  - Định nghĩa tài liệu quy ước gắn nhãn (Tags) cho tài nguyên AWS: [`docs/Quy uoc Tags.md`](./docs/Quy%20uoc%20Tags.md)
- **Quản lý mã nguồn & Kịch bản triển khai:**
  - Khởi tạo và thiết lập kho lưu trữ AWS CodeCommit: [`cicd-demo-repo/`](./cicd-demo-repo/)
  - Xây dựng mã nguồn trang web giao diện v1: [`cicd-demo-repo/src/index.html`](./cicd-demo-repo/src/index.html)
  - Viết file cấu hình trung tâm vòng đời triển khai CodeDeploy: [`cicd-demo-repo/appspec.yml`](./cicd-demo-repo/appspec.yml)
  - Viết và chuẩn hóa 5 kịch bản Lifecycle Hooks: [`cicd-demo-repo/scripts/`](./cicd-demo-repo/scripts/)
    - [`stop_server.sh`](./cicd-demo-repo/scripts/stop_server.sh) — Dừng dịch vụ web
    - [`before_install.sh`](./cicd-demo-repo/scripts/before_install.sh) — Cài đặt Apache httpd & dọn dẹp thư mục cũ
    - [`after_install.sh`](./cicd-demo-repo/scripts/after_install.sh) — Phân quyền apache:apache & ghi nhật ký deploy
    - [`start_server.sh`](./cicd-demo-repo/scripts/start_server.sh) — Kích hoạt và bật dịch vụ httpd
    - [`validate_service.sh`](./cicd-demo-repo/scripts/validate_service.sh) — Kiểm tra phản hồi HTTP và trạng thái healthy
- **Soạn thảo báo cáo tiến độ:**
  - Báo cáo Tuần 1: [Bản PDF](./Bao%20Cao%20Tien%20Do/Bao%20Cao%20Tien%20Do%20Tuan%201.pdf) | [Bản Word (.docx)](./Bao%20Cao%20Tien%20Do/Bao%20Cao%20Tien%20Do%20Tuan%201.docx)
  - Báo cáo Tuần 2: [Bản PDF](./Bao%20Cao%20Tien%20Do/BaoCaoTienDoTuan2DienToanDamMay.pdf) | [Bản Word (.docx)](./Bao%20Cao%20Tien%20Do/BaoCaoTienDoTuan2DienToanDamMay.docx)
- **Chi tiết giờ làm việc:** Xem tại [WORKLOG.md — Trần Hải Đạt](./WORKLOG.md)

---

### 👤 **Phạm Minh Luân (MSSV: 24110277)**
- **Hạ tầng máy chủ Amazon EC2:**
  - Khởi tạo cụm 2 máy chủ ảo Amazon EC2 (`cicd-web-1`, `cicd-web-2`) chạy Amazon Linux 2023 tại Region `us-east-1`.
  - Cấu hình Security Group, gán nhãn tags theo quy chuẩn (`Env=dev`) và gán IAM Instance Profile `LabInstanceProfile`.
  - SSH vào cả 2 máy chủ, cài đặt, cấu hình và kiểm tra dịch vụ `codedeploy-agent` hoạt động bình thường (`active running`).
- **Hạ tầng lưu trữ S3 & Dịch vụ CodeDeploy:**
  - Tạo và cấu hình S3 Bucket lưu trữ gói revision với tính năng Versioning: `cicd-bundles-046374136531` tại Region `us-east-1`.
  - Thiết lập CodeDeploy Application (`cicd-app`) và Deployment Group (`cicd-dg-dev`) sử dụng Service Role `LabRole`.
  - Cấu hình lọc máy chủ mục tiêu theo tag `Env=dev`, áp dụng chiến lược triển khai `OneAtATime` và bật tính năng tự động Rollback khi gặp sự cố (`DEPLOYMENT_FAILURE`).
- **Thực thi triển khai & Kiểm thử thực tế:**
  - Thực hiện đóng gói mã nguồn `app-v1.zip` và đẩy lên Amazon S3.
  - Kích hoạt quá trình Deployment v1 trên AWS CodeDeploy, theo dõi và xác nhận 7 lifecycle events hoàn tất thành công (`Succeeded`).
  - Kiểm thử truy cập website thực tế qua Public IP của cả 2 máy chủ EC2, kiểm tra log triển khai tại `/var/log/cicd-deploy.log` và log của CodeDeploy Agent trên EC2.
- **Chi tiết giờ làm việc:** Xem tại [WORKLOG.md — Phạm Minh Luân](./WORKLOG.md)

---

## **Liên Kết Nhanh Đến Các Thư Mục & Tài Liệu**

Bảng điều hướng nhanh đến các tài nguyên và mã nguồn trong repository:

-  **Báo cáo tiến độ:** [`Bao Cao Tien Do/`](./Bao%20Cao%20Tien%20Do/)
  - [Báo cáo tiến độ tuần 1 (PDF)](./Bao%20Cao%20Tien%20Do/Bao%20Cao%20Tien%20Do%20Tuan%201.pdf) | [Bản Word (.docx)](./Bao%20Cao%20Tien%20Do/Bao%20Cao%20Tien%20Do%20Tuan%201.docx)
  - [Báo cáo tiến độ tuần 2 (PDF)](./Bao%20Cao%20Tien%20Do/BaoCaoTienDoTuan2DienToanDamMay.pdf) | [Bản Word (.docx)](./Bao%20Cao%20Tien%20Do/BaoCaoTienDoTuan2DienToanDamMay.docx)
-  **Nhật ký công việc (Worklog):** [`WORKLOG.md`](./WORKLOG.md)
-  **Mã nguồn ứng dụng & kịch bản triển khai:** [`cicd-demo-repo/`](./cicd-demo-repo/)
  -  **Kịch bản Lifecycle Hook (Scripts):** [`cicd-demo-repo/scripts/`](./cicd-demo-repo/scripts/)
    - [`stop_server.sh`](./cicd-demo-repo/scripts/stop_server.sh) — Dừng dịch vụ web cũ
    - [`before_install.sh`](./cicd-demo-repo/scripts/before_install.sh) — Cài đặt httpd & dọn dẹp
    - [`after_install.sh`](./cicd-demo-repo/scripts/after_install.sh) — Phân quyền & ghi log
    - [`start_server.sh`](./cicd-demo-repo/scripts/start_server.sh) — Khởi chạy dịch vụ Apache
    - [`validate_service.sh`](./cicd-demo-repo/scripts/validate_service.sh) — Kiểm tra trạng thái hoạt động (Health check)
  -  **Cấu hình CodeDeploy:** [`appspec.yml`](./cicd-demo-repo/appspec.yml)
  -  **Mã nguồn trang Web:** [`cicd-demo-repo/src/`](./cicd-demo-repo/src/) ([`index.html`](./cicd-demo-repo/src/index.html))
-  **Tài liệu thiết kế & Quy ước:** [`docs/`](./docs/)
  - [Sơ đồ kiến trúc dự án](./docs/Kien%20Truc%20Du%20An%20.png)
  - [Quy ước gắn thẻ Tags](./docs/Quy%20uoc%20Tags.md)

---

## **Kiến Trúc Hệ Thống**

<img width="1728" height="383" alt="image" src="https://github.com/user-attachments/assets/cda74307-9100-4e8d-a54c-ffc1e9929dec" />

Hệ thống được thiết kế dựa trên các dịch vụ quản lý của AWS nhằm tự động hóa quy trình triển khai ứng dụng Web:

- **GitHub / AWS CodeCommit**: Kho lưu trữ mã nguồn ứng dụng và các kịch bản triển khai tự động.
- **Amazon S3**: Lưu trữ các gói đóng gói mã nguồn (Revision Artifacts dạng .zip).
- **AWS CodeDeploy**: Điều phối và quản lý toàn bộ quá trình triển khai tự động lên cụm máy chủ.
- **EC2 Instances (cicd-web-1, cicd-web-2)**: Cụm máy chủ ảo thực thi ứng dụng Web (sử dụng Apache HTTPD).
- **CodeDeploy Agent**: Dịch vụ nền chạy trên mỗi EC2 Instance để tiếp nhận gói mã nguồn và thi hành các kịch bản (hook scripts).

---

## **Cấu Trúc Thư Mục Dự Án**

Cấu trúc lưu trữ mã nguồn và các tệp cấu hình triển khai trong repository:

```text
├── Bao Cao Tien Do/            # Báo cáo tiến độ đồ án từng tuần (Word, PDF)
├── cicd-demo-repo/             # Mã nguồn ứng dụng và các kịch bản triển khai tự động
│   ├── appspec.yml             # File cấu hình trung tâm CodeDeploy định nghĩa vòng đời triển khai
│   ├── src/
│   │   └── index.html          # Mã nguồn giao diện trang web (HTML)
│   └── scripts/                # Toàn bộ lifecycle hook scripts điều khiển máy chủ
│       ├── stop_server.sh      # Dừng dịch vụ Apache trước khi cập nhật
│       ├── before_install.sh   # Cài đặt phần mềm phụ thuộc (httpd) & dọn dẹp thư mục cũ
│       ├── after_install.sh    # Phân quyền người dùng apache:apache & ghi log triển khai
│       ├── start_server.sh     # Khởi chạy dịch vụ Apache httpd
│       └── validate_service.sh # Kiểm tra trạng thái HTTP response (STATUS: healthy)
├── docs/                       # Tài liệu thiết kế kiến trúc và quy ước gắn nhãn (Tags)
├── WORKLOG.md                  # Nhật ký phân công công việc chi tiết và giờ làm việc
└── README.md                   # Tài liệu hướng dẫn tổng quan dự án
```

---

## **Quy Trình Lifecycle Event Hooks**

CodeDeploy Agent quản lý và thi hành tuần tự các chuỗi kịch bản theo quy trình vòng đời nghiêm ngặt:

### **1. ApplicationStop ([`scripts/stop_server.sh`](./cicd-demo-repo/scripts/stop_server.sh))**
Dừng phiên bản web server cũ để giải phóng tài nguyên hệ thống.

### **2. BeforeInstall ([`scripts/before_install.sh`](./cicd-demo-repo/scripts/before_install.sh))**
Cài đặt dịch vụ Apache (`httpd`) và dọn dẹp các nội dung cũ tại thư mục `/var/www/html/`.

### **3. Install**
CodeDeploy Agent tự động giải nén gói mã nguồn được tải về từ Amazon S3 vào thư mục `/var/www/html/`.

### **4. AfterInstall ([`scripts/after_install.sh`](./cicd-demo-repo/scripts/after_install.sh))**
Thiết lập quyền sở hữu `apache:apache` cho thư mục web và ghi nhật ký triển khai vào `/var/log/cicd-deploy.log`.

### **5. ApplicationStart ([`scripts/start_server.sh`](./cicd-demo-repo/scripts/start_server.sh))**
Kích hoạt và khởi chạy lại dịch vụ Apache HTTP Server.

### **6. ValidateService ([`scripts/validate_service.sh`](./cicd-demo-repo/scripts/validate_service.sh))**
Kiểm tra phản hồi HTTP từ trang web, xác nhận chuỗi `STATUS: healthy`. Nếu bước này thất bại, hệ thống sẽ kích hoạt cơ chế **Auto-Rollback**.

---

## **Chiến Lược Triển Khai & An Toàn**

- **Chiến lược In-place (OneAtATime)**: Triển khai lần lượt trên từng máy chủ EC2. Phương thức này đảm bảo cụm máy chủ luôn có phiên bản hoạt động để phục vụ người dùng, không gây gián đoạn dịch vụ (**Zero Downtime**).
- **Tự động khôi phục (Auto-Rollback)**: Tự động hủy bỏ triển khai và đưa hệ thống quay về phiên bản ổn định gần nhất ngay khi phát sinh lỗi (`DEPLOYMENT_FAILURE`).
- **Phân quyền IAM**: Áp dụng **LabRole** cho dịch vụ CodeDeploy và **LabInstanceProfile** cho các máy chủ EC2, tuân thủ đúng tiêu chuẩn phân quyền và bảo mật trong môi trường AWS Academy.

---

## **Hướng Dẫn Triển Khai Thủ Công**

Để thực hiện quá trình đóng gói và kích hoạt triển khai bằng AWS CLI, thực hiện lần lượt các lệnh sau:

### **1. Đóng gói dự án dạng ZIP**
```bash
zip -r app-v1.zip appspec.yml src/ scripts/
```

### **2. Tải gói triển khai lên Amazon S3**
```bash
aws s3 cp app-v1.zip s3://cicd-bundles-046374136531-east-1/app-v1.zip --region us-east-1
```

### **3. Kích hoạt Deployment trên AWS CodeDeploy**
```bash
aws deploy create-deployment \
  --application-name cicd-app \
  --deployment-group-name cicd-dg-dev \
  --s3-location bucket=cicd-bundles-046374136531-east-1,key=app-v1.zip,bundleType=zip \
  --region us-east-1
```

---

## **Các Commit Tiêu Biểu Trên GitHub (Week 2)**

Các commit quan trọng ghi nhận tiến trình phát triển và hoàn thiện hệ thống trong Tuần 2:

| SHA Commit | Thông Điệp Commit | Nội Dung Triển Khai | Đường Dẫn Chi Tiết |
| :--- | :--- | :--- | :--- |
| [`5d28b9c`](https://github.com/luanpm18/CI-CD-voi-CodeCommit-va-CodeDeploy-len-nhom-EC2-AWS-/commit/5d28b9c) | `feat: complete week 2 - add cicd-demo-repo and update worklog with hours worked` | Khởi tạo thư mục mã nguồn `cicd-demo-repo`, file `appspec.yml`, 5 hook scripts và cập nhật WORKLOG Tuần 2 | [Xem Commit 5d28b9c](https://github.com/luanpm18/CI-CD-voi-CodeCommit-va-CodeDeploy-len-nhom-EC2-AWS-/commit/5d28b9c) |
| [`08dd4a6`](https://github.com/luanpm18/CI-CD-voi-CodeCommit-va-CodeDeploy-len-nhom-EC2-AWS-/commit/08dd4a6) | `Cập nhật báo cáo tiến độ tuần 2` | Cập nhật tài liệu báo cáo tiến độ tuần 2 dạng Word (.docx) và PDF | [Xem Commit 08dd4a6](https://github.com/luanpm18/CI-CD-voi-CodeCommit-va-CodeDeploy-len-nhom-EC2-AWS-/commit/08dd4a6) |
| [`1be3a85`](https://github.com/luanpm18/CI-CD-voi-CodeCommit-va-CodeDeploy-len-nhom-EC2-AWS-/commit/1be3a85) | `docs: bổ sung phân công nhiệm vụ thành viên và liên kết điều hướng tài nguyên trong README` | Bổ sung phân công chi tiết của 2 thành viên và bảng link điều hướng đến tài liệu | [Xem Commit 1be3a85](https://github.com/luanpm18/CI-CD-voi-CodeCommit-va-CodeDeploy-len-nhom-EC2-AWS-/commit/1be3a85) |

---

## **Kế Hoạch Thực Hiện Tuần 3**

Kế hoạch nâng cấp và kiểm thử nâng cao hệ thống CI/CD dự kiến trong Tuần 3:

1. **Nghiên cứu & Thiết kế Blue/Green Deployment:**
   - Tìm hiểu cơ chế chuyển hướng lưu lượng (Traffic Rerouting) bằng Application Load Balancer (ALB) kết hợp 2 Target Groups (Original và Replacement).
   - Thiết kế mô hình kiến trúc Blue/Green trên cụm EC2 để đảm bảo Zero Downtime tuyệt đối khi cập nhật phiên bản mới.
2. **Tích hợp Giám sát & Rollback Tự động theo điều kiện (CloudWatch Alarms):**
   - Thiết lập Amazon CloudWatch Alarms để theo dõi trạng thái sức khỏe của cụm EC2 (ngưỡng CPU Utilization > 80%, lỗi phản hồi HTTP 5xx).
   - Cấu hình CodeDeploy Deployment Group tự động dừng và kích hoạt Rollback ngay khi CloudWatch kích hoạt cảnh báo Alarm.
3. **Triển khai Phiên bản v2 & Kiểm thử Thực tế:**
   - Xây dựng bản cập nhật ứng dụng Web v2 và đóng gói triển khai.
   - Kiểm thử kịch bản triển khai thành công và kiểm thử kịch bản giả lập lỗi (Validation Script Fail) để kiểm tra khả năng tự động khôi phục về bản v1.
4. **Hoàn thiện Báo cáo Tiến độ Tuần 3:**
   - Cập nhật nhật ký công việc [WORKLOG.md](./WORKLOG.md) và biên soạn tài liệu báo cáo tuần 3 đầy đủ số liệu kiểm thử.

---

## **Kết Luận**

Hệ thống CI/CD trên AWS được triển khai theo mô hình thực tế, tích hợp chặt chẽ giữa **CodeCommit**, **S3**, **CodeDeploy** và **EC2**, giúp tự động hóa quy trình giao hàng phần mềm một cách ổn định, an toàn và dễ vận hành. Việc áp dụng lifecycle hooks và cơ chế rollback giúp giảm thiểu rủi ro trong quá trình cập nhật phiên bản ứng dụng trên môi trường sản xuất ảo.

