-- NHÓM 2
-- MÔN: IE103 - Quản Lý Thông Tin
-- BTTH2
-- PHẦN 2
-- E: CURSOR
-- NOTE: A Batch/Top-Down processing Script.

-- ================================================================
-- 2E. 0. Tạo table detai_diem
-- ================================================================

DROP TABLE IF EXISTS DETAI_DIEM;
GO

CREATE TABLE DETAI_DIEM (
    MSDT char(6) PRIMARY KEY,
    DIEMTB FLOAT,
    CONSTRAINT FK_DETAI_DIEM_DETAI FOREIGN KEY (MSDT) REFERENCES DETAI(MSDT)
);
GO

-- ================================================================
-- 2E. 1.
-- Viết Cursor tính điểm trung bình cho từng đề tài.
-- Sau đó lưu kết quả vào bảng DETAI_DIEM.
-- ================================================================

-- Khai báo biến
DECLARE @MSDT CHAR(6);
DECLARE @DIEMTB FLOAT;

-- Xóa dữ liệu cũ trong bảng kết quả (nếu có)
DELETE FROM DETAI_DIEM;

-- Khai báo Cursor
DECLARE CUR_TINH_DIEM CURSOR FOR
SELECT MSDT
FROM DETAI;

-- Mở Cursor
OPEN CUR_TINH_DIEM;

-- Lấy dòng đầu tiên
FETCH NEXT FROM CUR_TINH_DIEM INTO @MSDT;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Tính điểm trung bình cho đề tài
    SELECT @DIEMTB = ROUND(AVG(DIEM), 2)
    FROM (
        SELECT DIEM FROM GV_HDDT WHERE MSDT = @MSDT
        UNION ALL
        SELECT DIEM FROM GV_PBDT WHERE MSDT = @MSDT
        UNION ALL
        SELECT DIEM FROM GV_UVDT WHERE MSDT = @MSDT
    ) AS T;

    -- Luu kết quả vào DETAI_DIEM
    INSERT INTO DETAI_DIEM(MSDT, DIEMTB)
    VALUES (@MSDT, @DIEMTB);

    -- Lấy dòng tiếp theo
    FETCH NEXT FROM CUR_TINH_DIEM INTO @MSDT;
END

-- Ðóng và hủy Cursor
CLOSE CUR_TINH_DIEM;
DEALLOCATE CUR_TINH_DIEM;
GO
-- Kiểm tra bảng đã nhập được chưa.
SELECT * FROM DETAI_DIEM;
GO

-- ================================================================
-- 2E. 2.
-- Gom các bước xử lý của Cursor ở câu 1 vào một Stored Procedure.
-- ================================================================

CREATE OR ALTER PROCEDURE SP_TINH_DIEMTB_DETAI
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @MSDT CHAR(6);
    DECLARE @DIEMTB FLOAT;

    -- Xóa dữ liệu cũ (tránh trùng khi chạy lại)
    DELETE FROM DETAI_DIEM;

    -- Cursor duyệt từng đề tài
    DECLARE CUR_DETAI CURSOR FOR
    SELECT MSDT
    FROM DETAI;

    OPEN CUR_DETAI;
    FETCH NEXT FROM CUR_DETAI INTO @MSDT;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Tính điểm trung bình của đề tài
        SELECT @DIEMTB = ROUND(AVG(DIEM), 2)
        FROM (
            SELECT DIEM FROM GV_HDDT WHERE MSDT = @MSDT
            UNION ALL
            SELECT DIEM FROM GV_PBDT WHERE MSDT = @MSDT
            UNION ALL
            SELECT DIEM FROM GV_UVDT WHERE MSDT = @MSDT
        ) AS T;

        -- Lưu vào bảng DETAI_DIEM
        INSERT INTO DETAI_DIEM(MSDT, DIEMTB)
        VALUES (@MSDT, @DIEMTB);

        FETCH NEXT FROM CUR_DETAI INTO @MSDT;
    END

    CLOSE CUR_DETAI;
    DEALLOCATE CUR_DETAI;
END;
GO

-- Chạy SP vừa tạo để cho kết quả mới
EXEC SP_TINH_DIEMTB_DETAI;
GO

-- ================================================================
-- 2E. 3.
-- Tạo thêm cột XEPLOAI có kiểu là NVARCCHAR(20) trong bảng DETAI_DIEM
-- Viết Cursor cập nhật kết quả xếp loại cho mỗi đề tài.
-- Thêm cột XEPLOAI vào bảng DETAI_DIEM để lưu kết quả xếp loại
-- ================================================================

ALTER TABLE DETAI_DIEM
ADD XEPLOAI NVARCHAR(20);
GO

-- Khai báo biến
DECLARE @MSDT CHAR(6);
DECLARE @DIEMTB FLOAT;
DECLARE @XEPLOAI NVARCHAR(20);

-- Khai báo Cursor và Lấy mã đề tài và điểm trung bình
DECLARE CUR_XEPLOAI CURSOR FOR
SELECT MSDT, DIEMTB
FROM DETAI_DIEM;

-- Mở Cursor
OPEN CUR_XEPLOAI;
FETCH NEXT FROM CUR_XEPLOAI INTO @MSDT, @DIEMTB;

WHILE @@FETCH_STATUS = 0
BEGIN
    IF @DIEMTB >= 9 AND @DIEMTB <= 10
        SET @XEPLOAI = N'Xuất sắc';
    ELSE IF @DIEMTB >= 8
        SET @XEPLOAI = N'Giỏi';
    ELSE IF @DIEMTB >= 7
        SET @XEPLOAI = N'Khá';
    ELSE IF @DIEMTB >= 6
        SET @XEPLOAI = N'Trung bình khá';
    ELSE IF @DIEMTB >= 5
        SET @XEPLOAI = N'Trung bình';
    ELSE IF @DIEMTB >= 4
        SET @XEPLOAI = N'Yếu';
    ELSE
        SET @XEPLOAI = N'Kém';

    UPDATE DETAI_DIEM
    SET XEPLOAI = @XEPLOAI
    WHERE MSDT = @MSDT;

    FETCH NEXT FROM CUR_XEPLOAI INTO @MSDT, @DIEMTB;
END
-- Đóng Cursor sau khi duyệt xong dữ liệu
CLOSE CUR_XEPLOAI;
-- Đóng Cursor sau khi duyệt xong dữ liệu
DEALLOCATE CUR_XEPLOAI;
GO

-- Kiểm tra kết quả
SELECT * FROM DETAI_DIEM;
GO

-- ================================================================
-- THE END
-- ================================================================
