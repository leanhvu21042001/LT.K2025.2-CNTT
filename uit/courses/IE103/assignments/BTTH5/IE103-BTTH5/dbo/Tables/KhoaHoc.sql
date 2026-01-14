CREATE TABLE [dbo].[KhoaHoc] (
    [MaKhoaHoc]  INT           IDENTITY (1, 1) NOT NULL,
    [TenKhoaHoc] VARCHAR (200) NOT NULL
);
GO

ALTER TABLE [dbo].[KhoaHoc]
    ADD CONSTRAINT [PK_KhoaHoc] PRIMARY KEY CLUSTERED ([MaKhoaHoc] ASC);
GO

