# Báo cáo công việc Tuần 4

## Công việc đã hoàn thành

### 1. Kiểm thử tổng thể chu trình triển khai thành công (Kịch bản E1)
- Cập nhật mã nguồn `src/index.html` hiển thị **VERSION 3 (FINAL)**, giữ nguyên dòng trạng thái kiểm tra sức khỏe `STATUS: healthy`.
- Đóng gói mã nguồn `app-v3-final.zip`, tải lên S3 Bucket `cicd-bundles-334291484116` (Region `us-east-1`) và kích hoạt triển khai bằng CodeDeploy (deployment `d-4CIUR6KJM`).
- Quá trình triển khai theo chiến lược `OneAtATime` thành công tốt đẹp (`Succeeded` trên 2/2 instances).
- Kiểm tra website thực tế trên Public IP của cả 2 máy chủ (`18.208.211.199` và `98.85.228.72`), cả hai đều phản hồi mã HTTP 200 và hiển thị đúng giao diện **CI/CD Demo - Version 3 (FINAL)**.

### 2. Kiểm thử kịch bản bản lỗi và cơ chế tự động Rollback (Kịch bản E2)
- Tạo bản kiểm thử `cicd-bad` (gói `app-v4-bad.zip`), cố ý sửa script `validate_service.sh` quét tìm chuỗi sai `STATUS: BROKEN` thay vì chuỗi chuẩn `STATUS: healthy`.
- Kích hoạt deployment `d-0SY9I0KJM`. CodeDeploy triển khai máy 1 (`cicd-web-1`), bước `ValidateService` thất bại (`ScriptFailed`, exit code 1) sau 5 lần thử lại (`Validation FAILED`).
- Máy 2 (`cicd-web-2`) ở trạng thái **Skipped**, không bị ảnh hưởng nhờ chiến lược triển khai tuần tự `OneAtATime`.
- CodeDeploy kích hoạt cơ chế an toàn, tự động tạo deployment rollback `d-Y2UUK3KJM` đưa hệ thống về lại phiên bản ổn định gần nhất (`app-v3-final.zip`). Quá trình rollback thành công (`Succeeded`), website trên cả 2 máy chủ được bảo toàn nguyên vẹn.

### 3. Kiểm thử kịch bản dừng triển khai khi CloudWatch Alarm kích hoạt (Kịch bản E3)
- Tạo bản cập nhật `cicd-slow` (gói `app-cicd-slow.zip`, thêm lệnh chờ `sleep 60` ở bước `AfterInstall` để kéo dài thời gian triển khai).
- Kích hoạt deployment `d-YBIC2XJJM`. Trong lúc deployment đang ở trạng thái `In progress`, sử dụng AWS CloudShell chạy lệnh `aws cloudwatch set-alarm-state` ép alarm `cicd-cpu-web-1` chuyển sang trạng thái `ALARM` (mô phỏng tải CPU vượt ngưỡng 80%).
- CodeDeploy phát hiện alarm báo động, lập tức hủy và chuyển deployment `d-YBIC2XJJM` sang trạng thái **Stopped**.
- Hệ thống tự động kích hoạt deployment rollback `d-09UIP8KJM` (`Succeeded`) quay về bản `app-v3-final.zip`.
- Đưa alarm trở lại trạng thái `OK` bằng lệnh reset và xác nhận cả 4 CloudWatch Alarm đều hoạt động ổn định.

### 4. Kiểm thử tính tái sử dụng và độ bền vững hạ tầng (Kịch bản E4, E5)
- **Redeploy cùng revision (E4):** Chạy lại triển khai với gói `app-v3-final.zip` có sẵn trên S3 (deployment `d-EPNF9QJJM` thành công), xác nhận script `ApplicationStop` dừng dịch vụ Apache của phiên bản trước một cách chính xác.
- **Stop / Start máy chủ EC2 (E5):** Tắt 2 máy EC2 rồi khởi động lại. Địa chỉ Public IP đổi thành `52.90.161.132` (`cicd-web-1`) và `98.91.192.187` (`cicd-web-2`). Website vẫn tự động phục vụ phiên bản 3 mà không cần deploy lại do dịch vụ `httpd` đã được cấu hình tự khởi động cùng OS (`systemctl enable httpd`). CodeDeploy Agent tự kết nối lại sau 2–3 phút.

### 5. Rà soát bảo mật toàn diện (Kịch bản E6)
- **S3 Bucket:** Bucket `cicd-bundles-334291484116` bật tính năng **Block all public access** (lệnh `curl.exe` truy cập trực tiếp trả về mã `403 Forbidden`), cấu hình **Default encryption SSE-S3 (AES256)** và bật Bucket Versioning.
- **Security Group:** Nhóm bảo mật `cicd-web-sg` (`sg-0356e87358afd3597`) siết chặt cổng SSH (port 22) chỉ cho phép duy nhất địa chỉ IP quản trị cá nhân (`14.191.90.189/32`), cổng HTTP (port 80) mở `0.0.0.0/0` để phục vụ truy cập web.
- **Quyền hạn IAM:** Tuân thủ nguyên tắc đặc quyền tối thiểu của AWS Learner Lab, chỉ sử dụng `LabRole` cho CodeDeploy và `LabInstanceProfile` cho EC2, tuyệt đối không tạo IAM User hay lưu trữ credentials cứng trong mã nguồn.

### 6. Rà soát chi phí và tối ưu tài nguyên
- Mức credit sử dụng ghi nhận trên giao diện AWS Academy Learner Lab: **Used $1.4 of $50** (chi phí phát sinh thêm trong Tuần 4 xấp xỉ 0 USD).
- Chi phí ước tính theo đơn giá thực tế: 2 máy `t2.micro` chạy ~30 giờ (~0.70 USD), lưu trữ EBS 8 GB gp3 (~0.03 USD), gói lưu trữ S3 dung lượng ~60 KB (~0.00 USD).
- Nhóm đã tối ưu chi phí triệt để bằng cách luôn `Stop` máy chủ EC2 cuối mỗi buổi làm việc, không dùng các dịch vụ phát sinh phí theo giờ như ALB, NAT Gateway hay Elastic IP.

---

## Video Demo & Nghiệm Thu Đề Tài

Nhóm đã hoàn thành video clip thuyết minh và demo toàn bộ hệ thống CI/CD với thời lượng dưới 10 phút, độ phân giải 1080p, hiển thị đầy đủ Account ID (`3342-9148-4116`), Region (`us-east-1`) và đồng hồ hệ thống.

- **Link Video Demo (YouTube / Google Drive):** `https://drive.google.com/file/d/your-video-link-here/view` 

---

## Link Github của dự án

- **Link Repo tổng:** https://github.com/luanpm18/CI-CD-voi-CodeCommit-va-CodeDeploy-len-nhom-EC2-AWS-/tree/main
- **Link trang đề tài (hệ thống Khoa):** https://projects-fit.hcmute.edu.vn/?view=student-mytopic&topic=518
- **Link Github báo cáo tiến độ Tuần 4 (PDF & Word):** https://github.com/luanpm18/CI-CD-voi-CodeCommit-va-CodeDeploy-len-nhom-EC2-AWS-/tree/main/Bao%20Cao%20Tien%20Do
- **Link Sơ đồ kiến trúc Draw.io:** https://github.com/luanpm18/CI-CD-voi-CodeCommit-va-CodeDeploy-len-nhom-EC2-AWS-/blob/main/docs/KienTrucTongThe.drawio
- **Link Github WORKLOG toàn khóa:** https://github.com/luanpm18/CI-CD-voi-CodeCommit-va-CodeDeploy-len-nhom-EC2-AWS-/blob/main/WORKLOG.md
- **Link Github mã nguồn ứng dụng & Scripts:** https://github.com/luanpm18/CI-CD-voi-CodeCommit-va-CodeDeploy-len-nhom-EC2-AWS-/tree/main/cicd-demo-repo
- **Link Github bản lỗi kiểm thử rollback:** https://github.com/luanpm18/CI-CD-voi-CodeCommit-va-CodeDeploy-len-nhom-EC2-AWS-/tree/main/cicd-bad

---

## Phân công nhiệm vụ & đóng góp của từng thành viên

Bảng tổng hợp công việc từng thành viên đã thực hiện trong Tuần 4:

### Phạm Minh Luân (MSSV: 24110277)
- Khởi động lại lab, kiểm tra trạng thái 2 máy chủ EC2, S3 và 4 CloudWatch Alarm.
- Thực hiện kịch bản kiểm thử E1: cập nhật mã nguồn Version 3 (FINAL), push CodeCommit, chạy `deploy.ps1` và xác nhận web 2 máy.
- Thực hiện kịch bản kiểm thử E2: tạo fixture `cicd-bad`, đóng gói và kiểm thử rollback khi hook `ValidateService` bị lỗi.
- Thực hiện kịch bản kiểm thử E3: cấu hình bản `cicd-slow`, dùng CloudShell ép alarm kích hoạt và kiểm chứng CodeDeploy dừng deployment.
- Thực hiện kịch bản E4 (redeploy cùng revision) và E5 (stop/start EC2 kiểm tra IP mới và tính sẵn sàng của Apache).
- Thuyết minh và ghi hình các phân đoạn kiểm thử trong video demo.
- Viết tài liệu báo cáo tiến độ Tuần 4 và cập nhật WORKLOG.
- *Chi tiết giờ làm việc: 9.5 giờ (Xem tại WORKLOG.md, Phạm Minh Luân).*

### Trần Hải Đạt (MSSV: 24110197)
- Thực hiện kịch bản kiểm thử E6: kiểm tra bảo mật S3 Block Public Access (HTTP 403), Default Encryption SSE-S3 và Security Group SSH port 22 (`14.191.90.189/32`).
- Rà soát chi phí sử dụng trên AWS Learner Lab, lập bảng đối chiếu đơn giá và phân tích các giải pháp tối ưu chi phí.
- Thiết kế và số hóa 4 sơ đồ kiến trúc hệ thống bằng Draw.io (`KienTrucTongThe.drawio`).
- Soạn thảo kịch bản quay video demo, hỗ trợ quay phim và biên tập hậu kỳ video (cắt ghép, tua nhanh, chèn nhãn).
- Xây dựng quy trình dọn dẹp an toàn tài nguyên AWS (Teardown) và chụp ảnh minh chứng sau dọn dẹp.
- Hỗ trợ hoàn thiện báo cáo cuối kỳ và chuẩn bị câu hỏi ôn tập vấn đáp.
- *Chi tiết giờ làm việc: 9.5 giờ (Xem tại WORKLOG.md, Trần Hải Đạt).*

---

## Các Commit Tiêu Biểu Trên GitHub (Week 4)

Các commit quan trọng ghi nhận tiến trình kiểm thử, hoàn thiện tài liệu và nghiệm thu trong Tuần 4:

| SHA Commit | Thông Điệp Commit | Nội Dung Triển Khai | Đường Dẫn Chi Tiết |
| :---: | :--- | :--- | :---: |
| `a8f12c4` | Cập nhật ứng dụng lên phiên bản 3 (FINAL) | Cập nhật giao diện web Version 3 (FINAL) và chuẩn hóa chuỗi kiểm tra health check | [Xem Commit a8f12c4](https://github.com/luanpm18/CI-CD-voi-CodeCommit-va-CodeDeploy-len-nhom-EC2-AWS-/commit/a8f12c4) |
| `c34d91e` | Cập nhật script kiểm thử rollback cicd-bad | Chuẩn hóa line ending LF và định dạng UTF-8 không BOM cho `validate_service.sh` | [Xem Commit c34d91e](https://github.com/luanpm18/CI-CD-voi-CodeCommit-va-CodeDeploy-len-nhom-EC2-AWS-/commit/c34d91e) |
| `f209b5a` | Bổ sung sơ đồ kiến trúc tổng thể Draw.io | Thêm file thiết kế kiến trúc `KienTrucTongThe.drawio` đầy đủ Account ID và Region | [Xem Commit f209b5a](https://github.com/luanpm18/CI-CD-voi-CodeCommit-va-CodeDeploy-len-nhom-EC2-AWS-/commit/f209b5a) |
| `7e14a82` | Hoàn thiện báo cáo tiến độ và bảng số liệu Tuần 4 | Cập nhật tài liệu báo cáo Word, PDF và bảng tổng hợp kết quả kiểm thử E1–E6 | [Xem Commit 7e14a82](https://github.com/luanpm18/CI-CD-voi-CodeCommit-va-CodeDeploy-len-nhom-EC2-AWS-/commit/7e14a82) |
| `b92d601` | Update WORKLOG tuần 4 và link video demo | Cập nhật nhật ký công việc chi tiết 4 tuần và gắn đường dẫn video demo nghiệm thu | [Xem Commit b92d601](https://github.com/luanpm18/CI-CD-voi-CodeCommit-va-CodeDeploy-len-nhom-EC2-AWS-/commit/b92d601) |

---

## Tài khoản GitHub của nhóm

| Tên hiển thị trên GitHub | Thuộc về | Ghi chú |
| :---: | :---: | :--- |
| `haidat2207` | Trần Hải Đạt (24110197) | Thành viên nhóm (Trưởng nhóm) |
| `luanpm18` | Phạm Minh Luân (24110277) | Thành viên nhóm |
| `cicd-student` | Máy trạm thực hành chung của nhóm | Git author name cấu hình cục bộ trên máy thực hành |

---

## Công cụ thực hiện của nhóm

- **Hạ tầng Cloud:** AWS Academy Learner Lab (Region `us-east-1`, Account ID: `3342-9148-4116`).
- **Môi trường phát triển:** Máy trạm Windows 11, Visual Studio Code, Windows Terminal (PowerShell 7.x).
- **Quản lý mã nguồn & Tự động hóa:** Git Client, AWS CodeCommit, Amazon S3, AWS CodeDeploy, script PowerShell `deploy.ps1`.
- **Giám sát & Quản trị:** Amazon CloudWatch Alarms, AWS CloudShell, AWS CLI v2.
- **Thiết kế & Báo cáo:** Draw.io (diagrams.net), Microsoft Word, Google Drive.
- **Quay & Biên tập Video:** OBS Studio, Windows Game Bar, CapCut PC (xuất MP4 1080p).
- **Hỗ trợ thông minh:** GitHub Copilot và Google Antigravity hỗ trợ tối ưu script và gợi ý cấu trúc báo cáo học thuật.

---

## Tổng kết đề tài & Hướng phát triển

### 1. Kết quả đạt được
- Xây dựng thành công đường ống triển khai liên tục (CD) tự động hóa từ máy phát triển lên cụm 2 máy chủ EC2 thông qua CodeCommit, S3 và CodeDeploy.
- Làm chủ 7 sự kiện trong vòng đời triển khai In-place và viết thành công 5 bash script lifecycle hooks chuẩn xác.
- Triển khai thành công cơ chế giám sát thời gian thực với 4 CloudWatch Alarm và cơ chế tự động Rollback an toàn khi xảy ra lỗi mã nguồn hoặc khi hạ tầng quá tải.
- Tối ưu hóa chi phí vận hành đạt mức tiết kiệm tối đa (~1.4 USD trên ngân sách 50 USD của Learner Lab).

### 2. Hướng phát triển trong tương lai
- **Tích hợp AWS CodePipeline:** Kết nối CodeCommit, CodeBuild và CodeDeploy thành chuỗi CI/CD hoàn toàn tự động hóa từ khâu kiểm thử đơn vị (Unit Test), đóng gói đến triển khai mà không cần chạy script thủ công.
- **Chuyển đổi sang Blue/Green Deployment:** Kết hợp với Application Load Balancer (ALB) và Auto Scaling Group để đạt mục tiêu triển khai không gián đoạn dịch vụ (Zero-Downtime Deployment).
- **Hạ tầng dưới dạng mã (IaC):** Sử dụng AWS CloudFormation hoặc Terraform để tự động hóa toàn bộ việc khởi tạo và dọn dẹp hạ tầng EC2, S3, CodeDeploy một cách nhất quán.

