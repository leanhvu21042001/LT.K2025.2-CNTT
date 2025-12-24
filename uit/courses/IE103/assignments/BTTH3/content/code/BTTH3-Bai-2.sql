-- NHOM 2
-- IE103
-- BTTH3
-- Bài 2
-- A. IMPORT và EXPORT (Bỏ qua, không có code)
-- B. XÁC THỰC NGƯỜI DÙNG
-- C. PHÂN QUYỀN NGƯỜI DÙNG
-- NOTE: A Batch/Top-Down processing Script.

-- ==================================================================
-- B. XÁC THỰC NGƯỜI DÙNG
-- ==================================================================

-- TẠO LOGIN Ở CẤP SERVER

CREATE LOGIN L1 WITH PASSWORD = 'L1@12345678';
CREATE LOGIN L2 WITH PASSWORD = 'L2@12345678';
CREATE LOGIN L3 WITH PASSWORD = 'L3@12345678';
CREATE LOGIN L4 WITH PASSWORD = 'L4@12345678';
CREATE LOGIN L5 WITH PASSWORD = 'L5@12345678';
CREATE LOGIN L6 WITH PASSWORD = 'L6@12345678';
GO

-- TẠO USER TRONG DATABASE

CREATE USER U1 FOR LOGIN L1;
CREATE USER U2 FOR LOGIN L2;
CREATE USER U3 FOR LOGIN L3;
CREATE USER U4 FOR LOGIN L4;
CREATE USER U5 FOR LOGIN L5;
CREATE USER U6 FOR LOGIN L6;
GO

-- TẠO ROLE TÙY CHỈNH - GOM NHÓM, PHÂN QUYỀN USER---

CREATE ROLE r1;
CREATE ROLE r2;
CREATE ROLE r3;
GO

-- GÁN USER VÀO ROLE TÙY CHỈNH

ALTER ROLE r1 ADD MEMBER U1;
ALTER ROLE r2 ADD MEMBER U2;
ALTER ROLE r2 ADD MEMBER U3;
ALTER ROLE r3 ADD MEMBER U4;
ALTER ROLE r3 ADD MEMBER U5;
ALTER ROLE r3 ADD MEMBER U6;
GO

-- GÁN QUYỀN SERVER ROLE VÀ DATABASE

ALTER SERVER ROLE sysadmin ADD MEMBER L1;
GO

ALTER ROLE db_owner ADD MEMBER U2;
ALTER ROLE db_accessadmin ADD MEMBER U2;
GO

ALTER ROLE db_owner ADD MEMBER U3;
ALTER ROLE db_accessadmin ADD MEMBER U3;
GO

ALTER SERVER ROLE sysadmin ADD MEMBER L4;
ALTER ROLE db_owner ADD MEMBER U4;
ALTER ROLE db_accessadmin ADD MEMBER U4;
GO

ALTER SERVER ROLE sysadmin ADD MEMBER L5;
ALTER ROLE db_owner ADD MEMBER U5;
ALTER ROLE db_accessadmin ADD MEMBER U5;
GO

ALTER SERVER ROLE sysadmin ADD MEMBER L6;
ALTER ROLE db_owner ADD MEMBER U6;
ALTER ROLE db_accessadmin ADD MEMBER U6;
GO

-- KIỂM TRA LOGIN ĐÃ ĐƯỢC TẠO (SERVER LEVEL)

SELECT [name], [principal_id], [type], [type_desc], [is_disabled]
FROM [master].[sys].[sql_logins]
WHERE name LIKE 'L%';
GO

-- KIỂM TRA USER TRONG DATABASE

SELECT [uid], [name], [hasdbaccess], [islogin], [issqluser]
FROM [master].[sys].[sysusers]
WHERE name LIKE 'U%';
GO

-- KIỂM TRA ROLE TRONG DATABASE

SELECT [uid], [name], [issqlrole]
FROM [master].[sys].[sysusers]
WHERE name LIKE 'r%';
GO

-- KIỂM TRA USER THUỘC ROLE TÙY CHỈNH

SELECT
    DP1.name AS [Role],
    DP2.name AS [User]
FROM sys.database_role_members DRM
JOIN sys.database_principals DP1
    ON DRM.role_principal_id = DP1.principal_id
JOIN sys.database_principals DP2
    ON DRM.member_principal_id = DP2.principal_id
WHERE DP2.name LIKE 'U%' AND DP1.name LIKE 'r%'
ORDER BY DP1.name;
GO

-- KIỂM TRA LOGIN THUỘC SYSADMIN

SELECT
    ServerRole.name AS [Server Role],
    ServerLogin.name AS [Login]
FROM sys.server_role_members RoleMem
JOIN sys.server_principals ServerRole
    ON RoleMem.role_principal_id = ServerRole.principal_id
JOIN sys.server_principals ServerLogin
    ON RoleMem.member_principal_id = ServerLogin.principal_id
WHERE ServerRole.name = 'sysadmin'
  AND ServerLogin.name LIKE 'L%';
GO

-- KIỂM TRA USER THUỘC db_accessadmin

SELECT
    RoleP.name AS [Role],
    UserP.name AS [User]
FROM sys.database_role_members RoleMem
JOIN sys.database_principals RoleP
    ON RoleMem.role_principal_id = RoleP.principal_id
JOIN sys.database_principals UserP
    ON RoleMem.member_principal_id = UserP.principal_id
WHERE RoleP.name = 'db_accessadmin'
  AND UserP.name LIKE 'U%';
GO

-- KIỂM TRA USER THUỘC db_owner

SELECT
    RoleP.name AS [Role],
    UserP.name AS [User]
FROM sys.database_role_members RoleMem
JOIN sys.database_principals RoleP
    ON RoleMem.role_principal_id = RoleP.principal_id
JOIN sys.database_principals UserP
    ON RoleMem.member_principal_id = UserP.principal_id
WHERE RoleP.name = 'db_owner'
  AND UserP.name LIKE 'U%';
GO

-- ==================================================================
-- C. PHÂN QUYỀN NGƯỜI DÙNG
-- ==================================================================

-- Tạo các USER ở cấp database KHÔNG gắn với LOGIN
-- Đặt tên là U1_2, U2_2, U3_2 vì trùng u1,u2,u3 ở trên nên thêm số 2 theo nhóm
CREATE USER U1_2 WITHOUT LOGIN;
CREATE USER U2_2 WITHOUT LOGIN;
CREATE USER U3_2 WITHOUT LOGIN;
GO

-- Kiểm tra các USER vừa tạo trong database

SELECT name, type_desc
FROM sys.database_principals
WHERE name IN ('U1_2', 'U2_2', 'U3_2');
GO
-- U1_2: SELECT, DELETE trên bảng DETAI, GV_HDDT
GRANT SELECT, DELETE ON DETAI TO U1_2;
GRANT SELECT, DELETE ON GV_HDDT TO U1_2;
GO
-- Dùng để kiểm tra các quyền vừa được cấp CHO U1
EXECUTE AS USER = 'U1_2';

-- Thực hiện truy vấn SELECT trên bảng DETAI với quyền của U1
SELECT * FROM DETAI;

-- Kết thúc giả lập, quay lại ngữ cảnh user ban đầu
REVERT;
GO
-- U2_2: UPDATE và DELETE trên bảng HOIDONG

GRANT UPDATE, DELETE ON HOIDONG TO U2_2;
GO

-- Kiểm tra quyền DELETE của user U2

EXECUTE AS USER = 'U2_2';
DELETE FROM HOIDONG WHERE 1 = '0';
REVERT;
GO

-- Kiểm tra quyền UPDATE của user U2
EXECUTE AS USER = 'U2_2';
UPDATE HOIDONG SET PHONG = 6969;
REVERT;
-- U3_2: INSERT trên các bảng DETAI, HOIDONG và GV_HDDT
GRANT INSERT ON DETAI TO U3_2;
GRANT INSERT ON HOIDONG TO U3_2;
GRANT INSERT ON GV_HDDT TO U3_2;
GO

-- Thực hiện thao tác INSERT trên bảng HOIDONG với quyền của user U3
EXECUTE AS USER = 'U3_2';
INSERT INTO HOIDONG (MSHD, PHONG, TGBD, NGAYHD, TINHTRANG, MSGV) VALUES
(4, 2, '07:00', '2014-11-29', N'Thật', 201);
REVERT;
GO

-- Kiểm tra dữ liệu trong bảng HOIDONG sau khi thực hiện INSERT
SELECT * FROM HOIDONG;
GO
-- Từ chối (DENY) quyền INSERT trên bảng DETAI cho user U1
DENY INSERT ON DETAI TO U1_2;

-- Từ chối (DENY) quyền INSERT trên bảng HOIDONG cho user U1
DENY INSERT ON HOIDONG TO U1_2;

-- Giả lập thực thi với quyền của user U1 để kiểm tra DENY
EXECUTE AS USER = 'U1_2';

-- Thử thực hiện INSERT vào bảng DETAI

INSERT INTO DETAI (MSDT, TENDT) VALUES
('970553', N'Quản lý thư viện2');

-- Kết thúc giả lập, quay lại ngữ cảnh ban đầu
REVERT;
-- Từ chối (DENY) quyền DELETE trên bảng GV_HDDT cho user U2
DENY DELETE ON GV_HDDT TO U2_2;

-- Giả lập thực thi với quyền của user U2 để kiểm tra DENY
EXECUTE AS USER = 'U2_2';

-- Thử thực hiện DELETE với điều kiện luôn sai để không xóa dữ liệu
DELETE FROM GV_HDDT WHERE 1 = 0;

-- Kết thúc giả lập, quay lại ngữ cảnh ban đầu
REVERT;
-- Thu hồi (REVOKE) quyền SELECT và DELETE trên bảng DETAI của user U1
-- REVOKE chỉ gỡ quyền đã được cấp trước đó, không phải từ chối tuyệt đối như DENY
REVOKE SELECT, DELETE ON DETAI FROM U1_2;

-- Giả lập thực thi với quyền của user U1 để kiểm tra sau khi thu hồi quyền
EXECUTE AS USER = 'U1_2';

-- Thử thực hiện truy vấn SELECT trên bảng DETAI
-- Kết quả phụ thuộc vào việc U1 còn được cấp quyền SELECT qua role khác hay không
SELECT * FROM DETAI;

-- Kết thúc giả lập, quay lại ngữ cảnh ban đầu
REVERT;
-- Thu hồi (REVOKE) quyền INSERT trên bảng HOIDONG của user U3
-- Lệnh REVOKE gỡ bỏ quyền INSERT đã được cấp trực tiếp trước đó cho U3
REVOKE INSERT ON HOIDONG FROM U3_2;
GO

-- Giả lập thực thi với quyền của user U3 để kiểm tra sau khi thu hồi quyền
EXECUTE AS USER = 'U3_2';

-- Thử thực hiện INSERT vào bảng HOIDONG
-- Câu lệnh sẽ thất bại nếu U3 không còn quyền INSERT thông qua user hoặc role nào khác
INSERT INTO HOIDONG (MSHD, PHONG, TGBD, NGAYHD, TINHTRANG, MSGV) VALUES
(5, 3, '08:00', '2014-11-30', N'Thật', 202);

-- Kết thúc giả lập, quay lại ngữ cảnh ban đầu
REVERT;
GO

-- ==================================================================
-- KẾT THÚC
-- ==================================================================

-- TODO: CLEAN UP/ROLLBACK
