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


---

# TUẦN 4: KIỂM THỬ TỔNG THỂ, TỐI ƯU CHI PHÍ, QUAY VIDEO DEMO VÀ DỌN DẸP HẠ TẦNG

**Thời gian thực hiện:** 26/10/2026 – 01/11/2026  
**Mục tiêu tuần 4:**
* Khởi động lại Learner Lab, rà soát tính nhất quán tài nguyên (Account ID `3342-9148-4116`, Region `us-east-1`, 2 EC2, S3, CodeDeploy, 4 CloudWatch Alarm).
* Thực hiện kiểm thử toàn diện kịch bản E1–E6: chu trình hoàn chỉnh v3 final, bản lỗi `cicd-bad` và auto-rollback, alarm dừng deployment và rollback, redeploy cùng revision, stop/start EC2 kiểm tra IP mới và rà soát bảo mật.
* Thiết kế và hoàn thiện 4 sơ đồ kiến trúc Draw.io (`KienTrucTongThe.drawio`).
* Tính toán, rà soát chi phí thực tế trên Learner Lab và tổng kết các biện pháp tối ưu chi phí.
* Sản xuất và hoàn thiện Video Demo nghiệm thu $\le$ 10 phút chuẩn 1080p.
* Hoàn thiện Báo cáo tổng kết cuối kỳ và chuẩn bị bộ câu hỏi ôn tập vấn đáp.
* Thực hiện quy trình dọn dẹp tài nguyên an toàn (Teardown) theo hướng dẫn.

---

## 1. BẢNG TỔNG HỢP PHÂN CÔNG VÀ GIỜ LÀM VIỆC TUẦN 4

| Công việc | Phạm Minh Luân (24110277) | Trần Hải Đạt (24110197) | Giờ làm việc | Trạng thái |
| :--- | :---: | :---: | :---: | :---: |
| **Khởi động lab, rà soát nhất quán, kiểm tra tag** | ✓ | ✓ | 1.0 giờ | Hoàn thành |
| **Kiểm thử E1 (Chu trình đầy đủ v3-final)** | ✓ | | 1.5 giờ | Hoàn thành |
| **Kiểm thử E2 (Bản lỗi và Auto-Rollback)** | ✓ | | 1.5 giờ | Hoàn thành |
| **Kiểm thử E3 (Alarm kích hoạt dừng deployment)** | ✓ | | 1.5 giờ | Hoàn thành |
| **Kiểm thử E4 & E5 (Redeploy, Stop/Start EC2)** | ✓ | | 1.0 giờ | Hoàn thành |
| **Kiểm thử E6 (Bảo mật S3 HTTP 403, Security Group)** | | ✓ | 1.0 giờ | Hoàn thành |
| **Rà soát chi phí Learner Lab & Bảng đối chiếu đơn giá** | | ✓ | 1.5 giờ | Hoàn thành |
| **Thiết kế sơ đồ kiến trúc tổng thể bằng Draw.io** | | ✓ | 2.0 giờ | Hoàn thành |
| **Viết tài liệu báo cáo tuần 4 và cập nhật WORKLOG** | ✓ | | 2.0 giờ | Hoàn thành |
| **Quay, dựng và biên tập Video Demo ($\le$ 10 phút)** | ✓ | ✓ | 2.5 giờ | Hoàn thành |
| **Dọn dẹp tài nguyên (Teardown) & Chụp ảnh minh chứng** | | ✓ | 1.5 giờ | Hoàn thành |
| **Luyện tập trả lời câu hỏi vấn đáp bảo vệ đề tài** | ✓ | ✓ | 1.0 giờ | Hoàn thành |

* **Tổng số giờ làm việc Tuần 4:**
  * **Phạm Minh Luân:** 9.5 giờ (Đạt yêu cầu ≥ 8 giờ/SV).
  * **Trần Hải Đạt:** 9.5 giờ (Đạt yêu cầu ≥ 8 giờ/SV).

---

## 2. CHI TIẾT CÔNG VIỆC TỪNG SINH VIÊN TUẦN 4

### Sinh viên 1: Phạm Minh Luân (MSSV: `24110277`)
* **Khởi động & Rà soát:** Khởi động phiên Learner Lab, kiểm tra 2 instance `cicd-web-1` (`i-0c88f250e4a1250be`), `cicd-web-2` (`i-08a124556f6dbc4f6`) ở trạng thái Running, 4 CloudWatch Alarm ở trạng thái OK. Đồng bộ và thống nhất Account ID `3342-9148-4116` cho toàn bộ tài liệu Tuần 4.
* **Kịch bản E1 (Triển khai thành công):** Cập nhật `src/index.html` lên Version 3 (FINAL), giữ nguyên chuỗi `STATUS: healthy`. Kích hoạt `deploy.ps1` tạo deployment `d-4CIUR6KJM` (Succeeded trên 2/2 instances). Kiểm tra thành công trên 2 Public IP (`18.208.211.199`, `98.85.228.72`).
* **Kịch bản E2 (Bản lỗi & Rollback):** Tạo bản `cicd-bad` cố ý sửa script kiểm tra `STATUS: BROKEN`. Deployment `d-0SY9I0KJM` Failed tại ValidateService ở máy 1; máy 2 Skipped nhờ chiến lược `OneAtATime`. CodeDeploy tự động tạo rollback `d-Y2UUK3KJM` Succeeded đưa hệ thống an toàn về bản v3.
* **Kịch bản E3 (Alarm dừng deployment):** Tạo bản `cicd-slow` (sleep 60), deploy `d-YBIC2XJJM`. Dùng CloudShell ép alarm `cicd-cpu-web-1` sang ALARM. Deployment bị Stopped ngay lập tức; CodeDeploy tự động kích hoạt rollback `d-09UIP8KJM` Succeeded. Reset alarm về OK.
* **Kịch bản E4 & E5:** Chạy redeploy cùng revision `app-v3-final.zip` (`d-EPNF9QJJM` Succeeded). Dừng và bật lại 2 EC2, kiểm tra website tự chạy trên IP mới (`52.90.161.132` và `98.91.192.187`) nhờ `systemctl enable httpd`.
* **Thực hiện Video Demo:** Thao tác trực tiếp trên màn hình các bước triển khai Git, CodeDeploy và kiểm thử rollback cho video demo nghiệm thu.
* **Soạn thảo tài liệu:** Tổng hợp kết quả kiểm thử, viết báo cáo tiến độ Tuần 4 và cập nhật WORKLOG.md.

### Sinh viên 2: Trần Hải Đạt (MSSV: `24110197`)
* **Kiểm tra bảo mật (E6):** Dùng lệnh `curl.exe` xác minh S3 Bucket `cicd-bundles-334291484116` trả về `HTTP 403 Forbidden` khi truy cập công khai. Xác nhận Block Public Access bật ON, Default encryption SSE-S3 AES256. Kiểm tra Security Group `cicd-web-sg` chỉ mở SSH port 22 cho IP quản trị `14.191.90.189/32`.
* **Phân tích & Tối ưu chi phí:** Theo dõi số dư credit trên Learner Lab (`Used $1.4 of $50`), lập bảng tính chi phí ước tính ($0.73 USD cho 2 máy `t2.micro` chạy ~30h). Tổng kết các phương án tối ưu: dừng máy cuối mỗi buổi, không dùng ALB/NAT, giữ alarm trong Free Tier.
* **Thiết kế sơ đồ kiến trúc Draw.io:** Xây dựng và xuất file `KienTrucTongThe.drawio` mô tả chi tiết: luồng dữ liệu Git $\rightarrow$ CodeCommit $\rightarrow$ S3 $\rightarrow$ CodeDeploy $\rightarrow$ 2 Subnet EC2, kèm 4 CloudWatch Alarm và cơ chế Rollback.
* **Sản xuất Video Demo:** Xây dựng kịch bản 8 phân đoạn chi tiết, thực hiện quay màn hình và biên tập hậu kỳ video (cắt gọt đoạn thừa, tua nhanh các bước chờ deploy, chèn nhãn thời lượng $\le$ 10 phút, xuất file 1080p).
* **Dọn dẹp hạ tầng (Teardown):** Lập quy trình và thực thi xóa an toàn tài nguyên theo thứ tự: CodeDeploy App/Group $\rightarrow$ CloudWatch Alarms $\rightarrow$ Terminate 2 EC2 $\rightarrow$ Xóa S3 Bucket (bao gồm versions và delete markers) $\rightarrow$ Xóa Security Group.
* **Hoàn thiện tài liệu:** Hỗ trợ viết báo cáo cuối kỳ, chuẩn bị phụ lục AI và ôn luyện bộ câu hỏi vấn đáp đề tài.

---

## 3. LINK VIDEO DEMO & NGHIỆM THU ĐỀ TÀI

* **Link Video Demo (Google Drive / YouTube):** https://drive.google.com/drive/folders/1mei0B_mjRlydAkb_a3_3tgatSokdC2xK?usp=sharing / https://youtu.be/dkLdsP9fIHs
* **Minh chứng hợp lệ:** Video thể hiện đầy đủ Account ID (`3342-9148-4116`), Region (`us-east-1`) và đồng hồ hệ thống góc màn hình; hoàn toàn không để lộ thông tin credentials.

---

## 4. TỔNG KẾT CHI PHÍ VÀ KẾT QUẢ ĐỒ ÁN

| Hạng mục tài nguyên | Số lượng / Thời gian dùng | Chi phí thực tế (Ước tính) | Trạng thái sau nghiệm thu |
| :--- | :---: | :---: | :---: |
| **EC2 `t2.micro` (Amazon Linux 2023)** | 2 instances $\times$ ~30 giờ | ~$0.70 USD | Đã Terminated / Dọn dẹp an toàn |
| **EBS gp3 Volume (Ổ đĩa gốc)** | 2 ổ $\times$ 8 GB | ~$0.03 USD | Đã xóa theo EC2 |
| **Amazon S3 Standard (Revision Bucket)** | 1 bucket (6 file revision, ~60 KB) | ~$0.00 USD | Đã xóa toàn bộ version & bucket |
| **Amazon CloudWatch Alarms** | 4 Metric Alarms | $0.00 USD (Trong Free Tier) | Đã xóa 4 alarms |
| **AWS CodeDeploy & CodeCommit** | 1 App, 1 Group, 1 Repo | $0.00 USD (Hỗ trợ theo lab) | Đã dọn dẹp an toàn |
| **Tổng mức Credit sử dụng (Learner Lab)** | **Used $1.4 of $50** | Tiết kiệm tối đa ngân sách | Hệ thống dọn dẹp sạch sẽ |
