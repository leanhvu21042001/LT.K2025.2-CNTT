CREATE DATABASE QuanLyDeTai;
GO
USE QuanLyDeTai;
GO
SET DATEFORMAT dmy; -- Định dạng ngày tháng năm
GO

/*LƯU Ý QUAN TRỌNG TRƯỚC KHI CHẠY:
-Để đảm bảo không bị lỗi khóa ngoại (Foreign Key), mình đã sắp xếp thứ 
tự tạo bảng và nhập dữ liệu theo quy tắc: Bảng cha tạo trước - Bảng con tạo sau.
-Dữ liệu ngày tháng được định dạng theo kiểu dmy (Ngày/Tháng/Năm) để khớp với dữ 
liệu trong bài (ví dụ: 29/11/2014).*/

--Phần 1:
-- 1. Bảng SINHVIEN 
CREATE TABLE SINHVIEN (
    MSSV char(8) PRIMARY KEY,
    TENSV nvarchar(30) NOT NULL,
    SODT varchar(10),
    LOP char(10) NOT NULL,
    DIACHI nchar(50) NOT NULL
);

-- 2. Bảng DETAI 
CREATE TABLE DETAI (
    MSDT char(6) PRIMARY KEY,
    TENDT nvarchar(30) NOT NULL
);

-- 3. Bảng HOCHAM (Tạo trước vì GIAOVIEN tham chiếu tới nó)
CREATE TABLE HOCHAM (
    MSHH int PRIMARY KEY,
    TENHH nvarchar(20) NOT NULL
);

-- 4. Bảng GIAOVIEN
CREATE TABLE GIAOVIEN (
    MSGV int PRIMARY KEY,
    TENGV nvarchar(30) NOT NULL,
    DIACHI nvarchar(50) NOT NULL,
    SODT varchar(10) NOT NULL,
    MSHH int,
    NAMHH smalldatetime NOT NULL,
    FOREIGN KEY (MSHH) REFERENCES HOCHAM(MSHH)
);

-- 5. Bảng HOCVI
CREATE TABLE HOCVI (
    MSHV int PRIMARY KEY,
    TENHV nvarchar(20) NOT NULL
);

-- 6. Bảng CHUYENNGANH
CREATE TABLE CHUYENNGANH (
    MSCN int PRIMARY KEY,
    TENCN nvarchar(30) NOT NULL
);

-- 7. Bảng HOIDONG
CREATE TABLE HOIDONG (
    MSHD int PRIMARY KEY,
    PHONG int,
    TGBD smalldatetime,
    NGAYHD smalldatetime NOT NULL,
    TINHTRANG nvarchar(30) NOT NULL,
    MSGV int, -- Chủ tịch hội đồng
    FOREIGN KEY (MSGV) REFERENCES GIAOVIEN(MSGV)
);

-- --- CÁC BẢNG TRUNG GIAN (CÓ KHÓA NGOẠI) ---

-- 8. Bảng SV_DETAI
CREATE TABLE SV_DETAI (
    MSSV char(8),
    MSDT char(6),
    PRIMARY KEY (MSSV, MSDT),
    FOREIGN KEY (MSSV) REFERENCES SINHVIEN(MSSV),
    FOREIGN KEY (MSDT) REFERENCES DETAI(MSDT)
);

-- 9. Bảng GV_HV_CN
CREATE TABLE GV_HV_CN (
    MSGV int,
    MSHV int,
    MSCN int,
    NAM smalldatetime NOT NULL,
    PRIMARY KEY (MSGV, MSHV, MSCN),
    FOREIGN KEY (MSGV) REFERENCES GIAOVIEN(MSGV),
    FOREIGN KEY (MSHV) REFERENCES HOCVI(MSHV),
    FOREIGN KEY (MSCN) REFERENCES CHUYENNGANH(MSCN)
);

-- 10. Bảng GV_HDDT (Giáo viên hướng dẫn)
CREATE TABLE GV_HDDT (
    MSGV int,
    MSDT char(6),
    DIEM float,
    PRIMARY KEY (MSGV, MSDT),
    FOREIGN KEY (MSGV) REFERENCES GIAOVIEN(MSGV),
    FOREIGN KEY (MSDT) REFERENCES DETAI(MSDT)
);

-- 11. Bảng GV_PBDT (Giáo viên phản biện)
CREATE TABLE GV_PBDT (
    MSGV int,
    MSDT char(6),
    DIEM float,
    PRIMARY KEY (MSGV, MSDT),
    FOREIGN KEY (MSGV) REFERENCES GIAOVIEN(MSGV),
    FOREIGN KEY (MSDT) REFERENCES DETAI(MSDT)
);

-- 12. Bảng GV_UVDT (Giáo viên ủy viên)
CREATE TABLE GV_UVDT (
    MSGV int,
    MSDT char(6),
    DIEM float,
    PRIMARY KEY (MSGV, MSDT),
    FOREIGN KEY (MSGV) REFERENCES GIAOVIEN(MSGV),
    FOREIGN KEY (MSDT) REFERENCES DETAI(MSDT)
);

-- 13. Bảng HOIDONG_GV 
CREATE TABLE HOIDONG_GV (
    MSHD int,
    MSGV int,
    PRIMARY KEY (MSHD, MSGV),
    FOREIGN KEY (MSHD) REFERENCES HOIDONG(MSHD),
    FOREIGN KEY (MSGV) REFERENCES GIAOVIEN(MSGV)
);

-- 14. Bảng HOIDONG_DT 
CREATE TABLE HOIDONG_DT (
    MSHD int,
    MSDT char(6),
    QUYETDINH nchar(10),
    PRIMARY KEY (MSHD, MSDT),
    FOREIGN KEY (MSHD) REFERENCES HOIDONG(MSHD),
    FOREIGN KEY (MSDT) REFERENCES DETAI(MSDT)
);

--INSERT INFORMATION
-- a) Insert SINHVIEN
INSERT INTO SINHVIEN VALUES ('13520001', N'Nguyễn Văn An', '0906762255', 'SE103.U32', N'THỦ ĐỨC');
INSERT INTO SINHVIEN VALUES ('13520002', N'Phan Tấn Đạt', '0975672350', 'IE204.T21', N'QUẬN 1');
INSERT INTO SINHVIEN VALUES ('13520003', N'Nguyễn Anh Hải', '0947578688', 'IE205.R12', N'QUẬN 9');
INSERT INTO SINHVIEN VALUES ('13520004', N'Phạm Tài', '0956757869', 'IE202.A22', N'QUẬN 1');
INSERT INTO SINHVIEN VALUES ('13520005', N'Lê Thúy Hằng', '0976668688', 'SE304.E22', N'THỦ ĐỨC');
INSERT INTO SINHVIEN VALUES ('13520006', N'Ưng Hồng Ân', '0957475898', 'IE208.F33', N'QUẬN 2');

-- b) Insert DETAI
INSERT INTO DETAI VALUES ('97001', N'Quản lý thư viện');
INSERT INTO DETAI VALUES ('97002', N'Nhận dạng vân tay');
INSERT INTO DETAI VALUES ('97003', N'Bán đấu giá trên mạng');
INSERT INTO DETAI VALUES ('97004', N'Quản lý siêu thị');
INSERT INTO DETAI VALUES ('97005', N'Xử lý ảnh');
INSERT INTO DETAI VALUES ('97006', N'Hệ giải toán thông minh');

-- c) Insert SV_DETAI
INSERT INTO SV_DETAI VALUES ('13520001', '97004');
INSERT INTO SV_DETAI VALUES ('13520002', '97005');
INSERT INTO SV_DETAI VALUES ('13520003', '97001');
INSERT INTO SV_DETAI VALUES ('13520004', '97002');
INSERT INTO SV_DETAI VALUES ('13520005', '97003');
INSERT INTO SV_DETAI VALUES ('13520006', '97005');

-- d) Insert HOCHAM
INSERT INTO HOCHAM VALUES (1, N'PHÓ GIÁO SƯ');
INSERT INTO HOCHAM VALUES (2, N'GIÁO SƯ');

-- e) Insert GIAOVIEN
INSERT INTO GIAOVIEN VALUES (00201, N'Trần Trung', N'Bến Tre', '35353535', 1, '1996');
INSERT INTO GIAOVIEN VALUES (00202, N'Nguyễn Văn An', N'Tiền Giang', '67868688', 1, '1996');
INSERT INTO GIAOVIEN VALUES (00203, N'Trần Thu Trang', N'Cần Thơ', '74758687', 1, '1996');
INSERT INTO GIAOVIEN VALUES (00204, N'Nguyễn Thị Loan', N'TP. HCM', '56575868', 2, '2005');
INSERT INTO GIAOVIEN VALUES (00205, N'Chu Tiến', N'Hà Nội', '46466646', 2, '2005');

-- f) Insert HOCVI
INSERT INTO HOCVI VALUES (1, N'Kỹ sư');
INSERT INTO HOCVI VALUES (2, N'Cử nhân');
INSERT INTO HOCVI VALUES (3, N'Thạc sĩ');
INSERT INTO HOCVI VALUES (4, N'Tiến sĩ');
INSERT INTO HOCVI VALUES (5, N'Tiến sĩ Khoa học');

-- g) Insert CHUYENNGANH
INSERT INTO CHUYENNGANH VALUES (1, N'Công nghệ Web');
INSERT INTO CHUYENNGANH VALUES (2, N'Mạng xã hội');
INSERT INTO CHUYENNGANH VALUES (3, N'Quản lý CNTT');
INSERT INTO CHUYENNGANH VALUES (4, N'GIS');

-- h) Insert GV_HV_CN
INSERT INTO GV_HV_CN VALUES (00201, 1, 1, '2013');
INSERT INTO GV_HV_CN VALUES (00201, 1, 2, '2013');
INSERT INTO GV_HV_CN VALUES (00201, 2, 1, '2014');
INSERT INTO GV_HV_CN VALUES (00202, 3, 2, '2013');
INSERT INTO GV_HV_CN VALUES (00203, 2, 4, '2014');
INSERT INTO GV_HV_CN VALUES (00204, 3, 2, '2014');

-- i) Insert GV_HDDT
INSERT INTO GV_HDDT VALUES (00201, '97001', 8);
INSERT INTO GV_HDDT VALUES (00202, '97002', 7);
INSERT INTO GV_HDDT VALUES (00205, '97001', 9);
INSERT INTO GV_HDDT VALUES (00204, '97004', 7);
INSERT INTO GV_HDDT VALUES (00203, '97005', 9);

-- j) Insert GV_PBDT
INSERT INTO GV_PBDT VALUES (00201, '97005', 8);
INSERT INTO GV_PBDT VALUES (00202, '97001', 7);
INSERT INTO GV_PBDT VALUES (00205, '97004', 9);
INSERT INTO GV_PBDT VALUES (00204, '97003', 7);
INSERT INTO GV_PBDT VALUES (00203, '97002', 9);

-- k) Insert GV_UVDT
INSERT INTO GV_UVDT VALUES (00205, '97005', 8);
INSERT INTO GV_UVDT VALUES (00202, '97005', 7);
INSERT INTO GV_UVDT VALUES (00204, '97005', 9);
INSERT INTO GV_UVDT VALUES (00203, '97001', 7);
INSERT INTO GV_UVDT VALUES (00204, '97001', 9);
INSERT INTO GV_UVDT VALUES (00205, '97001', 8);
INSERT INTO GV_UVDT VALUES (00203, '97003', 7);
INSERT INTO GV_UVDT VALUES (00201, '97003', 9);
INSERT INTO GV_UVDT VALUES (00202, '97003', 7);
INSERT INTO GV_UVDT VALUES (00201, '97004', 9);
INSERT INTO GV_UVDT VALUES (00202, '97004', 8);
INSERT INTO GV_UVDT VALUES (00203, '97004', 7);
INSERT INTO GV_UVDT VALUES (00201, '97002', 9);
INSERT INTO GV_UVDT VALUES (00204, '97002', 7);
INSERT INTO GV_UVDT VALUES (00205, '97002', 9);
INSERT INTO GV_UVDT VALUES (00201, '97006', 9);
INSERT INTO GV_UVDT VALUES (00202, '97006', 7);
INSERT INTO GV_UVDT VALUES (00204, '97006', 9);

-- l) Insert HOIDONG
-- Lưu ý: TGBD (Thời gian bắt đầu) chỉ có giờ, SQL sẽ tự thêm ngày mặc định (thường là 1900-01-01)
INSERT INTO HOIDONG VALUES (1, 002, '7:00', '29/11/2014', N'Thật', 00201);
INSERT INTO HOIDONG VALUES (2, 102, '7:00', '5/12/2014', N'Thật', 00202);
INSERT INTO HOIDONG VALUES (3, 003, '8:00', '6/12/2014', N'Thật', 00203);

-- m) Insert HOIDONG_GV
INSERT INTO HOIDONG_GV VALUES (1, 00201);
INSERT INTO HOIDONG_GV VALUES (1, 00202);
INSERT INTO HOIDONG_GV VALUES (1, 00203);
INSERT INTO HOIDONG_GV VALUES (1, 00204);
INSERT INTO HOIDONG_GV VALUES (2, 00203);
INSERT INTO HOIDONG_GV VALUES (2, 00202);
INSERT INTO HOIDONG_GV VALUES (2, 00205);
INSERT INTO HOIDONG_GV VALUES (2, 00204);
INSERT INTO HOIDONG_GV VALUES (3, 00201);
INSERT INTO HOIDONG_GV VALUES (3, 00202);
INSERT INTO HOIDONG_GV VALUES (3, 00203);
INSERT INTO HOIDONG_GV VALUES (3, 00204);

-- n) Insert HOIDONG_DT
INSERT INTO HOIDONG_DT VALUES (1, '97001', N'Được');
INSERT INTO HOIDONG_DT VALUES (1, '97002', N'Được');
INSERT INTO HOIDONG_DT VALUES (2, '97001', N'Không');
INSERT INTO HOIDONG_DT VALUES (2, '97004', N'Không');
INSERT INTO HOIDONG_DT VALUES (1, '97005', N'Được');
INSERT INTO HOIDONG_DT VALUES (3, '97001', N'Không');
INSERT INTO HOIDONG_DT VALUES (3, '97002', N'Được');

--Phần 2:
--A. STORED PROCEDURES VỚI THAM SỐ VÀO

/*1. Tham số vào là MSGV, TENGV, SODT, DIACHI, MSHH, NAMHH.
Trước khi insert dữ liệu cần kiểm tra MSHH đã tồn tại trong table HOCHAM
chưa, nếu chưa thì trả về giá trị 0.*/

CREATE PROCEDURE sp_A1_InsertGiaoVien_CheckHH
    @MSGV int,
    @TENGV nvarchar(30),
    @SODT varchar(10),
    @DIACHI nvarchar(50),
    @MSHH int,
    @NAMHH smalldatetime
AS
BEGIN
    -- Kiểm tra MSHH đã tồn tại chưa
    IF NOT EXISTS (SELECT 1 FROM HOCHAM WHERE MSHH = @MSHH)
    BEGIN
        SELECT 0 AS KetQua; -- MSHH không tồn tại, trả về 0 [cite: 84]
        RETURN;
    END

    -- Nếu MSHH tồn tại, tiến hành INSERT (Giả định MSGV không trùng)
    INSERT INTO GIAOVIEN (MSGV, TENGV, SODT, DIACHI, MSHH, NAMHH)
    VALUES (@MSGV, @TENGV, @SODT, @DIACHI, @MSHH, @NAMHH);
    
    SELECT 1 AS KetQua; -- Thành công
END
GO

/*2. Tham số vào là MSGV, TENGV, SODT, DIACHI, MSHH, NAMHH.
Trước khi insert dữ liệu cần kiểm tra MSGV trong table GIAOVIEN có trùng
không, nếu trùng thì trả về giá trị 0.*/

CREATE PROCEDURE sp_A2_InsertGiaoVien_CheckGV
    @MSGV int,
    @TENGV nvarchar(30),
    @SODT varchar(10),
    @DIACHI nvarchar(50),
    @MSHH int,
    @NAMHH smalldatetime
AS
BEGIN
    -- Kiểm tra MSGV có bị trùng không
    IF EXISTS (SELECT 1 FROM GIAOVIEN WHERE MSGV = @MSGV)
    BEGIN
        SELECT 0 AS KetQua; -- MSGV trùng, trả về 0 [cite: 86]
        RETURN;
    END

    -- Nếu MSGV không trùng, tiến hành INSERT (Giả định MSHH hợp lệ)
    INSERT INTO GIAOVIEN (MSGV, TENGV, SODT, DIACHI, MSHH, NAMHH)
    VALUES (@MSGV, @TENGV, @SODT, @DIACHI, @MSHH, @NAMHH);

    SELECT 1 AS KetQua; -- Thành công
END
GO

/*3. Giống (1) và (2) kiểm tra xem MSGV có trùng không? MSHH có tồn tại
chưa? Nếu MSGV trùng thì trả về 0. Nếu MSHH chưa tồn tại trả về 1, ngược
lại cho insert dữ liệu.*/

CREATE PROCEDURE sp_A3_InsertGiaoVien_CombinedCheck
    @MSGV int,
    @TENGV nvarchar(30),
    @SODT varchar(10),
    @DIACHI nvarchar(50),
    @MSHH int,
    @NAMHH smalldatetime
AS
BEGIN
    -- 1. Kiểm tra MSGV trùng [cite: 88]
    IF EXISTS (SELECT 1 FROM GIAOVIEN WHERE MSGV = @MSGV)
    BEGIN
        SELECT 0 AS KetQua; -- MSGV trùng, trả về 0
        RETURN;
    END

    -- 2. Kiểm tra MSHH chưa tồn tại [cite: 88]
    IF NOT EXISTS (SELECT 1 FROM HOCHAM WHERE MSHH = @MSHH)
    BEGIN
        SELECT 1 AS KetQua; -- MSHH chưa tồn tại, trả về 1
        RETURN;
    END

    -- 3. Ngược lại, cho insert dữ liệu
    INSERT INTO GIAOVIEN (MSGV, TENGV, SODT, DIACHI, MSHH, NAMHH)
    VALUES (@MSGV, @TENGV, @SODT, @DIACHI, @MSHH, @NAMHH);

    SELECT 2 AS KetQua; -- Trả về 2 để báo thành công
END
GO

/*4. Đưa vào MSDT cũ, TENDT mới. Hãy cập nhật tên đề tài mới với mã đề tài
cũ không đổi nếu không tìm thấy trả về 0, ngược lại cập nhật và trả về 1.*/

CREATE PROCEDURE sp_A4_UpdateDeTai
    @MSDT_cu char(6),
    @TENDT_moi nvarchar(30)
AS
BEGIN
    -- Cập nhật TENDT
    UPDATE DETAI
    SET TENDT = @TENDT_moi
    WHERE MSDT = @MSDT_cu;

    -- Kiểm tra số dòng bị ảnh hưởng
    IF @@ROWCOUNT = 0
    BEGIN
        SELECT 0 AS KetQua; -- Không tìm thấy, trả về 0
    END
    ELSE
    BEGIN
        SELECT 1 AS KetQua; -- Cập nhật thành công, trả về 1
    END
END
GO

/*5. Tham số đưa vào MSSV, TENSV mới, DIACHI mới. Hãy cập nhật sinh
viên trên với MSSV không đổi, nếu không tìm thấy trả về 0, ngược lại cập nhật
và trả về 1.*/

CREATE PROCEDURE sp_A5_UpdateSinhVien
    @MSSV char(8),
    @TENSV_moi nvarchar(30),
    @DIACHI_moi nchar(50)
AS
BEGIN
    -- Cập nhật TENSV và DIACHI
    UPDATE SINHVIEN
    SET
        TENSV = @TENSV_moi,
        DIACHI = @DIACHI_moi
    WHERE MSSV = @MSSV;

    -- Kiểm tra số dòng bị ảnh hưởng
    IF @@ROWCOUNT = 0
    BEGIN
        SELECT 0 AS KetQua; -- Không tìm thấy, trả về 0
    END
    ELSE
    BEGIN
        SELECT 1 AS KetQua; -- Cập nhật thành công, trả về 1
    END
END
GO


--B. STORED PROCEDURES VỚI THAM SỐ VÀO VÀ RA

/*1. Đưa vào TENHV trả ra: Số GV thỏa học vị, nếu không tìm thấy trả về 0.*/

CREATE PROCEDURE sp_B1_CountGvByHocVi
    @TENHV nvarchar(20),
    @SoGV int OUTPUT
AS
BEGIN
    -- Đếm số lượng giáo viên có học vị tương ứng
    SELECT @SoGV = COUNT(T1.MSGV)
    FROM GV_HV_CN AS T1
    INNER JOIN HOCVI AS T2 ON T1.MSHV = T2.MSHV
    WHERE T2.TENHV = @TENHV;
    
    -- Nếu không tìm thấy, COUNT sẽ là 0 (đáp ứng yêu cầu trả về 0 nếu không tìm thấy) 
END
GO

/*2. Đưa vào MSDT cho biết: Điểm trung bình của đề tài, nếu không tìm thấy trả
về 0.*/

CREATE PROCEDURE sp_B2_GetDiemTBDeTai
    @MSDT char(6),
    @DiemTB float OUTPUT
AS
BEGIN
    -- Gộp điểm từ 3 bảng điểm (HDDT, PBDT, UVDT)
    SELECT @DiemTB = AVG(DIEM)
    FROM (
        SELECT DIEM FROM GV_HDDT WHERE MSDT = @MSDT
        UNION ALL
        SELECT DIEM FROM GV_PBDT WHERE MSDT = @MSDT
        UNION ALL
        SELECT DIEM FROM GV_UVDT WHERE MSDT = @MSDT
    ) AS CombinedScores;

    -- Xử lý trường hợp không tìm thấy đề tài hoặc chưa có điểm
    IF @DiemTB IS NULL
    BEGIN
        SET @DiemTB = 0; -- Trả về 0 nếu không tìm thấy 
    END
END
GO

/*3. Đưa vào TENGV trả ra: SDT của giáo viên đó, nếu không tìm thấy trả về 0.
Nếu trùng tên thì có báo lỗi không? Tại sao? Làm sao để hiện thông báo có bao
nhiêu giáo viên trùng tên và trả về các SDT.*/

CREATE PROCEDURE sp_B3_GetSdtByTenGv
    @TENGV nvarchar(30),
    @SoLuongGv int OUTPUT
AS
BEGIN
    -- 1. Đếm số lượng giáo viên trùng tên
    SELECT @SoLuongGv = COUNT(MSGV)
    FROM GIAOVIEN
    WHERE TENGV = @TENGV;

    -- 2. Xử lý và hiển thị kết quả
    IF @SoLuongGv = 0
    BEGIN
        PRINT N'Không tìm thấy giáo viên nào có tên: ' + @TENGV + '. Trả về 0.';
        -- Trả về 0 nếu không tìm thấy (giá trị mặc định của @SoLuongGv có thể là 0) [cite: 94]
    END
    ELSE IF @SoLuongGv > 1
    BEGIN
        PRINT N'CẢNH BÁO: Tên giáo viên bị trùng (' + CAST(@SoLuongGv AS nvarchar) + N' người).'; -- [cite: 95]
        PRINT N'Hệ thống sẽ liệt kê tất cả số điện thoại tương ứng:';
        
        -- Hiển thị các SDT của những người trùng tên [cite: 95]
        SELECT TENGV, SODT
        FROM GIAOVIEN
        WHERE TENGV = @TENGV;
    END
    ELSE
    BEGIN
        -- Chỉ tìm thấy 1 người
        PRINT N'Tìm thấy 1 giáo viên.';
        SELECT SODT
        FROM GIAOVIEN
        WHERE TENGV = @TENGV;
    END
    
    -- *Trả lời câu hỏi*
    -- **Nếu trùng tên thì có báo lỗi không?**: Không, vì TENGV không phải là khóa chính[cite: 94].
    -- **Tại sao?**: Vì dữ liệu cho phép nhiều giáo viên có cùng tên, SQL chỉ trả về các bản ghi phù hợp.
    -- **Làm sao để hiện thông báo có bao nhiêu giáo viên trùng tên và trả về các SDT?**: Dùng biến OUTPUT @SoLuongGv để đếm và dùng lệnh PRINT kết hợp SELECT để hiển thị (đã triển khai). [cite: 95]
END
GO

/*4. Đưa vào MSHD cho biết: Điểm trung bình các đề tài của hội đồng đó.*/

CREATE PROCEDURE sp_B4_GetDiemTBHoiDong
    @MSHD int,
    @DiemTB float OUTPUT
AS
BEGIN
    DECLARE @TotalScore float;
    DECLARE @ScoreCount int;

    -- 1. Gộp điểm của tất cả đề tài thuộc hội đồng đó từ 3 bảng điểm (HDDT, PBDT, UVDT)
    SELECT
        @TotalScore = SUM(T3.DIEM),
        @ScoreCount = COUNT(T3.DIEM)
    FROM HOIDONG_DT AS T1 -- Bảng xác định đề tài thuộc hội đồng
    INNER JOIN DETAI AS T2 ON T1.MSDT = T2.MSDT
    INNER JOIN
    (
        -- Subquery gộp 3 bảng điểm
        SELECT MSDT, DIEM FROM GV_HDDT
        UNION ALL
        SELECT MSDT, DIEM FROM GV_PBDT
        UNION ALL
        SELECT MSDT, DIEM FROM GV_UVDT
    ) AS T3 ON T1.MSDT = T3.MSDT
    WHERE T1.MSHD = @MSHD;

    -- 2. Tính điểm trung bình và xử lý trường hợp không có điểm
    IF @ScoreCount IS NULL OR @ScoreCount = 0
    BEGIN
        SET @DiemTB = 0; -- Trả về 0 nếu không tìm thấy đề tài/điểm
    END
    ELSE
    BEGIN
        SET @DiemTB = @TotalScore / @ScoreCount;
    END
END
GO

/*5. Đưa vào TENGV cho biết: Số đề tài hướng dẫn, số đề tài phản biện do giáo
viên đó phụ trách. Nếu trùng tên thì có báo lỗi không hay hệ thống sẽ đếm tất
cả các đề tài của những giáo viên trùng tên đó?*/

CREATE PROCEDURE sp_B5_CountDeTaiByTenGv
    @TENGV nvarchar(30),
    @SoDT_HuongDan int OUTPUT,
    @SoDT_PhanBien int OUTPUT
AS
BEGIN
    -- Khởi tạo giá trị
    SET @SoDT_HuongDan = 0;
    SET @SoDT_PhanBien = 0;

    -- Lấy danh sách MSGV của tất cả giáo viên có tên trùng
    SELECT MSGV
    INTO #GiaoVienList
    FROM GIAOVIEN
    WHERE TENGV = @TENGV;

    -- Đếm số lượng GV trùng tên để trả lời câu hỏi [cite: 98]
    DECLARE @SoLuongGv int = (SELECT COUNT(*) FROM #GiaoVienList);

    IF @SoLuongGv = 0
    BEGIN
        PRINT N'Không tìm thấy giáo viên nào có tên: ' + @TENGV;
        DROP TABLE #GiaoVienList;
        RETURN;
    END

    -- 1. Đếm số đề tài Hướng dẫn
    SELECT @SoDT_HuongDan = COUNT(MSDT)
    FROM GV_HDDT
    WHERE MSGV IN (SELECT MSGV FROM #GiaoVienList);

    -- 2. Đếm số đề tài Phản biện
    SELECT @SoDT_PhanBien = COUNT(MSDT)
    FROM GV_PBDT
    WHERE MSGV IN (SELECT MSGV FROM #GiaoVienList);

    DROP TABLE #GiaoVienList;

    -- Trả lời câu hỏi
    IF @SoLuongGv > 1
    BEGIN
        PRINT N'CẢNH BÁO: Tên giáo viên bị trùng. Hệ thống đã đếm tổng số đề tài của TẤT CẢ các giáo viên có tên là: ' + @TENGV; -- [cite: 98]
    END
END
GO


----C. TRIGGER
--Trigger là một dạng chương trình con tự động "kích hoạt" khi có các hành động INSERT, UPDATE hoặc DELETE.
--Bật Trigger	         ENABLE TRIGGER trigger_name ON table_name;
--Tắt tạm thời	         DISABLE TRIGGER trigger_name ON table_name;
--Xóa bỏ	             DROP TRIGGER trigger_name;
--Xem code của trigger	 sp_helptext 'trigger_name';

-- Bai1: Tạo Trigger thỏa mãn điều kiện khi xóa một đề tài sẽ xóa các thông tin liên
--quan.(Trigger này đảm bảo một đề tài không được quá 4 sinh viên thực hiện).


CREATE TRIGGER trg_C1_CheckSoLuongSVDeTai
-- Gắn trigger này vào bảng SV_DETAI (bảng trung gian giữa Sinh viên và Đề tài).
ON SV_DETAI
-- Trigger sẽ tự động chạy sau khi bạn thực hiện lệnh thêm mới (Insert) hoặc cập nhật (Update) dữ liệu vào bảng này.
AFTER INSERT, UPDATE
AS
BEGIN
    -- Khai báo hai biến để chứa mã đề tài và số lượng sinh viên.
    DECLARE @MSDT char(6);
    DECLARE @SoLuongSV int;

    -- Lấy mã đề tài vừa được thao tác từ bảng inserted (đây là bảng tạm chứa dữ liệu bạn vừa nhập vào).
    SELECT @MSDT = MSDT FROM inserted;

    -- Đếm tổng số sinh viên hiện có của đề tài đó trong bảng chính.
    SELECT @SoLuongSV = COUNT(MSSV)
    FROM SV_DETAI
    WHERE MSDT = @MSDT;

    -- Nếu vượt quá 4 người, thực hiện báo lỗi RAISERROR và ROLLBACK TRANSACTION (hủy bỏ lệnh vừa nhập).
    IF @SoLuongSV > 4
    BEGIN
        -- Báo lỗi và hủy bỏ thao tác (ROLLBACK)
        RAISERROR(N'LỖI: Một đề tài không được phép có quá 4 sinh viên thực hiện.', 16, 1);
		-- Hủy bỏ toàn bộ thao tác. Dữ liệu sẽ không được lưu vào database.
        ROLLBACK TRANSACTION;
        RETURN;
    END
END
GO
/*	-- Cách hoạt động và ví dụ:
	Cách hoạt động: Khi bạn viết lệnh INSERT để thêm sinh viên vào đề tài, SQL Server sẽ tạm thời giữ thay đổi đó, rồi gọi trigger này. 
	Trigger kiểm tra "Nếu thêm bạn này vào thì tổng cộng có quá 4 người không?". Nếu quá, nó "rollback" (thu hồi) lệnh Insert đó như 
	chưa từng xảy ra.

	Ví dụ: Đề tài 97005 (Xử lý ảnh) hiện đã có 2 sinh viên là Ưng Hồng Ân và Phan Tấn Đạt.

		   Nếu bạn thêm tiếp 2 sinh viên nữa -> Thành công (tổng = 4).

	 	   Nếu bạn cố gắng thêm sinh viên thứ 5 vào mã đề tài 97005 -> Trigger sẽ báo lỗi và ngăn chặn lệnh thêm này.            */

-- Bai2: Tạo Trigger thỏa mãn ràng buộc là khi đổi 1 mã số giáo viên (MSGV) thì sẽ thay đổi các thông tin liên quan.(Trigger này kiểm 
--tra xem MSGV, MSHV, MSCN khi nhập vào bảng GV_HV_CN có thực sự tồn tại trong các bảng danh mục tương ứng không).

CREATE TRIGGER trg_C2_CheckGVHVCN
ON GV_HV_CN
AFTER INSERT, UPDATE
AS
BEGIN
    -- Biến cờ kiểm tra lỗi
    DECLARE @HasError int = 0;

    -- 1. Kiểm tra: "Có dòng nào vừa nhập mà mã giáo viên lại KHÔNG nằm trong bảng GIAOVIEN không?".
    IF EXISTS (
        SELECT *
        FROM inserted AS i
        WHERE NOT EXISTS (SELECT 1 FROM GIAOVIEN WHERE MSGV = i.MSGV)
    )
    BEGIN
        RAISERROR(N'LỖI: Mã số giáo viên (MSGV) không tồn tại trong bảng GIAOVIEN.', 16, 1);
		-- Nếu phát hiện lỗi (mã không tồn tại), biến cờ hiệu HasError sẽ bật lên.
        SET @HasError = 1;
    END

    -- 2. Kiểm tra: "Có dòng nào vừa nhập mà mã giáo viên lại KHÔNG nằm trong bảng HOCVI không?".
    IF EXISTS (
        SELECT *
        FROM inserted AS i
        WHERE NOT EXISTS (SELECT 1 FROM HOCVI WHERE MSHV = i.MSHV)
    )
    BEGIN
        RAISERROR(N'LỖI: Mã số học vị (MSHV) không tồn tại trong bảng HOCVI.', 16, 1);
		-- Nếu phát hiện lỗi (mã không tồn tại), biến cờ hiệu HasError sẽ bật lên.
        SET @HasError = 1;
    END

    -- 3. Kiểm tra: "Có dòng nào vừa nhập mà mã giáo viên lại KHÔNG nằm trong bảng CHUYENNGANH không?".
    IF EXISTS (
        SELECT *
        FROM inserted AS i
        WHERE NOT EXISTS (SELECT 1 FROM CHUYENNGANH WHERE MSCN = i.MSCN)
    )
    BEGIN
        RAISERROR(N'LỖI: Mã số chuyên ngành (MSCN) không tồn tại trong bảng CHUYENNGANH.', 16, 1);
		-- Nếu phát hiện lỗi (mã không tồn tại), biến cờ hiệu HasError sẽ bật lên.
        SET @HasError = 1;
    END

    -- Nếu HasError = 1, xóa sạch hành động vừa làm.
    IF @HasError = 1
    BEGIN
		-- Hủy bỏ toàn bộ thao tác. Dữ liệu sẽ không được lưu vào database.
        ROLLBACK TRANSACTION;
    END
END
GO

/*	-- Cách hoạt động và ví dụ:
		Cách hoạt động: Nó hoạt động như một "người gác cổng" thủ công để đảm bảo dữ liệu đồng bộ, tránh việc một giáo viên có học vị 
		"không tồn tại"(không có trong danh mục).

		Ví dụ: Bạn muốn nhập thông tin: Giáo viên có mã 00201 đạt học vị mã 99 vào năm 2024.

			   Trigger kiểm tra bảng HOCVI. Trong file của bạn, bảng HOCVI chỉ có mã từ 1 đến 5.

			   Mã 99 không tồn tại -> Trigger chặn lại và báo lỗi: "Mã số học vị không tồn tại".           */

-- Bai3: Tạo Trigger thỏa mãn ràng buộc là một hội đồng không quá 10 đề tài. Dùng “Group by” có được không? Giải thích.(Trigger này 
--đảm bảo tính khách quan: Một giáo viên không thể vừa là thành viên bình thường vừa là Chủ tịch của cùng một hội đồng).

CREATE TRIGGER trg_Bai3_CheckSoLuongDeTaiHD
ON HOIDONG_DT
-- Kích hoạt ngay sau khi có hành động thêm đề tài mới vào hội đồng hoặc chuyển đề tài từ hội đồng này sang hội đồng khác.
AFTER INSERT, UPDATE
AS
BEGIN
    -- Kiểm tra xem có hội đồng nào sau khi thêm/sửa mà vượt quá 10 đề tài không
    IF EXISTS (
        SELECT 1
        FROM HOIDONG_DT
        WHERE MSHD IN (SELECT MSHD FROM inserted)
		-- Nhóm các dòng dữ liệu lại theo từng mã hội đồng để bắt đầu đếm.
        GROUP BY MSHD
		-- Điều kiện lọc sau khi nhóm. Nếu số lượng đề tài của bất kỳ hội đồng nào lớn hơn 10, điều kiện này sẽ đúng.
        HAVING COUNT(MSDT) > 10
    )
    BEGIN
        RAISERROR(N'LỖI: Một hội đồng không được phép chấm quá 10 đề tài.', 16, 1);
		-- Nếu phát hiện vi phạm (số lượng > 10), lệnh này sẽ "nhấn nút hủy", mọi thay đổi dữ liệu sẽ không được lưu vào cơ sở dữ liệu.
        ROLLBACK TRANSACTION;
    END
END
GO

/*	-- Dùng “Group by” có được không? Giải thích:
		Trả lời: ĐƯỢC và RẤT NÊN DÙNG.

		Giải thích:

		Tại sao dùng được: GROUP BY là công cụ mạnh mẽ nhất trong SQL để phân nhóm dữ liệu. Khi cần kiểm tra giới hạn số lượng (như số sinh viên, số 
		đề tài, số tiết dạy), chúng ta bắt buộc phải gom các bản ghi có cùng mã định danh (ở đây là MSHD) lại để đếm tổng số thông qua hàm COUNT().

		Tại sao nên dùng:  Nếu không dùng GROUP BY, bạn sẽ phải dùng các biến đơn lẻ và vòng lặp (Cursor), điều này làm chậm hệ thống và code phức tạp 
		hơn nhiều. GROUP BY kết hợp với HAVING giúp SQL Server thực hiện kiểm tra song song nhiều hội đồng cùng lúc một cách hiệu quả.
	
	-- Cách hoạt động và ví dụ:
		Cách hoạt động: Khi bạn thêm một giáo viên vào một hội đồng, trigger sẽ nhìn sang bảng HOIDONG để xem ai là "sếp" (Chủ tịch) của hội 
		đồng đó. Nếu trùng tên/mã, lệnh thêm bị hủy.

		Ví dụ: Hội đồng 1 có Chủ tịch là Trần Trung (MSGV: 00201).

			   Nếu bạn thực hiện lệnh: INSERT INTO HOIDONG_GV VALUES (1, 00201); (Thêm ông Trung làm thành viên HĐ 1).

			   Trigger thấy 00201 đã là Chủ tịch HĐ 1 rồi -> Báo lỗi.              */

-- Bai4: Tạo Trigger thỏa mãn ràng buộc là một đề tài không quá 2 sinh viên. Dùng “Group by” có được không? Giải thích.(Một giáo viên đã hướng dẫn 
--đề tài thì không được phép làm giáo viên phản biện (chấm điểm độc lập) cho chính đề tài đó).

CREATE TRIGGER trg_Bai4_CheckSoLuongSV
ON SV_DETAI
-- Tự kích hoạt ngay sau khi bạn thêm mới hoặc sửa dữ liệu sinh viên/đề tài.
AFTER INSERT, UPDATE
AS
BEGIN
    -- Kiểm tra nếu có bất kỳ đề tài nào vừa được cập nhật mà vượt quá 2 sinh viên
    IF EXISTS (
        SELECT 1
        FROM SV_DETAI
        WHERE MSDT IN (SELECT MSDT FROM inserted)
		-- Gom tất cả sinh viên có cùng mã đề tài lại thành từng nhóm.
        GROUP BY MSDT
		-- Đếm số lượng sinh viên trong mỗi nhóm, nếu nhóm nào có trên 2 người thì xác nhận là lỗi.
        HAVING COUNT(MSSV) > 2
    )
    BEGIN
		-- Phát ra thông báo lỗi hiển thị lên màn hình người dùng.
        RAISERROR(N'LỖI: Mỗi đề tài không được phép có quá 2 sinh viên thực hiện.', 16, 1);
		-- -- Nếu phát hiện vi phạm (số lượng > 2), lệnh này sẽ "nhấn nút hủy", mọi thay đổi dữ liệu sẽ không được lưu vào cơ sở dữ liệu.
        ROLLBACK TRANSACTION;
    END
END
GO
/*	-- Dùng “Group by” có được không? Giải thích:
		Trả lời: ĐƯỢC và RẤT NÊN DÙNG.

		Giải thích:

		Tính chính xác: Khi dùng GROUP BY, SQL Server sẽ gom tất cả các bản ghi có cùng MSDT lại một chỗ rồi mới đếm. Điều này đảm bảo chúng ta tính 
		toán chính xác tổng số sinh viên hiện có của đề tài đó sau khi đã cộng thêm sinh viên mới.

		Xử lý đồng thời: GROUP BY cho phép trigger xử lý được trường hợp bạn thêm nhiều sinh viên cùng lúc (ví dụ dùng lệnh INSERT INTO... SELECT...). 
		Nếu dùng biến đơn lẻ mà không dùng GROUP BY, trigger có thể bị sót lỗi nếu nhập liệu hàng loạt.

		Thay thế: Nếu không dùng GROUP BY, bạn phải dùng các câu truy vấn lồng nhau (Subquery) phức tạp hoặc vòng lặp (Cursor), điều này làm code khó 
		đọc và hiệu suất kém hơn nhiều.
	-- Cách hoạt động và ví dụ:
		Cách hoạt động: Trigger này ngăn chặn xung đột lợi ích. Nó quét bảng Hướng dẫn, nếu thấy giáo viên này đã "nhúng tay" vào hướng dẫn đề tài này rồi thì không 
		cho phép họ vào danh sách Phản biện nữa.

		Ví dụ: Giáo viên Trần Trung (00201) đang hướng dẫn đề tài 97001 (Quản lý thư viện).

			   Nếu bạn nhập: INSERT INTO GV_PBDT (MSGV, MSDT, DIEM) VALUES (00201, '97001', 8);

			   Trigger sẽ báo lỗi: "Giáo viên phản biện không được là Giáo viên hướng dẫn cho cùng một đề tài".            */

-- Bai5: Tạo Trigger thỏa mãn ràng buộc là một giáo viên muốn có học hàm PGS phải là tiến sĩ.(Đảm bảo năm ghi nhận học hàm không phải là một năm trong tương lai).

CREATE TRIGGER trg_C5_CheckNamHocHam
ON GIAOVIEN
-- Trigger sẽ tự động chạy sau khi bạn thực hiện lệnh thêm mới (Insert) hoặc cập nhật (Update) dữ liệu vào bảng này.
AFTER INSERT, UPDATE
AS
BEGIN
    -- Lấy năm hiện tại từ hệ thống máy tính.
    DECLARE @NamHienTai int = YEAR(GETDATE());

    -- Kiểm tra nếu năm bạn vừa nhập vào (i.NAMHH) lớn hơn năm hiện tại.
    IF EXISTS (
        SELECT 1
        FROM inserted AS i
        WHERE YEAR(i.NAMHH) > @NamHienTai
    )
    BEGIN
		-- Phát ra thông báo lỗi hiển thị lên màn hình người dùng.
        RAISERROR(N'LỖI: Năm nhận học hàm (NAMHH) không được lớn hơn năm hiện tại.', 16, 1);
		-- Hủy bỏ toàn bộ thao tác. Dữ liệu sẽ không được lưu vào database.
        ROLLBACK TRANSACTION;
        RETURN;
    END
END
GO

/*	-- Cách hoạt động và ví dụ:
		Cách hoạt động: Đây là một dạng kiểm tra logic thời gian đơn giản để tránh sai sót khi nhập liệu.

		Ví dụ: Hôm nay là năm 2025. Bạn nhập thông tin giáo viên Nguyễn Văn An nhận học hàm Giáo sư vào năm 2030.
		 
			   Trigger so sánh: 2030 > 2025 -> Đúng.

			   Trigger báo lỗi và không cho lưu. */

--D. FUNCTION

/*1. Viết hàm tính điểm trung bình của một đề tài. Giá trị trả về là điểm trung
bình ứng với mã số đề tài nhập vào.*/

CREATE FUNCTION fn_D1_TinhDiemTBDeTai (@MSDT char(6))
RETURNS float
AS
BEGIN
    DECLARE @DiemTB float;

    -- Gộp điểm từ 3 bảng điểm (HDDT, PBDT, UVDT)
    SELECT @DiemTB = AVG(DIEM)
    FROM (
        SELECT DIEM FROM GV_HDDT WHERE MSDT = @MSDT
        UNION ALL
        SELECT DIEM FROM GV_PBDT WHERE MSDT = @MSDT
        UNION ALL
        SELECT DIEM FROM GV_UVDT WHERE MSDT = @MSDT
    ) AS CombinedScores;

    -- Trả về 0 nếu không có điểm hoặc đề tài không tồn tại
    RETURN ISNULL(@DiemTB, 0);
END
GO
/*Cách sử dụng (Ví dụ):
SELECT dbo.fn_D1_TinhDiemTBDeTai('97001') AS DiemTrungBinh;*/

/*2. Trả về kết quả của đề tài theo MSDT nhập vào. Kết quả là DAT nếu như
điểm trung bình từ 5 trở lên, và KHONGDAT nếu như điểm trung bình dưới 5.*/

CREATE FUNCTION fn_D2_KetQuaDeTai (@MSDT char(6))
RETURNS nchar(10)
AS
BEGIN
    DECLARE @DiemTB float;
    
    -- Gọi lại hàm D1 để lấy điểm trung bình
    SET @DiemTB = dbo.fn_D1_TinhDiemTBDeTai(@MSDT);

    -- Đánh giá kết quả
    IF @DiemTB >= 5
        RETURN N'ĐẠT';
    ELSE
        RETURN N'KHÔNG ĐẠT';
    
    RETURN N'KHÔNG ĐÁNH GIÁ'; -- Trường hợp hiếm (điểm TB = 0 do lỗi)
END
GO
/*Cách sử dụng (Ví dụ):
SELECT dbo.fn_D2_KetQuaDeTai('97005') AS KetQua;*/

/*3. Đưa vào MSDT, trả về mã số và họ tên của các sinh viên thực hiện đề tài.*/
CREATE FUNCTION fn_D3_GetSvByDeTai (@MSDT char(6))
RETURNS TABLE
AS
RETURN
(
    SELECT T1.MSSV, T1.TENSV
    FROM SINHVIEN AS T1
    INNER JOIN SV_DETAI AS T2 ON T1.MSSV = T2.MSSV
    WHERE T2.MSDT = @MSDT
);
GO
/*Cách sử dụng (Ví dụ):
SELECT * FROM dbo.fn_D3_GetSvByDeTai('97005');*/


--E. CURSOR
/*Tạo một bảng tên là DETAI_DIEM. Cấu trúc bảng như sau:
DETAI_DIEM(MSDT, DIEMTB).*/

CREATE TABLE DETAI_DIEM (
    MSDT char(6) PRIMARY KEY,
    DIEMTB float
    -- Cột XEPLOAI sẽ được thêm ở câu 3
);
GO

/*1. Viết Cursor tính điểm trung bình cho từng đề tài. Sau đó lưu kết quả vào
bảng DETAI_DIEM.*/

-- Nếu bảng DETAI_DIEM đã có dữ liệu, xóa sạch để chạy lại
TRUNCATE TABLE DETAI_DIEM;

DECLARE @MSDT_Current char(6);
DECLARE @DiemTB_Current float;

-- Khai báo Cursor
DECLARE DeTaiCursor CURSOR FOR
SELECT MSDT FROM DETAI;

OPEN DeTaiCursor;

-- Lấy dòng đầu tiên
FETCH NEXT FROM DeTaiCursor INTO @MSDT_Current;

-- Bắt đầu lặp
WHILE @@FETCH_STATUS = 0
BEGIN
    -- 1. Tính điểm trung bình bằng cách gọi Function đã tạo ở mục D1
    SET @DiemTB_Current = dbo.fn_D1_TinhDiemTBDeTai(@MSDT_Current);

    -- 2. Lưu kết quả vào bảng DETAI_DIEM
    INSERT INTO DETAI_DIEM (MSDT, DIEMTB)
    VALUES (@MSDT_Current, @DiemTB_Current);

    -- Lấy dòng tiếp theo
    FETCH NEXT FROM DeTaiCursor INTO @MSDT_Current;
END

-- Đóng và giải phóng Cursor
CLOSE DeTaiCursor;
DEALLOCATE DeTaiCursor;

-- Hiển thị kết quả (Kiểm tra)
SELECT * FROM DETAI_DIEM;
GO

/*2. Gom các bước xử lý của Cursor ở câu 1 vào một Stored Procedure.*/

CREATE PROCEDURE sp_E2_CalculateAllDeTaiDiem
AS
BEGIN
    -- Đảm bảo bảng DETAI_DIEM trống trước khi chạy
    TRUNCATE TABLE DETAI_DIEM;

    DECLARE @MSDT_Current char(6);
    DECLARE @DiemTB_Current float;

    DECLARE DeTaiCursor CURSOR FOR
    SELECT MSDT FROM DETAI;

    OPEN DeTaiCursor;
    FETCH NEXT FROM DeTaiCursor INTO @MSDT_Current;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Tính điểm trung bình
        SET @DiemTB_Current = dbo.fn_D1_TinhDiemTBDeTai(@MSDT_Current);

        -- Insert vào bảng DETAI_DIEM
        INSERT INTO DETAI_DIEM (MSDT, DIEMTB)
        VALUES (@MSDT_Current, @DiemTB_Current);

        FETCH NEXT FROM DeTaiCursor INTO @MSDT_Current;
    END

    CLOSE DeTaiCursor;
    DEALLOCATE DeTaiCursor;

    SELECT * FROM DETAI_DIEM; -- Hiển thị kết quả sau khi chạy SP
END
GO

/*3. Tạo thêm cột XEPLOAI có kiểu là NVARCCHAR(20) trong bảng
DETAI_DIEM, viết Cursor cập nhật kết quả xếp loại cho mỗi đề tài như sau:
Khoa Khoa học và Kỹ thuật Thông tin 10
+ "Xuất sắc": điểm trung bình từ 9 đến 10.
+ "Giỏi": điểm trung bình từ 8 đến 9.
+ "Khá": điểm trung bình từ 7 đến 8.
+ "Trung bình khá": điểm trung bình từ 6 đến 7.
+ "Trung bình": điểm trung bình từ 5 đến 6.
+ "Yếu": điểm trung bình từ 4 đến 5.
+ "Kém": điểm trung bình dưới 4.*/

-- Bước 1: Thêm cột XEPLOAI vào bảng DETAI_DIEM
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE Name = N'XEPLOAI' AND Object_ID = Object_ID(N'DETAI_DIEM'))
BEGIN
    ALTER TABLE DETAI_DIEM ADD XEPLOAI NVARCHAR(20);
END
GO

-- Bước 2: Viết Cursor cập nhật xếp loại
DECLARE @MSDT_Current char(6);
DECLARE @DiemTB_Current float;
DECLARE @XepLoai nvarchar(20);

-- Khai báo Cursor để duyệt qua bảng DETAI_DIEM
DECLARE XepLoaiCursor CURSOR FOR
SELECT MSDT, DIEMTB FROM DETAI_DIEM;

OPEN XepLoaiCursor;
FETCH NEXT FROM XepLoaiCursor INTO @MSDT_Current, @DiemTB_Current;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Logic xếp loại
    IF @DiemTB_Current >= 9 AND @DiemTB_Current <= 10
        SET @XepLoai = N'Xuất sắc';
    ELSE IF @DiemTB_Current >= 8
        SET @XepLoai = N'Giỏi';
    ELSE IF @DiemTB_Current >= 7
        SET @XepLoai = N'Khá';
    ELSE IF @DiemTB_Current >= 6
        SET @XepLoai = N'Trung bình khá';
    ELSE IF @DiemTB_Current >= 5
        SET @XepLoai = N'Trung bình';
    ELSE IF @DiemTB_Current >= 4
        SET @XepLoai = N'Yếu';
    ELSE
        SET @XepLoai = N'Kém';

    -- Cập nhật cột XEPLOAI
    UPDATE DETAI_DIEM
    SET XEPLOAI = @XepLoai
    WHERE MSDT = @MSDT_Current;

    FETCH NEXT FROM XepLoaiCursor INTO @MSDT_Current, @DiemTB_Current;
END

CLOSE XepLoaiCursor;
DEALLOCATE XepLoaiCursor;

-- Hiển thị kết quả (Kiểm tra)
SELECT * FROM DETAI_DIEM;
GO