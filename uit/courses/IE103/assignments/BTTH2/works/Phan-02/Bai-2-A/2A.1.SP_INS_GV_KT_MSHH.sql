-- ================================================================
-- 2A.1
-- Tham số vào là MSGV, TENGV, SODT, DIACHI, MSHH, NAMHH.
-- Trước khi insert dữ liệu cần kiểm tra MSHH đã tồn tại trong table HOCHAM chưa,
-- nếu chưa thì trả về giá trị 0.
-- ================================================================

CREATE PROC SP_INS_GV_KT_MSHH
    @MSGV INT, 
	@TENGV NVARCHAR(30), 
	@SODT VARCHAR(10),
    @DIACHI NVARCHAR(50), 
	@MSHH INT, 
	@NAMHH SMALLDATETIME
AS
BEGIN
    IF NOT EXISTS (SELECT MSHH FROM HOCHAM WHERE MSHH = @MSHH)
        RETURN 0
    INSERT INTO GIAOVIEN VALUES (@MSGV, @TENGV, @DIACHI, @SODT, @MSHH, @NAMHH)
    RETURN 1
END;