## A. STORED PROCEDURES VỚI THAM SỐ VÀO

### Kiểm Tra `MSHH` Trong Table `HOCHAM`

- Tham số vào là `MSGV`, `TENGV`, `SODT`, `DIACHI`, `MSHH`, `NAMHH`.
- Trước khi insert dữ liệu cần kiểm tra `MSHH` đã tồn tại trong table `HOCHAM` chưa
    - Nếu chưa thì trả về giá trị `0`.

```sql
CREATE PROC SP_INS_GV_KT_MSHH
    @MSGV INT,
    @TENGV NVARCHAR(30),
    @SODT VARCHAR(10),
    @DIACHI NVARCHAR(50),
    @MSHH INT,
    @NAMHH SMALLDATETIME
AS
BEGIN
    IF NOT EXISTS (SELECT MSHH FROM HOCHAM WHERE MSHH = @MSHH)
        RETURN 0
    INSERT INTO GIAOVIEN VALUES (@MSGV, @TENGV, @DIACHI, @SODT, @MSHH, @NAMHH)
    RETURN 1
END;
```

### Kiểm Tra `MSGV` Trong Table `GIAOVIEN`

- Tham số vào là `MSGV`, `TENGV`, `SODT`, `DIACHI`, `MSHH`, `NAMHH`.
- Trước khi insert dữ liệu cần kiểm tra `MSGV` trong table `GIAOVIEN` có trùng không
    - Nếu trùng thì trả về giá trị `0`.

```sql
CREATE PROC SP_INS_GV_KT_MSGV
    @MSGV INT,
    @TENGV NVARCHAR(30),
    @SODT VARCHAR(10),
    @DIACHI NVARCHAR(50),
    @MSHH INT,
    @NAMHH SMALLDATETIME
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM GIAOVIEN
        WHERE MSGV = @MSGV
    )
    BEGIN
        RETURN 0; -- MSGV đã tồn tại
    END
    INSERT INTO GIAOVIEN VALUES (@MSGV, @TENGV, @DIACHI, @SODT, @MSHH, @NAMHH)
    RETURN 1
END;
```

### Kiểm Tra `MSGV` và `MSHH`

- Giống [@kiem-tra-mshh-trong-table-hocham Mục] và [@kiem-tra-msgv-trong-table-giaovien Mục], kiểm tra xem `MSGV` có trùng không? `MSHH` có tồn tại chưa?
    - Nếu `MSGV` trùng thì trả về `0`.
    - Nếu `MSHH` chưa tồn tại trả về `1`.
    - Ngược lại cho `INSERT` dữ liệu

```sql
CREATE PROC SP_INS_GV_KT_MSHH_MSGV
    @MSGV INT,
    @TENGV NVARCHAR(30),
    @SODT VARCHAR(10),
    @DIACHI NVARCHAR(50),
    @MSHH INT,
    @NAMHH SMALLDATETIME
AS
BEGIN
    IF NOT EXISTS (SELECT MSHH FROM HOCHAM WHERE MSHH = @MSHH)
    BEGIN
        RETURN 1; -- Nếu MSHH chưa tồn tại trả về 1
    END
    IF EXISTS (SELECT 1 FROM GIAOVIEN WHERE MSGV = @MSGV)
    BEGIN
        RETURN 0; -- Nếu MSGV trùng thì trả về 0
    END
    INSERT INTO GIAOVIEN VALUES (@MSGV, @TENGV, @DIACHI, @SODT, @MSHH, @NAMHH)
END;
```

### Thao Tác với `MSDT` và `TENDT`

- Đưa vào `MSDT` cũ, `TENDT` mới.
- Hãy cập nhật tên đề tài mới với mã đề tài cũ không đổi.
    - Nếu không tìm thấy, trả về `0`.
    - Ngược lại cập nhật và trả về `1`.

```sql
CREATE PROC SP_UPD_DETAI_KT_MSDT
    @MSDT char(6),
    @TENDT NVARCHAR(30)
AS
BEGIN
    IF NOT EXISTS (SELECT MSDT FROM DETAI WHERE MSDT = @MSDT)
    BEGIN
        RETURN 0; -- Nếu MSHH chưa tồn tại trả về 0
    END

    UPDATE DETAI
    SET TENDT = @TENDT
    WHERE MSDT = @MSDT
    RETURN 1
END;
```

### Thao Tác với `MSSV`, `TENSV`, `DIACHI`

- Tham số đưa vào `MSSV`, `TENSV` mới, `DIACHI` mới.
- Hãy cập nhật sinh viên trên với `MSSV` không đổi.
    - Nếu không tìm thấy, trả về `0`.
    - Ngược lại cập nhật và trả về `1`.

```sql
CREATE PROC SP_UPD_SINHVIEN_KT_MSSV
    @MSSV char(8), 
    @TENSV NVARCHAR(30),
    @DIACHI nvarchar(50)
AS
BEGIN
    IF NOT EXISTS (SELECT MSSV FROM SINHVIEN WHERE MSSV = @MSSV)
    BEGIN
        RETURN 0; -- Nếu không tìm thấy trả về 0,
    END

    UPDATE SINHVIEN
    SET TENSV = @TENSV, DIACHI = @DIACHI
    WHERE MSSV = @MSSV
    RETURN 1
END;
```
