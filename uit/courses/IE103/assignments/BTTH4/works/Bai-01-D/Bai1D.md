

## Bài 1D: Cho CSDL Quản lý bán hàng đính kèm bên dưới.
    Hãy dùng Tableau để thiết kế một báo cáo cho biết Tổng doanh thu theo từng sản phẩm trong năm 2006 + 2007. Yêu cầu gồm có 2 phần sau:
    ▪ Phần Biểu đồ tròn (Pie Chart): Cho biết tỷ lệ phần trăm doanh số bán được của từng sản phẩm trong năm 2006 + 2007.
        o Sử dụng MASP (mã sản phẩm) để phân biệt các sản phẩm với nhau(Vì sản phẩm có thể trùng tên).
        o Gán nhãn (MASP) cho từng phần trong biểu đồ.
        o Thông tin phần trăm của từng sản phẩm để bên phải của biểu đồ.
        o Lưu ý: Thông tin phần trăm trong biểu đồ là tổng doanh thu của từng sản phẩm trong năm 2006 + 2007, tức cột cuối cùng trong phần
    Bảng số liệu chi tiết bên dưới.
    ▪ Phần Bảng số liệu chi tiết: Cho biết doanh thu cụ thể của từng sản phẩm trong năm 2006, năm 2007 và năm (2006 + 2007). Cụ thể:
        o Tổng doanh thu theo từng sản phẩm trong năm 2006.
        o Tổng doanh thu theo từng sản phẩm trong năm 2007.
        o Tổng doanh thu theo từng sản phẩm trong năm 2006 + 2007.
        o Phần Page Header tô nền vàng và có Border xung quanh.
        o Phần Detail có Border xung quanh.

### 1D.1 Phần Biểu đồ tròn (Pie Chart)

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

### Kiểm tra kết quả của view vừa tạo

```sql
   SELECT * FROM V_BAOCAO_DOANHTHU_SP_2006_2007;
```

### Tạo chart (Pie) trong sheet mới
![Ví dụ 1](./images/1d-1-1.png)

### Mapping dữ liệu từ View V_BAOCAO_DOANHTHU_SP_2006_2007 vào chart

    Kéo thả vào mục Marks các trường trong view:
    ▪ MaSP -> Color => để hiển thị màu phân biệt sp
    ▪ Sum(TongCaNam) -> Angle => để chia tỉ lệ trong biểu đồ
    ▪ Sum(TongCaNam) và MaSP -> Label => để hiển thị trên biểu đồ
    

![Ví dụ 2](./images/1d-1-2.png)

![Ví dụ 3](./images/1d-1-3.png)

![Ví dụ 4](./images/1d-1-4.png)

### Màn hình design của chart

![Ví dụ 5](./images/1d-1-5.png)


### 1D.2 Bảng số liệu chi tiết, tạo sheet mới, tô màu và vẽ đường viền
    Kéo thả các field trong View
![Ví dụ 6](./images/1d-1-6.png)

![Ví dụ 7](./images/1d-1-7.png)

### Tạo STT
![Ví dụ 8](./images/1d-1-8.png)

![Ví dụ 9](./images/1d-1-9.png)

### Màn hình design & preview chi tiết
![Ví dụ 10](./images/1d-1-10.png)

![Ví dụ 11](./images/1d-1-12.png)

### Tạo dashboard để hiển thị biểu đồ và chi tiết
    Kéo thả 2 sheet biểu đồ và sheet chi tiết vào
![Ví dụ 12](./images/1d-1-11.png)

### Màn hình design cuối cùng
![Ví dụ 13](./images/1d-1-13.png)

### Màn hình preview
![Ví dụ 14](./images/1d-1-14.png)


--------------