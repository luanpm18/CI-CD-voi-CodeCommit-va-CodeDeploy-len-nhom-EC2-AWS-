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
├── appspec.yml                 # File cấu hình trung tâm định nghĩa các giai đoạn triển khai
├── src/
│   └── index.html              # Mã nguồn trang chủ ứng dụng Web
├── scripts/
│   ├── stop_server.sh          # Dừng dịch vụ Apache trước khi cập nhật
│   ├── before_install.sh       # Cài đặt phần mềm phụ thuộc (httpd) & dọn dẹp thư mục cũ
│   ├── after_install.sh        # Phân quyền người dùng apache:apache & ghi log
│   ├── start_server.sh         # Khởi chạy dịch vụ Apache httpd
│   └── validate_service.sh     # Kiểm tra trạng thái HTTP response (STATUS: healthy)
└── README.md
```

---

## **Quy Trình Lifecycle Event Hooks**

CodeDeploy Agent quản lý và thi hành tuần tự các chuỗi kịch bản theo quy trình vòng đời nghiêm ngặt:

### **1. ApplicationStop (`scripts/stop_server.sh`)**
Dừng phiên bản web server cũ để giải phóng tài nguyên hệ thống.

### **2. BeforeInstall (`scripts/before_install.sh`)**
Cài đặt dịch vụ Apache (`httpd`) và dọn dẹp các nội dung cũ tại thư mục `/var/www/html/`.

### **3. Install**
CodeDeploy Agent tự động giải nén gói mã nguồn được tải về từ Amazon S3 vào thư mục `/var/www/html/`.

### **4. AfterInstall (`scripts/after_install.sh`)**
Thiết lập quyền sở hữu `apache:apache` cho thư mục web và ghi nhật ký triển khai vào `/var/log/cicd-deploy.log`.

### **5. ApplicationStart (`scripts/start_server.sh`)**
Kích hoạt và khởi chạy lại dịch vụ Apache HTTP Server.

### **6. ValidateService (`scripts/validate_service.sh`)**
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

## **Kết Luận**

Hệ thống CI/CD trên AWS được triển khai theo mô hình thực tế, tích hợp chặt chẽ giữa **CodeCommit**, **S3**, **CodeDeploy** và **EC2**, giúp tự động hóa quy trình giao hàng phần mềm một cách ổn định, an toàn và dễ vận hành. Việc áp dụng lifecycle hooks và cơ chế rollback giúp giảm thiểu rủi ro trong quá trình cập nhật phiên bản ứng dụng trên môi trường sản xuất ảo.

