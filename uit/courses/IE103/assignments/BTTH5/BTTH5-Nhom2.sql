-- BTTH5-Nhom2.sql
-- A. CHUẨN BỊ

-- Tao CSDL
CREATE DATABASE TEST_XML
GO

-- Su Dung CSDL
USE TEST_XML
GO

-- Tao Bang KhoaHoc
CREATE TABLE KhoaHoc
(
    MaKhoaHoc INT IDENTITY(1,1) NOT NULL,
    TenKhoaHoc VARCHAR(200) NOT NULL,
    CONSTRAINT PK_KhoaHoc PRIMARY KEY(MaKhoaHoc)
)
GO

-- SinhVien
CREATE TABLE SinhVien
(
    MSSV BIGINT IDENTITY(1,1)NOT NULL CONSTRAINT PK_SinhVien PRIMARY KEY(MSSV),
    TenSV VARCHAR(200) NOT NULL,
    MaKhoaHoc INT NOT NULL CONSTRAINT FK_SinhVien_MaKhoaHoc FOREIGN KEY
    REFERENCES KhoaHoc(MaKhoaHoc)
)
GO

-- MonHoc
CREATE TABLE MonHoc
(
    MaMonHoc INT IDENTITY NOT NULL CONSTRAINT PK_MonHoc PRIMARY KEY(MaMonHoc),
    TenMonHoc VARCHAR(200)
)
GO

-- KhoaHocMonHoc
CREATE TABLE KhoaHocMonHoc
(
    MaKhoaHoc INT CONSTRAINT FK_KhoaHocMonHoc_MaKhoaHoc FOREIGN KEY REFERENCES
    KhoaHoc(MaKhoaHoc),
    MaMonHoc INT CONSTRAINT FK_KhoaHocMonHoc_MaMonHoc FOREIGN KEY REFERENCES
    MonHoc(MaMonHoc)
)
GO

-- Diem
CREATE TABLE Diem
(
    MSSV BIGINT CONSTRAINT FK_Diem_MSSV FOREIGN KEY REFERENCES SinhVien(MSSV),
    MaMonHoc INT CONSTRAINT FK_Diem_MaMonHoc FOREIGN KEY REFERENCES
    MonHoc(MaMonHoc),
    Diem INT
)
GO

-- QuanLySV
CREATE TABLE QuanLySV
(
    MSDH INT NOT NULL,
    TenDH VARCHAR(20),
    ChiTietSV XML
)
GO

-- INSERT DỮ LIỆU
-- Insert KhoaHoc
INSERT INTO KhoaHoc (TenKhoaHoc) SELECT 'Mang May Tinh Truyen Thong'
INSERT INTO KhoaHoc (TenKhoaHoc) SELECT 'Khoa Hoc May Tinh'
INSERT INTO KhoaHoc (TenKhoaHoc) SELECT 'Ky Thuat May Tinh'
GO

-- Insert SinhVien
INSERT INTO SinhVien SELECT 'Anh',1
INSERT INTO SinhVien SELECT 'Son',2
INSERT INTO SinhVien SELECT 'Thuy',3
GO

-- Insert MonHoc
INSERT INTO MonHoc (TenMonHoc) SELECT ('Co So Du Lieu')
INSERT INTO MonHoc (TenMonHoc) SELECT ('Cau Truc Du Lieu')
INSERT INTO MonHoc (TenMonHoc) SELECT ('Lap Trinh Di Dong')
INSERT INTO MonHoc (TenMonHoc) SELECT ('Toan Giai Tich')
INSERT INTO MonHoc (TenMonHoc) SELECT ('Lap Trinh Java')
INSERT INTO MonHoc (TenMonHoc) SELECT ('He Quan Tri CSDL')
INSERT INTO MonHoc (TenMonHoc) SELECT ('Anh Van')
INSERT INTO MonHoc (TenMonHoc) SELECT ('Thiet Ke Web ')
INSERT INTO MonHoc (TenMonHoc) SELECT ('An Toan Thong Tin')
GO

-- Insert KhoaHocMonHoc
INSERT INTO KhoaHocMonHoc (MaKhoaHoc,MaMonHoc) SELECT 1,1
INSERT INTO KhoaHocMonHoc (MaKhoaHoc,MaMonHoc) SELECT 1,2
INSERT INTO KhoaHocMonHoc (MaKhoaHoc,MaMonHoc) SELECT 1,3
INSERT INTO KhoaHocMonHoc (MaKhoaHoc,MaMonHoc) SELECT 2,4
INSERT INTO KhoaHocMonHoc (MaKhoaHoc,MaMonHoc) SELECT 2,5
INSERT INTO KhoaHocMonHoc (MaKhoaHoc,MaMonHoc) SELECT 2,6
INSERT INTO KhoaHocMonHoc (MaKhoaHoc,MaMonHoc) SELECT 3,7
INSERT INTO KhoaHocMonHoc (MaKhoaHoc,MaMonHoc) SELECT 3,8
INSERT INTO KhoaHocMonHoc (MaKhoaHoc,MaMonHoc) SELECT 3,9
GO

-- Insert Diem
INSERT INTO Diem (MSSV,MaMonHoc,Diem) SELECT 1,1,75
INSERT INTO Diem (MSSV,MaMonHoc,Diem) SELECT 1,2,80
INSERT INTO Diem (MSSV,MaMonHoc,Diem) SELECT 1,3,70
INSERT INTO Diem (MSSV,MaMonHoc,Diem) SELECT 2,4,80
INSERT INTO Diem (MSSV,MaMonHoc,Diem) SELECT 2,5,80
INSERT INTO Diem (MSSV,MaMonHoc,Diem) SELECT 2,6,90
INSERT INTO Diem (MSSV,MaMonHoc,Diem) SELECT 3,7,80
INSERT INTO Diem (MSSV,MaMonHoc,Diem) SELECT 3,8,80
INSERT INTO Diem (MSSV,MaMonHoc,Diem) SELECT 3,9,90
GO

-- Insert QuanLySV
INSERT INTO QuanLySV VALUES (
    1,
    'DH CNTT',
    '<THONGTINSV>
        <sinhvien ID="10" Ten="Nam">
            <monhoc ID="1" Ten="Co So Du Lieu" />
            <monhoc ID="2" Ten="Cau Truc Du Lieu" />
            <monhoc ID="3" Ten="Lap Trinh Mobile" />
        </sinhvien>
        <sinhvien ID="11" Ten="An">
            <monhoc ID="4" Ten="Toan Giai Tich" />
            <monhoc ID="5" Ten="Lap Trinh Java" />
            <monhoc ID="6" Ten="He Quan Tri CSDL" />
        </sinhvien>
        <sinhvien ID="12" Ten="Thanh">
            <monhoc ID="7" Ten="Anh Van" />
            <monhoc ID="8" Ten="Thiet Ke Web" />
            <monhoc ID="9" Ten="An Toan Thong Tin" />
        </sinhvien>
    </THONGTINSV>'
)
GO

-- Insert QuanLySV
INSERT INTO QuanLySV VALUES (
    2,
    'DH KHTN',
    '<THONGTINSV>
        <sinhvien ID="10" Ten="Khang">
            <monhoc ID="1" Ten="Co So Du Lieu" />
            <monhoc ID="2" Ten="Cau Truc Du Lieu" />
            <monhoc ID="3" Ten="Lap Trinh Mobile" />
        </sinhvien>
        <sinhvien ID="11" Ten="Vinh">
            <monhoc ID="4" Ten="Toan Giai Tich" />
            <monhoc ID="5" Ten="Lap Trinh Java" />
            <monhoc ID="6" Ten="He Quan Tri CSDL" />
        </sinhvien>
        <sinhvien ID="12" Ten="Hoa">
            <monhoc ID="7" Ten="Anh Van" />
            <monhoc ID="8" Ten="Thiet Ke Web" />
            <monhoc ID="9" Ten="An Toan Thong Tin" />
        </sinhvien>
    </THONGTINSV>'
)
GO

-- B. THỰC HÀNH
-- Câu 1.

-- Xpath lấy Sinh viên có ID=10
SELECT ChiTietSV.query('/THONGTINSV/sinhvien[@ID="10"]') AS KetQua
FROM QuanLySV WHERE TenDH = 'DH CNTT'
GO

-- Xpath lấy sinh viên ở vị trí cuối cùng ở trường CNTT
SELECT ChiTietSV.query('/THONGTINSV/sinhvien[last()]') AS KetQua
FROM QuanLySV WHERE TenDH = 'DH CNTT'
GO

-- Câu 2.

-- Lấy tất cả các nút từ nút gốc là THONGTINSV
SELECT ChiTietSV.query('/THONGTINSV/*') as KetQua
FROM QuanLySV
GO

-- Câu 3.

-- Trả về danh sách sinh viên có ID < 12
SELECT ChiTietSV.query('
  for $sv in /THONGTINSV/sinhvien
  where $sv/@ID < 12
  return $sv
') AS KetQua
FROM QuanLySV WHERE MSDH = 1
GO

-- Câu 4.

-- Trả về danh sách sinh viên sắp xếp theo tên với MSDH = 2
SELECT ChiTietSV.query('
  for $sv in /THONGTINSV/sinhvien
  order by $sv/@Ten
  return $sv
') as KetQua
FROM QuanLySV WHERE MSDH = 2
GO

-- Câu 5.

-- Câu 5. Định dạng MSDH và TenDH
SELECT
   CAST(MSDH AS VARCHAR) + ' ' + TenDH AS ChiTietSV
FROM QuanLySV
FOR XML PATH('QuanLySV')
GO

-- Câu 6.

-- Câu 6. Xóa tên các sinh viên trường DH KHTN
UPDATE QuanLySV
SET ChiTietSV.modify('delete /THONGTINSV/sinhvien/@Ten')
WHERE TenDH = 'DH KHTN'
GO

-- Câu 6. Kiểm tra kết quả, thuộc tính Ten đã bị xóa
SELECT ChiTietSV.query('/THONGTINSV/sinhvien') AS KetQua
FROM QuanLySV WHERE TenDH = 'DH KHTN'
GO

-- Câu 7.

-- Câu 7. Thông tin sinh viên có tên Nam hoặc Thanh
SELECT ChiTietSV.query('
  for $s in /THONGTINSV/sinhvien
  where $s/@Ten = "Nam" or $s/@Ten = "Thanh"
  return $s
') as KetQua
FROM QuanLySV
GO

-- Câu 8.

-- Câu 8. Thay đổi tên sinh viên thứ 2 thành tên 'Binh' trong trường CNTT
UPDATE QuanLySV
SET ChiTietSV.modify('replace value of (/THONGTINSV/sinhvien)[2]/@Ten with "Binh"')
WHERE TenDH = 'DH CNTT'
GO

-- Câu 8. Kiểm tra kết quả, tên sinh viên thứ 2 đổi thành 'Binh'
SELECT ChiTietSV.query('/THONGTINSV/sinhvien') AS KetQua
FROM QuanLySV
WHERE TenDH = 'DH CNTT'
GO

-- Câu 9.

-- Câu 9. Kiểm tra xem có tồn tại sinh viên có ID là 12 trong trường KHTN không?
SELECT ChiTietSV.exist('/THONGTINSV/sinhvien[@ID="12"]') as KetQua
FROM QuanLySV WHERE TenDH = 'DH KHTN'
GO

-- Câu 9. Kiểm tra sinh viên có ID = 12
SELECT ChiTietSV.query('
  for $sv in /THONGTINSV/sinhvien
  where $sv/@ID = 12
  return $sv
') AS KetQua
FROM QuanLySV WHERE MSDH = 2
GO

-- Câu 10.

-- Câu 10. Xquery kiểm tra xem có tồn tại sinh viên tên ‘Lan’ trong trường CNTT
SELECT ChiTietSV.exist('/THONGTINSV/sinhvien[@Ten="Lan"]') as KetQua
FROM QuanLySV WHERE TenDH = 'DH CNTT'
GO

-- Câu 10b. INSERT dữ liệu mẫu vào THONGTINSV
UPDATE QuanLySV
SET ChiTietSV.modify('
  insert <sinhvien ID="15" Ten="Lan">
            <monhoc ID="10" Ten="Toan Roi Rac" />
            <monhoc ID="11" Ten="Lap Trinh C#" />
            <monhoc ID="12" Ten="CSDL Nang Cao" />
         </sinhvien>
  as last into (/THONGTINSV)[1]
')
WHERE TenDH = 'DH CNTT'
GO

-- Câu 10d. Xquery kiểm tra xem có tồn tại sinh viên tên ‘Lan’ trong trường CNTT
SELECT ChiTietSV.query('/THONGTINSV/sinhvien[@Ten="Lan"]') as KetQua
FROM QuanLySV WHERE TenDH = 'DH CNTT'
GO

-- Câu 11.

-- Câu 11. Thực hiện phép nối bằng Xquery
SELECT ChiTietSV.query('
  for $sv in /THONGTINSV/sinhvien
  for $mh in $sv/monhoc
  return
    <row>
      <TenKhoaHoc>{sql:column("TenDH")}</TenKhoaHoc>
      <TenSinhVien>{data($sv/@Ten)}</TenSinhVien>
      <TenMonHoc>{data($mh/@Ten)}</TenMonHoc>
    </row>
') AS KetQua
FROM QuanLySV
GO
