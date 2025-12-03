# IE103 - BÀI TẬP THỰC HÀNH 2 - NHÓM 2

- Mã Lớp: IE103.F12.LT.CNTT
- Mã Môn: IE103 - Quản Lý Thông Tin
- Giảng Viên: ThS. Nguyễn Thành Luân
- Nhóm: 2 (Omega)

## Nhóm 2 (Omega)

| **No** | **MSSV** | **Họ và Tên**         |
| ------ | -------- | --------------------- |
| 1      | 25410291 | Đinh Xuân Sâm         |
| 2      | 25410319 | Đặng Hữu Toàn         |
| 3      | 25410321 | Nguyễn Điền Triết     |
| 4      | 25410204 | Trương Xuân Hậu       |
| 5      | 25410338 | Lê Anh Vũ             |
| 6      | 25410176 | Trần Sơn Bình         |
| 7      | 25410247 | Lê Kim Long           |
| 8      | 25410337 | La Anh Vũ             |
| 9      | 25410209 | Lê Ngọc Hiệp          |
| 10     | 25410271 | Nguyễn Thị Ngọc Nhung |

## Mục Lục

[TOC]

## CSDL về Quản Lý Đề Tài

Cho lược đồ quan hệ sau:

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

## Phần 1

### Tạo CSDL

Viết các câu lệnh SQL tạo các quan hệ trên với các kiểu dữ liệu mô tả trong  bảng sau (tạo các ràng buộc khóa chính, khóa ngoại tương ứng):

| Quan Hệ  | Thuộc Tính                                     | Kiểu Dữ Liệu                                                 | Diễn Giải                                              |
| -------- | ---------------------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------ |
| SINHVIEN | MSSV<br />TENSV<br />SODT<br />LOP<br />DIACHI | char(8)<br />nvarchar(30)<br />varchar(10)<br />char(10)<br />nchar(50) | PK<br />NOT NULL<br />NULL<br />NOT NULL<br />NOT NULL |
|          |                                                |                                                              |                                                        |
|          |                                                |                                                              |                                                        |



## Phần 2

