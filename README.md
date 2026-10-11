# CI-CD-voi-CodeCommit-va-CodeDeploy-len-nhom-EC2-AWS-

## Thông tin sinh viên & Đồ án

- **Môn học:** Điện toán đám mây (Cloud Computing) - Đợt 1
- **Giảng viên hướng dẫn:** ThS. Huỳnh Xuân Phụng
- **Nhóm thực hiện:**

| Họ và tên | MSSV |
|---|---|
| Trần Hải Đạt | 24110197 |
| Phạm Minh Luân | 24110227 |

- **AWS Region:** us-east-1 (N. Virginia)

## Kiến trúc hệ thống

<img width="1728" height="383" alt="image" src="https://github.com/user-attachments/assets/cda74307-9100-4e8d-a54c-ffc1e9929dec" />


| Thành phần | Vai trò |
|---|---|
| GitHub | Lưu trữ mã nguồn của ứng dụng |
| AWS CodeDeploy | Điều phối việc triển khai lên các instance |
| EC2 Instance 1, 2 | Hai máy chủ chạy ứng dụng |
| CodeDeploy Agent | Chạy trên mỗi instance, nhận và thực thi lệnh triển khai |
