## A. Crystal Report Từ Bảng (Table)

Tạo một Crystal Report từ một bảng tùy chọn trong CSDL QLDT.

Yêu cầu:

- Đầy đủ cấu trúc của 1 Report.
- Thêm cột số thứ tự cho mỗi sinh viên bằng SQL.
- Tô nền vàng cho phần Page Header.
- Ngăn cách phần Details với Report Footer bằng 1 đường kẻ.
- Trình bày từng bước để tạo được Crystal Report.

### Các Bước Thực Hiện

#### Kết Nối SQL Server Với Tableau

![Bài 1.A - Kết nối SQL Server với Tableau](./images/tableau_connection.png)

#### Cập Nhật Title Của Report

![Bài 1.A - Cập Nhật Title Của Report](./images/update_title.png)

#### Kéo Fields Từ Data Panel Qua Rows Panel

![Bài 1.A - Kéo Fields Từ Data Panel Qua Rows Panel](./images/drag_data.png)

#### Bổ Sung Column STT

##### Tạo Calculated Field STT

![Bài 1.A - Tạo Calculated Field STT](./images/create_stt_field.png)

##### Kéo STT Vào Row Panel Và Chỉnh Sửa Thuộc Tính Cho Phù Hợp

Chọn thuộc tính `Discrete` để hiển thị STT rõ ràng.

![Bài 1.A - Chọn Thuộc Tính Discrete](./images/drag_stt_field.png)

#### Format Lại Layout

##### Kéo `Dia chi` Vào Mục `Text` Của `Marks` Panel

![Bài 1.A - Kéo Dia chi Vào Mục Text Của Marks Panel](./images/mark_diachi.png)

##### Kéo `Measure Names` Từ `Data` Panel Vào `Columns` Panel

![Bài 1.A - Kéo Measure Names Từ Data Vào Columns Panel](./images/drag_measure_names.png)

##### Cập Nhật Lại Màu Của Header

![Bài 1.A - Cập Nhật Lại Màu Của Header](./images/update_color.png)

##### Cập Nhật Lại Công Thức Tính Index Của STT Để Hiển Thị Chính Xác

- Chọn `Edit Table Calculation`

![Bài 1.A - Chọn Edit Table Calculation](./images/choose_edit_table_calculation.png)

- Cập nhật lại logic:
  - Chọn `Specific Dimensions`
  - Check tất cả các giá trị hiện tại cần kết hợp để xác định index.
  - Ở mục `At the level`: chọn `Deepest`

![Bài 1.A - Cập Nhật Lại Công Thức Tính Index Của STT](./images/update_calculation.png)

### Màn Hình Design

#### Tạo Dashboard Và Setup Layout

![Bài 1.A - Tạo Dashboard Và Setup Layout](./images/create_dashboard.png)

#### Thêm Title Cho Dashboard

![Bài 1.A - Thêm Title Cho Dashboard](./images/add_title_dashboard.png)

#### Kéo Report Vào Dashboard

![Bài 1.A - Kéo Report Vào Dashboard](./images/drag_report_to_dashboard.png)

#### Thêm Footer To Dashboard

![Bài 1.A - Thêm Footer To Dashboard](./images/add_footer_dashboard.png)

### Màn Hình Preview

![Bài 1.A - Màn Hình Preview](./images/full_report.png)

### Các Đối Tượng Sử Dụng

- `Mssv`
- `Tenv`
- `Sodt`
- `LOP`
- `Diachi`

![Bài 1.A - Các Trường Dữ Liệu Sử Dụng](./images/drag_data.png)
