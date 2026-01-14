CREATE TABLE [dbo].[Diem] (
    [MSSV]     BIGINT NULL,
    [MaMonHoc] INT    NULL,
    [Diem]     INT    NULL
);
GO

ALTER TABLE [dbo].[Diem]
    ADD CONSTRAINT [FK_Diem_MSSV] FOREIGN KEY ([MSSV]) REFERENCES [dbo].[SinhVien] ([MSSV]);
GO

ALTER TABLE [dbo].[Diem]
    ADD CONSTRAINT [FK_Diem_MaMonHoc] FOREIGN KEY ([MaMonHoc]) REFERENCES [dbo].[MonHoc] ([MaMonHoc]);
GO

