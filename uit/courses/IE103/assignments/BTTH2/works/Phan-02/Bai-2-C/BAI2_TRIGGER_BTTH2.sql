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