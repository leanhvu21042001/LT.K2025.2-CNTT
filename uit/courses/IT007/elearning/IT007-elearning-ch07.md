# Quản Lý Bộ Nhớ

Mục tiêu:

1. Khái niệm cơ sở về bộ nhớ.
2. Các kiểu địa chỉ nhớ và cách chuyển đổi giữa các kiểu này.
3. Các cơ chế và mô hình quản lý bộ nhớ.

Nội dung:

1. Khái niệm cơ sở.
2. Các kiểu địa chỉ nhớ.
3. Chuyển đổi địa chỉ nhớ.
4. Mô hình quản lý bộ nhớ.
5. Cơ chế phân trang.
6. Cơ chế swapping.

## Khái niệm cơ sở về bộ nhớ

### VIDEO: KHÁI NIỆM CƠ SỞ VỀ BỘ NHỚ

Trình bày giới thiệu quản lý bộ nhớ, trình bày mục tiêu và nội dung chương 7 - Quản lý bộ nhớ và trình bày giới thiệu các khái niệm cơ sở về bộ nhớ.

- [[Hệ điều hành] Chương 7.1: Khái niệm cơ sở về bộ nhớ](https://www.youtube.com/watch?v=6PiPe10l9E4)

- Chương trình phải được mang vào tỏng bộ nhớ và đặt nó trong một tiến trình để được xử lý.
- Input Queue: Một tập hợp của những tiến trình trên đĩa mà đang chờ để được mang vào trong bộ nhớ để thực thi.
- User programs trải qua nhiều bước trước khi được xử lý.
- Quản lý bộ nhớ: là công việc của hệ điều hành với sự hỗ trợ của phần cứng nhằm phân phối, sắp xếp các tiến trình trong bộ nhớ sao cho hiệu quả.
- Mục tiêu cần đạt được: là nạp càng nhiều tiến trình vào bộ nhớ càng tốt (gia tăng mức độ đa chương).
- Trong hầu hết các hệ thống, **kernel sẽ chiếm một phần cố định của bộ nhớ**; phần còn lại phân phối cho các tiến trình.
- Các yêu cầu đối với việc quản lý bộ nhớ:
    - Cấp phát bộ nhớ cho các tiến trình
    - Tái định vị (relocation): khi swapping,…
    - Bảo vệ: kiểm tra truy xuất bộ nhớ có hợp lệ không
    - Chia sẻ: cho phép các tiến trình chia sẻ vùng nhớ chung
    - Kết gán địa chỉ nhớ luận lý của user vào địa chỉ thực


