SELECT ChiTietSV.query('
  for $s in /THONGTINSV/sinhvien
  where $s/@Ten = "Nam" or $s/@Ten = "Thanh"
  return $s
') as KetQua
FROM QuanLySV
GO
