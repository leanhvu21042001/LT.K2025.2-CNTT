-- Sử dụng DB đúng, đặc biệt nếu triển khai từ SQL Projects của ADS
-- USE "IE103-BTTH2";
-- GO

-- Xóa trigger đã tạo trước đó nếu đây là lần chạy thứ 2 trở lên
-- Đảm bảo luôn có duy nhất 1 trigger được tạo và mới nhất.
IF OBJECT_ID('BTTH2_TRG_XoaDeTai', 'TR') IS NOT NULL
    DROP TRIGGER BTTH2_TRG_XoaDeTai;
GO

-- Tạo Trigger mới trên DETAI
CREATE TRIGGER BTTH2_TRG_XoaDeTai ON DETAI
-- DÙNG INSTEAD OF cho mục đích này
INSTEAD OF DELETE
AS
BEGIN

    -- Bước 1: Xóa dữ liệu tham chiếu ở các bảng con dựa trên MSDT

    -- Xóa trong SV_DETAI (Sinh viên - Đề tài)
    DELETE FROM SV_DETAI
    WHERE MSDT IN (SELECT MSDT FROM DELETED);

    -- Xóa trong GV_HDDT (Giáo viên hướng dẫn)
    DELETE FROM GV_HDDT
    WHERE MSDT IN (SELECT MSDT FROM DELETED);

    -- Xóa trong GV_PBDT (Giáo viên phản biện)
    DELETE FROM GV_PBDT
    WHERE MSDT IN (SELECT MSDT FROM DELETED);

    -- Xóa trong GV_UVDT (Giáo viên ủy viên)
    DELETE FROM GV_UVDT
    WHERE MSDT IN (SELECT MSDT FROM DELETED);

    -- Xóa trong HOIDONG_DT (Hội đồng - Đề tài)
    DELETE FROM HOIDONG_DT
    WHERE MSDT IN (SELECT MSDT FROM DELETED);

    -- Bước 2: Xóa chính đề tài đó trong bảng DETAI
    DELETE FROM DETAI
    WHERE MSDT IN (SELECT MSDT FROM DELETED);

    PRINT N'Thực thi BTTH2_TRG_XoaDeTai: Đã xóa đề tài và các dữ liệu liên quan.';
END;
GO

-- Ví dụ: Xóa đề tài '97001' (Quản lý thư viện)
DELETE FROM DETAI WHERE MSDT = '97001';

-- Sau khi chạy, bạn có thể select lại để kiểm tra xem nó còn tồn tại không
SELECT * FROM DETAI;
SELECT * FROM SV_DETAI;
