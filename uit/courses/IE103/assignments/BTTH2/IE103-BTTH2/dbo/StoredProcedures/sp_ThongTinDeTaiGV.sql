
-- ================================================================
-- 2B.5
-- Đưa vào TENGV cho biết:
-- Số đề tài hướng dẫn, số đề tài phản biện do giáo viên đó phụ trách.
-- Nếu trùng tên thì có báo lỗi không?
-- Hay hệ thống sẽ đếm tất cả các đề tài của những giáo viên trùng tên đó?
-- ================================================================

CREATE   PROCEDURE sp_ThongTinDeTaiGV @TENGV NVARCHAR(30),
                                    @SoDT_HD INT OUTPUT,
                                    @SoDT_PB INT OUTPUT
AS
BEGIN
SET @SoDT_HD = 0;
SET @SoDT_PB = 0;

DECLARE @SoLuong_GV_TrungTen INT;
SET @SoLuong_GV_TrungTen = 0;

-- Kiểm tra danh sách giáo viên xem có trùng tên không
SELECT @SoLuong_GV_TrungTen = Count(MSGV) FROM GIAOVIEN WHERE TENGV = @TENGV

-- Nếu là 1: không trùng tên.
-- Nếu là 2 trở lên: trùng tên -> Lỗi
-- Nếu là 0: không tồn tại giáo viên có tên này
IF @SoLuong_GV_TrungTen = 1
    BEGIN
        -- Lấy MSGV từ khi chỉ có 1 record duy nhất
        DECLARE  @MSGV INT;
        SELECT @MSGV = MSGV FROM GIAOVIEN WHERE TENGV = @TENGV

        -- Đếm số lượng đề tài hướng dẫn và phản biện
        SELECT @SoDT_HD = Count(MSDT) FROM GV_HDDT WHERE MSGV = @MSGV
        SELECT @SoDT_PB = COUNT(MSDT) FROM GV_PBDT WHERE MSGV = @MSGV
    end
ELSE IF @SoLuong_GV_TrungTen >= 2
    BEGIN
        THROW 51000, N'Trùng tên giáo viên', 2;
    end
ELSE
    BEGIN
        THROW 51000, N'Không tìm thấy giáo viên', 1;
    end
end
GO

