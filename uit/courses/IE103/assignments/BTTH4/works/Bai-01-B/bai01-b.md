## B. Crystal Report Từ View

Tạo một View cho biết thông tin đề tài, thông tin giáo viên là ủy viên đề tài và điểm số của các giáo viên ủy viên này cho từng đề tài. Sau đó tạo một Crystal Report từ View vừa tạo.

Yêu cầu:

- Đầy đủ cấu trúc của 1 Report.
- Thêm cột số thứ tự cho mỗi đề tài bằng Crystal Report.
- Sắp xếp điểm giảm dần theo từng đề tài.
- Page Header có 2 đường kẻ trên cùng và 1 đường kẻ dưới cùng, Report Footer có 2 đường kẻ. Tô nền vàng cho Page Header và Report Footer.
- Ngăn cách phần mỗi đề tài trong phần Details bằng 1 đường kẻ trước mỗi đề tài.

### Màn Hình Design

![Bài 1.B - Màn Hình Design](./images/config_stt_field.png)

### Màn Hình Preview 

![Bài 1.B - Màn Hình Preview](./images/dashboard_2.png)

### Các Đối Tượng Sử Dụng

Các Bảng và Trường tương ứng:

- `STT`
- `GV_UVDT`.`Diem`: `SUM(Diem)`
- `DETAI`.`Msdt`
- `DETAI`.`Tendt`
- `GIAOVIEN`.`Msgv(Giaovien)`

![Bài 1.B - Các Đối Tượng Sử Dụng](./images/drag_relevant_fields.png)
