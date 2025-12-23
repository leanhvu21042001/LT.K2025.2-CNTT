-- NOTE: This query runs under Azure Database Studio (ADS)
-- Use the master database explicitly.
USE master;
GO

-- Check if the database 'BTTH2' does NOT exist in the system records.
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'BTTH2')
BEGIN
    CREATE DATABASE BTTH2;
END
GO

-- Use the newly created db.
USE BTTH2;
GO
