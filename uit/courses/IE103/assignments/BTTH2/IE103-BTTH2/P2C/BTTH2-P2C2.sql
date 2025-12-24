IF OBJECT_ID('BTTH2_TRG_CapNhatMSGV', 'TR') IS NOT NULL
    DROP TRIGGER BTTH2_TRG_CapNhatMSGV;
GO

-- Tạo Trigger sử dụng cả INSERTED và DELETED
CREATE TRIGGER BTTH2_TRG_CapNhatMSGV
ON GIAOVIEN
INSTEAD OF UPDATE
AS 
BEGIN
    -- Khai báo biến để giữ giá trị cũ và mới
    DECLARE @OldMSGV INT;
    DECLARE @NewMSGV INT;

    -- Lấy MSGV cũ từ bảng DELETED (dữ liệu trước khi update)
    SELECT @OldMSGV = MSGV FROM DELETED;
    
    -- Lấy MSGV mới từ bảng INSERTED (dữ liệu người dùng muốn update)
    SELECT @NewMSGV = MSGV FROM INSERTED;

    -- Kiểm tra: Nếu người dùng có sửa MSGV (Khóa chính)
    IF (@OldMSGV <> @NewMSGV)
    BEGIN
        -- 1. Thêm dòng giáo viên mới với thông tin từ bảng INSERTED
        INSERT INTO GIAOVIEN (MSGV, TENGV, DIACHI, SODT, MSHH, NAMHH)
        SELECT MSGV, TENGV, DIACHI, SODT, MSHH, NAMHH 
        FROM INSERTED;

        -- 2. Cập nhật các bảng con đang giữ MSGV cũ thành MSGV mới
        UPDATE GV_HV_CN SET MSGV = @NewMSGV WHERE MSGV = @OldMSGV;
        UPDATE GV_HDDT  SET MSGV = @NewMSGV WHERE MSGV = @OldMSGV;
        UPDATE GV_PBDT  SET MSGV = @NewMSGV WHERE MSGV = @OldMSGV;
        UPDATE GV_UVDT  SET MSGV = @NewMSGV WHERE MSGV = @OldMSGV;
        UPDATE HOIDONG  SET MSGV = @NewMSGV WHERE MSGV = @OldMSGV;
        UPDATE HOIDONG_GV SET MSGV = @NewMSGV WHERE MSGV = @OldMSGV;

        -- 3. Xóa dòng giáo viên cũ (dựa trên bảng DELETED)
        DELETE FROM GIAOVIEN WHERE MSGV = @OldMSGV;
    END
    ELSE
    -- Trường hợp: Người dùng chỉ sửa tên, địa chỉ... (không sửa Khóa chính)
    BEGIN
        UPDATE GIAOVIEN
        SET TENGV = I.TENGV,
            DIACHI = I.DIACHI,
            SODT = I.SODT,
            MSHH = I.MSHH,
            NAMHH = I.NAMHH
        FROM GIAOVIEN G
        JOIN INSERTED I ON G.MSGV = I.MSGV;
    END
END;
GO

-- Bước 1: Kiểm tra thông tin TRƯỚC khi đổi
-- GV 202 đang hướng dẫn đề tài 97002
SELECT * FROM GIAOVIEN WHERE MSGV = 202;
SELECT * FROM GV_HDDT WHERE MSGV = 202;

-- Bước 2: Thực hiện đổi mã số (Kích hoạt Trigger)
UPDATE GIAOVIEN 
SET MSGV = 2020 
WHERE MSGV = 202;

-- Bước 3: Kiểm tra thông tin SAU khi đổi
-- Kiểm tra xem 202 còn không (nên là không)
SELECT * FROM GIAOVIEN WHERE MSGV = 202;

-- Kiểm tra xem 2020 đã xuất hiện chưa và thông tin liên quan đã chuyển qua chưa
SELECT MSGV, TENGV, MSHH FROM GIAOVIEN;
SELECT * FROM GV_HDDT; 
-- Kết quả kỳ vọng ở GV_HDDT: MSGV phải là 2020, vẫn giữ nguyên đề tài 97002 và điểm số cũ.
