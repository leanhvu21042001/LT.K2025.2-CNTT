CREATE TABLE [dbo].[SinhVien] (
    [MSSV]      BIGINT        IDENTITY (1, 1) NOT NULL,
    [TenSV]     VARCHAR (200) NOT NULL,
    [MaKhoaHoc] INT           NOT NULL
);
GO

ALTER TABLE [dbo].[SinhVien]
    ADD CONSTRAINT [PK_SinhVien] PRIMARY KEY CLUSTERED ([MSSV] ASC);
GO

ALTER TABLE [dbo].[SinhVien]
    ADD CONSTRAINT [FK_SinhVien_MaKhoaHoc] FOREIGN KEY ([MaKhoaHoc]) REFERENCES [dbo].[KhoaHoc] ([MaKhoaHoc]);
GO

