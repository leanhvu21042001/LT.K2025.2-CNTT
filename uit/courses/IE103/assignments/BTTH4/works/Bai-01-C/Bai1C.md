## C. Crystal Report Báo Cáo Doanh Thu

Cho CSDL Quản lý bán hàng đính kèm bên dưới. Hãy dùng Crystal Report để thiết kế một báo cáo cho biết Doanh thu theo tháng của từng nhân viên trong năm 2006.

Yêu cầu gồm có 2 phần sau:

- Phần Biểu đồ đường (Line Chart): Cho biết sự biến động về doanh số bán được của từng nhân viên qua các tháng trong năm 2006.
    - Trục X là các tháng trong năm 2006, trục Y là doanh số bán được.
    - Mỗi đường biểu thị một nhân viên tương ứng.

- Phần Bảng số liệu chi tiết: Cho biết doanh thu cụ thể của tháng đó với từng nhân viên. Trong đó có:
    - Tổng doanh thu theo từng nhân viên.
    - Tổng doanh thu của tất cả nhân viên trong năm 2006.
    - Lưu ý: Một số tháng không được hiển thị là do bảng `HOADON` không có số liệu bán hàng của tháng đó.

### Tạo View Cho Doanh Thu Năm 2006

```sql
-- Tạo View để tổng hợp doanh thu theo nhân viên và tháng trong năm 2006

CREATE OR ALTER VIEW V_BAOCAO_DOANHTHU_2006 AS
WITH
NhanVienActive AS (
    SELECT DISTINCT NV.MANV, NV.HOTEN
    FROM NHANVIEN NV
    JOIN HOADON HD ON NV.MANV = HD.MANV
    WHERE YEAR(HD.NGHD) = 2006
),

CacThangActive AS (
    SELECT DISTINCT MONTH(NGHD) AS Thang
    FROM HOADON
    WHERE YEAR(NGHD) = 2006
),

Data AS (
    SELECT NV.MANV, NV.HOTEN, T.Thang
    FROM NhanVienActive NV
    CROSS JOIN CacThangActive T
)
SELECT
    K.MANV,
    K.HOTEN,
    K.Thang,
    ISNULL(SUM(HD.TRIGIA), 0) AS TongTien
FROM
    Data K
LEFT JOIN
    HOADON HD ON K.MANV = HD.MANV
              AND K.Thang = MONTH(HD.NGHD)
              AND YEAR(HD.NGHD) = 2006
GROUP BY
    K.MANV, K.HOTEN, K.Thang
GO
```

### Kiểm Tra Kết Quả Của View Vừa Tạo

```sql
   SELECT * FROM V_BAOCAO_DOANHTHU_2006  ORDER BY MANV, Thang;
```

![Bài 1.C - Kiểm tra kết quả view](./images/1c-1-1.png)

### Kết Nối SQL Server Với Tableau

![Bài 1.C - Kết nối SQL Server với Tableau](./images/1c-1-2.png)

### Kéo VIEW V_BAOCAO_DOANHTHU_2006 Vào Trong Worksheet Để Tạo Chart Line

![Bài 1.C - Kéo view vào worksheet](./images/1c-1-3.png)

### Mapping Dữ Liệu Từ View V_BAOCAO_DOANHTHU_2006 Đã Tạo Theo Trục X Và Y

![Bài 1.C - Mapping dữ liệu](./images/1c-1-4.png)

### Format Và Chỉnh Sửa Lại Các Tiêu Đề Trên Chart

![Bài 1.C - Format và chỉnh sửa lại các tiêu đề trên chart (1)](./images/1c-1-5.png)

![Bài 1.C - Format và chỉnh sửa lại các tiêu đề trên chart (2)](./images/1c-1-6.png)

### Màn Hình Design Và Preview Của Chart Sau Khi Chỉnh Sửa

![Bài 1.C - Màn hình design và preview của chart (1)](./images/1c-1-7.png)

![Bài 1.C - Màn hình design và preview của chart (2)](./images/1c-1-8.png)

### Bảng Số Liệu Chi Tiết - Tạo Thêm 1 Sheet Cho Chi Tiết Và Mapping Dữ Liệu Từ View V_BAOCAO_DOANHTHU_2006

![Bài 1.C - Bảng số liệu chi tiết](./images/1c-1-9.png)

### Tạo Label Để Hiển Thị Dạng MaNV - HoTen

![Bài 1.C - Tạo label để hiển thị dạng MaNV - HoTen (1)](./images/1c-1-10.png)

![Bài 1.C - Tạo label để hiển thị dạng MaNV - HoTen (2)](./images/1c-1-11.png)

### Format Các Cột Tính Tổng, Vị Trí Hiển Thị

![Bài 1.C - Format các cột tính tổng, vị trí hiển thị](./images/1c-1-12.png)

### Màn Hình Design Và Preview Của Table Chi Tiết

![Bài 1.C - Màn hình design và preview của table chi tiết (1)](./images/1c-1-13.png)

![Bài 1.C - Màn hình design và preview của table chi tiết (2)](./images/1c-1-14.png)

### Tạo Thêm 1 Dashboard Để Hiển Thị Biểu Đồ Và Chi Tiết

![Bài 1.C - Tạo thêm 1 dashboard để hiển thị biểu đồ và chi tiết](./images/1c-1-15.png)

### Format Dashboard

![Bài 1.C - Format dashboard](./images/1c-1-16.png)

### Màn Hình Design Và Preview Hoàn Thành

![Bài 1.C - Màn hình design và preview hoàn thành (1)](./images/1c-1-17.png)

![Bài 1.C - Màn hình design và preview hoàn thành (2)](./images/1c-1-18.png)
