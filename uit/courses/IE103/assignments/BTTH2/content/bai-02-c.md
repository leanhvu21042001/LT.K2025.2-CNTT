## C. TRIGGER

### Trigger khi Xóa Đề Tài

- Tạo Trigger thỏa mãn điều kiện khi xóa một đề tài (MSDT) sẽ xóa các thông tin liên quan.

Tham khảo: [INSTEAD OF](https://learn.microsoft.com/en-us/sql/t-sql/statements/create-trigger-transact-sql?view=sql-server-ver17#instead-of).

#### Trigger

- Xóa trigger đã tạo trước đó nếu đây là lần chạy thứ 2 trở lên. Đảm bảo luôn có duy nhất 1 trigger được tạo và mới nhất.

```sql
IF OBJECT_ID('BTTH2_TRG_XoaDeTai', 'TR') IS NOT NULL
    DROP TRIGGER BTTH2_TRG_XoaDeTai;
GO
```

- Tạo Trigger mới trên `DETAI`. DÙNG INSTEAD OF cho mục đích này.

```sql
CREATE TRIGGER BTTH2_TRG_XoaDeTai ON DETAI
INSTEAD OF DELETE
AS
BEGIN
    -- Xóa dữ liệu tham chiếu ở các bảng con dựa trên MSDT
    DELETE FROM SV_DETAI
    WHERE MSDT IN (SELECT MSDT FROM DELETED);

    DELETE FROM GV_HDDT
    WHERE MSDT IN (SELECT MSDT FROM DELETED);

    DELETE FROM GV_PBDT
    WHERE MSDT IN (SELECT MSDT FROM DELETED);

    DELETE FROM GV_UVDT
    WHERE MSDT IN (SELECT MSDT FROM DELETED);

    DELETE FROM HOIDONG_DT
    WHERE MSDT IN (SELECT MSDT FROM DELETED);

    -- Xóa chính đề tài đó trong bảng DETAI
    DELETE FROM DETAI
    WHERE MSDT IN (SELECT MSDT FROM DELETED);

    PRINT N'Thực thi BTTH2_TRG_XoaDeTai: Đã xóa đề tài và các dữ liệu liên quan.';
END;
GO
```

#### Ví dụ

```sql
-- Ví dụ: Xóa đề tài '97001' (Quản lý thư viện)
DELETE FROM DETAI WHERE MSDT = '97001';

-- Sau khi chạy, bạn có thể select lại để kiểm tra xem nó còn tồn tại không
SELECT * FROM DETAI;
SELECT * FROM SV_DETAI;
```

- MSDT 97001 không còn tồn tại trong DETAI:

```
MSDT    TENDT
97002   Nhận dạng vân tay
97003   Bán đấu giá trên mạng
97004   Quản lý siêu thị
97005   Xử lý ảnh
97006   Hệ giải toán thông minh
```

- MSDT 97001 không còn tồn tại trong SV_DETAI:

```
    MSSV    MSDT
13520001    97004
13520002    97005
13520004    97002
13520005    97003
13520006    97005
```

### Trigger thay đổi MSGV

- Tạo Trigger thỏa mãn ràng buộc là khi đổi 1 mã số giáo viên (`MSGV`) thì sẽ thay đổi các thông tin liên quan.

#### Trigger

- Xóa trigger đã tạo trước đó nếu đây là lần chạy thứ 2 trở lên. Đảm bảo luôn có duy nhất 1 trigger được tạo và mới nhất.

```sql
IF OBJECT_ID('BTTH2_TRG_CapNhatMSGV', 'TR') IS NOT NULL
    DROP TRIGGER BTTH2_TRG_CapNhatMSGV;
GO
```

- Tạo Trigger mới trên `GIAOVIEN` sử dụng cả INSERTED và DELETED để lưu trữ dữ liệu mới/cũ tương ứng.

```sql
CREATE TRIGGER BTTH2_TRG_CapNhatMSGV ON GIAOVIEN
INSTEAD OF UPDATE
AS
BEGIN
    -- Khai báo biến để giữ giá trị cũ và mới
    DECLARE @OldMSGV INT;
    DECLARE @NewMSGV INT;

    -- Lấy MSGV cũ từ bảng DELETED (dữ liệu trước khi update)
    SELECT @OldMSGV = MSGV FROM DELETED;

    -- Lấy MSGV mới từ bảng INSERTED (dữ liệu người dùng muốn update)
    SELECT @NewMSGV = MSGV FROM INSERTED;

    -- Kiểm tra: Nếu người dùng có sửa MSGV (Khóa chính)
    IF (@OldMSGV <> @NewMSGV)
    BEGIN
        -- 1. Thêm dòng giáo viên mới với thông tin từ bảng INSERTED
        INSERT INTO GIAOVIEN (MSGV, TENGV, DIACHI, SODT, MSHH, NAMHH)
        SELECT MSGV, TENGV, DIACHI, SODT, MSHH, NAMHH
        FROM INSERTED;

        -- 2. Cập nhật các bảng con đang giữ MSGV cũ thành MSGV mới
        UPDATE GV_HV_CN SET MSGV = @NewMSGV WHERE MSGV = @OldMSGV;
        UPDATE GV_HDDT  SET MSGV = @NewMSGV WHERE MSGV = @OldMSGV;
        UPDATE GV_PBDT  SET MSGV = @NewMSGV WHERE MSGV = @OldMSGV;
        UPDATE GV_UVDT  SET MSGV = @NewMSGV WHERE MSGV = @OldMSGV;
        UPDATE HOIDONG  SET MSGV = @NewMSGV WHERE MSGV = @OldMSGV;
        UPDATE HOIDONG_GV SET MSGV = @NewMSGV WHERE MSGV = @OldMSGV;

        -- 3. Xóa dòng giáo viên cũ (dựa trên bảng DELETED)
        DELETE FROM GIAOVIEN WHERE MSGV = @OldMSGV;
    END
    ELSE
    -- Trường hợp: Người dùng chỉ sửa tên, địa chỉ... (không sửa Khóa chính)
    BEGIN
        UPDATE GIAOVIEN
        SET TENGV = I.TENGV,
            DIACHI = I.DIACHI,
            SODT = I.SODT,
            MSHH = I.MSHH,
            NAMHH = I.NAMHH
        FROM GIAOVIEN G
        JOIN INSERTED I ON G.MSGV = I.MSGV;
    END
END;
GO
```

#### Ví dụ

- Kiểm tra trước khi đổi (xem bảng GV_HDDT của 202)

```sql
SELECT * FROM GIAOVIEN WHERE MSGV = 202;
SELECT * FROM GV_HDDT WHERE MSGV = 202;
-- Quên không copy kết quả ở lần chạy đầu
```

- Thực hiện đổi ID

```sql
UPDATE GIAOVIEN
SET MSGV = 2020
WHERE MSGV = 202;
```

- Kiểm tra lại: 202 sẽ mất, thay bằng 2020, dữ liệu con cũng đổi theo.

```sql
SELECT * FROM GIAOVIEN WHERE MSGV = 202;
-- Trả về 0 kết quả
```

- Kiểm tra xem 2020 đã xuất hiện và thông tin liên quan đã chuyển qua.

```sql
SELECT * FROM GIAOVIEN WHERE MSGV = 2020;
```

```
MSGV    TENGV           MSHH
201     Trần Trung      1
203     Trần Thu Trang  1
204     Nguyễn Thị Loan 2
205     Chu Tiến        2
2020    Nguyễn Văn An   1
```

```sql
SELECT * FROM GV_HDDT WHERE MSGV = 2020;
```

```
MSGV    MSDT    DIEM
203     97005   9
204     97004   7
2020    97002   7
```

### Trigger Hội Đồng và Số Lượng Đề Tài

- Tạo Trigger thỏa mãn ràng buộc là một hội đồng không quá 10 đề tài.
- Dùng "Group by" có được không? Giải thích.

#### Trigger

- Xóa trigger đang tồn tại nếu có (ở các lần chạy thứ 2 trở đi).

```sql
IF OBJECT_ID('BTTH2_TRG_KiemTraSoLuongDeTai', 'TR') IS NOT NULL
    DROP TRIGGER BTTH2_TRG_KiemTraSoLuongDeTai;
GO
```

- Tạo Trigger kiểm tra ràng buộc số lượng Đề Tài
    - Sử dụng `FOR` (`AFTER`).
    - Kiểm tra xem có hội đồng nào vi phạm quy định (> 10 đề tài) hay không.
    - Logic: Chỉ cần kiểm tra các `MSHD` vừa bị tác động (có trong bảng `INSERTED`).
    - Nếu tìm thấy hội đồng nào có > 10 đề tài, hủy bỏ thao tác (`INSERT`/`UPDATE`) và báo lỗi.

```sql
CREATE TRIGGER BTTH2_TRG_KiemTraSoLuongDeTai
ON HOIDONG_DT
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT HOIDONG_DT.MSHD
        FROM HOIDONG_DT
        JOIN INSERTED ON HOIDONG_DT.MSHD = INSERTED.MSHD
        GROUP BY HOIDONG_DT.MSHD
        HAVING COUNT(HOIDONG_DT.MSHD) > 10
    )
    BEGIN
        RAISERROR(N'Lỗi: Quá 10 đề tài trên Hội Đồng.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO
```

#### Giải Thích

- CÓ thể dùng `GROUP BY`. Rất cần thiết cho chức năng đếm số lượng/lần xuất hiện giá trị của một trường cụ thể.
- VÌ:
    - Thống kê: Ràng buộc yêu cầu đếm số lượng đề tài trên mỗi hội đồng.
        - Trong mô hình quan hệ, bảng `HOIDONG_DT` chứa các dòng riêng lẻ (`MSHD`, `MSDT`).
        - Để biết một `MSHD` xuất hiện bao nhiêu lần (tương ứng với số lượng đề tài), ta gom nhóm các dòng có cùng `MSHD` lại với mệnh đề `GROUP BY`.
    - Kết hợp với `HAVING`: Sau khi `GROUP BY MSHD`, ta dùng hàm gộp `COUNT(MSDT)` để đếm và mệnh đề `HAVING` để lọc ra những nhóm vi phạm điều kiện (`> 10`).

#### Ví Dụ

- Thêm số lượng đề tài trước khi kiểm thử: với các đề tài bổ sung, và một hội đồng giả định.

```sql
INSERT INTO DETAI (MSDT, TENDT)
VALUES
('T01', 'Test 1'),
('T02', 'Test 2'),
('T03', 'Test 3'),
('T04', 'Test 4'),
('T05', 'Test 5'),
('T06', 'Test 6');
```

```sql
INSERT INTO HOIDONG (MSHD, PHONG, TGBD, NGAYHD, TINHTRANG, MSGV)
VALUES (99, 101, '07:00', '2024-01-01', N'Test', 201);
```

- Thêm 10 đề tài vào hội đồng giả định này, khiến số lượng đang ở `= 10`.

```sql
INSERT INTO HOIDONG_DT (MSHD, MSDT, QUYETDINH) VALUES
(99, '97002', N'Được'),
(99, '97003', N'Được'),
(99, '97004', N'Được'),
(99, '97005', N'Được'),
(99, '97006', N'Được'),
(99, 'T01', N'Được'),
(99, 'T02', N'Được'),
(99, 'T03', N'Được'),
(99, 'T04', N'Được'),
(99, 'T05', N'Được');
```

```
MSHD    MSDT    QUYETDINH
99      97002   Được
99      97003   Được
99      97004   Được
99      97005   Được
99      97006   Được
99      T01     Được
99      T02     Được
99      T03     Được
99      T04     Được
99      T05     Được
```

- Kiểm tra số lượng hiện tại

```sql
SELECT MSHD, COUNT(MSDT) as SoLuong FROM HOIDONG_DT WHERE MSHD = 99 GROUP BY MSHD;
```

```
MSHD    SoLuong
99      10
```

- Kiểm thử: Thêm đề tài T06 vào hội đồng giả định này, khiến điều kiện trở thành `> 10`.

```sql
INSERT INTO HOIDONG_DT (MSHD, MSDT, QUYETDINH) VALUES (99, 'T06', N'Được');
```

- Gặp lỗi: Quá số lượng 10, không cho phép hoàn thành.

```sql
Msg 50000, Level 16, State 1, Procedure BTTH2_TRG_KiemTraSoLuongDeTai, Line 16
Lỗi: Quá 10 đề tài trên Hội Đồng.
```

### Trigger Đề Tài và Số Lượng Sinh Viên

- Tạo Trigger thỏa mãn ràng buộc là một đề tài không quá 2 sinh viên.
- Dùng "Group by" có được không? Giải thích.

#### Trigger

- Xóa trigger đang tồn tại nếu có (ở các lần chạy thứ 2 trở đi).

```sql
IF OBJECT_ID('BTTH2_TRG_KiemTraSoLuongSinhVien', 'TR') IS NOT NULL
    DROP TRIGGER BTTH2_TRG_KiemTraSoLuongSinhVien;
GO
```

- Tạo Trigger kiểm tra ràng buộc số lượng Sinh Viên thực hiện Đề Tài.
    - Sử dụng `FOR INSERT`/`FOR UPDATE` (tương đương `AFTER`).
    - Kiểm tra xem có đề tài nào vừa bị tác động mà số lượng sinh viên tham gia vượt quá 2 hay không.

```sql
CREATE TRIGGER BTTH2_TRG_KiemTraSoLuongSinhVien
ON SV_DETAI
FOR INSERT, UPDATE
AS 
BEGIN
    IF EXISTS (
        SELECT SV_DETAI.MSDT
        FROM SV_DETAI
        JOIN INSERTED ON SV_DETAI.MSDT = INSERTED.MSDT
        GROUP BY SV_DETAI.MSDT
        HAVING COUNT(SV_DETAI.MSSV) > 2
    )
    BEGIN
        RAISERROR(N'Lỗi: Một đề tài không được quá 2 sinh viên thực hiện.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO
```


#### Giải Thích

- CÓ thể dùng `GROUP BY`. Đây là mệnh đề bắt buộc để thực hiện yêu cầu này.
- VÌ:
    - Mục đích thống kê: Chúng ta cần đếm số lượng sinh viên (`MSSV`) thuộc về từng đề tài (`MSDT`) riêng biệt.
    - Cơ chế hoạt động: Trong bảng `SV_DETAI`, dữ liệu được lưu dưới dạng từng dòng chi tiết (Mỗi dòng là một sinh viên đăng ký một đề tài).
    - Kết hợp `HAVING`: Mệnh đề `GROUP BY SV_DETAI.MSDT` sẽ gom tất cả các dòng có cùng mã đề tài lại thành một nhóm. Sau đó, hàm `COUNT(SV_DETAI.MSSV)` sẽ đếm số thành viên trong nhóm đó. Cuối cùng, `HAVING` sẽ lọc ra nhóm nào có kết quả đếm `> 2` để Trigger xử lý báo lỗi.

#### Ví Dụ

- Chuẩn bị dữ liệu kiểm thử
    - Tạo một đề tài kiểm thử mới mã 99999.
    - Chúng ta đang có sẵn 3 sinh viên để thực hiện việc thêm vào đề tài này.

```sql
IF NOT EXISTS (SELECT * FROM DETAI WHERE MSDT = '99999')
INSERT INTO DETAI (MSDT, TENDT) VALUES ('99999', N'Đề tài kiểm thử Trigger SV');
GO
```

- Thêm 2 sinh viên vào đề tài (Hợp lệ)

```sql
-- Xóa dữ liệu cũ của đề tài 99999 trong bảng SV_DETAI nếu có để test lại từ đầu
DELETE FROM SV_DETAI WHERE MSDT = '99999';
GO

-- Thêm sinh viên thứ 1
INSERT INTO SV_DETAI (MSSV, MSDT) VALUES ('13520001', '99999');
GO

-- Thêm sinh viên thứ 2
INSERT INTO SV_DETAI (MSSV, MSDT) VALUES ('13520002', '99999');
GO
```

- Kiểm tra số lượng hiện tại:

```sql
SELECT MSDT, COUNT(MSSV) AS SoLuongSV 
FROM SV_DETAI 
WHERE MSDT = '99999' 
GROUP BY MSDT;
GO
```

```
MSDT    SoLuongSV
99999   2
```

- Thêm sinh viên thứ 3 (Vi phạm ràng buộc)

```sql
INSERT INTO SV_DETAI (MSSV, MSDT) VALUES ('13520003', '99999');
GO
```

- Hệ thống báo lỗi và hủy thao tác.

```sql
Msg 50000, Level 16, State 1, Procedure BTTH2_TRG_KiemTraSoLuongSinhVien, Line 15
Lỗi: Một đề tài không được quá 2 sinh viên thực hiện.
Msg 3609, Level 16, State 1, Line 46
The transaction ended in the trigger. The batch has been aborted.
```

### Trigger Giáo Viên và Học Hàm

- **Yêu cầu:** Tạo Trigger thỏa mãn ràng buộc là một giáo viên muốn có học hàm Phó Giáo Sư (PGS) thì bắt buộc phải có học vị Tiến sĩ.

#### Trigger

- Xóa trigger cũ nếu tồn tại.

```sql
IF OBJECT_ID('BTTH2_TRG_KiemTraHocHamGiaoVien', 'TR') IS NOT NULL
    DROP TRIGGER BTTH2_TRG_KiemTraHocHamGiaoVien;
GO
```

- Tạo Trigger trên bảng `GIAOVIEN`.
- **Sự kiện:** `INSERT`, `UPDATE` (Kiểm tra khi thêm mới hoặc khi sửa học hàm).
- **Logic:**
    - Lọc ra danh sách các Giáo viên trong bảng `INSERTED` đang được gán học hàm là 'PHÓ GIÁO SƯ'.
    - Với mỗi giáo viên đó, kiểm tra trong bảng `GV_HV_CN` (Giáo viên - Học vị - Chuyên Ngành) xem họ có sở hữu học vị 'Tiến sĩ' (hoặc 'Tiến sĩ Khoa học') hay không.
    - Nếu không tìm thấy học vị Tiến sĩ, hệ thống sẽ báo lỗi và hủy thao tác.

```sql
CREATE TRIGGER BTTH2_TRG_KiemTraHocHamGiaoVien
ON GIAOVIEN
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT INSERTED.MSGV
        FROM INSERTED
        JOIN HOCHAM ON INSERTED.MSHH = HOCHAM.MSHH
        WHERE HOCHAM.TENHH = N'PHÓ GIÁO SƯ'
        AND NOT EXISTS (
            SELECT 1
            FROM GV_HV_CN
            JOIN HOCVI ON GV_HV_CN.MSHV = HOCVI.MSHV
            WHERE GV_HV_CN.MSGV = INSERTED.MSGV
            AND (HOCVI.TENHV = N'Tiến sĩ' OR HOCVI.TENHV = N'Tiến sĩ Khoa học')
        )
    )
    BEGIN
        RAISERROR(N'Lỗi: Giáo viên muốn được phong Phó Giáo Sư phải có học vị Tiến sĩ.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO
```

#### Ví Dụ

Để kiểm thử logic này một cách thực tế, chúng ta cần một trạng thái trung gian (Giáo viên chưa có học hàm) để thêm bằng cấp trước khi phong hàm.

- Chuẩn bị dữ liệu
    - Thêm một loại học hàm tạm thời là "Chưa có" (Mã 0) vào bảng `HOCHAM` để có thể tạo giáo viên ban đầu.
    - Tạo một giáo viên kiểm thử (Mã 901) với học hàm "Chưa có".

```sql
IF NOT EXISTS (SELECT * FROM HOCHAM WHERE MSHH = 0)
    INSERT INTO HOCHAM (MSHH, TENHH) VALUES (0, N'Chưa có');
GO

IF NOT EXISTS (SELECT * FROM GIAOVIEN WHERE MSGV = 901)
    INSERT INTO GIAOVIEN (MSGV, TENGV, DIACHI, SODT, MSHH, NAMHH)
    VALUES (901, N'Nguyễn Văn Test', N'TP.HCM', '0909090909', 0, '2024');
GO
```

- Gán học vị Cử nhân và cố gắng phong hàm PGS (Vi phạm)
    - Giáo viên 901 chỉ mới có bằng Cử nhân.
    - Thực hiện cập nhật `MSHH` lên mức 'PHÓ GIÁO SƯ' (Mã 1 - Theo dữ liệu bài 1).

```sql
INSERT INTO GV_HV_CN (MSGV, MSHV, MSCN, NAM) VALUES (901, 2, 1, '2010');
GO

-- Cố gắng cập nhật lên Phó Giáo Sư (Mã 1)
UPDATE GIAOVIEN SET MSHH = 1 WHERE MSGV = 901;
GO
```

- Hệ thống báo lỗi.

```sql
Msg 50000, Level 16, State 1, Procedure BTTH2_TRG_KiemTraHocHamGiaoVien, Line 23
Lỗi: Giáo viên muốn được phong Phó Giáo Sư phải có học vị Tiến sĩ.
Msg 3609, Level 16, State 1, Procedure BTTH2_TRG_CapNhatMSGV, Line 40
The transaction ended in the trigger. The batch has been aborted.
```

- Bổ sung học vị Tiến sĩ và phong hàm lại (Hợp lệ)

```sql
-- Bổ sung bằng Tiến sĩ (Mã 4) cho GV 901
INSERT INTO GV_HV_CN (MSGV, MSHV, MSCN, NAM) VALUES (901, 4, 1, '2015');
GO

-- Cập nhật lại lên Phó Giáo Sư (Mã 1)
UPDATE GIAOVIEN SET MSHH = 1 WHERE MSGV = 901;
GO
```

- Cập nhật thành công. Kiểm tra lại dữ liệu.

```sql
SELECT GV.MSGV, GV.TENGV, HH.TENHH 
FROM GIAOVIEN GV 
JOIN HOCHAM HH ON GV.MSHH = HH.MSHH 
WHERE GV.MSGV = 901;

```

```
MSGV    TENGV               TENHH
901     Nguyễn Văn Test     PHÓ GIÁO SƯ
```
