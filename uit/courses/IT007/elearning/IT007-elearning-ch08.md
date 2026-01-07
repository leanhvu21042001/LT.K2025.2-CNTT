---
created: 2026-01-08T07:39:00
updated:
type: Course
id:
title: Bộ Nhớ Ảo
subject: Operating Systems
tags:
  - OS
provider: UIT
---

# Chương 8. Bộ Nhớ Ảo

## Tổng Quan Về Bộ Nhớ Ảo

Ôn tập các chương trước và dẫn nhập giới thiệu bộ nhớ ảo, trình bày mục tiêu và nội dung chương 8 - Bộ nhớ ảo và trình bày giới thiệu tổng quan về bộ nhớ ảo.

Mục tiêu:

- Khái niệm tổng quan về bộ nhớ ảo.
- Hiểu và vận dụng các kỹ thuật cài đặt bộ nhớ ảo: demand paging, demand segmentation.
- Hiểu các vấn đề: frames, thrashing.

Nội dung:

- Tổng quan về bộ nhớ ảo.
- Cài đặt bộ nhớ ảo: demand paging
- Các giải thuật thay trang (Page Replacement Algorithms).
- Vấn đề cấp phát Frames.
- Vấn đề Thrashing.

### Tổng Quan Về Bộ Nhớ Ảo

#### Nhắc Lại Cơ Chế Dynamic Loading

- Cơ chế:
    - Chỉ khi nào cần được gọi đến thì một thủ tục mới được nạp vào bộ nhớ chính.
    - Tăng độ hiệu dụng của bộ nhớ bởi vì các thủ tục không được gọi đến sẽ không chiếm chỗ trong bộ nhớ.
- Rất hiệu quả trong trường hợp:
    - Tồn tại khối lượng mã lớn
    - Có tần suất sử dụng thấp
    - Không được sử dụng thường xuyên.
- Hỗ trợ từ hệ điều hành:
    - Thông thường, user chịu trách nhiệm thiết kế và thực hiện các chương trình có dynamic loading.
    - Hệ điều hành chủ yếu cung cấp một số thủ tục thư viện hỗ trợ, tạo điều kiện dễ dàng hơn cho lập trình viên.

#### Tổng Quan Về Bộ Nhớ Ảo

- Nhận xét:
    - Không phải tất cả các phần của một process cần thiết phải được nạp vào bộ nhớ chính tại cùng một thời điểm.
- Ví dụ:
    - Đoạn mã điều khiển các lỗi hiếm khi xẩy ra.
    - Các arrays, list, table được cấp phát bộ bộ nhớ (tĩnh) nhiều hơn yêu cầu thực sự.
    - Các tính năng ít khi được dùng của một chương trình.
    - Cả chương trình thì cũng có đoạn chưa được dùng.
- Ưu điểm:
    - Số lượng process trong bộ nhớ nhiều hơn.
    - Một process có thể thực thi ngay cả khi kích thước của nó lớn hơn bộ nhớ thực.
    - Giảm nhẹ công việc của lập trình viên.
- Không gian tráo đổi giữa bộ nhớ chính và bộ nhớ phụ (swap space)
    - swap partition trong Linux.
    - `pagefile.sys` trong Windows.

#### Quiz: Tổng Quan Về Bộ Nhớ Ảo

> [!NOTE]
> Phát biểu sau đúng hay sai? “Nếu như hệ thống không cần nạp toàn bộ tiến trình vào bộ nhớ vật lý để thực thi, hệ thống có thể tận dụng dung lượng bộ nhớ còn lại để chạy nhiều tiến trình khác?
> 
> - [x] True
> - [ ] False

> [!NOTE]
> Những yêu cầu nào sau đây KHÔNG phải là ưu điểm của bộ nhớ ảo?
> 
> - [ ] Giảm nhẹ công việc của lập trình viên
> - [ ] Một process có thể thực thi ngay cả khi kích thước của nó lớn hơn bộ nhớ thực
> - [ ] Số lượng process trong bộ nhớ nhiều hơn
> - [x] Cho phép các tiến trình được tự chia sẻ vùng nhớ chung

> [!NOTE]
> Bộ nhớ ảo là một kỹ thuật cho phép xử lý?
> 
> - [ ] Một tiến trình phải được nạp toàn bộ vào bộ nhớ vật lý
> - [ ] Chương trình chỉ cần nằm trên ổ cứng là có thể thực thi
> - [x] Một tiến trình không được nạp toàn bộ vào bộ nhớ vật lý
> - [ ] Tất cả đều đúng

### Cài Đặt Bộ Nhớ Ảo
