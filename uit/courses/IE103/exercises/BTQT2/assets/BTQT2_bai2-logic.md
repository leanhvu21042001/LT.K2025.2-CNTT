# Mô Hình Logic - Bài 2

## Bài 2

Đây là bản thiết kế (blueprint) cho cơ sở dữ liệu quan hệ, thể hiện các bảng (tables), cột (columns), và khóa (keys).

**Ghi chú:**

- `TÊN_BẢNG`
- **Khóa chính (PK)** được **in đậm**.
- *Khóa ngoại (FK)* được *in nghiêng*.
- Khóa chính tổng hợp (PK) bao gồm nhiều cột: (**cột 1**, **cột 2**).

### 1. Nhóm Bảng Tổ Chức (Đại Lý, Phòng Ban, Nhân Viên)

**DAILY**

- **MaDaily** (PK)
- ViTri

**PHONGBAN**

- **MaPB** (PK)
- TenPB
- *MaDaily* (FK tham chiếu `DAILY(MaDaily)`)

**CHUCVU**

- **MaCV** (PK)
- TenCV
- *MaPB* (FK tham chiếu `PHONGBAN(MaPB)`)

**NHANVIEN** (Bảng gốc cho Kế thừa)

- **MaNV** (PK)
- TenNV
- LoaiNV (vd: 'HanhChanh', 'KyThuat' - để phân biệt)
- *MaPB* (FK tham chiếu `PHONGBAN(MaPB)`)
- *(Ghi chú: Không còn `MaDaily` ở đây. Vị trí của NV được suy ra qua `PHONGBAN`)*

**NV_HANHCHANH** (Bảng con Kế thừa)

- ***MaNV*** (PK, FK tham chiếu `NHANVIEN(MaNV)`)
- TrinhDoHocVan

**NV_KYTHUAT** (Bảng con Kế thừa)

- ***MaNV*** (PK, FK tham chiếu `NHANVIEN(MaNV)`)
- BacTho
- SoNamKinhNghiem

**NHANVIEN_CHUCVU** (Bảng liên kết cho quan hệ n-n `CHUCVU_NV`)

- ***MaNV*** (PK, FK tham chiếu `NHANVIEN(MaNV)`)
- ***MaCV*** (PK, FK tham chiếu `CHUCVU(MaCV)`)
- NgayNhanChuc

### 2. Nhóm Bảng Nghiệp Vụ (Bán Hàng & Hợp Đồng)

**KHACHHANG**

- **MaKH** (PK)
- TenKH
- DiaChi
- SDT

**HOPDONG**

- **SoHD** (PK)
- NgayHD
- ThoiGianBH
- TienPhaiTT
- TienDaTT
- GiamTru
- *MaKH* (FK tham chiếu `KHACHHANG(MaKH)`)
- *MaNV_Lap* (FK tham chiếu `NHANVIEN(MaNV)`)
- *MaNV_Duyet* (FK tham chiếu `NHANVIEN(MaNV)`)

**XE**

- **SoKhung** (PK)
- **SoSuon** (PK)
- NuocSX
- LoaiXe
- MauXe
- SoPK
- *SoHD* (FK tham chiếu `HOPDONG(SoHD)`)

**PHIEUTHANHTOAN**

- **MaPTT** (PK)
- NgayTra
- SoTien
- *SoHD* (FK tham chiếu `HOPDONG(SoHD)`)
- *Ghi chú: Cần một Ràng buộc (CHECK constraint) ở tầng CSDL hoặc Logic ứng dụng để đảm bảo mỗi `SoHD` chỉ có tối đa 3 phiếu.*

### 3. Nhóm Bảng Bảo Hành

**BAOHANH**

- **MaBH** (PK)
- NgayYeuCau
- *SoKhung_Xe* (FK tham chiếu `XE(SoKhung)`)
- *SoSuon_Xe* (FK tham chiếu `XE(SoSuon)`)
- *(Ghi chú: Không còn `MaKH` ở đây. Khách hàng được suy ra qua `XE` -> `HOPDONG` -> `KHACHHANG`)*

**LINHKIEN**

- **MaLK** (PK)
- TenLK
- Gia (Gia niêm yết của linh kiện)

**PHANCONG_BAOHANH** (Bảng liên kết cho quan hệ n-n `THUCHIEN_BH`)

- ***MaNV*** (PK, FK tham chiếu `NV_KYTHUAT(MaNV)`)
- ***MaBH*** (PK, FK tham chiếu `BAOHANH(MaBH)`)
- NgayPhanCong

**CHITIET_BAOHANH** (Bảng liên kết cho quan hệ n-n `CHITIET_BH`)

- ***MaBH*** (PK, FK tham chiếu `BAOHANH(MaBH)`)
- ***MaLK*** (PK, FK tham chiếu `LINHKIEN(MaLK)`)
- LyDo
- LoiThuocVe (vd: 'Khach', 'NhaSanXuat')
- GiaTien (Giá linh kiện thực tế tại thời điểm bảo hành)