## D. FUNCTION

### Tính Điểm Trung Bình của Đề Tài từ `MSDT`

- Viết hàm tính điểm trung bình của một đề tài.
- Giá trị trả về là điểm trung bình ứng với mã số đề tài nhập vào.

```sql
IF OBJECT_ID('f_TinhDiemTB', 'FN') IS NOT NULL
    DROP FUNCTION f_TinhDiemTB;
GO

CREATE FUNCTION f_TinhDiemTB (@MSDT char(6))
RETURNS float
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM DETAI WHERE MSDT = @MSDT)
        RETURN 0;

    DECLARE @DiemTB float;

    SELECT @DiemTB = AVG(DIEM)
    FROM (
        SELECT DIEM FROM GV_HDDT WHERE MSDT = @MSDT
        UNION ALL
        SELECT DIEM FROM GV_PBDT WHERE MSDT = @MSDT
        UNION ALL
        SELECT DIEM FROM GV_UVDT WHERE MSDT = @MSDT
    ) AS TongHopDiem;

    RETURN ROUND(ISNULL(@DiemTB, 0), 3);
END;
GO
```

#### Ví dụ 1

- Tính điểm tất cả đề tài trong bảng `DETAI`.

```sql
SELECT
    MSDT,
    TENDT,
    dbo.f_TinhDiemTB(MSDT) AS DiemTrungBinh
FROM DETAI;
```

| MSDT  | TENDT                   | DiemTrungBinh |
| :---: | ----------------------- | ------------- |
| 97001 | Quản lý thư viện        | 8             |
| 97002 | Nhận dạng vân tay       | 8.2           |
| 97003 | Bán đấu giá trên mạng   | 7.5           |
| 97004 | Quản lý siêu thị        | 8             |
| 97005 | Xử lý ảnh               | 8.2           |
| 97006 | Hệ giải toán thông minh | 8.333         |

#### Ví dụ 2

- Tính điểm của 1 đề tài nhập vào cụ thể.

```sql
SELECT
    '97001' AS 'MSDT',
    dbo.f_TinhDiemTB('97001') AS DiemTrungBinh;
```

| MSDT  | DiemTrungBinh |
| :---: | ------------- |
| 97001 | 8             |

#### Ví dụ 3

- `MSDT` không tồn tại.

```sql
SELECT
    '99999' AS 'MSDT',
    dbo.f_TinhDiemTB('99999') AS DiemTrungBinh;
```

| MSDT  | DiemTrungBinh |
| :---: | ------------- |
| 99999 | 0             |

### Kết Quả của Đề Tài từ `MSDT`

- Trả về kết quả của đề tài theo `MSDT` nhập vào.
- Kết quả là `DAT` nếu như điểm trung bình từ `5` trở lên, và `KHONGDAT` nếu như điểm trung bình dưới `5`.

```sql
IF OBJECT_ID('f_KetQuaDeTai', 'FN') IS NOT NULL
    DROP FUNCTION f_KetQuaDeTai;
GO

CREATE FUNCTION f_KetQuaDeTai (@MSDT char(6))
RETURNS NVARCHAR(20)
AS
BEGIN
    DECLARE @DiemTB float;
    DECLARE @KetQua NVARCHAR(20);

    SET @DiemTB = dbo.f_TinhDiemTB(@MSDT);

    IF (@DiemTB >= 5)
        SET @KetQua = N'DAT';
    ELSE
        SET @KetQua = N'KHONGDAT';

    RETURN @KetQua;
END;
GO
```

#### Ví dụ 1

- Một đề tài cụ thể.

```sql
SELECT
    '97001' AS 'MSDT',
    dbo.f_KetQuaDeTai('97001') AS KetQuaDeTai;
```

| MSDT  | KetQuaDeTai |
| :---: | ----------- |
| 97001 | DAT         |

#### Ví dụ 2

- Đề tài không tồn tại (được xem là KHÔNG ĐẠT).

```sql
SELECT
    '99999' AS 'MSDT',
    dbo.f_KetQuaDeTai('99999') AS KetQuaDeTai;
```

| MSDT  | KetQuaDeTai |
| :---: | ----------- |
| 99999 | KHONGDAT    |

### Thông Tin Sinh Viên từ `MSDT`

- Đưa vào `MSDT`, trả về mã số và họ tên của các sinh viên thực hiện đề tài.

```sql
IF OBJECT_ID('f_DanhSachSVThucHienDeTai', 'IF') IS NOT NULL
    DROP FUNCTION f_DanhSachSVThucHienDeTai;
GO

CREATE FUNCTION f_DanhSachSVThucHienDeTai (@MSDT char(6))
RETURNS TABLE
AS
RETURN (
    SELECT
        SV.MSSV,
        SV.TENSV
    FROM SINHVIEN SV
    JOIN SV_DETAI SD ON SV.MSSV = SD.MSSV
    WHERE SD.MSDT = @MSDT
);
GO
```

#### Ví dụ 1

- `MSDT` cụ thể: 97001

```sql
SELECT * FROM dbo.f_DanhSachSVThucHienDeTai('97001');
```

|   MSSV   | TENSV          |
| :------: | -------------- |
| 13520003 | Nguyễn Anh Hải |

#### Ví dụ 2

- `MSDT` không tồn tại, có nghĩa không có sinh viên. Kết quả trống.

```sql
SELECT * FROM dbo.f_DanhSachSVThucHienDeTai('97006');
```

| MSSV | TENSV |
| :--: | ----- |
