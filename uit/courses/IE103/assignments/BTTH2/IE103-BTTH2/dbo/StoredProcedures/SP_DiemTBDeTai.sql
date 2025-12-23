
-- ================================================================
-- 2B.2
-- Đưa vào MSDT cho biết: Điểm trung bình của đề tài, nếu không tìm thấy trả về 0
-- ================================================================

CREATE   PROCEDURE SP_DiemTBDeTai
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

