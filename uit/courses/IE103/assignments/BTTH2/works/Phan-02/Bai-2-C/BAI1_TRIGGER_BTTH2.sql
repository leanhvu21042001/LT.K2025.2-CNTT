-- Bai1: Tạo Trigger thỏa mãn điều kiện khi xóa một đề tài sẽ xóa các thông tin liên
quan.(Trigger này đảm bảo một đề tài không được quá 4 sinh viên thực hiện).


CREATE TRIGGER trg_C1_CheckSoLuongSVDeTai
-- Gắn trigger này vào bảng SV_DETAI (bảng trung gian giữa Sinh viên và Đề tài).
ON SV_DETAI
-- Trigger sẽ tự động chạy sau khi bạn thực hiện lệnh thêm mới (Insert) hoặc cập nhật (Update) dữ liệu vào bảng này.
AFTER INSERT, UPDATE
AS
BEGIN
    -- Khai báo hai biến để chứa mã đề tài và số lượng sinh viên.
    DECLARE @MSDT char(6);
    DECLARE @SoLuongSV int;

    -- Lấy mã đề tài vừa được thao tác từ bảng inserted (đây là bảng tạm chứa dữ liệu bạn vừa nhập vào).
    SELECT @MSDT = MSDT FROM inserted;

    -- Đếm tổng số sinh viên hiện có của đề tài đó trong bảng chính.
    SELECT @SoLuongSV = COUNT(MSSV)
    FROM SV_DETAI
    WHERE MSDT = @MSDT;

    -- Nếu vượt quá 4 người, thực hiện báo lỗi RAISERROR và ROLLBACK TRANSACTION (hủy bỏ lệnh vừa nhập).
    IF @SoLuongSV > 4
    BEGIN
        -- Báo lỗi và hủy bỏ thao tác (ROLLBACK)
        RAISERROR(N'LỖI: Một đề tài không được phép có quá 4 sinh viên thực hiện.', 16, 1);
		-- Hủy bỏ toàn bộ thao tác. Dữ liệu sẽ không được lưu vào database.
        ROLLBACK TRANSACTION;
        RETURN;
    END
END
GO
	-- Cách hoạt động và ví dụ:
	Cách hoạt động: Khi bạn viết lệnh INSERT để thêm sinh viên vào đề tài, SQL Server sẽ tạm thời giữ thay đổi đó, rồi gọi trigger này. 
	Trigger kiểm tra "Nếu thêm bạn này vào thì tổng cộng có quá 4 người không?". Nếu quá, nó "rollback" (thu hồi) lệnh Insert đó như 
	chưa từng xảy ra.

	Ví dụ: Đề tài 97005 (Xử lý ảnh) hiện đã có 2 sinh viên là Ưng Hồng Ân và Phan Tấn Đạt.

		   Nếu bạn thêm tiếp 2 sinh viên nữa -> Thành công (tổng = 4).

	 	   Nếu bạn cố gắng thêm sinh viên thứ 5 vào mã đề tài 97005 -> Trigger sẽ báo lỗi và ngăn chặn lệnh thêm này.