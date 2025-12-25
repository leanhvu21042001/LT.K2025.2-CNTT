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

### Slide: Khái niệm cơ sở về bộ nhớ

### Quiz: Khái niệm cơ sở về bộ nhớ

> [!NOTE]
> Chọn phát biểu đúng khi nói về việc quản lý bộ nhớ?
> 
> - [ ] Chương trình ứng dụng chỉ làm việc với địa chỉ luận lý và không bao giờ nhìn thấy địa chỉ vật lý thực sự
> - [x] Tất cả các đáp án đều đúng
> - [ ] Địa chỉ bộ nhớ trong mã nguồn được biểu diễn dưới dạng ký hiệu (symbolic)
> - [ ] Việc liên kết địa chỉ sẽ được thực hiện trong giai đoạn thực thi nếu chương trình cần truy cập đến một vị trí nào đó trong bộ nhớ chính

> [!NOTE]
> Chọn phát biểu đúng trong các phát biểu sau?
> 
> - [ ] Tất cả đều đúng
> - [ ] Input queue là một tập các tiến trình trên RAM đang chờ được cấp CPU
> - [x] Chương trình cần phải được nạp vào bộ nhớ chính và được cấp phát CPU cùng với các tài nguyên khác thì mới có thể được thực thi
> - [ ] Chương trình chỉ cần được cấp CPU là có thể được thực thi

> [!NOTE]
> Những yêu cầu nào sau đây KHÔNG phải là yêu cầu dành cho quản lý bộ nhớ?
> 
> - [ ] Kiểm tra việc truy xuất bộ nhớ có hợp lệ không
> - [ ] Cấp phát/thu hồi bộ nhớ cho các tiến trình
> - [ ] Cho phép các tiến trình chia sẻ vùng nhớ chung
> - [ ] Tái định vị
> - [ ] Chuyển địa chỉ luận lý thành địa chỉ thực
> - [x] Cho phép các tiến trình được tự chia sẻ vùng nhớ chung

## Các kiểu địa chỉ nhớ

### VIDEO: CÁC KIỂU ĐỊA CHỈ NHỚ

Trình bày về các kiểu địa chỉ nhớ bao gồm địa chỉ vật lý, địa chỉ luận lý, các khái niệm liên quan đến linking và địa chỉ bộ nhớ khi linking.

- Địa chỉ vật lý (**physical address**) (địa chỉ thực): là một vị trí thực trong bộ nhớ chính.
- Địa chỉ luận lý (**logical address**): là một vị trí nhớ được diễn tả trong một chương trình (còn gọi là địa chỉ ảo - virtual address).
    - Các trình biên dịch (compiler) tạo ra mã lệnh chương trình mà trong đó mọi tham chiếu bộ nhớ đều là địa chỉ luận lý.
- Địa chỉ tuyệt đối (**absolute address**): địa chỉ tương đương với địa chỉ thực.
- Địa chỉ tương đối (**relative address**) (địa chỉ khả tái định vị, relocatable address) là một kiểu địa chỉ luận lý trong đó các địa chỉ được biểu diễn tương đối so với một vị trí xác định nào đó trong chương trình.
    - Ví dụ: 12 byte so với vị trí bắt đầu chương trình,…

Ví dụ:

```c
#include <stdio.h>

int main() {
    int soNguyen = 10;
    printf("Giá trị của soNguyen: %d\n", soNguyen);
    printf("Vị trí của soNguyen trong bộ nhớ: %p\n", &soNguyen);
    return 0;
}
```

## Chuyển đổi địa chỉ nhớ

## Mô hình quản lý bộ nhớ

## Cơ chế phân trang

## Cơ chế hoán vị

## Bài kiểm tra tiểu kết
