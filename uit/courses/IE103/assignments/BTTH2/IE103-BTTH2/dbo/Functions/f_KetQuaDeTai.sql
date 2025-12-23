
CREATE FUNCTION f_KetQuaDeTai (@MSDT char(6))
RETURNS NVARCHAR(20)
AS
BEGIN
    DECLARE @DiemTB float;
    DECLARE @KetQua NVARCHAR(20);

    SET @DiemTB = dbo.f_TinhDiemTB(@MSDT);

    IF (@DiemTB >= 5)
        SET @KetQua = N'DAT';
    ELSE
        SET @KetQua = N'KHONGDAT';

    RETURN @KetQua;
END;
GO

