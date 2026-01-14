## D. Crystal Report Báo Cáo Tổng Doanh Thu

Cho CSDL Quản lý bán hàng đính kèm bên dưới. Hãy dùng Crystal Report để thiết kế một báo cáo cho biết Tổng doanh thu theo từng sản phẩm trong năm 2006 + 2007.

Yêu cầu gồm có 2 phần sau:

- Phần Biểu đồ tròn (Pie Chart): Cho biết tỷ lệ phần trăm doanh số bán được của từng sản phẩm trong năm 2006 + 2007.
    - Sử dụng `MASP` (mã sản phẩm) để phân biệt các sản phẩm với nhau (Vì sản phẩm có thể trùng tên).
    - Gán nhãn `MASP` cho từng phần trong biểu đồ.
    - Thông tin phần trăm của từng sản phẩm để bên phải của biểu đồ.
    - Lưu ý: Thông tin phần trăm trong biểu đồ là tổng doanh thu của từng sản phẩm trong năm 2006 + 2007, tức cột cuối cùng trong phần Bảng số liệu chi tiết bên dưới.

- Phần Bảng số liệu chi tiết: Cho biết doanh thu cụ thể của từng sản phẩm trong năm 2006, năm 2007 và năm (2006 + 2007). Cụ thể:
    - Tổng doanh thu theo từng sản phẩm trong năm 2006.
    - Tổng doanh thu theo từng sản phẩm trong năm 2007.
    - Tổng doanh thu theo từng sản phẩm trong năm 2006 + 2007.
    - Phần Page Header tô nền vàng và có Border xung quanh.
    - Phần Detail có Border xung quanh.

### Phần Biểu Đồ Tròn (Pie Chart)

```sql
-- Tạo View tính tổng doanh thu riêng từng sản phẩm trong năm 2006, 2007

CREATE OR ALTER VIEW V_BAOCAO_DOANHTHU_SP_2006_2007 AS
SELECT
    SP.MASP,
    SP.TENSP,
    ISNULL(SUM(CASE WHEN YEAR(HD.NGHD) = 2006 THEN CT.SL * SP.GIA ELSE 0 END), 0) AS DoanhThu2006,
    ISNULL(SUM(CASE WHEN YEAR(HD.NGHD) = 2007 THEN CT.SL * SP.GIA ELSE 0 END), 0) AS DoanhThu2007,
    ISNULL(SUM(CASE WHEN YEAR(HD.NGHD) IN (2006, 2007) THEN CT.SL * SP.GIA ELSE 0 END), 0) AS TongCaHaiNam
FROM
    SANPHAM SP
LEFT JOIN
    CTHD CT ON SP.MASP = CT.MASP
LEFT JOIN
    HOADON HD ON CT.SOHD = HD.SOHD
GROUP BY
    SP.MASP, SP.TENSP
GO
```

### Kiểm Tra Kết Quả Của View Vua Tạo

```sql
   SELECT * FROM V_BAOCAO_DOANHTHU_SP_2006_2007;
```

### Tạo Chart (Pie) Trong Sheet Mới

![Bài 1.D - Tạo chart (Pie) trong sheet mới](./images/1d-1-1.png)

### Mapping Dữ Liệu Từ View V_BAOCAO_DOANHTHU_SP_2006_2007 Vào Chart

Kéo thả vào mục Marks các trường trong view:

- MaSP -> Color => để hiển thị màu phân biệt sp
- Sum(TongCaNam) -> Angle => để chia tỉ lệ trong biểu đồ
- Sum(TongCaNam) và MaSP -> Label => để hiển thị trên biểu đồ

![Bài 1.D - Mapping dữ liệu từ View vào chart (1)](./images/1d-1-2.png)

![Bài 1.D - Mapping dữ liệu từ View vào chart (2)](./images/1d-1-3.png)

![Bài 1.D - Mapping dữ liệu từ View vào chart (3)](./images/1d-1-4.png)

### Màn Hình Design Của Chart

![Bài 1.D - Màn hình design của chart](./images/1d-1-5.png)

### Bảng Số Liệu Chi Tiết, Tạo Sheet Mới, Tô Màu Và Vẽ Đường Viền

Kéo thả các field trong View

![Bài 1.D - Bảng số liệu chi tiết (1)](./images/1d-1-6.png)

![Bài 1.D - Bảng số liệu chi tiết (2)](./images/1d-1-7.png)

### Tạo STT

![Bài 1.D - Tạo STT (1)](./images/1d-1-8.png)

![Bài 1.D - Tạo STT (2)](./images/1d-1-9.png)

### Màn Hình Design & Preview Chi Tiết

![Bài 1.D - Màn hình design & preview chi tiết (1)](./images/1d-1-10.png)

![Bài 1.D - Màn hình design & preview chi tiết (2)](./images/1d-1-12.png)

### Tạo Dashboard Để Hiển Thị Biểu Đồ Và Chi Tiết

Kéo thả 2 sheet biểu đồ và sheet chi tiết vào

![Bài 1.D - Tạo dashboard để hiển thị biểu đồ và chi tiết](./images/1d-1-11.png)

### Màn Hình Design Của Dashboard

![Bài 1.D - Màn hình design cuối cùng](./images/1d-1-13.png)

### Màn Hình Preview

![Bài 1.D - Màn hình preview](./images/1d-1-14.png)
