----C. TRIGGER
--Trigger là một dạng chương trình con tự động "kích hoạt" khi có các hành động INSERT, UPDATE hoặc DELETE.
--Bật Trigger	         ENABLE TRIGGER trigger_name ON table_name;
--Tắt tạm thời	         DISABLE TRIGGER trigger_name ON table_name;
--Xóa bỏ	             DROP TRIGGER trigger_name;
--Xem code của trigger	 sp_helptext 'trigger_name';

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

-- Bai2: Tạo Trigger thỏa mãn ràng buộc là khi đổi 1 mã số giáo viên (MSGV) thì sẽ thay đổi các thông tin liên quan.(Trigger này kiểm 
tra xem MSGV, MSHV, MSCN khi nhập vào bảng GV_HV_CN có thực sự tồn tại trong các bảng danh mục tương ứng không).

CREATE TRIGGER trg_C2_CheckGVHVCN
ON GV_HV_CN
AFTER INSERT, UPDATE
AS
BEGIN
    -- Biến cờ kiểm tra lỗi
    DECLARE @HasError int = 0;

    -- 1. Kiểm tra: "Có dòng nào vừa nhập mà mã giáo viên lại KHÔNG nằm trong bảng GIAOVIEN không?".
    IF EXISTS (
        SELECT *
        FROM inserted AS i
        WHERE NOT EXISTS (SELECT 1 FROM GIAOVIEN WHERE MSGV = i.MSGV)
    )
    BEGIN
        RAISERROR(N'LỖI: Mã số giáo viên (MSGV) không tồn tại trong bảng GIAOVIEN.', 16, 1);
		-- Nếu phát hiện lỗi (mã không tồn tại), biến cờ hiệu HasError sẽ bật lên.
        SET @HasError = 1;
    END

    -- 2. Kiểm tra: "Có dòng nào vừa nhập mà mã giáo viên lại KHÔNG nằm trong bảng HOCVI không?".
    IF EXISTS (
        SELECT *
        FROM inserted AS i
        WHERE NOT EXISTS (SELECT 1 FROM HOCVI WHERE MSHV = i.MSHV)
    )
    BEGIN
        RAISERROR(N'LỖI: Mã số học vị (MSHV) không tồn tại trong bảng HOCVI.', 16, 1);
		-- Nếu phát hiện lỗi (mã không tồn tại), biến cờ hiệu HasError sẽ bật lên.
        SET @HasError = 1;
    END

    -- 3. Kiểm tra: "Có dòng nào vừa nhập mà mã giáo viên lại KHÔNG nằm trong bảng CHUYENNGANH không?".
    IF EXISTS (
        SELECT *
        FROM inserted AS i
        WHERE NOT EXISTS (SELECT 1 FROM CHUYENNGANH WHERE MSCN = i.MSCN)
    )
    BEGIN
        RAISERROR(N'LỖI: Mã số chuyên ngành (MSCN) không tồn tại trong bảng CHUYENNGANH.', 16, 1);
		-- Nếu phát hiện lỗi (mã không tồn tại), biến cờ hiệu HasError sẽ bật lên.
        SET @HasError = 1;
    END

    -- Nếu HasError = 1, xóa sạch hành động vừa làm.
    IF @HasError = 1
    BEGIN
		-- Hủy bỏ toàn bộ thao tác. Dữ liệu sẽ không được lưu vào database.
        ROLLBACK TRANSACTION;
    END
END
GO

	-- Cách hoạt động và ví dụ:
		Cách hoạt động: Nó hoạt động như một "người gác cổng" thủ công để đảm bảo dữ liệu đồng bộ, tránh việc một giáo viên có học vị 
		"không tồn tại"(không có trong danh mục).

		Ví dụ: Bạn muốn nhập thông tin: Giáo viên có mã 00201 đạt học vị mã 99 vào năm 2024.

			   Trigger kiểm tra bảng HOCVI. Trong file của bạn, bảng HOCVI chỉ có mã từ 1 đến 5.

			   Mã 99 không tồn tại -> Trigger chặn lại và báo lỗi: "Mã số học vị không tồn tại".

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