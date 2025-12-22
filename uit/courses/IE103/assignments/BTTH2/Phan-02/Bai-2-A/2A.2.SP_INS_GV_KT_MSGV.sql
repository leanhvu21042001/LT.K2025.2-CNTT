
--2A.2
--Tham số vào là MSGV, TENGV, SODT, DIACHI, MSHH, NAMHH.
--Trước khi insert dữ liệu cần kiểm tra MSGV trong table GIAOVIEN có trùng không, nếu trùng thì trả về giá trị 0.
CREATE PROC SP_INS_GV_KT_MSGV
    @MSGV INT,
	@TENGV NVARCHAR(30),
	@SODT VARCHAR(10),
    @DIACHI NVARCHAR(50),
	@MSHH INT,
	@NAMHH SMALLDATETIME
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM GIAOVIEN
        WHERE MSGV = @MSGV
    )
    BEGIN
        RETURN 0; -- MSGV đã tồn tại
    END
    INSERT INTO GIAOVIEN VALUES (@MSGV, @TENGV, @DIACHI, @SODT, @MSHH, @NAMHH)
    RETURN 1
END;