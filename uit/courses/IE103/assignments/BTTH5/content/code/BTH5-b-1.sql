-- Xpath lấy Sinh viên có ID=10
SELECT ChiTietSV.query('/THONGTINSV/sinhvien[@ID="10"]') AS KetQua
FROM QuanLySV WHERE TenDH = 'DH CNTT'
GO

-- Xpath lấy sinh viên ở vị trí cuối cùng ở trường CNTT
SELECT ChiTietSV.query('/THONGTINSV/sinhvien[last()]') AS KetQua
FROM QuanLySV WHERE TenDH = 'DH CNTT'
GO
