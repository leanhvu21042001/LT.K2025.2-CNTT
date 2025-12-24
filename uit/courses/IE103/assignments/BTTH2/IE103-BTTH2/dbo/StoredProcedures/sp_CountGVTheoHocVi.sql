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
CREATE   PROCEDURE sp_CountGVTheoHocVi
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

