INSERT INTO SINHVIEN (MSSV, TENSV, SODT, LOP, DIACHI) VALUES
('13520001', 'Nguyễn Văn An', '0906762255', 'SE103.U32', 'THỦ ĐỨC'),
('13520002', 'Phan Tấn Đạt', '0975672350', 'IE204.T21', 'QUẬN 1'),
('13520003', 'Nguyễn Anh Hải', '0947578688', 'IE205.R12', 'QUẬN 9'),
('13520004', 'Phạm Tài', '0956757869', 'IE202.A22', 'QUẬN 1'),
('13520005', 'Lê Thúy Hằng', '0976668688', 'SE304.E22', 'THỦ ĐỨC'),
('13520006', 'Ưng Hồng Ân', '0957475898', 'IE208.F33', 'QUẬN 2');

INSERT INTO DETAI (MSDT, TENDT) VALUES
('97001', 'Quản lý thư viện'),
('97002', 'Nhận dạng vân tay'),
('97003', 'Bán đấu giá trên mạng'),
('97004', 'Quản lý siêu thị'),
('97005', 'Xử lý ảnh'),
('97006', 'Hệ giải toán thông minh');

INSERT INTO SV_DETAI (MSSV, MSDT) VALUES
('13520001', '97004'),
('13520002', '97005'),
('13520003', '97001'),
('13520004', '97002'),
('13520005', '97003'),
('13520006', '97005');

INSERT INTO HOCHAM (MSHH, TENHH) VALUES
(1, 'PHÓ GIÁO SƯ'),
(2, 'GIÁO SƯ');

INSERT INTO GIAOVIEN (MSGV, TENGV, DIACHI, SODT, MSHH, NAMHH) VALUES
(201, 'Trần Trung', 'Bến Tre', '35353535', 1, '1996'),
(202, 'Nguyễn Văn An', 'Tiền Giang', '67868688', 1, '1996'),
(203, 'Trần Thu Trang', 'Cần Thơ', '74758687', 1, '1996'),
(204, 'Nguyễn Thị Loan', 'TP. HCM', '56575868', 2, '2005'),
(205, 'Chu Tiến', 'Hà Nội', '46466646', 2, '2005');

INSERT INTO HOCVI (MSHV, TENHV) VALUES
(1, 'Kỹ sư'),
(2, 'Cử nhân'),
(3, 'Thạc sĩ'),
(4, 'Tiến sĩ'),
(5, 'Tiến sĩ Khoa học');

INSERT INTO CHUYENNGANH (MSCN, TENCN) VALUES
(1, 'Công nghệ Web'),
(2, 'Mạng xã hội'),
(3, 'Quản lý CNTT'),
(4, 'GIS');

INSERT INTO GV_HV_CN (MSGV, MSHV, MSCN, NAM) VALUES
(201, 1, 1, '2013'),
(201, 1, 2, '2013'),
(201, 2, 1, '2014'),
(202, 3, 2, '2013'),
(203, 2, 4, '2014'),
(204, 3, 2, '2014');

INSERT INTO GV_HDDT (MSGV, MSDT, DIEM) VALUES
(201, '97001', 8),
(202, '97002', 7),
(205, '97001', 9),
(204, '97004', 7),
(203, '97005', 9);

INSERT INTO GV_PBDT (MSGV, MSDT, DIEM) VALUES
(201, '97005', 8),
(202, '97001', 7),
(205, '97004', 9),
(204, '97003', 7),
(203, '97002', 9);


INSERT INTO GV_UVDT (MSGV, MSDT, DIEM) VALUES
(205, '97005', 8),
(202, '97005', 7),
(204, '97005', 9),
(203, '97001', 7),
(204, '97001', 9),
(205, '97001', 8),
(203, '97003', 7),
(201, '97003', 9),
(202, '97003', 7),
(201, '97004', 9),
(202, '97004', 8),
(203, '97004', 7),
(201, '97002', 9),
(204, '97002', 7),
(205, '97002', 9),
(201, '97006', 9),
(202, '97006', 7),
(204, '97006', 9);

INSERT INTO HOIDONG (MSHD, PHONG, TGBD, NGAYHD, TINHTRANG, MSGV) VALUES
(1, 2, '07:00', '2014-11-29', 'Thật', 201),
(2, 102, '07:00', '2014-12-05', 'Thật', 202),
(3, 3, '08:00', '2014-12-06', 'Thật', 203);

INSERT INTO HOIDONG_GV (MSHD, MSGV) VALUES
(1, 201), (1, 202), (1, 203), (1, 204),
(2, 203), (2, 202), (2, 205), (2, 204),
(3, 201), (3, 202), (3, 203), (3, 204);

INSERT INTO HOIDONG_DT (MSHD, MSDT, QUYETDINH) VALUES
(1, '97001', 'Được'),
(1, '97002', 'Được'),
(2, '97001', 'Không'),
(2, '97004', 'Không'),
(1, '97005', 'Được'),
(3, '97001', 'Không'),
(3, '97002', 'Được');
