#import "libs/report.typ": *

// YOUR CONTENT HERE

= Bài 2. Thực hành
<bai-2>

Hãy sử dụng XPath, XQuery để thực hiện các yêu cầu sau:

+ Câu 1: Viết lệnh XPath lấy Sinh viên có ID=10 và lệnh XPath lấy sinh viên ở vị trí cuối cùng ở trường CNTT.
+ Câu 2: Viết lệnh trả về tất cả các nút từ nút gốc là THONGTINSV.
+ Câu 3: Viết lệnh XQuery trả về danh sách sinh viên có ID < 12 với MSDH = 1.
+ Câu 4: Viết lệnh XQuery trả về danh sách sinh viên sắp xếp theo tên với MSDH=2.
+ Câu 5: Viết lệnh XQuery trả về MSDH và TenDH theo định dạng XML.
+ Câu 6: Viết lệnh XQuery xóa tên các sinh viên trường DH KHTN.
+ Câu 7: Viết lệnh XQuery trả về thông tin các sinh viên có tên là 'Nam' hoặc 'Thanh'.
+ Câu 8: Viết lệnh XQuery thay đổi tên sinh viên thứ 2 thành tên 'Binh' trong trường CNTT.
+ Câu 9: Viết lệnh XQuery kiểm tra xem có tồn tại sinh viên có ID là 12 trong trường KHTN không? (Nếu có trả về 1, nếu không thì trả về 0).
+ Câu 10: Viết lệnh XQuery kiểm tra xem có tồn tại sinh viên tên 'Lan' trong trường CNTT không? (Nếu có trả về 1, nếu không thì trả về 0). Và INSERT thêm vào THONGTINSV.
+ Câu 11: Thực hiện phép nối bằng các lệnh XQuery như một câu truy vấn trong SQL để trả về thông tin là sinh viên nào học khóa học tên là gì, sinh viên nào học môn học gì?

== Giới thiệu về XPath và XQuery

XPath và XQuery là các ngôn ngữ truy vấn XML được sử dụng để truy xuất và thao tác dữ liệu XML trong SQL Server.

- #strong[XPath:] Ngôn ngữ để định vị và chọn các phần tử trong tài liệu XML.
- #strong[XQuery:] Ngôn ngữ truy vấn XML mạnh mẽ, cho phép truy vấn, chuyển đổi và xây dựng tài liệu XML.

== Câu 1: XPath lấy Sinh viên theo ID và vị trí

=== XPath lấy Sinh viên có ID=10

Sử dụng biểu thức XPath với điều kiện lọc theo thuộc tính `@ID`.

#figure(
  ```sql
  -- Xpath lấy Sinh viên có ID=10
  SELECT ChiTietSV.query('/THONGTINSV/sinhvien[@ID="10"]') AS KetQua
  FROM QuanLySV WHERE TenDH = 'DH CNTT'
  GO
  ```,
  caption: [Bài 2. XPath lấy sinh viên có ID=10],
)

Giải thích:
- `/THONGTINSV/sinhvien[@ID="10"]`: Đường dẫn XPath tìm phần tử `sinhvien` có thuộc tính `ID` bằng "10".
- `query()`: Phương thức để thực thi biểu thức XPath/XQuery trên cột XML.

=== XPath lấy sinh viên ở vị trí cuối cùng

Sử dụng hàm `last()` để lấy phần tử cuối cùng trong tập hợp.

#figure(
  ```sql
  -- Xpath lấy sinh viên ở vị trí cuối cùng ở trường CNTT
  SELECT ChiTietSV.query('/THONGTINSV/sinhvien[last()]') AS KetQua
  FROM QuanLySV WHERE TenDH = 'DH CNTT'
  GO
  ```,
  caption: [Bài 2. XPath lấy sinh viên ở vị trí cuối cùng],
)

Giải thích:
- `[last()]`: Hàm XPath trả về phần tử cuối cùng trong tập hợp các phần tử `sinhvien`.

== Câu 2: Lấy tất cả các nút con từ nút gốc

Sử dụng ký tự đại diện `*` để lấy tất cả các phần tử con trực tiếp của nút gốc `THONGTINSV`.

#figure(
  ```sql
  SELECT ChiTietSV.query('/THONGTINSV/*') as KetQua
  FROM QuanLySV
  GO
  ```,
  caption: [Bài 2. Lấy tất cả các nút con từ THONGTINSV],
)

Giải thích:
- `/THONGTINSV/*`: Ký tự `*` đại diện cho tất cả các phần tử con trực tiếp của `THONGTINSV`.
- Kết quả trả về tất cả các phần tử `sinhvien` trong XML.

== Câu 3: XQuery với điều kiện WHERE

Sử dụng cú pháp FLWOR (For-Let-Where-Order by-Return) của XQuery để lọc dữ liệu.

#figure(
  ```sql
  SELECT ChiTietSV.query('
    for $sv in /THONGTINSV/sinhvien
    where $sv/@ID < 12
    return $sv
  ') AS KetQua
  FROM QuanLySV WHERE MSDH = 1
  GO
  ```,
  caption: [Bài 2. XQuery với điều kiện WHERE],
)

Giải thích:
- `for $sv in /THONGTINSV/sinhvien`: Duyệt qua tất cả các phần tử `sinhvien`.
- `where $sv/@ID < 12`: Lọc các sinh viên có ID nhỏ hơn 12.
- `return $sv`: Trả về phần tử sinh viên thỏa mãn điều kiện.

== Câu 4: XQuery với sắp xếp (ORDER BY)

Sử dụng mệnh đề `order by` trong XQuery để sắp xếp kết quả.

#figure(
  ```sql
  SELECT ChiTietSV.query('
    for $sv in /THONGTINSV/sinhvien
    order by $sv/@Ten
    return $sv
  ') as KetQua
  FROM QuanLySV WHERE MSDH = 2
  GO
  ```,
  caption: [Bài 2. XQuery với ORDER BY],
)

Giải thích:
- `order by $sv/@Ten`: Sắp xếp các sinh viên theo thuộc tính `Ten` (tên).
- Kết quả được sắp xếp theo thứ tự bảng chữ cái.

== Câu 5: Tạo XML từ dữ liệu quan hệ

Viết lệnh XQuery trả về MSDH và TenDH theo định dạng sau:

#figure(
  ```xml
  <!-- Dữ liệu mẫu -->
  <QuanLySV>
    <ChiTietSV>1 DH CNTT</ChiTietSV>
  </QuanLySV>
  ```,
  caption: [Bài 2. Định dạng XML mẫu của Câu 5],
)

Sử dụng `FOR XML PATH` để tạo cấu trúc XML từ dữ liệu quan hệ.

#figure(
  ```sql
  SELECT
      CAST(MSDH AS VARCHAR) + ' ' + TenDH AS ChiTietSV
  FROM QuanLySV
  FOR XML PATH('QuanLySV')
  GO
  ```,
  caption: [Bài 2. Tạo XML từ dữ liệu quan hệ],
)

Giải thích:
- `FOR XML PATH('QuanLySV')`: Tạo cấu trúc XML với phần tử gốc là `QuanLySV`.
- `CAST(MSDH AS VARCHAR) + ' ' + TenDH`: Nối MSDH và TenDH thành một chuỗi.

== Câu 6: Xóa thuộc tính bằng XQuery

Sử dụng phương thức `modify()` với lệnh `delete` để xóa thuộc tính.

#figure(
  ```sql
  UPDATE QuanLySV
  SET ChiTietSV.modify('delete /THONGTINSV/sinhvien/@Ten')
  WHERE TenDH = 'DH KHTN'
  GO
  ```,
  caption: [Bài 2. Xóa thuộc tính bằng XQuery],
)

Giải thích:
- `modify('delete ...')`: Phương thức để sửa đổi XML.
- `/THONGTINSV/sinhvien/@Ten`: Đường dẫn đến thuộc tính `Ten` của tất cả các phần tử `sinhvien`.
- Sau khi thực thi, tất cả các thuộc tính `Ten` của sinh viên trong trường DH KHTN sẽ bị xóa.

== Câu 7: XQuery với điều kiện OR

Sử dụng toán tử logic `or` trong mệnh đề `where` để lọc dữ liệu theo nhiều điều kiện.

#figure(
  ```sql
  SELECT ChiTietSV.query('
    for $s in /THONGTINSV/sinhvien
    where $s/@Ten = "Nam" or $s/@Ten = "Thanh"
    return $s
  ') as KetQua
  FROM QuanLySV
  GO
  ```,
  caption: [Bài 2. XQuery với điều kiện OR],
)

Giải thích:
- `where $s/@Ten = "Nam" or $s/@Ten = "Thanh"`: Lọc các sinh viên có tên là "Nam" hoặc "Thanh".
- Kết quả trả về tất cả các phần tử `sinhvien` thỏa mãn một trong hai điều kiện.

== Câu 8: Thay thế giá trị thuộc tính

Sử dụng `replace value of` để thay đổi giá trị của thuộc tính tại vị trí cụ thể.

#figure(
  ```sql
  UPDATE QuanLySV
  SET ChiTietSV.modify('replace value of (/THONGTINSV/sinhvien)[2]/@Ten with "Binh"')
  WHERE TenDH = 'DH CNTT'
  GO
  ```,
  caption: [Bài 2. Thay thế giá trị thuộc tính],
)

Giải thích:
- `[/THONGTINSV/sinhvien](2)`: Chọn phần tử `sinhvien` thứ 2 (chỉ số bắt đầu từ 1).
- `replace value of ... with "Binh"`: Thay thế giá trị của thuộc tính `Ten` bằng "Binh".

== Câu 9: Kiểm tra sự tồn tại với exist()

Phương thức `exist()` trả về giá trị boolean (1 nếu tồn tại, 0 nếu không tồn tại).

#figure(
  ```sql
  SELECT ChiTietSV.exist('/THONGTINSV/sinhvien[@ID="12"]') as KetQua
  FROM QuanLySV WHERE TenDH = 'DH KHTN'
  GO
  ```,
  caption: [Bài 2. Kiểm tra sự tồn tại với exist()],
)

Giải thích:
- `exist()`: Phương thức kiểm tra sự tồn tại của phần tử hoặc điều kiện trong XML.
- Trả về `1` nếu tìm thấy sinh viên có ID=12, `0` nếu không tìm thấy.

== Câu 10: Kiểm tra và INSERT dữ liệu XML

Viết lệnh XQuery kiểm tra xem có tồn tại sinh viên tên 'Lan' trong trường CNTT không? (Nếu có trả về 1, nếu không thì trả về 0). Và INSERT thêm vào THONGTINSV:

=== Phần 1: Kiểm tra sự tồn tại

#figure(
  ```sql
  -- Xquery kiểm tra xem có tồn tại sinh viên tên 'Lan' trong trường CNTT
  SELECT ChiTietSV.exist('/THONGTINSV/sinhvien[@Ten="Lan"]') as KetQua
  FROM QuanLySV WHERE TenDH = 'DH CNTT'
  ```,
  caption: [Bài 2. Kiểm tra sinh viên tên 'Lan'],
)

Giải thích:
- `exist()`: Phương thức kiểm tra sự tồn tại của phần tử hoặc điều kiện trong XML.
- Trả về `1` nếu tìm thấy sinh viên tên 'Lan', `0` nếu không tìm thấy.

=== Phần 2: INSERT phần tử mới vào XML

Dữ liệu mẫu cần chèn:

#figure(
  ```xml
  <!-- Dữ liệu mẫu -->
  <sinhvien ID="15" Ten="Lan">
    <monhoc ID="10" Ten="Toan Roi Rac" />
    <monhoc ID="11" Ten="Lap Trinh C#" />
    <monhoc ID="12" Ten="CSDL Nang Cao" />
  </sinhvien>
  ```,
  caption: [Bài 2. Dữ liệu mẫu cần chèn],
)

Sử dụng lệnh `insert` với các tùy chọn vị trí: `as first`, `as last`, `before`, `after`.

#figure(
  ```sql
  -- INSERT dữ liệu mẫu vào THONGTINSV
  UPDATE QuanLySV
  SET ChiTietSV.modify('
    insert <sinhvien ID="15" Ten="Lan">
              <monhoc ID="10" Ten="Toan Roi Rac" />
              <monhoc ID="11" Ten="Lap Trinh C#" />
              <monhoc ID="12" Ten="CSDL Nang Cao" />
           </sinhvien>
    as last into [/THONGTINSV](1)
  ')
  WHERE TenDH = 'DH CNTT'
  GO
  ```,
  caption: [Bài 2. INSERT phần tử mới vào XML],
)

Giải thích:
- `insert ... as last into [/THONGTINSV](1)`: Chèn phần tử mới vào cuối cùng của phần tử `THONGTINSV` đầu tiên.
- `(1)`: Chỉ định phần tử đầu tiên (vì có thể có nhiều phần tử `THONGTINSV`).

== Câu 11: Phép nối (Join) với XQuery

Thực hiện phép nối bằng các lệnh XQuery như một câu truy vấn trong SQL để trả về thông tin là sinh viên nào học khóa học tên là gì, sinh viên nào học môn học gì?

#figure(
  ```sql
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
  ```,
  caption: [Bài 2. Phép nối với XQuery],
)

Giải thích:
- `for $sv in /THONGTINSV/sinhvien`: Vòng lặp ngoài duyệt qua tất cả sinh viên.
- `for $mh in $sv/monhoc`: Vòng lặp trong duyệt qua tất cả môn học của mỗi sinh viên.
- `sql:column("TenDH")`: Lấy giá trị từ cột quan hệ `TenDH` của bảng.
- `data($sv/@Ten)`: Lấy giá trị của thuộc tính `Ten` từ biến `$sv`.
- Kết quả: Mỗi dòng sẽ là một cặp (Sinh viên, Môn học) với tên khóa học tương ứng.

Kết quả mẫu:

#figure(
  ```xml
  <row>
    <TenKhoaHoc>DH CNTT</TenKhoaHoc>
    <TenSinhVien>Nam</TenSinhVien>
    <TenMonHoc>Co So Du Lieu</TenMonHoc>
  </row>
  <row>
    <TenKhoaHoc>DH CNTT</TenKhoaHoc>
    <TenSinhVien>Nam</TenSinhVien>
    <TenMonHoc>Cau Truc Du Lieu</TenMonHoc>
  </row>
  ...
  ```,
  caption: [Bài 2. Kết quả mẫu của Câu 11],
)

== Tổng kết

Trong bài này, chúng ta đã học cách:

- Sử dụng XPath để định vị và chọn phần tử XML.
- Sử dụng XQuery với cú pháp FLWOR để truy vấn dữ liệu XML.
- Sử dụng phương thức `modify()` để sửa đổi dữ liệu XML:
  - `insert`: Chèn phần tử mới.
  - `delete`: Xóa phần tử hoặc thuộc tính.
  - `replace value of`: Thay thế giá trị.
- Sử dụng phương thức `exist()` để kiểm tra sự tồn tại.
- Thực hiện phép nối (join) giữa các phần tử XML và dữ liệu quan hệ.

#pagebreak()
