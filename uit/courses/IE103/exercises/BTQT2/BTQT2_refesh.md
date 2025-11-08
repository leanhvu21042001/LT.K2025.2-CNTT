# Phân tích và Thiết kế CSDL (Phiên bản Hiện đại)

Tài liệu này giải lại 2 bài toán trong `BTQT2_Nhom2` bằng các phương pháp và ký hiệu phổ biến trong ngành công nghiệp hiện nay, bao gồm:

1. **Mô hình Quan hệ (Relational):** Sử dụng ký hiệu **ERD Chân quạ (Crow's Foot)**.
2. **Mô hình Tài liệu (NoSQL/Document):** Sử dụng thiết kế **phi chuẩn hóa (denormalized)** cho cơ sở dữ liệu tài liệu như MongoDB.

## MỤC LỤC

1. **Bài toán 1: Quản lý Đề tài Tốt nghiệp (Refresh)**
    - 1.1. Cách 1: Mô hình Quan hệ (ERD Crow's Foot)
    - 1.2. Cách 2: Mô hình Tài liệu (NoSQL/Document)
2. **Bài toán 2: Quản lý Cửa hàng Xe máy (Refresh)**
    - 2.1. Cách 1: Mô hình Quan hệ (ERD Crow's Foot)
    - 2.2. Cách 2: Mô hình Tài liệu (NoSQL/Document)

## 1. Bài toán 1: Quản lý Đề tài Tốt nghiệp (Refresh)

### 1.1. Cách 1: Mô hình Quan hệ (ERD Crow's Foot)

Ký hiệu Chân quạ (Crow's Foot) biểu diễn mối kết hợp và bản số ngay trên đường nối, thay vì dùng hình thoi.

- **Ký hiệu:**
    
    - `|` : Một (One)
        
    - `o` : Không (Zero)
        
    - `<` (chân quạ): Nhiều (Many)
        
    - `--|--` : Một và chỉ một (One and only one)
        
    - `--o--` : Không hoặc một (Zero or one)
        
    - `--|<` : Một hoặc nhiều (One or many)
        
    - `--o<` : Không hoặc nhiều (Zero or many)
        
- **Mô tả ERD (Crow's Foot):**
    
    - `KHOA` --|--|< `GIAOVIEN` (Một KHOA có _một hoặc nhiều_ GIÁO VIÊN)
        
    - `KHOA` --|--|< `SINHVIEN` (Một KHOA có _một hoặc nhiều_ SINH VIÊN)
        
    - `KHOA` --|--|< `DETAI` (Một KHOA có _một hoặc nhiều_ ĐỀ TÀI)
        
    - `KHOA` --|--|< `HOIDONG` (Một KHOA lập _một hoặc nhiều_ HỘI ĐỒNG)
        
    - `GIAOVIEN` (HD) --o<--|-- `DETAI` (Một GV hướng dẫn _không hoặc nhiều_ ĐT; Một ĐT có _một và chỉ một_ GVHD)
        
    - `GIAOVIEN` (PB) --o<--|-- `DETAI` (Một GV phản biện _không hoặc nhiều_ ĐT; Một ĐT có _một và chỉ một_ GVPB)
        
    - `GIAOVIEN` (CT) --o<--|-- `HOIDONG` (Một GV làm chủ tịch _không hoặc nhiều_ HĐ; Một HĐ có _một và chỉ một_ Chủ tịch)
        
    - `GIAOVIEN` (TK) --o<--|-- `HOIDONG` (Tương tự chủ tịch)
        
    - `HOIDONG` --|<--|-- `DETAI` (Một HĐ chấm _một hoặc nhiều_ ĐT; Một ĐT bảo vệ tại _một và chỉ một_ HĐ)
        
    - `SINHVIEN` --|{ `THUCHIEN` }|-- `DETAI`
        
        - Đây là mối kết hợp N-N (Nhiều-Nhiều).
            
        - Một SINH VIÊN thực hiện _1 đến 2_ ĐỀ TÀI.
            
        - Một ĐỀ TÀI được thực hiện bởi _1 đến 3_ SINH VIÊN.
            
        - `THUCHIEN` trở thành một bảng trung gian (giống hệt mô hình logic cổ điển) với các thuộc tính riêng (LanBaoVe, Diem...).
            
- **Mô hình Logic (Relational):**
    
    - Sau khi chuyển đổi, mô hình logic (các bảng quan hệ) **giống hệt 100%** với kết quả của phương pháp cổ điển. Điều này chứng tỏ các quy tắc nền tảng là không đổi.
        

### 1.2. Cách 2: Mô hình Tài liệu (NoSQL/Document)

Tư duy của NoSQL là "lấy dữ liệu theo cách bạn sẽ dùng nó". Chúng ta sẽ **phi chuẩn hóa** (denormalize) và **nhúng** (embed) dữ liệu vào nhau để giảm số lần truy vấn.

Chúng ta sẽ thiết kế xoay quanh thực thể chính là `DETAI`.

- **Collection: `deTais`** (Tương đương bảng ĐỀ TÀI)
    
- **Tài liệu (Document):** Mỗi đề tài là 1 tài liệu JSON.
    

```json
{
  "_id": "DT001",
  "tenDT": "Xay dung he thong quan ly...",
  "thoiGianBD": "2025-01-01T00:00:00Z",
  "thoiGianKT": "2025-06-01T00:00:00Z",
  "khoa": {
    "maKhoa": "CNTT",
    "tenKhoa": "Cong nghe Thong tin"
  },
  "gvHuongDan": {
    "maGV": "GV001",
    "tenGV": "Nguyen Van A",
    "hocVi": "Tien Si",
    "chuyenNganh": "AI"
  },
  "gvPhanBien": {
    "maGV": "GV002",
    "tenGV": "Tran Thi B",
    "hocVi": "Thac Si"
  },
  "hoiDong": {
    "maHD": "HD01",
    "ngayBV": "2025-06-15T00:00:00Z",
    "diaChiBV": "Phong H.01, Dai hoc X",
    "chuTich": {
      "maGV": "GV003",
      "tenGV": "Le Van C"
    },
    "thuKy": {
      "maGV": "GV004",
      "tenGV": "Pham Thi D"
    }
  },
  "sinhVienThucHien": [
    {
      "maSV": "SV001",
      "tenSV": "Ngo Van X",
      "lop": "K2021",
      "lanBaoVe": 1,
      "diem": {
        "diemHD": 8.5,
        "diemPB": 9.0,
        "diemCT": 8.0
      },
      "diemTB": 8.5
    },
    {
      "maSV": "SV002",
      "tenSV": "Hoang Thi Y",
      "lop": "K2021",
      "lanBaoVe": 1,
      "diem": {
        "diemHD": 8.0,
        "diemPB": 8.5,
        "diemCT": 8.0
      },
      "diemTB": 8.17
    }
  ]
}
```

- **Nhận xét:**
    
    - **Ưu điểm:** Chỉ cần 1 truy vấn `db.deTais.find({"_id": "DT001"})` là lấy được **toàn bộ** thông tin (SV, GVHD, GVPB, Hội đồng). Tốc độ đọc cực nhanh.
        
    - **Nhược điểm:** Dư thừa dữ liệu. Nếu `GV001` đổi số điện thoại, bạn phải cập nhật ở _nhiều_ tài liệu đề tài. (Tuy nhiên, có thể giải quyết bằng cách chỉ lưu `maGV` và dùng `$lookup` - tương tự `JOIN`).
        

## 2. Bài toán 2: Quản lý Cửa hàng Xe máy (Refresh)

### 2.1. Cách 1: Mô hình Quan hệ (ERD Crow's Foot)

- **Mô tả ERD (Crow's Foot):**
    
    - `DAILY` --|--|< `NHANVIEN` (Một ĐẠI LÝ có _một hoặc nhiều_ NHÂN VIÊN)
        
    - `NHANVIEN` là cha của `NV_HANHCHANH` và `NV_KYTHUAT` (Quan hệ kế thừa ISA).
        
    - `KHACHHANG` --o<--|-- `HOPDONG` (Một KH có _không hoặc nhiều_ HĐ; Một HĐ thuộc _một và chỉ một_ KH)
        
    - `NV_HANHCHANH` (Lập) --o<--|-- `HOPDONG` (Một NVHC lập _không hoặc nhiều_ HĐ; Một HĐ do _một và chỉ một_ NVHC lập)
        
    - `NV_HANHCHANH` (Kế toán) --o<--|-- `HOPDONG` (Tương tự)
        
    - `HOPDONG` --|--|< `XE` (Một HĐ có _một hoặc nhiều_ XE; Một XE (với số khung cụ thể) thuộc _một và chỉ một_ HĐ. Đây là mối kết hợp xác định (identifying relationship) - XE không thể tồn tại nếu không có HĐ).
        
    - `HOPDONG` --|--|{ `THANHTOAN` (Một HĐ có _1 đến 3_ lần THANH TOÁN; Một TT thuộc _một và chỉ một_ HĐ).
        
    - `KHACHHANG` --o< `BAOHANH` (Quan hệ N-N với `XE`, thông qua `BAOHANH`. Nhưng đề bài nói 1 phiếu BH cho 1 xe).
        
    - `XE` --o<--|-- `BAOHANH` (Một XE có _không hoặc nhiều_ lần BAOHANH; Một phiếu BH cho _một và chỉ một_ XE)
        
    - `NV_KYTHUAT` --o<--|-- `BAOHANH` (Một NVKT thực hiện _không hoặc nhiều_ BH; Một BH do _một và chỉ một_ NVKT thực hiện).
        
    - `BAOHANH` --o{ `CHITIET_BH` }o-- `LINHKIEN` (Mối kết hợp N-N. Một BH có thể cần _không hoặc nhiều_ LK; Một LK có thể được dùng cho _không hoặc nhiều_ BH).
        
- **Mô hình Logic (Relational):**
    
    - Giống hệt kết quả của phương pháp cổ điển.
        

### 2.2. Cách 2: Mô hình Tài liệu (NoSQL/Document)

Tư duy thiết kế sẽ xoay quanh `HOPDONG` (hóa đơn) là thực thể gốc (Aggregate Root).

- **Collection: `hopDongs`**
- **Tài liệu (Document):**

```json
{
  "_id": "HD12345",
  "ngayHD": "2025-11-08T00:00:00Z",
  "thoiGianBH": "24 thang",
  "tienPhaiTT": 75000000,
  "hinhThucTT": "Tra gop",
  "khachHang": {
    "maKH": "KH001",
    "tenKH": "Tran Van B",
    "diaChi": "456 Duong XYZ, Q1, TPHCM",
    "sdt": "0987654321"
  },
  "nhanVienLap": {
    "maNV": "NVHC01",
    "tenNV": "Nguyen Thi C"
  },
  "keToan": {
    "maNV": "NVHC02",
    "tenNV": "Le Van D"
  },
  "xeDaMua": [
    {
      "soKhung": "SKF123456",
      "soSuon": "SSF654321",
      "soPK": "PK987",
      "nuocSX": "Nhat Ban",
      "loaiXe": "Honda SH 150i",
      "mauXe": "Trang",
      "giaTien": 75000000,
      "baoHanh": [
        {
          "maPhieuBH": "BH001",
          "ngayNhan": "2025-12-01",
          "lyDoBH": "Loi phuoc truoc",
          "loiThuocVe": "San pham",
          "giaTienSua": 0,
          "nvKyThuat": {
            "maNV": "NVKT01",
            "tenNV": "Pham Van E"
          },
          "linhKienThayThe": [
            {
              "maLK": "LK005",
              "tenLK": "Bo phuoc truoc",
              "giaTien": 1500000
            }
          ]
        }
      ]
    }
  ],
  "lichSuThanhToan": [
    {
      "maTT": "TT001",
      "ngayTra": "2025-11-08",
      "soTien": 40000000,
      "nguoiNhan": "NVHC01"
    },
    {
      "maTT": "TT002",
      "ngayTra": "2025-12-08",
      "soTien": 35000000,
      "nguoiNhan": "NVHC01"
    }
  ]
}
```

- **Nhận xét:**
    - **Ưu điểm:** Cực kỳ mạnh mẽ. Chỉ cần 1 truy vấn `db.hopDongs.find({"_id": "HD12345"})`, bạn có tất cả: thông tin khách hàng, nhân viên, danh sách xe đã mua, toàn bộ lịch sử bảo hành của từng chiếc xe, và toàn bộ lịch sử thanh toán của hóa đơn đó.
    - **Nhược điểm:** Tài liệu (document) này có thể trở nên rất lớn. Phải cẩn thận về giới hạn kích thước (ví dụ: 16MB trên MongoDB).

### Tổng kết

- **Mô hình Quan hệ (SQL):** Vẫn là lựa chọn số 1 cho các ứng dụng nghiệp vụ (như 2 bài toán trên) nơi mà **tính toàn vẹn dữ liệu (Data Integrity)** và **tính nhất quán (Consistency - ACID)** là vua. Ký hiệu Chân quạ (Crow's Foot) là ký hiệu của ngành.
- **Mô hình Tài liệu (NoSQL):** Là lựa chọn tuyệt vời cho các hệ thống cần **tốc độ đọc cực nhanh**, **linh hoạt về cấu trúc** và **dễ dàng mở rộng ngang** (horizontal scaling).
