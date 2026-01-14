CREATE TABLE [dbo].[KhoaHocMonHoc] (
    [MaKhoaHoc] INT NULL,
    [MaMonHoc]  INT NULL
);
GO

ALTER TABLE [dbo].[KhoaHocMonHoc]
    ADD CONSTRAINT [FK_KhoaHocMonHoc_MaKhoaHoc] FOREIGN KEY ([MaKhoaHoc]) REFERENCES [dbo].[KhoaHoc] ([MaKhoaHoc]);
GO

ALTER TABLE [dbo].[KhoaHocMonHoc]
    ADD CONSTRAINT [FK_KhoaHocMonHoc_MaMonHoc] FOREIGN KEY ([MaMonHoc]) REFERENCES [dbo].[MonHoc] ([MaMonHoc]);
GO

