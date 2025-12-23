## B. STORED PROCEDURES VỚI THAM SỐ VÀO VÀ RA

### Đưa vào `TENHV` trả ra GV

Trả ra:

- Số GV thỏa học vị
- Nếu không tìm thấy trả về 0

```sql
-- Tạo Stored Procedure
Create procedure sp_CountGVTheoHocVi
    @TenHV NVARCHAR(20),
    @SOGV INT OUTPUT
AS
    BEGIN
        SET @SOGV = 0;

        DECLARE @MSHV_HOCVI INT;
        SELECT @MSHV_HOCVI = MSHV
        FROM HOCVI
        WHERE TENHV = @TenHV;

        IF @MSHV_HOCVI IS NOT NULL
        BEGIN
            SELECT @SOGV = COUNT(DISTINCT MSGV)
            FROM GV_HV_CN
            WHERE MSHV = @MSHV_HOCVI;
        end;
    end;
GO
```

#### Ví dụ 1: Học Vị Thạc Sĩ

- Học Vị = Thạc Sĩ

```sql
DECLARE @KETQUA INT;
EXEC sp_CountGVTheoHocVi N'Thạc sĩ', @KETQUA output ;
SELECT N'Số GV Thạc sĩ: ' AS KetQua, @KETQUA AS SoLuong;
```

|KetQua|SoLuong|
|---|:-:|
|Số GV Thạc sĩ: |2|

#### Ví dụ 2: Học Vị Tiến Sĩ

- Học vị = Tiến Sĩ (Không tồn tại)

```sql
DECLARE @KETQUA INT;
EXEC sp_CountGVTheoHocVi N'Tiến sĩ', @KETQUA output ;
SELECT N'Số GV Tiến sĩ: ' AS KetQua, @KETQUA AS SoLuong;
```

|KetQua|SoLuong|
|---|:-:|
|Số GV Tiến sĩ: |0|

### Đưa vào `MSDT` trả về Điểm Trung Bình của Đề Tài

Đưa vào:

- `MSDT`

Cho biết:

- Điểm trung bình của đề tài.
  - Nếu không tìm thấy trả về `0`.


```sql
CREATE PROCEDURE SP_DiemTBDeTai
    @MSDT CHAR(6),
    @DIEMTRUNGBINH FLOAT OUTPUT
AS
BEGIN
    SET @DIEMTRUNGBINH = 0;

    SELECT @DIEMTRUNGBINH = AVG(DIEM)
    FROM (
        SELECT DIEM FROM GV_HDDT WHERE MSDT = @MSDT
        UNION ALL
        SELECT DIEM FROM GV_PBDT WHERE MSDT = @MSDT
        UNION ALL
        SELECT DIEM FROM GV_UVDT WHERE MSDT = @MSDT
    ) AS ALLDIEM;

    IF @DIEMTRUNGBINH IS NULL
    BEGIN
        SET @DIEMTRUNGBINH = 0;
    END
END
GO
```

#### Ví dụ 1: Đề tài `97001`

```sql
DECLARE @KETQUA FLOAT;
EXEC SP_DiemTBDeTai '97001', @KETQUA output ;
SELECT 'Diem TB De Tai 97001 ' AS KETQUA, @KETQUA AS DiemTB;
```

| KETQUA               | DiemTB |
| -------------------- | :----: |
| Diem TB De Tai 97001 |   8    |

#### Ví dụ 2: 97007

- Đề tài không có điểm: `97007`

```sql
DECLARE @KETQUA FLOAT;
EXEC sp_DiemTBDeTai '97007', @KETQUA OUTPUT;
SELECT 'Diem TB De Tai 97007 ' AS KetQua, @KETQUA AS DiemTB;
```

|KETQUA|DiemTB|
|---|:-:|
|Diem TB De Tai 97007 |0|

### Đưa vào `TENGV` trả ra SDT của GV

Đưa vào TENGV trả ra:

- `SDT` của giáo viên đó.
- Nếu không tìm thấy trả về `0`.
- Nếu trùng tên thì có báo lỗi không?
  - Tại sao?
- Làm sao để hiện thông báo có bao nhiêu giáo viên trùng tên và trả về các SDT?

Giải đáp:

- Nếu trùng tên thì sẽ không báo lỗi.
  - Nguyên nhân là nếu trùng tên thì đồng nghĩa với việc đang có nhiều records (bản ghi) có column là `TENGV` đang giống nhau.
  - Về mặt câu lệnh SQL, có thể như sau: ```sql SELECT * FROM GIAOVIEN WHERE TENGV = %NAME```.
  - Kết quả trả về của câu lệnh SQL này có khả năng sẽ là `0`, `1` hoặc nhiều records.
  - Nếu đề cập tới việc xảy ra lỗi ở đây thì có khả năng liên quan tới việc dữ liệu có khả năng bị sai lệch do sẽ không biết được sẽ lấy số điện thoại của record nào để trả về.
- Đáp ứng yêu cầu hiện thông báo có bao nhiêu giáo viên trùng tên và trả về các SDT, ta có thể làm như sau:

```sql
CREATE PROCEDURE sp_TimGVTheoTen @TENGV NVARCHAR(30),
                                 @SOLUONGGV INT OUTPUT,
                                 @DS_SDT VARCHAR(100) OUTPUT
AS
BEGIN
    SET @DS_SDT = '';
    -- DEM SO LUONG GIAO VIEN TRUNG TEN
    SELECT @SOLUONGGV = COUNT(MSGV)
    FROM GIAOVIEN
    WHERE TENGV = @TENGV;
end
    -- KIEM TRA SO LUONG GIAO VIEN VA TRA VE THONG TIN TUONG UNG
    IF @SOLUONGGV > 0
        BEGIN
            SELECT @DS_SDT = STRING_AGG(SODT, ', ')
            FROM GIAOVIEN
            WHERE TENGV = @TENGV;
        end
    ELSE
        BEGIN
            SET @SOLUONGGV = 0;
            SET @DS_SDT = '';
        end;
GO
```

Dữ liệu bảng `GIAOVIEN` (Đã thêm một record Nguyễn Văn An, `MSGV`: `206`, `SODT`: `12434343`):

```sql
INSERT INTO GIAOVIEN (MSGV, TENGV, DIACHI, SODT, MSHH, NAMHH)
VALUES (206, N'Nguyễn Văn An', N'Cần Thơ', '12434343', 1, '2025');
```

Giá trị của bảng (không hiển thị cột `NAMHH` để tiết kiệm không gian):

| MSGV | TENGV           | DIACHI     | SODT     | MSHH |
| ---: | --------------- | ---------- | -------- | ---- |
|  201 | Trần Trung      | Bến Tre    | 35353535 | 1    |
|  202 | Nguyễn Văn An   | Tiền Giang | 67868688 | 1    |
|  203 | Trần Thu Trang  | Cần Thơ    | 74758687 | 1    |
|  204 | Nguyễn Thị Loan | TP. HCM    | 56575868 | 2    |
|  205 | Chu Tiến        | Hà Nội     | 46466646 | 2    |
|  206 | Nguyễn Văn An   | Cần Thơ    | 12434343 | 1    |

#### Ví dụ 1: Có trùng tên

- Trường hợp trùng tên: Nguyễn Văn An

```sql
DECLARE @SoLuong INT, @DS_SDT NVARCHAR(100);
EXEC sp_TimGVTheoTen N'Nguyễn Văn An', @SoLuong OUTPUT, @DS_SDT OUTPUT;
SELECT N'Tong so giao vien trung ten: ' AS ThongBao, @SoLuong AS SoLuong, @DS_SDT AS 'Danh sach so dien thoai';
```

- Kết quả: trả về 2 bản ghi có sự trùng lặp ở trường `TENGV`

|ThongBao|SoLuong|Danh sach so dien thoai|
|---|---|---|
|Tong so giao vien trung ten: |2|67868688, 12434343|

#### Ví dụ 2: Không trùng tên

- Trường hợp không trùng tên: Trần Trung

```sql
DECLARE @SoLuong INT, @DS_SDT NVARCHAR(100);
EXEC sp_TimGVTheoTen N'Trần Trung', @SoLuong OUTPUT, @DS_SDT OUTPUT;
SELECT N'Tong so giao vien trung ten: ' AS ThongBao, @SoLuong AS SoLuong, @DS_SDT AS 'Danh sach so dien thoai';
```

- Kết quả: trả về duy nhất 1 bản ghi do không tìm thấy sự trùng lặp ở trường `TENGV`

|ThongBao|SoLuong|Danh sach so dien thoai|
|---|---|---|
|Tong so giao vien trung ten: |1|35353535|

#### Ví dụ 3: Tên không tồn tại

- Trường hợp không tìm thấy: Lê Kim Long

```sql
DECLARE @SoLuong INT, @DS_SDT NVARCHAR(100);
EXEC sp_TimGVTheoTen N'Lê Kim Long', @SoLuong OUTPUT, @DS_SDT OUTPUT;
SELECT N'Tong so giao vien trung ten: ' AS ThongBao, @SoLuong AS SoLuong, @DS_SDT AS 'Danh sach so dien thoai';
```

- Kết quả: `0`, vì không tìm thấy `TENGV` phù hợp.

|ThongBao|SoLuong|Danh sach so dien thoai|
|---|---|---|
|Tong so giao vien trung ten: |0||

### Đưa vào `MSHD` cho biết Điểm Trung Bình

Cho biết:

- Điểm trung bình các đề tài của hội đồng đó.

```sql
CREATE PROCEDURE sp_DiemTBTheoHD @MSHD INT,
                                 @DIEM_TB FLOAT OUTPUT
AS
BEGIN
    SET @DIEM_TB = 0;
    SELECT @DIEM_TB = AVG(T2.DIEM) FROM HOIDONG_DT T1
    JOIN (
        SELECT MSDT, DIEM FROM GV_HDDT
        UNION ALL
        SELECT MSDT, DIEM FROM GV_PBDT
        UNION ALL
        SELECT MSDT, DIEM FROM GV_UVDT
    ) AS T2 ON T1.MSDT = T2.MSDT
    WHERE T1.MSHD = @MSHD
    GROUP BY T1.MSDT;
end;
GO
```

#### Ví dụ: Hội đồng 1

```sql
DECLARE @MSHD INT = 1, @DiemTB FLOAT;
EXEC sp_DiemTBTheoHD @MSHD, @DiemTB output;
SELECT @MSHD as 'Ma So Hoi Dong', @DiemTB as 'Diem Trung Binh'
```

| Ma So Hoi Dong | Diem Trung Binh |
| :------------: | :-------------: |
|       1        |       8.2       |

#### Ví dụ: Hội đồng 2

```sql
DECLARE @MSHD INT = 2, @DiemTB FLOAT;
EXEC sp_DiemTBTheoHD @MSHD, @DiemTB output;
SELECT @MSHD as 'Ma So Hoi Dong', @DiemTB as 'Diem Trung Binh'
```

| Ma So Hoi Dong | Diem Trung Binh |
| :------------: | :-------------: |
|       2        |        8        |

### Đưa vào `TENGV`

Đưa vào TENGV cho biết:

- Số đề tài hướng dẫn, số đề tài phản biện do giáo viên đó phụ trách.
- Nếu trùng tên thì có báo lỗi không hay hệ thống sẽ đếm tất cả các đề tài của những giáo viên trùng tên đó?

Giải đáp:

- Tương tự câu 3 ở trên, hệ thống sẽ không báo lỗi cú pháp SQL. Thay vào đó, hệ thống sẽ lấy được tất cả các records có cùng tên giáo viên đó.
- Xử lý Stored Procedure để trả về số lượng đề tài hướng dẫn và phản biện dựa theo tên giáo viên, ta có thể xử lý như sau (sử dụng THROW để thông báo lỗi):

```sql
CREATE PROCEDURE sp_ThongTinDeTaiGV @TENGV NVARCHAR(30),
                                    @SoDT_HD INT OUTPUT,
                                    @SoDT_PB INT OUTPUT
AS
BEGIN
    SET @SoDT_HD = 0;
    SET @SoDT_PB = 0;

    DECLARE @SoLuong_GV_TrungTen INT;
    SET @SoLuong_GV_TrungTen = 0;

    -- Kiểm tra danh sách giáo viên xem có trùng tên không
    SELECT @SoLuong_GV_TrungTen = Count(MSGV) FROM GIAOVIEN WHERE TENGV = @TENGV

    -- Nếu là 1: không trùng tên.
    -- Nếu là 2 trở lên: trùng tên -> Lỗi
    -- Nếu là 0: không tồn tại giáo viên có tên này
    IF @SoLuong_GV_TrungTen = 1
        BEGIN
            -- Lấy MSGV từ khi chỉ có 1 record duy nhất
            DECLARE  @MSGV INT;
            SELECT @MSGV = MSGV FROM GIAOVIEN WHERE TENGV = @TENGV

            -- Đếm số lượng đề tài hướng dẫn và phản biện
            SELECT @SoDT_HD = Count(MSDT) FROM GV_HDDT WHERE MSGV = @MSGV
            SELECT @SoDT_PB = COUNT(MSDT) FROM GV_PBDT WHERE MSGV = @MSGV
        end
    ELSE IF @SoLuong_GV_TrungTen >= 2
        BEGIN
            THROW 51000, N'Trùng tên giáo viên', 2;
        end
    ELSE
        BEGIN
            THROW 51000, N'Không tìm thấy giáo viên', 1;
        end
    end
GO
```

#### Dữ liệu đang có

- `GIAOVIEN`

```sql
SELECT TOP (100) [MSGV]
      ,[TENGV]
      ,[DIACHI]
      ,[SODT]
      ,[MSHH]
    --   ,[NAMHH]
  FROM [IE103-BTTH2].[dbo].[GIAOVIEN]
```

| MSGV | TENGV           | DIACHI     | SODT     | MSHH |
| :--: | :-------------- | ---------- | -------- | ---- |
| 201  | Trần Trung      | Bến Tre    | 35353535 | 1    |
| 202  | Nguyễn Văn An   | Tiền Giang | 67868688 | 1    |
| 203  | Trần Thu Trang  | Cần Thơ    | 74758687 | 1    |
| 204  | Nguyễn Thị Loan | TP. HCM    | 56575868 | 2    |
| 205  | Chu Tiến        | Hà Nội     | 46466646 | 2    |
| 206  | Nguyễn Văn An   | Cần Thơ    | 12434343 | 1    |

- `GV_HDDT`

|MSGV|MSDT|DIEM|
|:-:|:-:|:-:|
|201|97001 |8|
|202|97002 |7|
|203|97005 |9|
|204|97004 |7|
|205|97001 |9|

- `GV_PBDT`

|MSGV|MSDT|DIEM|
|:-:|:-:|:-:|
|201|97005 |8|
|202|97001 |7|
|203|97002 |9|
|204|97003 |7|
|205|97004 |9|

#### Ví dụ 1: không tìm thấy giáo viên

- `TENGV`: Lê Kim Long

```sql
DECLARE @SoDT_HD INT, @SoDT_PB INT
EXEC sp_ThongTinDeTaiGV N'Lê Kim Long', @SoDT_HD OUTPUT ,@SoDT_PB OUTPUT ;
SELECT
	@SoDT_HD AS N'Số lượng đề tài hướng dẫn',
	@SoDT_PB AS N'Số lượng đề tài phản biện';
```

- Kết quả: thông báo “Không tìm thấy giáo viên”.

```sql
Msg 51000, Level 16, State 1, Procedure sp_ThongTinDeTaiGV, Line 34
Không tìm thấy giáo viên
```

#### Ví dụ 2: trùng tên giáo viên

- `TENGV`: Nguyễn Văn An

```sql
DECLARE @SoDT_HD INT, @SoDT_PB INT
EXEC sp_ThongTinDeTaiGV N'Nguyễn Văn An', @SoDT_HD OUTPUT ,@SoDT_PB OUTPUT ;
SELECT
    @SoDT_HD AS N'Số lượng đề tài hướng dẫn',
    @SoDT_PB AS N'Số lượng đề tài phản biện';
```

- Kết quả: thông báo “Trùng tên giáo viên”.

```sql
Msg 51000, Level 16, State 2, Procedure sp_ThongTinDeTaiGV, Line 30
Trùng tên giáo viên
```

#### Ví dụ 3: tên giáo viên hợp lệ

- `TENGV`: Trần Trung

```sql
DECLARE @SoDT_HD INT, @SoDT_PB INT
EXEC sp_ThongTinDeTaiGV N'Trần Trung', @SoDT_HD OUTPUT ,@SoDT_PB OUTPUT ;
SELECT
	N'**Số lượng**' AS N'**Loại**',
	@SoDT_HD AS N'Đề tài hướng dẫn',
	@SoDT_PB AS N'Đề tài phản biện';
```

- Kết quả: trả về số lượng đề tài tương ứng hướng dẫn và phản biện.

|   **Loại**   | Đề t&#224;i hướng dẫn | Đề t&#224;i phản biện |
| :----------: | :-------------------: | :-------------------: |
| **Số lượng** |           1           |           1           |

