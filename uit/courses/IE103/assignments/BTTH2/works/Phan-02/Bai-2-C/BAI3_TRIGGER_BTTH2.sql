-- Bai3: Tạo Trigger thỏa mãn ràng buộc là một hội đồng không quá 10 đề tài. Dùng “Group by” có được không? Giải thích.(Trigger này 
đảm bảo tính khách quan: Một giáo viên không thể vừa là thành viên bình thường vừa là Chủ tịch của cùng một hội đồng).

CREATE TRIGGER trg_Bai3_CheckSoLuongDeTaiHD
ON HOIDONG_DT
-- Kích hoạt ngay sau khi có hành động thêm đề tài mới vào hội đồng hoặc chuyển đề tài từ hội đồng này sang hội đồng khác.
AFTER INSERT, UPDATE
AS
BEGIN
    -- Kiểm tra xem có hội đồng nào sau khi thêm/sửa mà vượt quá 10 đề tài không
    IF EXISTS (
        SELECT 1
        FROM HOIDONG_DT
        WHERE MSHD IN (SELECT MSHD FROM inserted)
		-- Nhóm các dòng dữ liệu lại theo từng mã hội đồng để bắt đầu đếm.
        GROUP BY MSHD
		-- Điều kiện lọc sau khi nhóm. Nếu số lượng đề tài của bất kỳ hội đồng nào lớn hơn 10, điều kiện này sẽ đúng.
        HAVING COUNT(MSDT) > 10
    )
    BEGIN
        RAISERROR(N'LỖI: Một hội đồng không được phép chấm quá 10 đề tài.', 16, 1);
		-- Nếu phát hiện vi phạm (số lượng > 10), lệnh này sẽ "nhấn nút hủy", mọi thay đổi dữ liệu sẽ không được lưu vào cơ sở dữ liệu.
        ROLLBACK TRANSACTION;
    END
END
GO

	-- Dùng “Group by” có được không? Giải thích:
		Trả lời: ĐƯỢC và RẤT NÊN DÙNG.

		Giải thích:

		Tại sao dùng được: GROUP BY là công cụ mạnh mẽ nhất trong SQL để phân nhóm dữ liệu. Khi cần kiểm tra giới hạn số lượng (như số sinh viên, số 
		đề tài, số tiết dạy), chúng ta bắt buộc phải gom các bản ghi có cùng mã định danh (ở đây là MSHD) lại để đếm tổng số thông qua hàm COUNT().

		Tại sao nên dùng:  Nếu không dùng GROUP BY, bạn sẽ phải dùng các biến đơn lẻ và vòng lặp (Cursor), điều này làm chậm hệ thống và code phức tạp 
		hơn nhiều. GROUP BY kết hợp với HAVING giúp SQL Server thực hiện kiểm tra song song nhiều hội đồng cùng lúc một cách hiệu quả.
	
	-- Cách hoạt động và ví dụ:
		Cách hoạt động: Khi bạn thêm một giáo viên vào một hội đồng, trigger sẽ nhìn sang bảng HOIDONG để xem ai là "sếp" (Chủ tịch) của hội 
		đồng đó. Nếu trùng tên/mã, lệnh thêm bị hủy.

		Ví dụ: Hội đồng 1 có Chủ tịch là Trần Trung (MSGV: 00201).

			   Nếu bạn thực hiện lệnh: INSERT INTO HOIDONG_GV VALUES (1, 00201); (Thêm ông Trung làm thành viên HĐ 1).

			   Trigger thấy 00201 đã là Chủ tịch HĐ 1 rồi -> Báo lỗi.