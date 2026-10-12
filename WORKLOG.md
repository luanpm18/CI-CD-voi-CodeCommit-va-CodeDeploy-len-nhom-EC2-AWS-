# TUẦN 1: TÌM HIỂU LÝ THUYẾT, THIẾT KẾ KIẾN TRÚC & DỰNG CỤM HẠ TẦNG EC2 CHO CI/CD

**Thời gian thực hiện:** 05/10/2026 – 11/10/2026  
**Mục tiêu tuần 1:**
* Nghiên cứu lý thuyết các dịch vụ cốt lõi: Quy trình CI/CD trên AWS, AWS CodeCommit, và AWS CodeDeploy.
* Thiết kế mô hình kiến trúc dự kiến và quy ước gắn nhãn (Tagging) cho tài nguyên.
* Tạo cụm máy chủ ảo Amazon EC2 (`cicd-web-1`, `cicd-web-2`) và cấu hình Tagging đầy đủ.
* Cài đặt, cấu hình và kiểm tra trạng thái hoạt động của CodeDeploy Agent trên các máy chủ EC2.
* Hoàn thành tài liệu báo cáo tiến độ tuần 1 .

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

### Sinh viên 1: Phạm Minh Luân (MSSV: `24110227`)
* **Tìm hiểu công nghệ:** Nghiên cứu tổng quan về mô hình CI/CD và cơ chế hoạt động của CodeCommit, CodeDeploy.
* **Khởi tạo hạ tầng EC2:** Tạo cụm 2 máy chủ ảo Amazon EC2 với tên định danh lần lượt là `cicd-web-1` và `cicd-web-2`, đồng thời thiết lập hệ thống Tagging theo đúng chuẩn quy ước của nhóm.
* **Cấu hình CodeDeploy Agent:** Tiến hành cài đặt, cấu hình và kiểm tra trạng thái hoạt động của `codedeploy-agent` trên các instance EC2 để sẵn sàng tiếp nhận mã nguồn triển khai tự động.

### Sinh viên 2: Trần Hải Đạt (MSSV: `24110197`)
* **Nghiên cứu lý thuyết:** Phối hợp nghiên cứu các tài liệu kỹ thuật về dịch vụ lưu trữ mã nguồn AWS CodeCommit và công cụ tự động hóa triển khai CodeDeploy.
* **Thiết kế hệ thống:** Xây dựng bản thiết kế kiến trúc dự kiến cho hệ thống CI/CD (DevOps & IaC) và định nghĩa quy chuẩn gắn nhãn (`Tags`) cho toàn bộ tài nguyên AWS .
* **Lập tài liệu:** Tổng hợp thông tin, soạn thảo và hoàn thiện tài liệu báo cáo tiến độ công việc của tuần 1.
