# TUẦN 1: TÌM HIỂU LÝ THUYẾT, THIẾT KẾ KIẾN TRÚC & DỰNG CỤM HẠ TẦNG EC2 CHO CI/CD

**Thời gian thực hiện:** 05/10/2026 – 11/10/2026  
**Mục tiêu tuần 1:**
* Nghiên cứu lý thuyết các dịch vụ cốt lõi: Quy trình CI/CD trên AWS, AWS CodeCommit, và AWS CodeDeploy.
* Thiết kế mô hình kiến trúc dự kiến và quy ước gắn nhãn (Tagging) cho tài nguyên.
* Tạo cụm máy chủ ảo Amazon EC2 (`cicd-web-1`, `cicd-web-2`) và cấu hình Tagging đầy đủ.
* Cài đặt, cấu hình và kiểm tra trạng thái hoạt động của CodeDeploy Agent trên các máy chủ EC2.
* Hoàn thành tài liệu báo cáo tiến độ tuần 1.

---

## 1. BẢNG TỔNG HỢP PHÂN CÔNG VÀ GIỜ LÀM VIỆC TUẦN 1

| Công việc | Phạm Minh Luân (24110277) | Trần Hải Đạt (24110197) | Trạng thái |
| :--- | :---: | :---: | :---: |
| **Tìm hiểu lý thuyết CI/CD, CodeCommit, CodeDeploy** | ✓ | ✓ | Hoàn thành |
| **Thiết kế kiến trúc dự kiến và quy ước tag tài nguyên** | | ✓ | Hoàn thành |
| **Tạo cụm EC2 (`cicd-web-1`, `cicd-web-2`) và cấu hình tag** | ✓ | | Hoàn thành |
| **Cài đặt, cấu hình và kiểm tra trạng thái CodeDeploy agent** | ✓ | | Hoàn thành |
| **Viết tài liệu báo cáo tiến độ tuần 1** | | ✓ | Hoàn thành |

---

## 2. CHI TIẾT CÔNG VIỆC TỪNG SINH VIÊN

### Sinh viên 1: Phạm Minh Luân (MSSV: `24110277`)
* **Tìm hiểu công nghệ:** Nghiên cứu tổng quan về mô hình CI/CD và cơ chế hoạt động của CodeCommit, CodeDeploy.
* **Khởi tạo hạ tầng EC2:** Tạo cụm 2 máy chủ ảo Amazon EC2 với tên định danh lần lượt là `cicd-web-1` và `cicd-web-2`, đồng thời thiết lập hệ thống Tagging theo đúng chuẩn quy ước của nhóm.
* **Cấu hình CodeDeploy Agent:** Tiến hành cài đặt, cấu hình và kiểm tra trạng thái hoạt động của `codedeploy-agent` trên các instance EC2 để sẵn sàng tiếp nhận mã nguồn triển khai tự động.

### Sinh viên 2: Trần Hải Đạt (MSSV: `24110197`)
* **Nghiên cứu lý thuyết:** Phối hợp nghiên cứu các tài liệu kỹ thuật về dịch vụ lưu trữ mã nguồn AWS CodeCommit và công cụ tự động hóa triển khai CodeDeploy.
* **Thiết kế hệ thống:** Xây dựng bản thiết kế kiến trúc dự kiến cho hệ thống CI/CD (DevOps & IaC) và định nghĩa quy chuẩn gắn nhãn (`Tags`) cho toàn bộ tài nguyên AWS .
* **Lập tài liệu:** Tổng hợp thông tin, soạn thảo và hoàn thiện tài liệu báo cáo tiến độ công việc của tuần 1.

---

# TUẦN 2: THIẾT LẬP CODEDEPLOY, XÂY DỰNG MÃ NGUỒN VÀ TRIỂN KHAI V1 THÀNH CÔNG LÊN 2 EC2

**Thời gian thực hiện:** 12/10/2026 – 18/10/2026  
**Mục tiêu tuần 2:**
* Tạo và cấu hình S3 Bucket (`cicd-bundles-046374136531`) lưu trữ gói revision với Versioning Enabled tại `us-east-1`.
* Khởi tạo kho lưu trữ AWS CodeCommit (`cicd-demo-repo`) tại vùng US East (N. Virginia `us-east-1`).
* Xây dựng cấu trúc mã nguồn ứng dụng v1 (`src/index.html`), file cấu hình `appspec.yml` và 5 script vòng đời (`Lifecycle Hook Scripts`).
* Cấu hình AWS CodeDeploy Application (`cicd-app`) và Deployment Group (`cicd-dg-dev`) với chiến lược `OneAtATime`, lọc máy theo tag `Env=dev` và bật Auto-Rollback.
* Đóng gói mã nguồn `app-v1.zip`, đẩy lên S3 và kích hoạt triển khai thành công lên cả 2 máy chủ EC2 (`cicd-web-1` và `cicd-web-2`).
* Kiểm thử dịch vụ web thực tế qua Public IP của 2 máy (`STATUS: healthy`).

---

## 1. BẢNG TỔNG HỢP PHÂN CÔNG VÀ GIỜ LÀM VIỆC TUẦN 2

| Công việc | Phạm Minh Luân (24110277) | Trần Hải Đạt (24110197) | Giờ làm việc | Trạng thái |
| :--- | :---: | :---: | :---: | :---: |
| **Tạo và cấu hình S3 Bucket (`cicd-bundles-046374136531`)** | ✓ | | 1.5 giờ | Hoàn thành |
| **Khởi tạo và cấu hình kho AWS CodeCommit (`cicd-demo-repo`)** | | ✓ | 1.0 giờ | Hoàn thành |
| **Xây dựng `appspec.yml`, 5 script hooks và trang web v1** | | ✓ | 3.5 giờ | Hoàn thành |
| **Tạo CodeDeploy Application (`cicd-app`) và Deployment Group (`cicd-dg-dev`)** | ✓ | | 2.5 giờ | Hoàn thành |
| **Đóng gói `app-v1.zip`, upload S3 và kích hoạt Deployment v1** | ✓ | | 2.5 giờ | Hoàn thành |
| **Kiểm thử website qua 2 Public IP, kiểm tra log hooks trên EC2** | ✓ | ✓ | 2.5 giờ | Hoàn thành |
| **Viết tài liệu báo cáo tiến độ tuần 2** | | ✓ | 2.0 giờ | Hoàn thành |

* **Tổng số giờ làm việc Tuần 2:**
  * **Phạm Minh Luân:** 9.0 giờ (Đạt yêu cầu ≥ 8 giờ/SV).
  * **Trần Hải Đạt:** 9.0 giờ (Đạt yêu cầu ≥ 8 giờ/SV).

---

## 2. CHI TIẾT CÔNG VIỆC TỪNG SINH VIÊN TUẦN 2

### Sinh viên 1: Phạm Minh Luân (MSSV: `24110277`)
* **Hạ tầng lưu trữ & Kiểm tra máy chủ:** Kiểm tra, khởi động lại 2 instance EC2 và gán tag `Env=dev`. Khởi tạo S3 Bucket `cicd-bundles-046374136531` tại `us-east-1`, bật tính năng Bucket Versioning để quản lý lịch sử revision.
* **Cấu hình CodeDeploy:** Tạo Application `cicd-app` (nền tảng EC2/On-premises) và Deployment Group `cicd-dg-dev` sử dụng role `LabRole`, lọc máy theo tag `Env=dev` (nhận diện đúng 2 instances), chiến lược `OneAtATime` và kích hoạt tự động Rollback khi gặp sự cố.
* **Thực thi triển khai:** Kích hoạt quá trình Deploy bản v1 từ S3, theo dõi tiến trình thực thi của 7 lifecycle hooks trên CodeDeploy console và xác minh trạng thái hoàn tất (`Succeeded`).

### Sinh viên 2: Trần Hải Đạt (MSSV: `24110197`)
* **Quản lý mã nguồn:** Thiết lập kho lưu trữ CodeCommit `cicd-demo-repo` tại vùng `us-east-1` và quản lý đồng bộ cây thư mục trên GitHub repo.
* **Phát triển ứng dụng & Kịch bản:** Xây dựng giao diện web phiên bản 1 (`src/index.html`), cấu hình file trung tâm `appspec.yml` và viết chi tiết 5 kịch bản hook (`stop_server.sh`, `before_install.sh`, `after_install.sh`, `start_server.sh`, `validate_service.sh`), chuẩn hóa định dạng dòng LF và quyền thực thi `+x`.
* **Kiểm thử & Lập báo cáo:** Đóng gói file nén `app-v1.zip`, kiểm thử truy cập thực tế qua 2 địa chỉ Public IP (`54.174.23.97` và `13.223.51.85`), thu thập minh chứng và hoàn thiện báo cáo tiến độ tuần 2.

---

# TUẦN 3: GIÁM SÁT BẰNG CLOUDWATCH ALARM, KIỂM THỬ ROLLBACK TỰ ĐỘNG VÀ TĂNG CƯỜNG BẢO MẬT

**Thời gian thực hiện:** 19/10/2026 – 25/10/2026  
**Mục tiêu tuần 3:**
* Triển khai phiên bản v2 (`app-v2.zip`) lên cả 2 máy chủ EC2 và xác nhận hiển thị VERSION 2.
* Tạo 4 CloudWatch Alarm (`cicd-cpu-web-1/2`, `cicd-status-web-1/2`), gắn vào Deployment Group `cicd-dg-dev` và bật Rollback khi deployment fail và khi alarm kích hoạt.
* Kiểm thử kịch bản A: triển khai bản lỗi (`app-v3-bad`), quan sát CodeDeploy tự động Rollback.
* Kiểm thử kịch bản B: ép Alarm kích hoạt khi đang triển khai, quan sát deployment bị dừng.
* Tăng cường bảo mật: giới hạn SSH theo IP cá nhân, S3 bật Block Public Access và Default encryption.
* Nghiên cứu Blue/Green Deployment (chỉ nghiên cứu, không triển khai).
* Hoàn thiện README, WORKLOG và báo cáo tiến độ Tuần 3.

---

## 1. BẢNG TỔNG HỢP PHÂN CÔNG VÀ GIỜ LÀM VIỆC TUẦN 3

| Công việc | Phạm Minh Luân (24110277) | Trần Hải Đạt (24110197) | Giờ làm việc | Trạng thái |
| :--- | :---: | :---: | :---: | :---: |
| **Kiểm tra hạ tầng đầu tuần (EC2, CodeDeploy Agent, S3)** | ✓ | | 1.5 giờ | Hoàn thành |
| **Viết `deploy.ps1` (đóng gói zip, upload S3, tạo deployment, chờ kết quả) và chạy thử** | ✓ | | 2.5 giờ | Hoàn thành |
| **Chạy kịch bản A (deploy bản lỗi, xem Rollback)** | ✓ | | 2 giờ | Hoàn thành |
| **Chạy kịch bản B (Alarm kích hoạt khi đang triển khai)** | ✓ | | 2 giờ | Hoàn thành |
| **Viết README, WORKLOG và chỉnh sửa báo cáo Word** | ✓ | | 1 giờ | Hoàn thành |
| **Triển khai phiên bản 2 (Version 2) lên 2 EC2** | | ✓ | 1.5 giờ | Hoàn thành |
| **Thiết lập 4 CloudWatch Alarm** | | ✓ | 2.0 giờ | Hoàn thành |
| **Gắn Alarm vào Deployment Group và bật Rollback** | | ✓ | 1.5 giờ | Hoàn thành |
| **Thiết lập thư mục `cicd-bad` để test lỗi** | | ✓ | 1.5 giờ | Hoàn thành |
| **Thiết lập bảo mật (Security Group, S3 Block Public Access, Default encryption)** | | ✓ | 1.5 giờ | Hoàn thành |
| **Chụp và sắp xếp ảnh minh chứng** | | ✓ | 1.0 giờ | Hoàn thành |

* **Tổng số giờ làm việc Tuần 3:**
  * **Phạm Minh Luân:** 9.0 giờ (Đạt yêu cầu ≥ 8 giờ/SV).
  * **Trần Hải Đạt:** 9.0 giờ (Đạt yêu cầu ≥ 8 giờ/SV).

---

## 2. CHI TIẾT CÔNG VIỆC TỪNG SINH VIÊN TUẦN 3

### Sinh viên 1: Phạm Minh Luân (MSSV: `24110277`)
* **Kiểm tra hạ tầng đầu tuần:** Kiểm tra 2 instance `cicd-web-1`, `cicd-web-2` đang chạy, CodeDeploy Agent hoạt động và S3 Bucket `cicd-bundles-334291484116` sẵn sàng.
* **Tự động hóa triển khai:** Viết script `deploy.ps1` thực hiện đóng gói file zip, upload lên S3, tạo deployment và chờ kết quả; chạy thử một lần để xác nhận hoạt động. Script không chứa credentials.
* **Kịch bản A (bản lỗi, Rollback):** Triển khai `app-v3-bad` (cố ý sửa `validate_service.sh` kiểm tra chuỗi `STATUS: BROKEN`). Deployment `d-CEH74P1FM` Failed ở ValidateService, CodeDeploy tự tạo rollback `d-PZ1WTY1FM` Succeeded, đưa hệ thống về `app-v2.zip`; sau đó triển khai lại v2 (`d-HP9EBB2FM`).
* **Kịch bản B (Alarm khi đang triển khai):** Triển khai v2, dùng CloudShell ép alarm `cicd-cpu-web-1` sang ALARM, deployment `d-JP3EKO2FM` bị Stopped; sau đó đưa alarm về OK và xác nhận 2 web vẫn hiển thị VERSION 2.
* **Tài liệu:** Viết README, cập nhật WORKLOG, chỉnh sửa và hoàn thiện báo cáo Word Tuần 3 (gồm phần nghiên cứu Blue/Green).

### Sinh viên 2: Trần Hải Đạt (MSSV: `24110197`)
* **Triển khai v2:** Đóng gói và triển khai `app-v2.zip` (deployment `d-MB7AKSZEM`), kiểm tra website trên Public IP của cả 2 máy chủ hiển thị VERSION 2.
* **Giám sát:** Tạo 4 CloudWatch Alarm: `cicd-cpu-web-1`, `cicd-cpu-web-2` (CPUUtilization > 80%) và `cicd-status-web-1`, `cicd-status-web-2` (StatusCheckFailed ≥ 1).
* **Tích hợp Rollback:** Gắn 4 alarm vào Deployment Group `cicd-dg-dev`, bật rollback khi deployment fail và khi alarm kích hoạt.
* **Bản lỗi kiểm thử:** Tạo thư mục `cicd-bad` chứa bản lỗi cố ý để kiểm thử rollback.
* **Bảo mật:** Giới hạn SSH của Security Group `cicd-web-sg` chỉ cho IP cá nhân (`/32`), giữ HTTP 80; bật S3 Block Public Access và Default encryption SSE-S3. Chỉ dùng `LabRole`, không tạo IAM user.
* **Minh chứng:** Chụp ảnh minh chứng (có Account ID, Region, thời gian) và sắp xếp theo thứ tự hình trong báo cáo.