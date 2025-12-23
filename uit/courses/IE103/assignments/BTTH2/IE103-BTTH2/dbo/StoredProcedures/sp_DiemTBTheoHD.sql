
-- ================================================================
-- 2B.4
-- Đưa vào MSHD cho biết: Điểm trung bình các đề tài của hội đồng đó
-- ================================================================

CREATE   PROCEDURE sp_DiemTBTheoHD @MSHD INT,
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
GO

