
-- ================================================================
-- 2E. 2.
-- Gom các bước xử lý của Cursor ở câu 1 vào một Stored Procedure.
-- ================================================================

CREATE   PROCEDURE SP_TINH_DIEMTB_DETAI
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

