-- Bai4: Tạo Trigger thỏa mãn ràng buộc là một đề tài không quá 2 sinh viên. Dùng “Group by” có được không? Giải thích.(Một giáo viên đã hướng dẫn 
đề tài thì không được phép làm giáo viên phản biện (chấm điểm độc lập) cho chính đề tài đó).

CREATE TRIGGER trg_Bai4_CheckSoLuongSV
ON SV_DETAI
-- Tự kích hoạt ngay sau khi bạn thêm mới hoặc sửa dữ liệu sinh viên/đề tài.
AFTER INSERT, UPDATE
AS
BEGIN
    -- Kiểm tra nếu có bất kỳ đề tài nào vừa được cập nhật mà vượt quá 2 sinh viên
    IF EXISTS (
        SELECT 1
        FROM SV_DETAI
        WHERE MSDT IN (SELECT MSDT FROM inserted)
		-- Gom tất cả sinh viên có cùng mã đề tài lại thành từng nhóm.
        GROUP BY MSDT
		-- Đếm số lượng sinh viên trong mỗi nhóm, nếu nhóm nào có trên 2 người thì xác nhận là lỗi.
        HAVING COUNT(MSSV) > 2
    )
    BEGIN
		-- Phát ra thông báo lỗi hiển thị lên màn hình người dùng.
        RAISERROR(N'LỖI: Mỗi đề tài không được phép có quá 2 sinh viên thực hiện.', 16, 1);
		-- -- Nếu phát hiện vi phạm (số lượng > 2), lệnh này sẽ "nhấn nút hủy", mọi thay đổi dữ liệu sẽ không được lưu vào cơ sở dữ liệu.
        ROLLBACK TRANSACTION;
    END
END
GO
	-- Dùng “Group by” có được không? Giải thích:
		Trả lời: ĐƯỢC và RẤT NÊN DÙNG.

		Giải thích:

		Tính chính xác: Khi dùng GROUP BY, SQL Server sẽ gom tất cả các bản ghi có cùng MSDT lại một chỗ rồi mới đếm. Điều này đảm bảo chúng ta tính 
		toán chính xác tổng số sinh viên hiện có của đề tài đó sau khi đã cộng thêm sinh viên mới.

		Xử lý đồng thời: GROUP BY cho phép trigger xử lý được trường hợp bạn thêm nhiều sinh viên cùng lúc (ví dụ dùng lệnh INSERT INTO... SELECT...). 
		Nếu dùng biến đơn lẻ mà không dùng GROUP BY, trigger có thể bị sót lỗi nếu nhập liệu hàng loạt.

		Thay thế: Nếu không dùng GROUP BY, bạn phải dùng các câu truy vấn lồng nhau (Subquery) phức tạp hoặc vòng lặp (Cursor), điều này làm code khó 
		đọc và hiệu suất kém hơn nhiều.
	-- Cách hoạt động và ví dụ:
		Cách hoạt động: Trigger này ngăn chặn xung đột lợi ích. Nó quét bảng Hướng dẫn, nếu thấy giáo viên này đã "nhúng tay" vào hướng dẫn đề tài này rồi thì không 
		cho phép họ vào danh sách Phản biện nữa.

		Ví dụ: Giáo viên Trần Trung (00201) đang hướng dẫn đề tài 97001 (Quản lý thư viện).

			   Nếu bạn nhập: INSERT INTO GV_PBDT (MSGV, MSDT, DIEM) VALUES (00201, '97001', 8);

			   Trigger sẽ báo lỗi: "Giáo viên phản biện không được là Giáo viên hướng dẫn cho cùng một đề tài".