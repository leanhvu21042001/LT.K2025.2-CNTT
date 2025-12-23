-- NHOM 2
-- IE103
-- BTTH2
-- Phần 2
-- 2. INSERT dữ liệu
-- NOTE: A Batch/Top-Down processing Script.

INSERT INTO SINHVIEN (MSSV, TENSV, SODT, LOP, DIACHI) VALUES
('13520001', N'Nguyễn Văn An', '0906762255', 'SE103.U32', N'THỦ ĐỨC'),
('13520002', N'Phan Tấn Đạt', '0975672350', 'IE204.T21', N'QUẬN 1'),
('13520003', N'Nguyễn Anh Hải', '0947578688', 'IE205.R12', N'QUẬN 9'),
('13520004', N'Phạm Tài', '0956757869', 'IE202.A22', N'QUẬN 1'),
('13520005', N'Lê Thúy Hằng', '0976668688', 'SE304.E22', N'THỦ ĐỨC'),
('13520006', N'Ưng Hồng Ân', '0957475898', 'IE208.F33', N'QUẬN 2');

INSERT INTO DETAI (MSDT, TENDT) VALUES
('97001', N'Quản lý thư viện'),
('97002', N'Nhận dạng vân tay'),
('97003', N'Bán đấu giá trên mạng'),
('97004', N'Quản lý siêu thị'),
('97005', N'Xử lý ảnh'),
('97006', N'Hệ giải toán thông minh');

INSERT INTO SV_DETAI (MSSV, MSDT) VALUES
('13520001', '97004'),
('13520002', '97005'),
('13520003', '97001'),
('13520004', '97002'),
('13520005', '97003'),
('13520006', '97005');

INSERT INTO HOCHAM (MSHH, TENHH) VALUES
(1, N'PHÓ GIÁO SƯ'),
(2, N'GIÁO SƯ');

INSERT INTO GIAOVIEN (MSGV, TENGV, DIACHI, SODT, MSHH, NAMHH) VALUES
(201, N'Trần Trung', N'Bến Tre', '35353535', 1, '1996'),
(202, N'Nguyễn Văn An', N'Tiền Giang', '67868688', 1, '1996'),
(203, N'Trần Thu Trang', N'Cần Thơ', '74758687', 1, '1996'),
(204, N'Nguyễn Thị Loan', N'TP. HCM', '56575868', 2, '2005'),
(205, N'Chu Tiến', N'Hà Nội', '46466646', 2, '2005');

INSERT INTO HOCVI (MSHV, TENHV) VALUES
(1, N'Kỹ sư'),
(2, N'Cử nhân'),
(3, N'Thạc sĩ'),
(4, N'Tiến sĩ'),
(5, N'Tiến sĩ Khoa học');

INSERT INTO CHUYENNGANH (MSCN, TENCN) VALUES
(1, N'Công nghệ Web'),
(2, N'Mạng xã hội'),
(3, N'Quản lý CNTT'),
(4, N'GIS');

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
(1, 2, '07:00', '2014-11-29', N'Thật', 201),
(2, 102, '07:00', '2014-12-05', N'Thật', 202),
(3, 3, '08:00', '2014-12-06', N'Thật', 203);

INSERT INTO HOIDONG_GV (MSHD, MSGV) VALUES
(1, 201), (1, 202), (1, 203), (1, 204),
(2, 203), (2, 202), (2, 205), (2, 204),
(3, 201), (3, 202), (3, 203), (3, 204);

INSERT INTO HOIDONG_DT (MSHD, MSDT, QUYETDINH) VALUES
(1, '97001', N'Được'),
(1, '97002', N'Được'),
(2, '97001', N'Không'),
(2, '97004', N'Không'),
(1, '97005', N'Được'),
(3, '97001', N'Không'),
(3, '97002', N'Được');
GO
