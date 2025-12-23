## C. PHÂN QUYỀN NGƯỜI DÙNG

### Mô Tả Yêu Cầu

Thực hiện các phát biểu `GRANT` / `DENY` / `REVOKE` trên CSDL **Quản lý đề tài** gồm các bảng sau (Nhóm 2):

* T1: `DETAI`
* T2: `HOIDONG`
* T3: `GV_HDDT`

Tạo các user `U1`, `U2`, `U3` và phân quyền theo yêu cầu.

1. U1 có quyền select, delete trên T1, T3
2. U2 có quyền update, delete trên T2
3. U3 có quyền insert trên T1, T2, T3
4. U1 bị từ chối quyền insert trên T1, T2
5. U2 bị từ chối quyền delete trên T3
6. Thu hồi các quyền của U1 trên T1
7. Thu hồi các quyền của U3 trên T2

### Tạo User - Chuẩn Bị Môi Trường

```sql
CREATE USER U1 WITHOUT LOGIN;
CREATE USER U2 WITHOUT LOGIN;
CREATE USER U3 WITHOUT LOGIN;
```

- Kiểm tra kết quả:

```sql
SELECT name, type_desc FROM sys.database_principals 
WHERE name IN ('U1', 'U2', 'U3');
```

| name | type_desc |
| :--: | --------- |
|  U1  | SQL_USER  |
|  U2  | SQL_USER  |
|  U3  | SQL_USER  |

### GRANT - U1 có quyền SELECT, DELETE trên T1, T3

#### GRANT

```sql
GRANT SELECT, DELETE ON DETAI TO U1;
GRANT SELECT, DELETE ON GV_HDDT TO U1;
```

#### Kiểm tra

```sql
EXECUTE AS USER = 'U1';
SELECT * FROM DETAI;
REVERT;
```

| MSDT  | TENDT                   |
| :---: | :---------------------- |
| 97001 | Quản lý thư viện        |
| 97002 | Nhận dạng vân tay       |
| 97003 | Bán đấu giá trên mạng   |
| 97004 | Quản lý siêu thị        |
| 97005 | Xử lý ảnh               |
| 97006 | Hệ giải toán thông minh |

### GRANT - U2 có quyền UPDATE, DELETE trên T2

#### GRANT

```sql
GRANT UPDATE, DELETE ON HOIDONG TO U2;
```

#### Kiểm tra

- DELETE

```sql
EXECUTE AS USER = 'U2';
DELETE FROM HOIDONG WHERE 1 = '0';
REVERT;
GO
```

```sql
Commands completed successfully.
```

- UPDATE

```sql
EXECUTE AS USER = 'U2';
UPDATE HOIDONG SET PHONG = 6969;
REVERT;
```

| MSHD | PHONG | TINHTRANG | MSGV |
| :--: | ----- | --------- | ---- |
|  1   | 6969  | Thật      | 201  |
|  2   | 6969  | Thật      | 202  |
|  3   | 6969  | Thật      | 203  |

### GRANT - U3 có quyền INSERT trên T1, T2, T3

#### GRANT

```sql
GRANT INSERT ON DETAI TO U3;
GRANT INSERT ON HOIDONG TO U3;
GRANT INSERT ON GV_HDDT TO U3;
```

#### Kiểm tra

- INSERT trên `HOIDONG`

```sql
EXECUTE AS USER = 'U3';
INSERT INTO HOIDONG (MSHD, PHONG, TGBD, NGAYHD, TINHTRANG, MSGV) VALUES
(4, 2, '07:00', '2014-11-29', N'Thật', 201);
REVERT;
```

| MSHD | PHONG | TINHTRANG | MSGV |
| :--: | ----- | --------- | ---- |
|  1   | 6969  | Thật      | 201  |
|  2   | 6969  | Thật      | 202  |
|  3   | 6969  | Thật      | 203  |
|  4   | 2     | Thật      | 201  |

### DENY - U1 bị từ chối quyền INSERT trên T1, T2

#### DENY

```sql
DENY INSERT ON DETAI TO U1;
DENY INSERT ON HOIDONG TO U1;
```

#### Kiểm tra

```sql
EXECUTE AS USER = 'U1';
INSERT INTO DETAI (MSDT, TENDT) VALUES
('970553', N'Quản lý thư viện2');
REVERT;
```

```sql
Msg 229, Level 14, State 5, Line 9
The INSERT permission was denied on the object 'DETAI', database 'IE103-BTTH2', schema 'dbo'.
```

### DENY - U2 bị từ chối quyền DELETE trên T3

#### DENY

```sql
DENY DELETE ON GV_HDDT TO U2;
```

#### Kiểm tra

```sql
EXECUTE AS USER = 'U2';
DELETE FROM GV_HDDT WHERE 1 = 0;
REVERT;
```

```sql
The DELETE permission was denied on the object 'GV_HDDT', database 'IE103-BTTH2', schema 'dbo'.
```

### REVOKE - Thu hồi các quyền của U1 trên T1

#### REVOKE

```sql
REVOKE SELECT, DELETE ON DETAI FROM U1;
```

#### Kiểm tra

```sql
EXECUTE AS USER = 'U1';
SELECT * FROM DETAI;
REVERT;
```

```sql
The SELECT permission was denied on the object 'DETAI', database 'IE103-BTTH2', schema 'dbo'.
```

### REVOKE - Thu hồi các quyền của U3 trên T2

#### REVOKE

```sql
REVOKE INSERT ON HOIDONG FROM U3;
```

#### Kiểm tra

```sql
EXECUTE AS USER = 'U3';
INSERT INTO HOIDONG (MSHD, PHONG, TGBD, NGAYHD, TINHTRANG, MSGV) VALUES
(5, 3, '08:00', '2014-11-30', N'Thật', 202);
REVERT;
```

```sql
The INSERT permission was denied on the object 'HOIDONG', database 'IE103-BTTH2', schema 'dbo'.
```

