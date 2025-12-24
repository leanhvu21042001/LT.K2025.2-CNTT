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
