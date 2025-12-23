# Phụ Lục: Thiết Lập Môi Trường Lab

## Các Tài Nguyên

Các tài nguyên (tài liệu, code, vv...) của lab này được lưu tại:

- [LT.K2025.2-CNTT > IE103 > assignments > BTTH2](https://github.com/lt20252cnttalpha/LT.K2025.2-CNTT/tree/main/uit/courses/IE103/assignments/BTTH2)
    - `content`: Thư mục chứa các file nội dung của báo cáo.
    - `content/code`: Thư mục chứa các script `.sql` để thực thi.
    - `IE103-BTTH2`: Thư mục chứa file dự án `.sqlproj` cho SQL Projects.

## Thiết bị

- macOS, M4 Pro (`arm64`).

## Các công cụ

- `make` (cài đặt sẵn)
- brew.sh: quản lý gói.
- Colima
- `docker`
- Azure Database Studio (ADS)
- SQL Projects (ADS Extension)

## Quản lý vòng đời của SQL Server.

- Sử dụng `make` với `Makefile`.

```bash
# Khởi tạo hoặc/và chạy SQL Server
make up

# Tắt/Shutdown SQL Server
make down

# Xóa bỏ SQL Server
make clean
```

## Khởi tạo môi trường lab thủ công

- Kết nối vào SQL Server: `localhost`, `sa`, `Password123!`
- Tạo DB với `00-CREATE-DB.sql` hoặc nhập truy vấn thủ công.
- Chạy các script `.sql` tương ứng lần lượt từ thư mục `content/code`.
    - `bai-01-1.sql`
    - `bai-01-2.sql`
    - ...

## Khởi tạo môi trường lab với ADS (SQL Projects)

- Mở thư mục Lab với ADS.
- Mở file project `IE103-BTTH2.sqlproj` từ SQL Projects.
- Chuột phải vào tên của project (IE103-BTTH2) và chọn Publish.
- Tiếp tục theo trình thuật sĩ hướng dẫn.
    - Có thể Load Profile `IE103-BTTH2.publish.xml` nếu muốn.
