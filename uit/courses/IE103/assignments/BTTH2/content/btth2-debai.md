# Đề Bài - Cơ Sở Dữ Liệu về Quản Lý Đề Tài

Cho lược đồ quan hệ sau, hãy hoàn thành các yêu cầu ở [@phan-1 Mục] (Phần 1) và [@phan-2 Mục] (Phần 2).

1. SINHVIEN(<u>MSSV</u>, TENSV, SODT, LOP, DIACHI)
2. DETAI(<u>MSDT</u>, TENDT) 
3. SV_DETAI(<u>MSSV, MSDT</u>)
4. GIAOVIEN(<u>MSGV</u>, TENGV, DIACHI, SODT, MSHH, NAMHH)
5. HOCVI(<u>MSHV</u>, TENHV)
6. CHUYENNGANH(<u>MSCN</u>, TENCN) 
7. GV_HV_CN(<u>MSGV</u>, MSHV, MSCN, NAM)
8. HOCHAM(<u>MSHH</u>, TENHH)
9. GV_HDDT(<u>MSGV, MSDT</u>, DIEM)
10. GV_PBDT(<u>MSGV, MSDT</u>, DIEM)
11. GV_UVDT(<u>MSGV, MSDT</u>, DIEM)
12. HOIDONG(<u>MSHD</u>, PHONG, TGBD, NGAYHD, TINHTRANG, MSGV)
13. HOIDONG_GV(<u>MSHD, MSGV</u>)
14. HOIDONG_DT(<u>MSHD, MSDT</u>, QUYETDINH)

# Môi Trường Triển Khai

- RDBMS: Microsoft SQL Server 2019 (Azure SQL Edge).
- Editor: Azure Database Studio (ADS).
- Extensions: SQL Database Projects (`microsoft.sql-database-projects`).

## Các Tài Nguyên

Các tài nguyên (tài liệu, code, vv...) của lab này được lưu tại:

- [LT.K2025.2-CNTT > IE103 > assignments > BTTH2](https://github.com/lt20252cnttalpha/LT.K2025.2-CNTT/tree/main/uit/courses/IE103/assignments/BTTH2)
    - `content`: Thư mục chứa các file nội dung của báo cáo.
    - `content/code`: Thư mục chứa các script `.sql` để thực thi.
    - `IE103-BTTH2`: Thư mục chứa file dự án `.sqlproj` cho SQL Projects.
    - `IE103-BTTH2.ipynb`: Notebook nội dung của lab này.
