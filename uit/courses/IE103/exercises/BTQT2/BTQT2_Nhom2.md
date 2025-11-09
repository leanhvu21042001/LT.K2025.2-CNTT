

# IE103 - Bài Tập Quá Trình 2 - Nhóm 2

- Mã Lớp: IE103.F12.LT.CNTT
- Mã Môn: IE103
- Tên Môn: Quản Lý Thông Tin
- Giảng Viên: ThS. Nguyễn Thành Luân
- Nhóm: 2 (Omega)

## Nhóm 2 (Omega)

Thành viên của nhóm 2:

|  No |   MSSV   | Họ và Tên             |
| --: | :------: | :-------------------- |
|   1 | 25410291 | Đinh Xuân Sâm         |
|   2 | 25410319 | Đặng Hữu Toàn         |
|   3 | 25410321 | Nguyễn Điền Triết     |
|   4 | 25410204 | Trương Xuân Hậu       |
|   5 | 25410338 | Lê Anh Vũ             |
|   6 | 25410176 | Trần Sơn Bình         |
|   7 | 25410247 | Lê Kim Long           |
|   8 | 25410337 | La Anh Vũ             |
|   9 | 25410209 | Lê Ngọc Hiệp          |
|  10 | 25410271 | Nguyễn Thị Ngọc Nhung |

## Yêu Cầu/Đề Bài

1. Tìm mô hình ERD và Class Diagram cho 2 bài toán sau (2 tasks).  
2. Chuyển 2 mô hình trên sang mô hình logic (1 task).

### Bài 1.

Người ta cần tin học hoá khâu Quản lý các đề tài tốt nghiệp của 1 trường ĐH. Với các thông tin sau:

* Mỗi SV năm 4 sẽ làm đề tài TN.
  * Mỗi đề tài bao gồm Tên DT, giáo viên hướng dẫn, thời gian bắt đầu, kết thúc, thuộc khoa nào.
* Khoa sẽ thành lập hội đồng (HĐ) khoa học, mỗi HĐ gồm:
  * Chủ tịch, 1 thành viên thư ký, ngày bảo vệ tại địa chỉ cụ thể.
* Mỗi đề tài sẽ bảo vệ tại một hội đồng, điểm đề tài là trung bình cộng của:
  * Chủ tịch, 01 GV phản biện, 01 GV hướng dẫn.
* Giáo viên cho điểm theo từng Sinh viên mặc dù các sinh viên có thể làm chung đề tài.
* Trong đợt bảo vệ có thể có nhiều hội đồng, 1 GV có thể hướng dẫn nhiều Đề Tài (ĐT), hay phản biện nhiều ĐT.
  * Chủ tịch HD, thư ký là giáo viên.
  * Mỗi giáo viên cần thông tin: Tên, địa chỉ, SDT, học vị, chuyên ngành.
* Mỗi ĐT có thể tối đa 03 Sinh viên thực hiện.
* SV có điểm Trung Bình (TB) \< 5 sẽ:
  * phải bảo vệ lại với khóa sau, và
  * chỉ được bảo vệ tối đa 2 lần,
  * đề tài lần 1 phải khác lần 2.

### Bài 2.

Người ta cần tin học hoá khâu Quản lý mua bán tại cửa hàng bán xe máy 2 bánh với các thông tin sau:

* Khách hàng có thể mua trả hết hay trả góp, nhiều nhất 3 lần cho mỗi hóa đơn.
* Thông tin chiếc xe gồm:
  * Nước SX, loại xe, Số PK, số khung, số sườn, màu xe.
* Khi mua xe khách hàng được giao HD có:
  * SỐ HD, Ngày HD, Thời gian bảo hành, Tiền phải thanh toán, tiền đã thanh toán, nhân viên lập, kế toán.
  * Ngoài ra còn thông tin KH: Tên, địa chỉ, SDT.
* Nếu trả nhiều lần trên HD sẽ ghi rõ:
  * 2 lần trả kế tiếp, Ngày trả lần 1, ngày trả lần 2.
  * Khi KH thanh toán lần 2 cần lập phiếu thanh toán và ghi rõ:
    * Thanh toán cho HD nào, ngày trả, số tiền, người nhận và người trả.
* Với các HĐ thanh toán 1 lần sẽ giảm 2% cho mỗi HĐ và tỉ lệ này có thể thay đổi.  
* Với khách hàng mua số lượng 1 lần trên 3 chiếc và thanh toán 1 lần sẽ giảm 5% trên HD và tỉ lệ này có thể thay đổi.
* Trường hợp KH yêu cầu bảo hành sẽ có bộ phận kỹ thuật kiểm tra và báo cáo bằng phiếu nhận xét:
  * Ghi rõ tên các linh kiện, lí do BH, lỗi thuộc về khách hay sản phẩm, giá tiền.
* Cửa hàng có nhiều đại lý nằm trên các vị trí khác nhau. Nhân viên bao gồm:
  * Hành chánh (chức vụ, thuộc phòng ban nào, Trình độ học vấn)
  * Kỹ thuật (chức vụ, bậc thợ, số năm kinh nghiệm).

## Bài Làm

Tài liệu này trình bày lời giải chi tiết cho 2 bài toán quản lý thông tin, bao gồm ba mô hình:

1. **Mô hình ERD** (Entity-Relationship Diagram - Mô hình Thực thể Kết hợp)
   
2. **Mô hình CD** (Class Diagram - Mô hình Lớp)
   
3. **Mô hình Logic** (Chuyển đổi sang Lược đồ Quan hệ)

## Bảng Chú giải Viết tắt

|   |   |   |
|---|---|---|
|**Từ viết tắt**|**Diễn giải (Nghĩa)**|**Nơi sử dụng (Trong Mục 1.4 và 2.4)**|
|**Bài 1**|**Quản lý Đề tài Tốt nghiệp**||
|MaKhoa|Mã Khoa|KHOA, GIAOVIEN, SINHVIEN, HOIDONG, DETAI|
|MaGV|Mã Giáo Viên|GIAOVIEN (Khóa chính)|
|MaSV|Mã Sinh Viên|SINHVIEN (Khóa chính)|
|MaDT|Mã Đề Tài|DETAI (Khóa chính)|
|MaHD|Mã Hội Đồng|HOIDONG (Khóa chính)|
|MaGV_CT|Mã Giáo Viên (làm Chủ Tịch)|HOIDONG (Khóa ngoại)|
|MaGV_TK|Mã Giáo Viên (làm Thư Ký)|HOIDONG (Khóa ngoại)|
|MaGVHD|Mã Giáo Viên Hướng Dẫn|DETAI (Khóa ngoại)|
|MaGVPB|Mã Giáo Viên Phản Biện|DETAI (Khóa ngoại)|
|DiemHD|Điểm (của) Giáo Viên Hướng Dẫn|THUCHIEN|
|DiemPB|Điểm (của) Giáo Viên Phản Biện|THUCHIEN|
|DiemCT|Điểm (của) Chủ Tịch Hội đồng|THUCHIEN|
|**Bài 2**|**Quản lý Cửa hàng Xe máy**||
|MaDaiLy|Mã Đại Lý|DAILY (Khóa chính)|
|MaNV|Mã Nhân Viên|NHANVIEN (Khóa chính)|
|NV_HANHCHANH|Nhân Viên Hành Chánh|Bảng NV_HANHCHANH|
|NV_KYTHUAT|Nhân Viên Kỹ Thuật|Bảng NV_KYTHUAT|
|TrinhDoHV|Trình Độ Học Vấn|NV_HANHCHANH|
|SoNamKN|Số Năm Kinh Nghiệm|NV_KYTHUAT|
|MaKH|Mã Khách Hàng|KHACHHANG (Khóa chính)|
|SoHD|Số Hợp Đồng|HOPDONG (Khóa chính)|
|TienPhaiTT|Tiền Phải Thanh Toán (Tổng)|HOPDONG|
|SoKhung|Số Khung (xe)|XE (Khóa chính)|
|MaTT|Mã Thanh Toán|THANHTOAN (Khóa chính)|
|MaPhieuBH|Mã Phiếu Bảo Hành|BAOHANH (Khóa chính)|
|MaLK|Mã Linh Kiện|LINHKIEN (Khóa chính)|
|MaNV_Lap|Mã Nhân Viên Lập (Hợp đồng)|HOPDONG (Khóa ngoại)|
|MaNV_KeToan|Mã Nhân Viên Kế Toán|HOPDONG (Khóa ngoại)|
|MaNV_Nhan|Mã Nhân Viên Nhận (tiền)|THANHTOAN (Khóa ngoại)|
|MaKH_Tra|Mã Khách Hàng Trả (tiền)|THANHTOAN (Khóa ngoại)|
|MaNV_KT|Mã Nhân Viên Kỹ Thuật (BH)|BAOHANH (Khóa ngoại)|
|CHITIET_BH|Chi Tiết Bảo Hành|Bảng CHITIET_BAOHANH|

## Bài toán 1: Quản lý Đề tài Tốt nghiệp

### Phân tích Thực thể và Mối kết hợp

- **Thực thể (Entities):**
  
    - `KHOA`: Quản lý chung. (`MaKhoa`, `TenKhoa`)
      
    - `GIAOVIEN`: Hướng dẫn, phản biện, chủ tịch, thư ký. (`MaGV`, `TenGV`, `DiaChi`, `SDT`, `HocVi`, `ChuyenNganh`)
      
    - `SINHVIEN`: Thực hiện đề tài. (`MaSV`, `TenSV`, `Lop`,...)
      
    - `DETAI`: Đối tượng được quản lý. (`MaDT`, `TenDT`, `ThoiGianBD`, `ThoiGianKT`)
      
    - `HOIDONG`: Nơi bảo vệ đề tài. (`MaHD`, `NgayBV`, `DiaChiBV`)
    
- **Mối kết hợp (Relationships) và Bản số (Cardinality):**
  
    - **Phân tích bản số (Theo IE103 - Trang 23):** Ký hiệu bản số `(min, max)` đặt ở phía thực thể `A` sẽ mô tả số lượng của `B` tham gia vào mối quan hệ, và ngược lại.
      
    - `KHOA` - `GIAOVIEN`: (1,n). 1 KHOA có (1,n) GIAOVIEN. 1 GIAOVIEN thuộc (1,1) KHOA.
      
    - `KHOA` - `SINHVIEN`: (1,n). 1 KHOA có (1,n) SINHVIEN. 1 SINHVIEN thuộc (1,1) KHOA.
      
    - `KHOA` - `DETAI`: (1,n). 1 KHOA quản lý (1,n) DETAI. 1 DETAI thuộc (1,1) KHOA.
      
    - `KHOA` - `HOIDONG`: (1,n). 1 KHOA lập (1,n) HOIDONG. 1 HOIDONG thuộc (1,1) KHOA.
      
    - `GIAOVIEN` - `DETAI (Hướng dẫn)`: (1,n). 1 GIAOVIEN hướng dẫn (0,n) DETAI. 1 DETAI được hướng dẫn bởi (1,1) GIAOVIEN.
      
    - `GIAOVIEN` - `DETAI (Phản biện)`: (1,n). 1 GIAOVIEN phản biện (0,n) DETAI. 1 DETAI được phản biện bởi (1,1) GIAOVIEN.
      
    - `GIAOVIEN` - `HOIDONG (Chủ tịch)`: (1,n). 1 GIAOVIEN làm chủ tịch (0,n) HOIDONG. 1 HOIDONG có (1,1) GIAOVIEN làm chủ tịch.
      
    - `GIAOVIEN` - `HOIDONG (Thư ký)`: (1,n). 1 GIAOVIEN làm thư ký (0,n) HOIDONG. 1 HOIDONG có (1,1) GIAOVIEN làm thư ký.
      
    - `HOIDONG` - `DETAI (Bảo vệ)`: (1,n). 1 HOIDONG chấm (1,n) DETAI. 1 DETAI bảo vệ tại (1,1) HOIDONG.
      
    - **`SINHVIEN` - `DETAI (Thực hiện)`**: (n,m).
      
        - Nghiệp vụ: 1 `SINHVIEN` làm tối đa 2 `DETAI` (lần 1, lần 2). => Bản số `(1,2)`.
          
        - Nghiệp vụ: 1 `DETAI` có tối đa 3 `SINHVIEN`. => Bản số `(1,3)`.
          
        - **Kết luận:** Mối kết hợp này có thuộc tính (`LanBaoVe`, `DiemHD`, `DiemPB`, `DiemCT`).
          

### Task 1: Mô hình ERD (Mức Quan niệm)

ERD theo ký hiệu Chen:

- `[KHOA] ---(1,1)---<QL_GV>---(1,n)--- [GIAOVIEN]`
  
- `[KHOA] ---(1,1)---<QL_SV>---(1,n)--- [SINHVIEN]`
  
- `[KHOA] ---(1,1)---<QL_DT>---(1,n)--- [DETAI]`
  
- `[KHOA] ---(1,1)---<THANHLAP>---(1,n)--- [HOIDONG]`
  
- `[GIAOVIEN] ---(0,n)---<HUONGDAN>---(1,1)--- [DETAI]`
  
- `[GIAOVIEN] ---(0,n)---<PHANBIEN>---(1,1)--- [DETAI]`
  
- `[GIAOVIEN] ---(0,n)---<LAMCHUTICH>---(1,1)--- [HOIDONG]`
  
- `[GIAOVIEN] ---(0,n)---<LAMTHUKY>---(1,1)--- [HOIDONG]`
  
- `[HOIDONG] ---(1,n)---<BAOVE>---(1,1)--- [DETAI]`
  
- `[SINHVIEN] ---(1,3)---<THUCHIEN>---(1,2)--- [DETAI]`
  - Mối kết hợp `THUCHIEN` có các thuộc tính: `LanBaoVe`, `DiemHD`, `DiemPB`, `DiemCT`.
  

### Task 2: Mô hình Class Diagram (Mức Quan niệm)

(Sử dụng ký hiệu UML hoặc vẽ lại trong Draw.io)

```ASN.1
+-----------+ (1)  (QL)  (1..*) +-----------+
|   KHOA    |-------------------| GIAOVIEN  |
+-----------+                   +-----------+
| -MaKhoa   | (1)  (QL)  (1..*) | -MaGV     |
| -TenKhoa  |-------------------| -TenGV    |
+-----------+ \                 | -...      |
    |         \ (1) (QL) (1..*) +-----------+
(1) | (QL)     \                / (0..*) | (0..*)
    | (1..*)    \+-----------+ / (HD)   | (PB)
    |            | SINHVIEN  |/ (1)     | (1)
    |            +-----------+          |
    |            | -MaSV     |          |
    |            | -TenSV    |          |
    |            +-----------+          |
    |                | (1..3)           |
    |                |                  |
    | (1)       +-------------+ (1..2) +--------+
    | (TL)      |  THUCHIEN   |--------| DETAI  |
    | (1..*)    | (Assoc. Cls)|        +--------+
    |           +-------------+        | -MaDT  |
    |           | -LanBaoVe   |        | -TenDT |
    |           | -DiemHD     |        | -...   |
    |           | -DiemPB     |        +--------+
    |           | -DiemCT     |            | (1)
    |           +-------------+            | (BV)
    |                                      | (1..*)
+-----------+ (1)                  (1) +-----------+
| HOIDONG   |------------------------| GIAOVIEN  | (CTich)
+-----------+                        | (0..*)
| -MaHD     | (1)                  (1) +-----------+
| -NgayBV   |------------------------| GIAOVIEN  | (TKy)
| -...      |                        | (0..*)
+-----------+                        +-----------+
    | (1..*)
    | (BV)
    | (1)
+--------+
| DETAI  |
+--------+
```

### Task 3: Mô hình Logic (Mức Logic)

Chuyển đổi sang Lược đồ Quan hệ. (PK: Khóa chính, FK: Khóa ngoại)

1. **KHOA** (`MaKhoa` (PK), `TenKhoa`)
   
2. **GIAOVIEN** (`MaGV` (PK), `TenGV`, `DiaChi`, `SDT`, `HocVi`, `ChuyenNganh`, `MaKhoa` (FK))
   
3. **SINHVIEN** (`MaSV` (PK), `TenSV`, `Lop`, `MaKhoa` (FK))
   
4. **HOIDONG** (`MaHD` (PK), `NgayBV`, `DiaChiBV`, `MaKhoa` (FK), `MaGV_CT` (FK), `MaGV_TK` (FK))
   
5. **DETAI** (`MaDT` (PK), `TenDT`, `ThoiGianBD`, `ThoiGianKT`, `MaKhoa` (FK), `MaGVHD` (FK), `MaGVPB` (FK), `MaHD` (FK))
   
6. **THUCHIEN** (`MaSV` (PK, FK), `MaDT` (PK, FK), `LanBaoVe`, `DiemHD`, `DiemPB`, `DiemCT`)
   
    - Theo nghiệp vụ "đề tài lần 1 phải khác lần 2", một `SINHVIEN` không thể làm cùng 1 `DETAI` 2 lần. Do đó, khóa chính là cặp `(MaSV, MaDT)`. `LanBaoVe` (1 hay 2) chỉ là thuộc tính mô tả cho lần thực hiện đó của sinh viên.

## Bài toán 2: Quản lý Cửa hàng Xe máy

### Phân tích Thực thể và Mối kết hợp

- **Thực thể (Entities):**
  
    - `DAILY`: Nơi cửa hàng hoạt động. (`MaDaiLy`, `DiaChi`)
      
    - `NHANVIEN`: Người làm việc (Chung). (`MaNV`, `TenNV`)
      
    - `NV_HANHCHANH`: Loại NV (Kế thừa). (`ChucVu`, `PhongBan`, `TrinhDoHV`)
      
    - `NV_KYTHUAT`: Loại NV (Kế thừa). (`ChucVu`, `BacTho`, `SoNamKN`)
      
    - `KHACHHANG`: Người mua xe. (`MaKH`, `TenKH`, `DiaChi`, `SDT`)
      
    - `HOPDONG`: Hóa đơn mua bán. (`SoHD`, `NgayHD`, `ThoiGianBH`, `TienPhaiTT`)
      
    - `XE`: Sản phẩm. (`SoKhung`, `SoSuon`, `SoPK`, `NuocSX`, `LoaiXe`, `MauXe`)
      
    - `THANHTOAN`: Phiếu/lần thanh toán trả góp. (`MaTT`, `NgayTra`, `SoTien`)
      
    - `BAOHANH`: Phiếu nhận xét bảo hành. (`MaPhieuBH`, `LyDoBH`, `LoiThuocVe`, `GiaTienTong`)
      
    - `LINHKIEN`: Linh kiện dùng khi bảo hành. (`MaLK`, `TenLK`)
    
- **Mối kết hợp (Relationships) và Bản số (Cardinality):**
  
    - `DAILY` - `NHANVIEN`: (1,n). 1 DAILY có (1,n) NHANVIEN. 1 NHANVIEN làm tại (1,1) DAILY.
      
    - `NHANVIEN` -> `NV_HANHCHANH`, `NV_KYTHUAT`: Kế thừa (ISA).
      
    - `KHACHHANG` - `HOPDONG`: (1,n). 1 KHACHHANG có (1,n) HOPDONG. 1 HOPDONG của (1,1) KHACHHANG.
      
    - `NV_HANHCHANH` - `HOPDONG (Lập HĐ)`: (1,n). 1 NV_HC lập (0,n) HOPDONG. 1 HOPDONG được lập bởi (1,1) NV_HC.
      
    - `NV_HANHCHANH` - `HOPDONG (Kế toán)`: (1,n). 1 NV_HC (Kế toán) duyệt (0,n) HOPDONG. 1 HOPDONG được duyệt bởi (1,1) NV_HC (Kế toán).
      
    - `HOPDONG` - `XE`: (1,n). 1 HOPDONG có (1,n) XE. 1 XE (với SoKhung) chỉ thuộc (1,1) HOPDONG.
      
    - **`HOPDONG` - `THANHTOAN`**: (1,n).
      
        - Nghiệp vụ: "nhiều nhất 3 lần cho mỗi hóa đơn".
          
        - **Thiết kế (Tinh chỉnh):** Để chuẩn hóa, ta không lưu `TienDaTT`, `NgayTra1`, `NgayTra2` trên `HOPDONG`. Thay vào đó, mọi lần thanh toán (kể cả lần 1) đều được ghi vào bảng `THANHTOAN`.
          
        - **Kết luận:** 1 HOPDONG có (1,3) THANHTOAN. 1 THANHTOAN thuộc (1,1) HOPDONG.
        
    - `KHACHHANG` - `BAOHANH`: (1,n). 1 KHACHHANG yêu cầu (0,n) BAOHANH. 1 BAOHANH của (1,1) KHACHHANG.
      
    - `XE` - `BAOHANH`: (1,n). 1 XE được (0,n) BAOHANH. 1 BAOHANH cho (1,1) XE.
      
    - `NV_KYTHUAT` - `BAOHANH`: (1,n). 1 NV_KT thực hiện (0,n) BAOHANH. 1 BAOHANH do (1,1) NV_KT thực hiện.
      
    - `BAOHANH` - `LINHKIEN`: (n,m). 1 BAOHANH có thể cần (0,n) LINHKIEN. 1 LINHKIEN có thể dùng cho (0,n) BAOHANH.
      
        - Mối kết hợp `CHITIET_BH` có thuộc tính: `GiaTien` (cho linh kiện đó).
          

### Task 1: Mô hình ERD (Mức Quan niệm)

- `[DAILY] ---(1,1)---<LAMVIEC>---(1,n)--- [NHANVIEN]`
  
- `[NHANVIEN] --- (ISA) --- [NV_HANHCHANH]`
  
- `[NHANVIEN] --- (ISA) --- [NV_KYTHUAT]`
  
- `[KHACHHANG] ---(1,1)---<LAP_HD>---(1,n)--- [HOPDONG]`
  
- `[NV_HANHCHANH] ---(0,n)---<NV_LAP>---(1,1)--- [HOPDONG]`
  
- `[NV_HANHCHANH] ---(0,n)---<NV_KETOAN>---(1,1)--- [HOPDONG]`
  
- `[HOPDONG] ---(1,n)---<CHITIET_HD>---(1,1)--- [XE]`
  
- `[HOPDONG] ---(1,1)---<CO_TT>---(1,3)--- [THANHTOAN]`
  
- `[KHACHHANG] ---(1,1)---<YEUCAU_BH>---(0,n)--- [BAOHANH]`
  
- `[XE] ---(1,1)---<DUOC_BH>---(0,n)--- [BAOHANH]`
  
- `[NV_KYTHUAT] ---(1,1)---<THUCHIEN_BH>---(0,n)--- [BAOHANH]`
  
- `[BAOHANH] ---(0,n)---<CHITIET_BH>---(0,n)--- [LINHKIEN]`
  - `CHITIET_BH` có thuộc tính: `GiaTien`.

### Task 2: Mô hình Class Diagram (Mức Quan niệm)

```
+-----------+ (1)  (Làm việc) (1..*) +---------------+
|   DAILY   |-----------------------|   NHANVIEN    | (Abstract)
+-----------+                       +---------------+
| -MaDaiLy  |                       | #MaNV         |
| -DiaChi   |                       | #TenNV        |
+-----------+                       +---------------+
                                     /_\     /_\
                                      |       |
                         +---------------+   +---------------+
                         | NV_HANHCHANH  |   | NV_KYTHUAT    |
                         +---------------+   +---------------+
                         | -ChucVu       |   | -ChucVu       |
                         | -PhongBan     |   | -BacTho       |
                         | -TrinhDoHV    |   | -SoNamKN      |
                         +---------------+   +---------------+
                                | (0..*)       | (0..*)
(Lập) (1) | (KToán)(1)     | (THiện)
          |                |
+-----------+ (1) (Lập) (1..*) +-----------+
| KHACHHANG |-------------------| HOPDONG   |
+-----------+                   +-----------+
| -MaKH     |                   | -SoHD     |
| -TenKH    |                   | -TienPhaiTT |
| -...      |                   | -...      |
+-----------+                   +-----------+
    | (1)                         | (1)
    |                             | (1..3)
    |                             |
    | (Y/cầu)               (Có) / (Composition)
    | (0..*)                     /
    |                   +-----------+
    |                   | THANHTOAN |
    |                   +-----------+
    |                   | -MaTT     |
    |                   | -SoTien   |
    |                   +-----------+
    |
+-----------+ (1) (BH) (0..*) +--------+
| BAOHANH   |-----------------|   XE   |
+-----------+                 +--------+
| -MaPhieuBH|                 | -SoKhung |
| -...      |                 | -...     |
+-----------+                 +--------+
    | (1)                         | (1)
    | (BH)                        | (Chi tiết)
    | (0..*)                      | (1..*)
+---------------+               +-----------+
| NV_KYTHUAT    |               | HOPDONG   |
+---------------+               +-----------+
    | (1)
    |
    | (0..*)
+------------------+ (Association Class)
|   CHITIET_BH     |
+------------------+
| -GiaTien         |
+------------------+
    | (1..*) | (1..*)
    |        |
+-----------+ +-----------+
| BAOHANH   | | LINHKIEN  |
+-----------+ +-----------+
              | -MaLK     |
              | -TenLK    |
              +-----------+
```

### Task 3: Mô hình Logic (Mức Logic)

Chuyển đổi sang Lược đồ Quan hệ. (PK: Khóa chính, FK: Khóa ngoại)

1. **DAILY** (`MaDaiLy` (PK), `DiaChi`)
   
2. **NHANVIEN** (`MaNV` (PK), `TenNV`, `MaDaiLy` (FK))
   
    - _Ghi chú (Kế thừa):_ Đây là bảng cha, chứa các thuộc tính chung.
    
3. **NV_HANHCHANH** (`MaNV` (PK, FK), `ChucVu`, `PhongBan`, `TrinhDoHV`)
   
    - _Ghi chú (Kế thừa):_ Tham chiếu đến `NHANVIEN`.
    
4. **NV_KYTHUAT** (`MaNV` (PK, FK), `ChucVu`, `BacTho`, `SoNamKN`)
   
    - _Ghi chú (Kế thừa):_ Tham chiếu đến `NHANVIEN`.
    
5. **KHACHHANG** (`MaKH` (PK), `TenKH`, `DiaChi`, `SDT`)
   
6. **LINHKIEN** (`MaLK` (PK), `TenLK`)
   
7. **HOPDONG** (`SoHD` (PK), `NgayHD`, `ThoiGianBH`, `TienPhaiTT`, `MaKH` (FK), `MaNV_Lap` (FK), `MaNV_KeToan` (FK))
   
    - _Ghi chú (Tinh chỉnh):_ Đã loại bỏ `TienDaTT`, `NgayTra1`, `NgayTra2` để đưa vào bảng `THANHTOAN`.
    
8. **XE** (`SoKhung` (PK), `SoSuon`, `SoPK`, `NuocSX`, `LoaiXe`, `MauXe`, `SoHD` (FK))
   
    - Khóa ngoại: `SoHD` (tham chiếu HOPDONG)
    
9. **THANHTOAN** (`MaTT` (PK), `NgayTra`, `SoTien`, `MaNV_Nhan` (FK), `MaKH_Tra` (FK), `SoHD` (FK))
   
    - Khóa ngoại: `SoHD` (tham chiếu HOPDONG)
    
10. **BAOHANH** (`MaPhieuBH` (PK), `LyDoBH`, `LoiThuocVe`, `GiaTienTong`, `MaKH` (FK), `SoKhung` (FK), `MaNV_KT` (FK))
    
    - Khóa ngoại: `MaKH`, `SoKhung`, `MaNV_KT`.
    
11. **CHITIET_BAOHANH** (`MaPhieuBH` (PK, FK), `MaLK` (PK, FK), `GiaTien`)
    
    - Khóa chính: (`MaPhieuBH`, `MaLK`)
      
    - Khóa ngoại: `MaPhieuBH` (tham chiếu BAOHANH), `MaLK` (tham chiếu LINHKIEN)