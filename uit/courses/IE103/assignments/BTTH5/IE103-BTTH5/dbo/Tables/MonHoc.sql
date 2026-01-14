CREATE TABLE [dbo].[MonHoc] (
    [MaMonHoc]  INT           IDENTITY (1, 1) NOT NULL,
    [TenMonHoc] VARCHAR (200) NULL
);
GO

ALTER TABLE [dbo].[MonHoc]
    ADD CONSTRAINT [PK_MonHoc] PRIMARY KEY CLUSTERED ([MaMonHoc] ASC);
GO

