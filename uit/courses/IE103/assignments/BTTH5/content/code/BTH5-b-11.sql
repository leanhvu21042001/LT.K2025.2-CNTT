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
