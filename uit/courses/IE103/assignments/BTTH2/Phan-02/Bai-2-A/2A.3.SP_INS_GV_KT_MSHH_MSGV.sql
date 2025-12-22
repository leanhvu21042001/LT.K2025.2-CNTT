--2A.3
--Giống (1) và (2) kiểm tra xem MSGV có trùng không? MSHH có tồn tại chưa? Nếu MSGV trùng thì trả về 0. Nếu MSHH chưa tồn tại trả về 1, ngược lại cho insert dữ liệu
CREATE PROC SP_INS_GV_KT_MSHH_MSGV
    @MSGV INT, 
	@TENGV NVARCHAR(30), 
	@SODT VARCHAR(10),
    @DIACHI NVARCHAR(50), 
	@MSHH INT, 
	@NAMHH SMALLDATETIME
AS
BEGIN
    IF NOT EXISTS (SELECT MSHH FROM HOCHAM WHERE MSHH = @MSHH)
	BEGIN
        RETURN 1; --Nếu MSHH chưa tồn tại trả về 1
	END
	IF EXISTS (SELECT 1 FROM GIAOVIEN WHERE MSGV = @MSGV)
    BEGIN
        RETURN 0; -- Nếu MSGV trùng thì trả về 0
    END
    INSERT INTO GIAOVIEN VALUES (@MSGV, @TENGV, @DIACHI, @SODT, @MSHH, @NAMHH)
END;