-- Xquery kiểm tra xem có tồn tại sinh viên tên ‘Lan’ trong trường CNTT
SELECT ChiTietSV.exist('/THONGTINSV/sinhvien[@Ten="Lan"]') as KetQua
FROM QuanLySV WHERE TenDH = 'DH CNTT'

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
