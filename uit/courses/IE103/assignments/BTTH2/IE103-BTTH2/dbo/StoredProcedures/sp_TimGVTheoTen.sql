
-- ================================================================
-- 2B.3
-- Đưa vào TENGV trả ra: SDT của giáo viên đó, nếu không tìm thấy trả về 0.
-- Nếu trùng tên thì có báo lỗi không? Tại sao?
-- Làm sao để hiện thông báo có bao nhiêu giáo viên trùng tên và trả về các SDT?
-- ================================================================

CREATE   PROCEDURE sp_TimGVTheoTen @TENGV NVARCHAR(30),
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

