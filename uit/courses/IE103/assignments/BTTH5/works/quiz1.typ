#import "libs/report.typ": *

// YOUR CONTENT HERE

= Bài 1. Chuẩn bị
<bai-1>

Trước khi thực hành với XPath và XQuery, chúng ta cần chuẩn bị cơ sở dữ liệu và dữ liệu mẫu.

== Tạo Database và các bảng

Thực hiện các lệnh sau để tạo database `TEST_XML` và các bảng cần thiết:

#figure(
  ```sql
  CREATE DATABASE TEST_XML
  GO
  USE TEST_XML
  GO
  ```,
  caption: [Bài 1. Tạo và sử dụng database],
)

== Bảng KhoaHoc

#figure(
  ```sql
  -- KhoaHoc
  CREATE TABLE KhoaHoc
  (
      MaKhoaHoc INT IDENTITY(1,1) NOT NULL,
      TenKhoaHoc VARCHAR(200) NOT NULL,
      CONSTRAINT PK_KhoaHoc PRIMARY KEY(MaKhoaHoc)
  )
  INSERT INTO KhoaHoc (TenKhoaHoc) SELECT 'Mang May Tinh Truyen Thong'
  INSERT INTO KhoaHoc (TenKhoaHoc) SELECT 'Khoa Hoc May Tinh'
  INSERT INTO KhoaHoc (TenKhoaHoc) SELECT 'Ky Thuat May Tinh'
  ```,
  caption: [Bài 1. Tạo bảng KhoaHoc và chèn dữ liệu],
)

== Bảng SinhVien

#figure(
  ```sql
  -- SinhVien
  CREATE TABLE SinhVien
  (
      MSSV BIGINT IDENTITY(1,1)NOT NULL CONSTRAINT PK_SinhVien PRIMARY KEY(MSSV),
      TenSV VARCHAR(200) NOT NULL,
      MaKhoaHoc INT NOT NULL CONSTRAINT FK_SinhVien_MaKhoaHoc FOREIGN KEY
      REFERENCES KhoaHoc(MaKhoaHoc)
  )
  INSERT INTO SinhVien SELECT 'Anh',1
  INSERT INTO SinhVien SELECT 'Son',2
  INSERT INTO SinhVien SELECT 'Thuy',3
  ```,
  caption: [Bài 1. Tạo bảng SinhVien và chèn dữ liệu],
)

== Bảng MonHoc

#figure(
  ```sql
  -- MonHoc
  CREATE TABLE MonHoc
  (
      MaMonHoc INT IDENTITY NOT NULL CONSTRAINT PK_MonHoc PRIMARY KEY(MaMonHoc),
      TenMonHoc VARCHAR(200)
  )
  INSERT INTO MonHoc (TenMonHoc) SELECT ('Co So Du Lieu')
  INSERT INTO MonHoc (TenMonHoc) SELECT ('Cau Truc Du Lieu')
  INSERT INTO MonHoc (TenMonHoc) SELECT ('Lap Trinh Di Dong')
  INSERT INTO MonHoc (TenMonHoc) SELECT ('Toan Giai Tich')
  INSERT INTO MonHoc (TenMonHoc) SELECT ('Lap Trinh Java')
  INSERT INTO MonHoc (TenMonHoc) SELECT ('He Quan Tri CSDL')
  INSERT INTO MonHoc (TenMonHoc) SELECT ('Anh Van')
  INSERT INTO MonHoc (TenMonHoc) SELECT ('Thiet Ke Web ')
  INSERT INTO MonHoc (TenMonHoc) SELECT ('An Toan Thong Tin')
  ```,
  caption: [Bài 1. Tạo bảng MonHoc và chèn dữ liệu],
)

== Bảng KhoaHocMonHoc

#figure(
  ```sql
  -- KhoaHocMonHoc
  CREATE TABLE KhoaHocMonHoc
  (
      MaKhoaHoc INT CONSTRAINT FK_KhoaHocMonHoc_MaKhoaHoc FOREIGN KEY REFERENCES
      KhoaHoc(MaKhoaHoc),
      MaMonHoc INT CONSTRAINT FK_KhoaHocMonHoc_MaMonHoc FOREIGN KEY REFERENCES
      MonHoc(MaMonHoc)
  )
  INSERT INTO KhoaHocMonHoc (MaKhoaHoc,MaMonHoc) SELECT 1,1
  INSERT INTO KhoaHocMonHoc (MaKhoaHoc,MaMonHoc) SELECT 1,2
  INSERT INTO KhoaHocMonHoc (MaKhoaHoc,MaMonHoc) SELECT 1,3
  INSERT INTO KhoaHocMonHoc (MaKhoaHoc,MaMonHoc) SELECT 2,4
  INSERT INTO KhoaHocMonHoc (MaKhoaHoc,MaMonHoc) SELECT 2,5
  INSERT INTO KhoaHocMonHoc (MaKhoaHoc,MaMonHoc) SELECT 2,6
  INSERT INTO KhoaHocMonHoc (MaKhoaHoc,MaMonHoc) SELECT 3,7
  INSERT INTO KhoaHocMonHoc (MaKhoaHoc,MaMonHoc) SELECT 3,8
  INSERT INTO KhoaHocMonHoc (MaKhoaHoc,MaMonHoc) SELECT 3,9
  ```,
  caption: [Bài 1. Tạo bảng KhoaHocMonHoc và chèn dữ liệu],
)

== Bảng Diem

#figure(
  ```sql
  -- Diem
  CREATE TABLE Diem
  (
      MSSV BIGINT CONSTRAINT FK_Diem_MSSV FOREIGN KEY REFERENCES SinhVien(MSSV),
      MaMonHoc INT CONSTRAINT FK_Diem_MaMonHoc FOREIGN KEY REFERENCES
      MonHoc(MaMonHoc),
      Diem INT
  )
  INSERT INTO Diem (MSSV,MaMonHoc,Diem) SELECT 1,1,75
  INSERT INTO Diem (MSSV,MaMonHoc,Diem) SELECT 1,2,80
  INSERT INTO Diem (MSSV,MaMonHoc,Diem) SELECT 1,3,70
  INSERT INTO Diem (MSSV,MaMonHoc,Diem) SELECT 2,4,80
  INSERT INTO Diem (MSSV,MaMonHoc,Diem) SELECT 2,5,80
  INSERT INTO Diem (MSSV,MaMonHoc,Diem) SELECT 2,6,90
  INSERT INTO Diem (MSSV,MaMonHoc,Diem) SELECT 3,7,80
  INSERT INTO Diem (MSSV,MaMonHoc,Diem) SELECT 3,8,80
  INSERT INTO Diem (MSSV,MaMonHoc,Diem) SELECT 3,9,90
  ```,
  caption: [Bài 1. Tạo bảng Diem và chèn dữ liệu],
)

== Bảng QuanLySV (chứa dữ liệu XML)

Bảng quan trọng nhất cho bài tập này là `QuanLySV`, chứa cột `ChiTietSV` kiểu XML.

#figure(
  ```sql
  -- QuanLySV
  CREATE TABLE QuanLySV
  (
      MSDH INT NOT NULL,
      TenDH VARCHAR(20),
      ChiTietSV XML
  )
  ```,
  caption: [Bài 1. Tạo bảng QuanLySV],
)

=== Chèn dữ liệu XML cho trường DH CNTT

#figure(
  ```sql
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
  ```,
  caption: [Bài 1. Chèn dữ liệu XML cho trường DH CNTT],
)

=== Chèn dữ liệu XML cho trường DH KHTN

#figure(
  ```sql
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
  ```,
  caption: [Bài 1. Chèn dữ liệu XML cho trường DH KHTN],
)

== Tổng kết phần chuẩn bị

Sau khi hoàn thành các bước trên, chúng ta đã có:
- Database `TEST_XML` với các bảng quan hệ: `KhoaHoc`, `SinhVien`, `MonHoc`, `KhoaHocMonHoc`, `Diem`.
- Bảng `QuanLySV` chứa dữ liệu XML trong cột `ChiTietSV`, bao gồm thông tin về sinh viên và môn học của hai trường: DH CNTT và DH KHTN.

Dữ liệu XML trong bảng `QuanLySV` sẽ được sử dụng để thực hành các câu lệnh XPath và XQuery trong phần tiếp theo.

#pagebreak()
