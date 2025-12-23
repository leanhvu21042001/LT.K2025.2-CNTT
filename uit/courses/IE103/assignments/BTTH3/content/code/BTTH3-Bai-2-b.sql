CREATE LOGIN L2 WITH PASSWORD = 'L2@12345678';
CREATE LOGIN L3 WITH PASSWORD = 'L3@12345678';
CREATE LOGIN L4 WITH PASSWORD = 'L4@12345678';
CREATE LOGIN L5 WITH PASSWORD = 'L5@12345678';
CREATE LOGIN L6 WITH PASSWORD = 'L6@12345678';
GO

CREATE USER U1 FOR LOGIN L1;
CREATE USER U2 FOR LOGIN L2;
CREATE USER U3 FOR LOGIN L3;
CREATE USER U4 FOR LOGIN L4;
CREATE USER U5 FOR LOGIN L5;
CREATE USER U6 FOR LOGIN L6;
GO

CREATE ROLE r1;
CREATE ROLE r2;
CREATE ROLE r3;
GO

ALTER ROLE r1 ADD MEMBER U1;
ALTER ROLE r2 ADD MEMBER U2;
ALTER ROLE r2 ADD MEMBER U3;
ALTER ROLE r3 ADD MEMBER U4;
ALTER ROLE r3 ADD MEMBER U5;
ALTER ROLE r3 ADD MEMBER U6;
GO

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

-- REVIEW CREATED LOGIN

SELECT TOP (1000) [name]
      ,[principal_id]
    --   ,[sid]
      ,[type]
      ,[type_desc]
      ,[is_disabled]
    --   ,[create_date]
    --   ,[modify_date]
    --   ,[default_database_name]
    --   ,[default_language_name]
    --   ,[credential_id]
    --   ,[is_policy_checked]
    --   ,[is_expiration_checked]
    --   ,[password_hash]
  FROM [master].[sys].[sql_logins]
  WHERE name LIKE 'L%'
GO

-- REVIEW USERS

SELECT TOP (1000) [uid]
      ,[status]
      ,[name]
    --   ,[sid]
    --   ,[roles]
    --   ,[createdate]
    --   ,[updatedate]
      ,[altuid]
    --   ,[password]
      ,[gid]
    --   ,[environ]
      ,[hasdbaccess]
      ,[islogin]
    --   ,[isntname]
    --   ,[isntgroup]
    --   ,[isntuser]
      ,[issqluser]
    --   ,[isaliased]
    --   ,[issqlrole]
    --   ,[isapprole]
  FROM [master].[sys].[sysusers]
  WHERE name LIKE 'U%';
GO

-- REVIEW ROLEs

SELECT TOP (1000) [uid]
      ,[status]
      ,[name]
    --   ,[sid]
    --   ,[roles]
    --   ,[createdate]
    --   ,[updatedate]
      ,[altuid]
    --   ,[password]
      ,[gid]
    --   ,[environ]
      ,[hasdbaccess]
      ,[islogin]
    --   ,[isntname]
    --   ,[isntgroup]
    --   ,[isntuser]
      ,[issqluser]
    --   ,[isaliased]
    --   ,[issqlrole]
    --   ,[isapprole]
  FROM [master].[sys].[sysusers]
  WHERE name LIKE 'r%';
GO

-- B.4 Review

SELECT 
    DRM.role_principal_id,
    DP1.name AS [Role],
    DRM.member_principal_id,
    DP2.name AS [User]
FROM sys.database_role_members AS DRM
JOIN sys.database_principals AS DP1
    ON DRM.role_principal_id = DP1.principal_id
JOIN sys.database_principals AS DP2
    ON DRM.member_principal_id = DP2.principal_id
WHERE DP2.name LIKE 'U%' AND DP1.name LIKE 'r%'
ORDER BY DP1.name;
GO

-- B Review: sysadmin

SELECT
    ServerRole.principal_id AS [Role ID],
    ServerRole.name AS [Server Role Name],
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

-- User thuộc db_accessadmin

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

-- User thuộc db_owner

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
