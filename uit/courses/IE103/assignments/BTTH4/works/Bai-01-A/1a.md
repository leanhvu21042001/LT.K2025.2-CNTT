## A. Crystal Report Từ Bảng (Table)

Tạo một Crystal Report từ một bảng tùy chọn trong CSDL QLDT.

Yêu cầu:

- Đầy đủ cấu trúc của 1 Report.
- Thêm cột số thứ tự cho mỗi sinh viên bằng SQL.
- Tô nền vàng cho phần Page Header.
- Ngăn cách phần Details với Report Footer bằng 1 đường kẻ.
- Trình bày từng bước để tạo được Crystal Report.

### Kết Nối SQL Server Với Tableau

![Bài 1.A - Tableau Connection](./images/tableau_connection.png)

### Cập Nhật Title Của Report

![Bài 1.A - Update title](./images/update_title.png)

### Drag Các Database Fields Từ Data Panel Qua Rows Panel

![Bài 1.A - Drag data](./images/drag_data.png)

### Bổ Sung Column STT

#### Tạo Calculated Field

![Bài 1.A - Create stt field](./images/create_stt_field.png)

#### Drag Vào Row Panel và Chỉnh Sửa Thuộc Tính Cho Phù Hợp

Chọn thuộc tính `Discrete` để hiển thị STT rõ ràng.

![Bài 1.A - Drag stt field](./images/drag_stt_field.png)

### Format Lại Layout

#### Ẩn Đi Column Không Cần Thiết Có Chứa Nội Dung "ABC"

##### Drag Row `Dia chi` Vào Mục `Text` Của `Marks` Panel

![Bài 1.A - Mark dia chi](./images/mark_diachi.png)

##### Drag `Measure Names` Từ `Data` Panel Vào `Columns` Panel

![Bài 1.A - Drag measure name](./images/drag_measure_names.png)

##### Cập Nhật Lại Color Của Header

![Bài 1.A - Update color](./images/update_color.png)

##### Cập Nhật Lại Công Thức Tính Index Của STT Để Hiển Thị Chính Xác

- Chọn `Edit Table Calculation`

![Bài 1.A - Choose edit table calculation](./images/choose_edit_table_calculation.png)

- Cập nhật lại logic
  - Chọn `Specific Dimensions`
  - Check tất cả các giá trị hiện tại cần kết hợp để xác định index.
  - Ở mục `At the level`: chọn `Deepest`

![Bài 1.A - Update calculation](./images/update_calculation.png)

### Tạo Dashboard Cho Report

#### Tạo Dashboard Và Setup Layout

![Bài 1.A - Create dashboard](./images/create_dashboard.png)

#### Thêm Title Cho Dashboard

![Bài 1.A - Add title dashboard](./images/add_title_dashboard.png)

#### Drag Report Vào Dashboard

![Bài 1.A - Drag report to dashboard](./images/drag_report_to_dashboard.png)

#### Add Footer To Dashboard

![Bài 1.A - Add footer to dashboard](./images/add_footer_dashboard.png)

### Report Hoàn Chỉnh

![Bài 1.A - Full Report](./images/full_report.png)
