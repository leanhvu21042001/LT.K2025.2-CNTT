## B. XÁC THỰC NGƯỜI DÙNG

### Mô tả yêu cầu

- Tạo 6 user từ `u1` đến `u6`
- Tạo 3 role từ `r1` đến `r3`
- Tạo nhóm:
  - `u1` thuộc `r1`;
  - `u2`, `u3` thuộc `r2`;
  - `u4`, `u5`, `u6` thuộc `r3`
- Thực hiện:
  - r1 thành viên của `SysAdmin`
  - r2 thành viên của `db_owner`, `db_accessadmin`
  - r3 thành viên của `SysAdmin`, `db_owner`, `db_accessadmin`

### B.1 Tạo Login L1 → L6

```sql
CREATE LOGIN L1 WITH PASSWORD = 'L1@12345678';
CREATE LOGIN L2 WITH PASSWORD = 'L2@12345678';
CREATE LOGIN L3 WITH PASSWORD = 'L3@12345678';
CREATE LOGIN L4 WITH PASSWORD = 'L4@12345678';
CREATE LOGIN L5 WITH PASSWORD = 'L5@12345678';
CREATE LOGIN L6 WITH PASSWORD = 'L6@12345678';
```

| name | principal_id | type | type_desc | is_disabled |
| :--: | ------------ | ---- | --------- | ----------- |
|  L1  | 262          | S    | SQL_LOGIN | 0           |
|  L2  | 263          | S    | SQL_LOGIN | 0           |
|  L3  | 264          | S    | SQL_LOGIN | 0           |
|  L4  | 265          | S    | SQL_LOGIN | 0           |
|  L5  | 266          | S    | SQL_LOGIN | 0           |
|  L6  | 267          | S    | SQL_LOGIN | 0           |

### B.2 Tạo User U1 → U6 tương ứng với Login

```sql
CREATE USER U1 FOR LOGIN L1;
CREATE USER U2 FOR LOGIN L2;
CREATE USER U3 FOR LOGIN L3;
CREATE USER U4 FOR LOGIN L4;
CREATE USER U5 FOR LOGIN L5;
CREATE USER U6 FOR LOGIN L6;
```

| uid  | status | name | altuid | gid  | hasdbaccess | islogin | issqluser |
| :--: | ------ | ---- | ------ | ---- | ----------- | ------- | --------- |
|  7   | 0      | U1   | NULL   | 0    | 1           | 1       | 1         |
|  8   | 0      | U2   | NULL   | 0    | 1           | 1       | 1         |
|  9   | 0      | U3   | NULL   | 0    | 1           | 1       | 1         |
|  10  | 0      | U4   | NULL   | 0    | 1           | 1       | 1         |
|  11  | 0      | U5   | NULL   | 0    | 1           | 1       | 1         |
|  12  | 0      | U6   | NULL   | 0    | 1           | 1       | 1         |

### B.3 Tạo Role r1, r2, r3

```sql
CREATE ROLE r1;
CREATE ROLE r2;
CREATE ROLE r3;
```

| uid  | status | name | altuid | gid  | hasdbaccess | islogin | issqluser |
| :--: | ------ | ---- | ------ | ---- | ----------- | ------- | --------- |
|  13  | 0      | r1   | 1      | 13   | 0           | 0       | 0         |
|  14  | 0      | r2   | 1      | 14   | 0           | 0       | 0         |
|  15  | 0      | r3   | 1      | 15   | 0           | 0       | 0         |

### B.4 Gán User vào Role

```sql
ALTER ROLE r1 ADD MEMBER U1;

ALTER ROLE r2 ADD MEMBER U2;
ALTER ROLE r2 ADD MEMBER U3;

ALTER ROLE r3 ADD MEMBER U4;
ALTER ROLE r3 ADD MEMBER U5;
ALTER ROLE r3 ADD MEMBER U6;
```

| role_principal_id | Role | member_principal_id | User |
| :---------------: | ---- | ------------------- | ---- |
|        13         | r1   | 7                   | U1   |
|        14         | r2   | 8                   | U2   |
|        14         | r2   | 9                   | U3   |
|        15         | r3   | 10                  | U4   |
|        15         | r3   | 11                  | U5   |
|        15         | r3   | 12                  | U6   |

### B.5 Gán quyền hệ thống cho Role

#### r1 là thành viên của SysAdmin

```sql
ALTER SERVER ROLE sysadmin ADD MEMBER L1;
```

#### r2 là thành viên của db_owner, db_accessadmin

```sql
ALTER ROLE db_owner ADD MEMBER U2;
ALTER ROLE db_accessadmin ADD MEMBER U2;

ALTER ROLE db_owner ADD MEMBER U3;
ALTER ROLE db_accessadmin ADD MEMBER U3;
```

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

### Kiểm tra kết quả:

- Login thuộc `sysadmin`:

```sql
SELECT
    ServerRole.principal_id AS [Role ID],
    ServerRole.name AS [Server Role],
    ServerLogin.principal_id AS [LOGIN ID],
    ServerLogin.name AS [LOGIN Name],
    ServerLogin.type_desc AS [Type]
FROM sys.server_role_members AS RoleMem
INNER JOIN sys.server_principals AS ServerRole
    ON RoleMem.role_principal_id = ServerRole.principal_id
INNER JOIN sys.server_principals AS ServerLogin
    ON RoleMem.member_principal_id = ServerLogin.principal_id
WHERE ServerRole.name = 'sysadmin' AND ServerLogin.name LIKE 'L%'
ORDER BY [LOGIN Name];
GO
```

| Role ID | Server Role | LOGIN ID | LOGIN Name | Type      |
| :-----: | ----------- | -------- | ---------- | --------- |
|    3    | sysadmin    | 262      | L1         | SQL_LOGIN |
|    3    | sysadmin    | 265      | L4         | SQL_LOGIN |
|    3    | sysadmin    | 266      | L5         | SQL_LOGIN |
|    3    | sysadmin    | 267      | L6         | SQL_LOGIN |

- User thuộc các role mới tạo (r1 - r3):

```sql
SELECT 
    RoleP.principal_id AS [Role ID],
    RoleP.name AS [Role Name],
    RoleMem.member_principal_id as [User ID],
    UserP.name AS [User Name],
    UserP.type_desc AS [Member Type]
FROM sys.database_role_members AS RoleMem
INNER JOIN sys.database_principals AS RoleP
    ON RoleMem.role_principal_id = RoleP.principal_id
INNER JOIN sys.database_principals AS UserP
    ON RoleMem.member_principal_id = UserP.principal_id
WHERE UserP.name LIKE 'U%' AND RoleP.name LIKE 'r%'
ORDER BY [Role Name];
GO
```

| Role ID | Role Name | User ID | User Name | Member Type |
| :-----: | --------- | ------- | --------- | ----------- |
|   13    | r1        | 7       | U1        | SQL_USER    |
|   14    | r2        | 8       | U2        | SQL_USER    |
|   14    | r2        | 9       | U3        | SQL_USER    |
|   15    | r3        | 10      | U4        | SQL_USER    |
|   15    | r3        | 11      | U5        | SQL_USER    |
|   15    | r3        | 12      | U6        | SQL_USER    |

- User thuộc `db_accessadmin`

```sql
SELECT 
    RoleP.principal_id AS [Role ID],
    RoleP.name AS [Role Name],
    RoleMem.member_principal_id as [User ID],
    UserP.name AS [User Name],
    UserP.type_desc AS [Member Type]
FROM sys.database_role_members AS RoleMem
INNER JOIN sys.database_principals AS RoleP
    ON RoleMem.role_principal_id = RoleP.principal_id
INNER JOIN sys.database_principals AS UserP
    ON RoleMem.member_principal_id = UserP.principal_id
WHERE UserP.name LIKE 'U%' AND RoleP.name LIKE 'db_accessadmin'
ORDER BY [Role Name];
GO
```

| Role ID | Role Name      | User ID | User Name | Member Type |
| :-----: | -------------- | ------- | --------- | ----------- |
|  16385  | db_accessadmin | 8       | U2        | SQL_USER    |
|  16385  | db_accessadmin | 9       | U3        | SQL_USER    |
|  16385  | db_accessadmin | 10      | U4        | SQL_USER    |
|  16385  | db_accessadmin | 11      | U5        | SQL_USER    |
|  16385  | db_accessadmin | 12      | U6        | SQL_USER    |

- User thuộc `db_owner`

```sql
SELECT 
    RoleP.principal_id AS [Role ID],
    RoleP.name AS [Role Name],
    RoleMem.member_principal_id as [User ID],
    UserP.name AS [User Name],
    UserP.type_desc AS [Member Type]
FROM sys.database_role_members AS RoleMem
INNER JOIN sys.database_principals AS RoleP
    ON RoleMem.role_principal_id = RoleP.principal_id
INNER JOIN sys.database_principals AS UserP
    ON RoleMem.member_principal_id = UserP.principal_id
WHERE UserP.name LIKE 'U%' AND RoleP.name LIKE 'db_owner'
ORDER BY [Role Name];
GO
```

| Role ID | Role Name | User ID | User Name | Member Type |
| :-----: | --------- | ------- | --------- | ----------- |
|  16384  | db_owner  | 8       | U2        | SQL_USER    |
|  16384  | db_owner  | 9       | U3        | SQL_USER    |
|  16384  | db_owner  | 10      | U4        | SQL_USER    |
|  16384  | db_owner  | 11      | U5        | SQL_USER    |
|  16384  | db_owner  | 12      | U6        | SQL_USER    |
