-- 2A.4
-- Đưa vào MSDT cũ, TENDT mới. Hãy cập nhật tên đề tài mới với mã đề tài cũ không đổi nếu không tìm thấy trả về 0, ngược lại cập nhật và trả về 1

CREATE PROC SP_UPD_DETAI_KT_MSDT
    @MSDT char(6),
	@TENDT NVARCHAR(30)
AS
BEGIN
    IF NOT EXISTS (SELECT MSDT FROM DETAI WHERE MSDT = @MSDT)
	BEGIN
        RETURN 0; -- Nếu MSHH chưa tồn tại trả về 0
	END

    UPDATE DETAI
	SET TENDT = @TENDT
	WHERE MSDT = @MSDT
	RETURN 1
END;
