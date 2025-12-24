-- NHÓM 2
-- MÔN: IE103 - Quản Lý Thông Tin
-- BTTH3
-- PHẦN 2
-- MỤC C: TRIGGER

-- ==================================================================
-- Câu 1. Khi xóa một đề tài (MSDT) sẽ xóa các thông tin liên quan.
-- ==================================================================

-- == TRIGGER

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

-- == VÍ DỤ

-- Ví dụ: Xóa đề tài '97001' (Quản lý thư viện)
DELETE FROM DETAI WHERE MSDT = '97001';
GO

-- Sau khi chạy, bạn có thể select lại để kiểm tra xem nó còn tồn tại không
SELECT * FROM DETAI;
SELECT * FROM SV_DETAI;
GO

-- ==================================================================
-- Câu 2. Khi đổi 1 mã số giáo viên (`MSGV`) thì sẽ thay đổi các thông tin liên quan.
-- ==================================================================

-- == TRIGGER

-- Xóa trigger nếu đã tồn tại
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

-- == VÍ DỤ

-- Bước 1: Kiểm tra thông tin TRƯỚC khi đổi
-- GV 202 đang hướng dẫn đề tài 97002
SELECT * FROM GIAOVIEN WHERE MSGV = 202;
SELECT * FROM GV_HDDT WHERE MSGV = 202;
GO

-- Bước 2: Thực hiện đổi mã số (Kích hoạt Trigger)
UPDATE GIAOVIEN
SET MSGV = 2020
WHERE MSGV = 202;
GO

-- Bước 3: Kiểm tra thông tin SAU khi đổi
-- Kiểm tra xem 202 còn không (nên là không)
SELECT * FROM GIAOVIEN WHERE MSGV = 202;
GO

-- Kiểm tra xem 2020 đã xuất hiện chưa và thông tin liên quan đã chuyển qua chưa
SELECT MSGV, TENGV, MSHH FROM GIAOVIEN;
SELECT * FROM GV_HDDT;
GO

-- ==================================================================
-- Câu 3. Một hội đồng không quá 10 đề tài.
-- ==================================================================

-- == TRIGGER
-- Xóa trigger đang tồn tại nếu có (ở các lần chạy thứ 2 trở đi).
IF OBJECT_ID('BTTH2_TRG_KiemTraSoLuongDeTai', 'TR') IS NOT NULL
    DROP TRIGGER BTTH2_TRG_KiemTraSoLuongDeTai;
GO

-- - Tạo Trigger kiểm tra ràng buộc số lượng Đề Tài
--     - Sử dụng `FOR` (`AFTER`).
--     - Kiểm tra xem có hội đồng nào vi phạm quy định (> 10 đề tài) hay không.
--     - Logic: Chỉ cần kiểm tra các `MSHD` vừa bị tác động (có trong bảng `INSERTED`).
--     - Nếu tìm thấy hội đồng nào có > 10 đề tài, hủy bỏ thao tác (`INSERT`/`UPDATE`) và báo lỗi.

CREATE TRIGGER BTTH2_TRG_KiemTraSoLuongDeTai
ON HOIDONG_DT
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT HOIDONG_DT.MSHD
        FROM HOIDONG_DT
        JOIN INSERTED ON HOIDONG_DT.MSHD = INSERTED.MSHD
        GROUP BY HOIDONG_DT.MSHD
        HAVING COUNT(HOIDONG_DT.MSHD) > 10
    )
    BEGIN
        RAISERROR(N'Lỗi: Quá 10 đề tài trên Hội Đồng.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

-- == VÍ DỤ

-- Thêm số lượng đề tài trước khi kiểm thử: với các đề tài bổ sung, và một hội đồng giả định.
INSERT INTO DETAI (MSDT, TENDT) VALUES
('T01', 'Test 1'),
('T02', 'Test 2'),
('T03', 'Test 3'),
('T04', 'Test 4'),
('T05', 'Test 5'),
('T06', 'Test 6');
GO

-- Thêm một hội đồng giả định
INSERT INTO HOIDONG (MSHD, PHONG, TGBD, NGAYHD, TINHTRANG, MSGV)
VALUES (99, 101, '07:00', '2024-01-01', N'Test', 201);
GO

-- Thêm 10 đề tài vào hội đồng giả định này, khiến số lượng đang ở `= 10`.

INSERT INTO HOIDONG_DT (MSHD, MSDT, QUYETDINH) VALUES
(99, '97002', N'Được'),
(99, '97003', N'Được'),
(99, '97004', N'Được'),
(99, '97005', N'Được'),
(99, '97006', N'Được'),
(99, 'T01', N'Được'),
(99, 'T02', N'Được'),
(99, 'T03', N'Được'),
(99, 'T04', N'Được'),
(99, 'T05', N'Được');
GO

-- Kiểm tra số lượng hiện tại
SELECT MSHD, COUNT(MSDT) as SoLuong FROM HOIDONG_DT WHERE MSHD = 99 GROUP BY MSHD;
GO

-- Kiểm thử: Thêm đề tài T06 vào hội đồng giả định này, khiến điều kiện trở thành `> 10`.
INSERT INTO HOIDONG_DT (MSHD, MSDT, QUYETDINH) VALUES (99, 'T06', N'Được');
GO
