## E. CURSOR

### Tạo Bảng `DETAI_DIEM`

```sql
CREATE TABLE DETAI_DIEM (
    MSDT char(6) PRIMARY KEY,
    DIEMTB FLOAT,
    CONSTRAINT FK_DETAI_DIEM_DETAI FOREIGN KEY (MSDT) REFERENCES DETAI(MSDT)
);
```

`DETAI_DIEM` đã được tạo:

| database    | schema | name        | type       |
| ----------- | ------ | ----------- | ---------- |
| IE103-BTTH2 | dbo    | CHUYENNGANH | BASE TABLE |
| IE103-BTTH2 | dbo    | DETAI       | BASE TABLE |
| IE103-BTTH2 | dbo    | GIAOVIEN    | BASE TABLE |
| IE103-BTTH2 | dbo    | GV_HDDT     | BASE TABLE |
| IE103-BTTH2 | dbo    | GV_HV_CN    | BASE TABLE |
| IE103-BTTH2 | dbo    | GV_PBDT     | BASE TABLE |
| IE103-BTTH2 | dbo    | GV_UVDT     | BASE TABLE |
| IE103-BTTH2 | dbo    | HOCHAM      | BASE TABLE |
| IE103-BTTH2 | dbo    | HOCVI       | BASE TABLE |
| IE103-BTTH2 | dbo    | HOIDONG     | BASE TABLE |
| IE103-BTTH2 | dbo    | HOIDONG_DT  | BASE TABLE |
| IE103-BTTH2 | dbo    | HOIDONG_GV  | BASE TABLE |
| IE103-BTTH2 | dbo    | SINHVIEN    | BASE TABLE |
| IE103-BTTH2 | dbo    | SV_DETAI    | BASE TABLE |
| IE103-BTTH2 | dbo    | DETAI_DIEM  | BASE TABLE |

### Cursor Tính Điểm Trung Bình

- Viết Cursor tính điểm trung bình cho từng đề tài.
- Sau đó lưu kết quả vào bảng `DETAI_DIEM`.

Khởi tạo Cursor:

- Khai báo biến
```sql
DECLARE @MSDT CHAR(6);
DECLARE @DIEMTB FLOAT;
```
- Xóa dữ liệu cũ trong bảng kết quả (nếu có)

```sql
DELETE FROM DETAI_DIEM;
```

- Khai báo Cursor

```sql
DECLARE CUR_TINH_DIEM CURSOR FOR
    SELECT MSDT
    FROM DETAI;

-- Mở Cursor
OPEN CUR_TINH_DIEM;

-- Lấy dòng đầu tiên
FETCH NEXT FROM CUR_TINH_DIEM INTO @MSDT;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Tính điểm trung bình cho đề tài
    SELECT @DIEMTB = ROUND(AVG(DIEM), 2)
    FROM (
        SELECT DIEM FROM GV_HDDT WHERE MSDT = @MSDT
        UNION ALL
        SELECT DIEM FROM GV_PBDT WHERE MSDT = @MSDT
        UNION ALL
        SELECT DIEM FROM GV_UVDT WHERE MSDT = @MSDT
    ) AS T;

    -- Lưu kết quả vào DETAI_DIEM
    INSERT INTO DETAI_DIEM(MSDT, DIEMTB)
    VALUES (@MSDT, @DIEMTB);

    -- Lấy dòng tiếp theo
    FETCH NEXT FROM CUR_TINH_DIEM INTO @MSDT;
END

-- Ðóng và hủy Cursor
CLOSE CUR_TINH_DIEM;
DEALLOCATE CUR_TINH_DIEM;
```

- Kiểm tra bảng `DETAI_DIEM` đã nhập được chưa.

```sql
SELECT * FROM DETAI_DIEM;
```

| MSDT  | DIEMTB |
| :---: | ------ |
| 97001 | 8      |
| 97002 | 8.2    |
| 97003 | 7.5    |
| 97004 | 8      |
| 97005 | 8.2    |
| 97006 | 8.33   |

### Tạo Stored Procedure cho Tính Điểm Trung Bình

- Gom các bước xử lý của Cursor ở [@cursor-tinh-diem-trung-binh Mục Tính Điểm Trung Bình] vào một Stored Procedure.

```sql
CREATE OR ALTER PROCEDURE SP_TINH_DIEMTB_DETAI
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @MSDT CHAR(6);
    DECLARE @DIEMTB FLOAT;

    -- Làm sạch: Xóa dữ liệu cũ (tránh trùng khi chạy lại)
    DELETE FROM DETAI_DIEM;

    -- Cursor duyệt từng đề tài
    DECLARE CUR_DETAI CURSOR FOR
        SELECT MSDT
        FROM DETAI;

    OPEN CUR_DETAI;
    FETCH NEXT FROM CUR_DETAI INTO @MSDT;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Tính điểm trung bình của đề tài
        SELECT @DIEMTB = ROUND(AVG(DIEM), 2)
        FROM (
            SELECT DIEM FROM GV_HDDT WHERE MSDT = @MSDT
            UNION ALL
            SELECT DIEM FROM GV_PBDT WHERE MSDT = @MSDT
            UNION ALL
            SELECT DIEM FROM GV_UVDT WHERE MSDT = @MSDT
        ) AS T;

        -- Lưu vào bảng DETAI_DIEM
        INSERT INTO DETAI_DIEM(MSDT, DIEMTB)
        VALUES (@MSDT, @DIEMTB);

        FETCH NEXT FROM CUR_DETAI INTO @MSDT;
    END

    CLOSE CUR_DETAI;
    DEALLOCATE CUR_DETAI;
END;
```

- Chạy Stored Procedure vừa tạo:

```sql
EXEC SP_TINH_DIEMTB_DETAI;
```

- Kiểm tra bảng `DETAI_DIEM`:

```sql
SELECT * FROM DETAI_DIEM;
```

| MSDT  | DIEMTB |
| :---: | ------ |
| 97001 | 8      |
| 97002 | 8.2    |
| 97003 | 7.5    |
| 97004 | 8      |
| 97005 | 8.2    |
| 97006 | 8.33   |

### Xếp Loại Kết Quả với `XEPLOAI`

#### Yêu cầu

- Tạo thêm cột `XEPLOAI` có kiểu là `NVARCCHAR(20)` trong bảng `DETAI_DIEM`.
- Viết Cursor cập nhật kết quả xếp loại cho mỗi đề tài như sau:
    + "Xuất sắc": điểm trung bình từ 9 đến 10.
    + "Giỏi": điểm trung bình từ 8 đến 9.
    + "Khá": điểm trung bình từ 7 đến 8.
    + "Trung bình khá": điểm trung bình từ 6 đến 7.
    + "Trung bình": điểm trung bình từ 5 đến 6.
    + "Yếu": điểm trung bình từ 4 đến 5.
    + "Kém": điểm trung bình dưới 4.

#### Thực hiện

- Thêm cột `XEPLOAI`:

```sql
ALTER TABLE DETAI_DIEM
ADD XEPLOAI NVARCHAR(20);
```

- Khai báo biến

```sql
DECLARE @MSDT CHAR(6);
DECLARE @DIEMTB FLOAT;
DECLARE @XEPLOAI NVARCHAR(20);
```

- Khai báo Cursor, lấy mã đề tài và điểm trung bình:

```sql
DECLARE CUR_XEPLOAI CURSOR FOR
    SELECT MSDT, DIEMTB
    FROM DETAI_DIEM;
```

- Cấu hình Cursor:

```sql
-- Mở Cursor
OPEN CUR_XEPLOAI;
FETCH NEXT FROM CUR_XEPLOAI INTO @MSDT, @DIEMTB;

WHILE @@FETCH_STATUS = 0
BEGIN
    IF @DIEMTB >= 9 AND @DIEMTB <= 10
        SET @XEPLOAI = N'Xuất sắc';
    ELSE IF @DIEMTB >= 8
        SET @XEPLOAI = N'Giỏi';
    ELSE IF @DIEMTB >= 7
        SET @XEPLOAI = N'Khá';
    ELSE IF @DIEMTB >= 6
        SET @XEPLOAI = N'Trung bình khá';
    ELSE IF @DIEMTB >= 5
        SET @XEPLOAI = N'Trung bình';
    ELSE IF @DIEMTB >= 4
        SET @XEPLOAI = N'Yếu';
    ELSE
        SET @XEPLOAI = N'Kém';

    UPDATE DETAI_DIEM
    SET XEPLOAI = @XEPLOAI
    WHERE MSDT = @MSDT;

    FETCH NEXT FROM CUR_XEPLOAI INTO @MSDT, @DIEMTB;
END
-- Đóng Cursor sau khi duyệt xong dữ liệu
CLOSE CUR_XEPLOAI;
-- Hủy Cursor sau khi hoàn thành
DEALLOCATE CUR_XEPLOAI;
```

- Kiểm tra bảng `DETAI_DIEM`:

```sql
SELECT * FROM DETAI_DIEM;
```

| MSDT  | DIEMTB | XEPLOAI |
| :---: | ------ | ------- |
| 97001 | 8      | Giỏi    |
| 97002 | 8.2    | Giỏi    |
| 97003 | 7.5    | Khá     |
| 97004 | 8      | Giỏi    |
| 97005 | 8.2    | Giỏi    |
| 97006 | 8.33   | Giỏi    |
