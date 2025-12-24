-- Bai5: Tạo Trigger thỏa mãn ràng buộc là một giáo viên muốn có học hàm PGS phải là tiến sĩ.(Đảm bảo năm ghi nhận học hàm không phải là một năm trong tương lai).

CREATE TRIGGER trg_C5_CheckNamHocHam
ON GIAOVIEN
-- Trigger sẽ tự động chạy sau khi bạn thực hiện lệnh thêm mới (Insert) hoặc cập nhật (Update) dữ liệu vào bảng này.
AFTER INSERT, UPDATE
AS
BEGIN
    -- Lấy năm hiện tại từ hệ thống máy tính.
    DECLARE @NamHienTai int = YEAR(GETDATE());

    -- Kiểm tra nếu năm bạn vừa nhập vào (i.NAMHH) lớn hơn năm hiện tại.
    IF EXISTS (
        SELECT 1
        FROM inserted AS i
        WHERE YEAR(i.NAMHH) > @NamHienTai
    )
    BEGIN
		-- Phát ra thông báo lỗi hiển thị lên màn hình người dùng.
        RAISERROR(N'LỖI: Năm nhận học hàm (NAMHH) không được lớn hơn năm hiện tại.', 16, 1);
		-- Hủy bỏ toàn bộ thao tác. Dữ liệu sẽ không được lưu vào database.
        ROLLBACK TRANSACTION;
        RETURN;
    END
END
GO

	-- Cách hoạt động và ví dụ:
		Cách hoạt động: Đây là một dạng kiểm tra logic thời gian đơn giản để tránh sai sót khi nhập liệu.

		Ví dụ: Hôm nay là năm 2025. Bạn nhập thông tin giáo viên Nguyễn Văn An nhận học hàm Giáo sư vào năm 2030.
		 
			   Trigger so sánh: 2030 > 2025 -> Đúng.

			   Trigger báo lỗi và không cho lưu.