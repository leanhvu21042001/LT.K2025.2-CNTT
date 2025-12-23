## A. IMPORT - EXPORT
  
### **A.1 Chọn 1 file dữ liệu (SV) từ excel, và import vào SQLServer.**

  ---
  ##### Buớc 1
  ![Demo Import A.1](./imgs/import-001.jpg)

  ---
  ##### Buớc 2
  ![Demo Import A.2](./imgs/import-002.jpg)

  ---
  ##### Buớc 3
  ![Demo Import A.3](./imgs/import-003.jpg)

  ---
  ##### Buớc 4
  ![Demo Import A.4](./imgs/import-004.jpg)

  ---

### **A.2 Chọn 1 table trong SQL Server, và export tới file Excel.**

  ---
  ##### Buớc 1
  ![Demo Export A.1](./imgs/export-001.jpg)

  ---
  ##### Buớc 2
  ![Demo Export A.2](./imgs/export-002.jpg)

  ---
  ##### Buớc 3
  ![Demo Export A.3](./imgs/export-003.jpg)

  ---
  ##### Buớc 4
  ![Demo Export A.4](./imgs/export-004.jpg)

  ---

## B. XÁC THỰC NGƯỜI DÙNG

### Mô tả yêu cầu

- Tạo 6 user: u1 → u6  
- Tạo 3 role: r1, r2, r3  
- Phân nhóm:
  - u1 thuộc r1  
  - u2, u3 thuộc r2  
  - u4, u5, u6 thuộc r3  
- Phân quyền:
  - r1 là thành viên của SysAdmin  
  - r2 là thành viên của db_owner, db_accessadmin  
  - r3 là thành viên của SysAdmin, db_owner, db_accessadmin  

---

### **B.1 Tạo Login L1 → L6**

```sql
CREATE LOGIN L1 WITH PASSWORD = 'L1@12345678';
CREATE LOGIN L2 WITH PASSWORD = 'L2@12345678';
CREATE LOGIN L3 WITH PASSWORD = 'L3@12345678';
CREATE LOGIN L4 WITH PASSWORD = 'L4@12345678';
CREATE LOGIN L5 WITH PASSWORD = 'L5@12345678';
CREATE LOGIN L6 WITH PASSWORD = 'L6@12345678';
```

![Demo B.1](./imgs/B1.jpg)

---

### **B.2 Tạo User U1 → U6 tương ứng với Login**

```sql
CREATE USER U1 FOR LOGIN L1;
CREATE USER U2 FOR LOGIN L2;
CREATE USER U3 FOR LOGIN L3;
CREATE USER U4 FOR LOGIN L4;
CREATE USER U5 FOR LOGIN L5;
CREATE USER U6 FOR LOGIN L6;
```

![Demo B.2](./imgs/B2.jpg)

---

### **B.3 Tạo Role r1, r2, r3**

```sql
CREATE ROLE r1;
CREATE ROLE r2;
CREATE ROLE r3;
```

![Demo B.3](./imgs/B3.jpg)

---

### **B.4 Gán User vào Role**

```sql
ALTER ROLE r1 ADD MEMBER U1;

ALTER ROLE r2 ADD MEMBER U2;
ALTER ROLE r2 ADD MEMBER U3;

ALTER ROLE r3 ADD MEMBER U4;
ALTER ROLE r3 ADD MEMBER U5;
ALTER ROLE r3 ADD MEMBER U6;
```

![Demo B.4](./imgs/B4.jpg)

---

### **B.5 Gán quyền hệ thống cho Role**

#### r1 là thành viên của SysAdmin

```sql
ALTER SERVER ROLE sysadmin ADD MEMBER L1;
```

![Demo B.5 - R1](./imgs/B5.1.jpg)

---

#### r2 là thành viên của db_owner, db_accessadmin

```sql
ALTER ROLE db_owner ADD MEMBER U2;
ALTER ROLE db_accessadmin ADD MEMBER U2;

ALTER ROLE db_owner ADD MEMBER U3;
ALTER ROLE db_accessadmin ADD MEMBER U3;
```

![Demo B.5 - R2](./imgs/B5.2.jpg)

---

#### r3 là thành viên của SysAdmin, db_owner, db_accessadmin

```sql
ALTER SERVER ROLE sysadmin ADD MEMBER L4;
ALTER ROLE db_owner ADD MEMBER U4;
ALTER ROLE db_accessadmin ADD MEMBER U4;

ALTER SERVER ROLE sysadmin ADD MEMBER L5;
ALTER ROLE db_owner ADD MEMBER U5;
ALTER ROLE db_accessadmin ADD MEMBER U5;

ALTER SERVER ROLE sysadmin ADD MEMBER L6;
ALTER ROLE db_owner ADD MEMBER U6;
ALTER ROLE db_accessadmin ADD MEMBER U6;
```

![Demo B.5 - R3](./imgs/B5.3.jpg)

---

## C. PHÂN QUYỀN NGƯỜI DÙNG

### Mô tả yêu cầu

Thực hiện các phát biểu **GRANT / DENY / REVOKE** trên CSDL **Quản lý đề tài** gồm các bảng:

* **T1: DETAI**
* **T2: HOIDONG**
* **T3: GV_HDDT**

Tạo các user **U1, U2, U3** và phân quyền theo yêu cầu.

---

### **C.1 Tạo User**

```sql
CREATE USER U1 WITHOUT LOGIN;
CREATE USER U2 WITHOUT LOGIN;
CREATE USER U3 WITHOUT LOGIN;
```


![Execute Script](./imgs/C1.1.jpg)

#### Test Script C.1
```sql 
SELECT name, type_desc FROM sys.database_principals 
WHERE name IN ('U1', 'U2', 'U3');
```

![Test Script](./imgs/C1.1-test.jpg)

---

### **C.2 Cấp quyền (GRANT)**

#### U1 có quyền SELECT, DELETE trên T1, T3

```sql
GRANT SELECT, DELETE ON DETAI TO U1;
GRANT SELECT, DELETE ON GV_HDDT TO U1;
```


![Execute Script](./imgs/C2-U1-Execute.jpg)

#### Test Script C.2 User U1

**SELECT:**
```sql
EXECUTE AS USER = 'U1';
SELECT * FROM DETAI;
REVERT;
```
![Test Script](./imgs/C2.1-test.jpg)

---

#### U2 có quyền UPDATE, DELETE trên T2

```sql
GRANT UPDATE, DELETE ON HOIDONG TO U2;
```


![Execute Script](./imgs/C2-U2-Script.jpg)

---

#### Test Script C.2 User U2

**DELETE:**
```sql
EXECUTE AS USER = 'U2';
DELETE FROM HOIDONG WHERE MAHD = 'HD001';
REVERT;
```
![Test Script](./imgs/C2-U2-Delete-HoiDong.jpg)

**UPDATE:**
```sql
EXECUTE AS USER = 'U2';
UPDATE HOIDONG SET PHONG = 6969; 
REVERT;
```

![Test Script](./imgs/C2-U2-Update-HoiDong.jpg)
---

#### U3 có quyền INSERT trên T1, T2, T3

```sql
GRANT INSERT ON DETAI TO U3;
GRANT INSERT ON HOIDONG TO U3;
GRANT INSERT ON GV_HDDT TO U3;
```


![Execute Script](./imgs/C2-U3-Script.jpg)

---

#### Test Script C.2 User U3

**INSERT:**
```sql
EXECUTE AS USER = 'U3';
INSERT INTO HOIDONG (MSHD, PHONG, TGBD, NGAYHD, TINHTRANG, MSGV) VALUES
(4, 2, '07:00', '2014-11-29', N'Thật', 201);≠
REVERT;
```

![Test Script](./imgs/C2-U3-Insert-HoiDong.jpg)

---

### **C.3 Từ chối quyền (DENY)**

#### U1 bị từ chối quyền INSERT trên T1, T2

```sql
DENY INSERT ON DETAI TO U1;
DENY INSERT ON HOIDONG TO U1;
```

![Execute Script](./imgs/C3-U1-Script.jpg)

---

#### Test Script C.3 User U1

**INSERT:**
```sql
EXECUTE AS USER = 'U1';
INSERT INTO DETAI (MSDT, TENDT) VALUES
('970553', N'Quản lý thư viện2');
REVERT;
```

![Test Script](./imgs/C3-U1-Insert-Detai.jpg)

---

#### U2 bị từ chối quyền DELETE trên T3

```sql
DENY DELETE ON GV_HDDT TO U2;
```

![Execute Script](./imgs/C3-U2-Script.jpg)

---

#### Test Script C.3 User U2
```sql
EXECUTE AS USER = 'U2';
DELETE FROM GV_HDDT WHERE 1 = 0;
REVERT;
```

**DELETE:**

![Test Script](./imgs/C3-U2-Delete-GV_HDDT.jpg)

---

### C.4 Thu hồi quyền (REVOKE)

#### Thu hồi các quyền của U1 trên T1

```sql
REVOKE SELECT, DELETE ON DETAI FROM U1;
```

![Execute Script](./imgs/C4-U1-Script.jpg)

#### Test Script C.4 User U1

**SELECT:**
```sql
EXECUTE AS USER = 'U1';
SELECT * FROM DETAI;
REVERT;
```

![Test Script](./imgs/C4-U1-Select-Detai.jpg)

---

#### Thu hồi các quyền của U3 trên T2

```sql
REVOKE INSERT ON HOIDONG FROM U3;
```

![Execute Script](./imgs/C4-U3-Script.jpg)

#### Test Script C.4 User U3

**INSERT:**
```sql
EXECUTE AS USER = 'U3';
INSERT INTO HOIDONG (MSHD, PHONG, TGBD, NGAYHD, TINHTRANG, MSGV) VALUES
(5, 3, '08:00', '2014-11-30', N'Thật', 202);
REVERT;
```

![Test Script](./imgs/C4-U3-Insert-HoiDong.jpg)

---