# Chương 3: Quản Lý Tiến Trình

Trên các máy tính đời cũ, chỉ có một chương trình duy nhất được phép thực thi tại một thời điểm. Chương trình này chiếm toàn quyền điều khiển và được phép truy cập tất cả tài nguyên của hệ thống. Ngược lại, các hệ thống máy tính ngày nay cho phép nhiều chương trình cùng được nạp vào bộ nhớ chính và được thực thi đồng thời với nhau.

Sự phát triển này đòi hỏi sự kiểm soát chặt chẽ hơn và khả năng phân chia mạnh mẽ hơn đối với các chương trình khác nhau. Các nhu cầu này dẫn đến sự ra đời của khái niệm tiến trình - một chương trình được thực thi. Một tiến trình là một đơn vị công việc trong các hệ thống máy tính hiện đại.

Mục tiêu:

- Phát biểu được khái niệm và các trạng thái của tiến trình
- Liệt kê được các thông số của tiến trình
- Mô tả được các khái niệm về định thời tiến trình
- Liệt kê được các tác vụ cơ bản của tiến trình
- Ứng dụng được các cách tạo và hủy tiến trình
- Phát biểu được cách giao tiếp giữa các tiến tình

Nội dung:

- Khái niệm cơ bản
- Trạng thái của tiến trình
- Khối điều khiển tiến trình
- Định thời tiến trình
- Các tác vụ đối với tiến trình
- Sự cộng tác giữa các tiến trình
- Giao tiếp giữa các tiến trình
- Tiểu trình

## Khái niệm cơ bản

### Quiz 1

Tiến trình KHÔNG bao gồm thành phần nào sau đây?

- [ ] Địa chỉ trả về sau hoàn tất hàm
- [x] Đoạn mã khởi động máy tính
- [ ] Con trỏ chỉ câu lệnh thực thi tiếp theo
- [ ] Các thanh ghi

Biết đoạn chương trình trên là source code của chương trình tên là `test`. Nếu thực thi lệnh

```bash
./test He Dieu Hanh
```

```
Hello, He
```

NHỮNG phát biểu nào sau đây là đúng khi nói về tiến trình?

- [x] Tiến trình là thực thể chủ động
- [ ] Tiến trình không gây ra thay đổi gì trên hệ thống máy tính
- [ ] Sau khi cài đặt xong, chương trình sẽ trở thành tiến trình
- [x] Tiến trình được lưu trên bộ nhớ chinh

Trong các vùng nhớ sau, vùng nhớ nào có khả năng thay đổi kích thước khi tiến trình thực thi?

- [ ] Data section
- [ ] Text section
- [x] Heap section
- [x] Stack section

## Trạng thái của tiến trình

## Khối điều khiển tiến trình

## Định thời tiến trình

## Các tác vụ đối với tiến trình

## Sự cộng tác giữa các tiến trình

## Giao tiếp giữa các tiến trình

## Tiểu trình

## Báo Cáo

Đề bài tiếp theo cho các bạn có thể nói là không phải cốt lõi môn học, và có thể chỉ có giá trị thường thức, không bổ béo gì cho lắm: Phân biệt Unix-like vs Unix-based. Tại sao các công ty vẫn dùng song song 2 hệ này.

Phân tích nhanh: Linux (Unix-like) đi cùng GPL với các yêu cầu có thể tóm tắt đơn giản như sau: 1. Phải trích dẫn công lao (credits) của những người đã tham gia làm nên phần mềm đó. 2. Phải đóng góp ngược lại phần code nếu đã có thay đổi/bổ sung nếu họ phát triển một sản phẩm từ phần mềm đó. Mục 1 thì được, nhưng mục 2 thì rõ ràng các công ty họ khó mà đồng ý, vì khi đó phần code có thể là lợi thế cạnh tranh của họ lại phải đem ra cho cộng đồng. Trong khi đó, với Unix-based (một số họ BSD), doanh nghiệp có thể dùng thoải mái và làm bất kỳ điều gì họ muốn. Và, quan trọng hơn, tất cả đều là POSIX nên có thể port qua lại với một ít chỉnh sửa.
