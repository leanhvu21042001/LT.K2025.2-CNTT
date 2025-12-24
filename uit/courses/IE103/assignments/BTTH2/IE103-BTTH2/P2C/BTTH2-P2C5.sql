-- NHÓM 2
-- MÔN: IE103 - Quản Lý Thông Tin
-- BTTH3
-- PHẦN 2
-- MỤC C
-- CÂU 5

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

