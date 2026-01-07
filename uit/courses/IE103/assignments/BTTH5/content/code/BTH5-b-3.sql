SELECT ChiTietSV.query('
  for $sv in /THONGTINSV/sinhvien
  where $sv/@ID < 12
  return $sv
') AS KetQua
FROM QuanLySV WHERE MSDH = 1
GO
