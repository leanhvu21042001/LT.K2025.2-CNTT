-- NHÓM 2
-- MÔN: IE103 - Quản Lý Thông Tin
-- BTTH2
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

-- ==================================================================
-- Câu 4. Một đề tài không quá 2 sinh viên.
-- ==================================================================

-- == TRIGGER

-- Xóa trigger nếu đang tồn tại

IF OBJECT_ID('BTTH2_TRG_KiemTraSoLuongSinhVien', 'TR') IS NOT NULL
    DROP TRIGGER BTTH2_TRG_KiemTraSoLuongSinhVien;
GO

-- Tạo trigger mới
CREATE TRIGGER BTTH2_TRG_KiemTraSoLuongSinhVien
ON SV_DETAI
FOR INSERT, UPDATE
AS 
BEGIN
    IF EXISTS (
        SELECT SV_DETAI.MSDT
        FROM SV_DETAI
        JOIN INSERTED ON SV_DETAI.MSDT = INSERTED.MSDT
        GROUP BY SV_DETAI.MSDT
        HAVING COUNT(SV_DETAI.MSSV) > 2
    )
    BEGIN
        RAISERROR(N'Lỗi: Một đề tài không được quá 2 sinh viên thực hiện.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

-- == VÍ DỤ

-- Thêm đề tài để kiểm thử
IF NOT EXISTS (SELECT * FROM DETAI WHERE MSDT = '99999')
INSERT INTO DETAI (MSDT, TENDT) VALUES ('99999', N'Đề tài kiểm thử Trigger SV');
GO

-- Xóa dữ liệu cũ của đề tài 99999 trong bảng SV_DETAI nếu có để test lại từ đầu
DELETE FROM SV_DETAI WHERE MSDT = '99999';
GO

-- Thêm sinh viên thứ 1
INSERT INTO SV_DETAI (MSSV, MSDT) VALUES ('13520001', '99999');
GO

-- Thêm sinh viên thứ 2
INSERT INTO SV_DETAI (MSSV, MSDT) VALUES ('13520002', '99999');
GO

-- Xem số lượng Sinh Viên của đề tài kiểm thử
SELECT MSDT, COUNT(MSSV) AS SoLuongSV 
FROM SV_DETAI 
WHERE MSDT = '99999' 
GROUP BY MSDT;
GO

-- Cố gắng thêm sinh viên và gặp lỗi
INSERT INTO SV_DETAI (MSSV, MSDT) VALUES ('13520003', '99999');
GO

-- ==================================================================
-- Câu 5. Giáo viên muốn có học hàm Phó Giáo Sư (PGS) thì bắt buộc phải có học vị Tiến sĩ.
-- ==================================================================

-- == TRIGGER
-- Xóa trigger cũ nếu tồn tại (cho các lần chạy thứ 2 trở lên)
IF OBJECT_ID('BTTH2_TRG_KiemTraHocHamGiaoVien', 'TR') IS NOT NULL
    DROP TRIGGER BTTH2_TRG_KiemTraHocHamGiaoVien;
GO

-- Tạo trigger với các logic đã trình bày trong báo cáo
CREATE TRIGGER BTTH2_TRG_KiemTraHocHamGiaoVien
ON GIAOVIEN
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT INSERTED.MSGV
        FROM INSERTED
        JOIN HOCHAM ON INSERTED.MSHH = HOCHAM.MSHH
        -- Chỉ kiểm tra nếu là PGS
        WHERE HOCHAM.TENHH = N'PHÓ GIÁO SƯ'
        AND NOT EXISTS (
            -- Kiểm tra xem giáo viên này có bằng Tiến sĩ hay không
            SELECT 1
            FROM GV_HV_CN
            JOIN HOCVI ON GV_HV_CN.MSHV = HOCVI.MSHV
            WHERE GV_HV_CN.MSGV = INSERTED.MSGV
            AND (HOCVI.TENHV = N'Tiến sĩ' OR HOCVI.TENHV = N'Tiến sĩ Khoa học')
        )
    )
    BEGIN
        RAISERROR(N'Lỗi: Giáo viên muốn được phong Phó Giáo Sư phải có học vị Tiến sĩ.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

-- == VÍ DỤ
-- Chuẩn bị môi trường và dữ liệu

-- Thêm một học hàm mới để thử nghiệm (không phải là GIÁO SƯ hoặc PHÓ GIÁO SƯ)
IF NOT EXISTS (SELECT * FROM HOCHAM WHERE MSHH = 0)
    INSERT INTO HOCHAM (MSHH, TENHH) VALUES (0, N'Chưa có');
GO

-- Thêm một giáo viên mới với học hàm 0 vừa thêm
IF NOT EXISTS (SELECT * FROM GIAOVIEN WHERE MSGV = 901)
    INSERT INTO GIAOVIEN (MSGV, TENGV, DIACHI, SODT, MSHH, NAMHH)
    VALUES (901, N'Nguyễn Văn Test', N'TP.HCM', '0909090909', 0, '2024');
GO

-- Gán học vị kỹ sư
INSERT INTO GV_HV_CN (MSGV, MSHV, MSCN, NAM) VALUES (901, 2, 1, '2010');
GO

-- Cố gắng cập nhật lên Phó Giáo Sư (Mã 1)
UPDATE GIAOVIEN SET MSHH = 1 WHERE MSGV = 901;
GO

-- Bổ sung bằng Tiến sĩ (Mã 4) cho GV 901
INSERT INTO GV_HV_CN (MSGV, MSHV, MSCN, NAM) VALUES (901, 4, 1, '2015');
GO

-- Cập nhật lại lên Phó Giáo Sư (Mã 1)
UPDATE GIAOVIEN SET MSHH = 1 WHERE MSGV = 901;
GO

-- Kiểm tra lại

SELECT GV.MSGV, GV.TENGV, HH.TENHH 
FROM GIAOVIEN GV 
JOIN HOCHAM HH ON GV.MSHH = HH.MSHH 
WHERE GV.MSGV = 901;
GO

-- HOÀN THÀNH
