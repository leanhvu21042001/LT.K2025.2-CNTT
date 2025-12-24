-- NHÓM 2
-- MÔN: IE103 - Quản Lý Thông Tin
-- BTTH2
-- NOTE: Script này chạy trên Azure Database Studio (ADS)

-- Sử dụng master
USE master;
GO

-- Nếu DB BTTH2 chưa tồn tại, hãy tạo mới
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'BTTH2')
BEGIN
    CREATE DATABASE BTTH2;
END
GO

-- Chuyển qua sử dụng DB mới này
USE BTTH2;
GO
