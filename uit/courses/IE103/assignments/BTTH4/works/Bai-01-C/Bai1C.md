

## Bài 1C: Cho CSDL Quản lý bán hàng đính kèm bên dưới
    Hãy dùng Tableau để thiết kế một báo cáo cho biết Doanh thu theo tháng
    của từng nhân viên trong năm 2006. Yêu cầu gồm có 2 phần sau:
    ▪ Phần Biểu đồ đường (Line Chart): Cho biết sự biến động về doanh số bán được của từng nhân viên qua các tháng trong năm 2006.
        o Trục X là các tháng trong năm 2006, trục Y là doanh số bán được.
        o Mỗi đường biểu thị một nhân viên tương ứng.
    ▪ Phần Bảng số liệu chi tiết: Cho biết doanh thu cụ thể của tháng đó với từng nhân viên. Trong đó có:
        o Tổng doanh thu theo từng nhân viên.
        o Tổng doanh thu của tất cả nhân viên trong năm 2006.
        o Lưu ý: Một số tháng không được hiển thị là do bảng HOADON không có số liệu bán hàng của tháng đó.

### 1C.1 Tạo View cho doanh thu năm 2006

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
\
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

### Kiểm tra kết quả của view vừa tạo

```sql
   SELECT * FROM V_BAOCAO_DOANHTHU_2006  ORDER BY MANV, Thang;
```
![Ví dụ 1](./images/1c-1-1.png)

### Kết nối SQL Server với Tableau
![Ví dụ 2](./images/1c-1-2.png)

### Kéo VIEW V_BAOCAO_DOANHTHU_2006 vào trong Worksheet để tạo chart line
![Ví dụ 3](./images/1c-1-3.png)

### Mapping dữ liệu từ View V_BAOCAO_DOANHTHU_2006 đã tạo theo trục X và Y
![Ví dụ 4](./images/1c-1-4.png)

### Format và chỉnh sửa lại các tiêu đề trên chart
![Ví dụ 5](./images/1c-1-5.png)

![Ví dụ 6](./images/1c-1-6.png)

### Màn hình design và preview của chart sau khi chỉnh sửa 
![Ví dụ 7](./images/1c-1-7.png)

![Ví dụ 8](./images/1c-1-8.png)

### 1C.2 Bảng số liệu chi tiết - tạo thêm 1 sheet cho chi tiết và mapping dữ liệu từ view V_BAOCAO_DOANHTHU_2006
   
![Ví dụ 9](./images/1c-1-9.png)

### Tạo label để hiển thị dạng MaNV - HoTen
![Ví dụ 10](./images/1c-1-10.png)

![Ví dụ 11](./images/1c-1-11.png)

### Format các cột tính tổng, vị trí hiển thị
![Ví dụ 12](./images/1c-1-12.png)

### Màn hình design và preview của table chi tiết

![Ví dụ 13](./images/1c-1-13.png)

![Ví dụ 14](./images/1c-1-14.png)

### Tạo thêm 1 dashboard để hiển thị biểu đồ và chi tiết
![Ví dụ 15](./images/1c-1-15.png)

### Format dashboard
![Ví dụ 16](./images/1c-1-16.png)

### Màn hình design và preview cuối
![Ví dụ 17](./images/1c-1-17.png)

![Ví dụ 18](./images/1c-1-18.png)

--------------