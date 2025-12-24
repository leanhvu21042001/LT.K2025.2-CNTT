-- NHOM 2
-- IE103
-- BTTH2
-- Phần 2
-- B. STORED PROCEDURES với tham số VÀO và RA
-- NOTE: A Batch/Top-Down processing Script.

-- ================================================================
-- 2B.1
-- Đưa vào TENHV trả ra: Số GV thỏa học vị, nếu không tìm thấy trả về 0
-- ================================================================

-- Tạo Stored Procedure
CREATE OR ALTER PROCEDURE sp_CountGVTheoHocVi
    @TenHV NVARCHAR(20),
    @SOGV INT OUTPUT
AS
BEGIN
    SET @SOGV = 0;

    DECLARE @MSHV_HOCVI INT;
    SELECT @MSHV_HOCVI = MSHV
    FROM HOCVI
    WHERE TENHV = @TenHV;

    IF @MSHV_HOCVI IS NOT NULL
    BEGIN
        SELECT @SOGV = COUNT(DISTINCT MSGV)
        FROM GV_HV_CN
        WHERE MSHV = @MSHV_HOCVI;
    end;
end;
GO

-- Ví dụ 1: Học Vị Thạc Sĩ

DECLARE @KETQUA INT;
EXEC sp_CountGVTheoHocVi N'Thạc sĩ', @KETQUA output ;
SELECT N'Số GV Thạc sĩ: ' AS KetQua, @KETQUA AS SoLuong;
GO

-- Ví dụ 2: Học Vị không tồn tại GV thỏa mãn

DECLARE @KETQUA INT;
EXEC sp_CountGVTheoHocVi N'Tiến sĩ', @KETQUA output ;
SELECT N'Số GV Tiến sĩ: ' AS KetQua, @KETQUA AS SoLuong;
GO

-- ================================================================
-- 2B.2
-- Đưa vào MSDT cho biết: Điểm trung bình của đề tài, nếu không tìm thấy trả về 0
-- ================================================================

CREATE OR ALTER PROCEDURE SP_DiemTBDeTai
    @MSDT CHAR(6),
    @DIEMTRUNGBINH FLOAT OUTPUT
AS
BEGIN
    SET @DIEMTRUNGBINH = 0;

    SELECT @DIEMTRUNGBINH = AVG(DIEM)
    FROM (
        SELECT DIEM FROM GV_HDDT WHERE MSDT = @MSDT
        UNION ALL
        SELECT DIEM FROM GV_PBDT WHERE MSDT = @MSDT
        UNION ALL
        SELECT DIEM FROM GV_UVDT WHERE MSDT = @MSDT
    ) AS ALLDIEM;

    IF @DIEMTRUNGBINH IS NULL
    BEGIN
        SET @DIEMTRUNGBINH = 0;
    END
END
GO

-- Ví dụ 1: Đề tài 97001

DECLARE @KETQUA FLOAT;
EXEC SP_DiemTBDeTai '97001', @KETQUA output ;
SELECT 'Diem TB De Tai 97001 ' AS KETQUA, @KETQUA AS DiemTB;
GO

-- Ví dụ 2: Đề tài không có điểm 97007

DECLARE @KETQUA FLOAT;
EXEC sp_DiemTBDeTai '97007', @KETQUA OUTPUT;
SELECT 'Diem TB De Tai 97007 ' AS KetQua, @KETQUA AS DiemTB;
GO

-- ================================================================
-- 2B.3
-- Đưa vào TENGV trả ra: SDT của giáo viên đó, nếu không tìm thấy trả về 0.
-- Nếu trùng tên thì có báo lỗi không? Tại sao?
-- Làm sao để hiện thông báo có bao nhiêu giáo viên trùng tên và trả về các SDT?
-- ================================================================

CREATE OR ALTER PROCEDURE sp_TimGVTheoTen @TENGV NVARCHAR(30),
                                 @SOLUONGGV INT OUTPUT,
                                 @DS_SDT VARCHAR(100) OUTPUT
AS
BEGIN
    SET @DS_SDT = '';
    -- DEM SO LUONG GIAO VIEN TRUNG TEN
    SELECT @SOLUONGGV = COUNT(MSGV)
    FROM GIAOVIEN
    WHERE TENGV = @TENGV;
end
    -- KIEM TRA SO LUONG GIAO VIEN VA TRA VE THONG TIN TUONG UNG
    IF @SOLUONGGV > 0
        BEGIN
            SELECT @DS_SDT = STRING_AGG(SODT, ', ')
            FROM GIAOVIEN
            WHERE TENGV = @TENGV;
        end
    ELSE
        BEGIN
            SET @SOLUONGGV = 0;
            SET @DS_SDT = '';
        end;
GO

-- Ví dụ 1: Trường hợp trùng tên (Nguyễn Văn An)

DECLARE @SoLuong INT, @DS_SDT NVARCHAR(100);
EXEC sp_TimGVTheoTen N'Nguyễn Văn An', @SoLuong OUTPUT, @DS_SDT OUTPUT;
SELECT N'Tong so giao vien trung ten: ' AS ThongBao, @SoLuong AS SoLuong, @DS_SDT AS 'Danh sach so dien thoai';
GO

-- Ví dụ 2: Trường hợp không trùng tên (Trần Trung)

DECLARE @SoLuong INT, @DS_SDT NVARCHAR(100);
EXEC sp_TimGVTheoTen N'Trần Trung', @SoLuong OUTPUT, @DS_SDT OUTPUT;
SELECT N'Tong so giao vien trung ten: ' AS ThongBao, @SoLuong AS SoLuong, @DS_SDT AS 'Danh sach so dien thoai';
GO

-- Ví dụ 3: Trường hợp không tìm thấy (Lê Kim Long)

DECLARE @SoLuong INT, @DS_SDT NVARCHAR(100);
EXEC sp_TimGVTheoTen N'Lê Kim Long', @SoLuong OUTPUT, @DS_SDT OUTPUT;
SELECT N'Tong so giao vien trung ten: ' AS ThongBao, @SoLuong AS SoLuong, @DS_SDT AS 'Danh sach so dien thoai';
GO

-- ================================================================
-- 2B.4
-- Đưa vào MSHD cho biết: Điểm trung bình các đề tài của hội đồng đó
-- ================================================================

CREATE OR ALTER PROCEDURE sp_DiemTBTheoHD @MSHD INT,
                                 @DIEM_TB FLOAT OUTPUT
AS
BEGIN
    SET @DIEM_TB = 0;
    SELECT @DIEM_TB = AVG(T2.DIEM) FROM HOIDONG_DT T1
    JOIN (
        SELECT MSDT, DIEM FROM GV_HDDT
        UNION ALL
        SELECT MSDT, DIEM FROM GV_PBDT
        UNION ALL
        SELECT MSDT, DIEM FROM GV_UVDT
    ) AS T2 ON T1.MSDT = T2.MSDT
    WHERE T1.MSHD = @MSHD
    GROUP BY T1.MSDT;
end
go

-- Ví dụ: Hội đồng 1

DECLARE @MSHD INT = 1, @DiemTB FLOAT;
EXEC sp_DiemTBTheoHD @MSHD, @DiemTB output;
SELECT @MSHD as 'Ma So Hoi Dong', @DiemTB as 'Diem Trung Binh'
GO

-- Ví dụ: Hội đồng 2

DECLARE @MSHD INT = 2, @DiemTB FLOAT;
EXEC sp_DiemTBTheoHD @MSHD, @DiemTB output;
SELECT @MSHD as 'Ma So Hoi Dong', @DiemTB as 'Diem Trung Binh'
GO

-- ================================================================
-- 2B.5
-- Đưa vào TENGV cho biết:
-- Số đề tài hướng dẫn, số đề tài phản biện do giáo viên đó phụ trách.
-- Nếu trùng tên thì có báo lỗi không?
-- Hay hệ thống sẽ đếm tất cả các đề tài của những giáo viên trùng tên đó?
-- ================================================================

CREATE OR ALTER PROCEDURE sp_ThongTinDeTaiGV @TENGV NVARCHAR(30),
                                    @SoDT_HD INT OUTPUT,
                                    @SoDT_PB INT OUTPUT
AS
BEGIN
SET @SoDT_HD = 0;
SET @SoDT_PB = 0;

DECLARE @SoLuong_GV_TrungTen INT;
SET @SoLuong_GV_TrungTen = 0;

-- Kiểm tra danh sách giáo viên xem có trùng tên không
SELECT @SoLuong_GV_TrungTen = Count(MSGV) FROM GIAOVIEN WHERE TENGV = @TENGV

-- Nếu là 1: không trùng tên.
-- Nếu là 2 trở lên: trùng tên -> Lỗi
-- Nếu là 0: không tồn tại giáo viên có tên này
IF @SoLuong_GV_TrungTen = 1
    BEGIN
        -- Lấy MSGV từ khi chỉ có 1 record duy nhất
        DECLARE  @MSGV INT;
        SELECT @MSGV = MSGV FROM GIAOVIEN WHERE TENGV = @TENGV

        -- Đếm số lượng đề tài hướng dẫn và phản biện
        SELECT @SoDT_HD = Count(MSDT) FROM GV_HDDT WHERE MSGV = @MSGV
        SELECT @SoDT_PB = COUNT(MSDT) FROM GV_PBDT WHERE MSGV = @MSGV
    end
ELSE IF @SoLuong_GV_TrungTen >= 2
    BEGIN
        THROW 51000, N'Trùng tên giáo viên', 2;
    end
ELSE
    BEGIN
        THROW 51000, N'Không tìm thấy giáo viên', 1;
    end
end
GO

-- Dữ liệu đang có

SELECT TOP (100) [MSGV]
,[TENGV]
,[DIACHI]
,[SODT]
,[MSHH]
-- ,[NAMHH]
FROM [IE103-BTTH2].[dbo].[GIAOVIEN]
GO

SELECT * FROM GV_HDDT;
GO

SELECT * FROM GV_PBDT;
GO

-- Ví dụ 1: không tìm thấy giáo viên (Lê Kim Long)

DECLARE @SoDT_HD INT, @SoDT_PB INT
EXEC sp_ThongTinDeTaiGV N'Lê Kim Long', @SoDT_HD OUTPUT ,@SoDT_PB OUTPUT ;
SELECT
    @SoDT_HD AS N'Số lượng đề tài hướng dẫn',
    @SoDT_PB AS N'Số lượng đề tài phản biện';
GO

-- Ví dụ 2: trùng tên giáo viên (Nguyễn Văn An)

DECLARE @SoDT_HD INT, @SoDT_PB INT
EXEC sp_ThongTinDeTaiGV N'Nguyễn Văn An', @SoDT_HD OUTPUT ,@SoDT_PB OUTPUT ;
SELECT
    @SoDT_HD AS N'Số lượng đề tài hướng dẫn',
    @SoDT_PB AS N'Số lượng đề tài phản biện';
GO

-- Ví dụ 3: tên giáo viên hợp lệ (Trần Trung)

DECLARE @SoDT_HD INT, @SoDT_PB INT
EXEC sp_ThongTinDeTaiGV N'Trần Trung', @SoDT_HD OUTPUT ,@SoDT_PB OUTPUT ;
SELECT
    N'**Số lượng**' AS N'**Loại**',
    @SoDT_HD AS N'Đề tài hướng dẫn',
    @SoDT_PB AS N'Đề tài phản biện';
GO

-- ================================================================
-- THE END
-- ================================================================
