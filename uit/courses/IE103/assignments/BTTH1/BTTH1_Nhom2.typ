#import "../../../../../tools/typst/libs/academic-alt.typ": *

#show: university-assignment.with(
  title: "Bài Tập Thực Hành 1",
  subtitle: "IE103 - Quản Lý Thông Tin",
  author: "Nhóm 2",
  details: (
    course: "IE103",
    instructor: "Ths. Nguyễn Thành Luân",
    due-date: "Tháng 12, 2025",
    duration: "~3 hours",
    lab-number: "BTTH1",
  )
)

= Nhóm 2

#figure(
  align(center)[
  #table(
    columns: (10%, 20%, 70%),
    align: (right,left,left,),
    table.header([#strong[No];], [#strong[MSSV];], [#strong[Họ và Tên];],),
    table.hline(),
    [1], [25410291], [Đinh Xuân Sâm],
    [2], [25410319], [Đặng Hữu Toàn],
    [3], [25410321], [Nguyễn Điền Triết],
    [4], [25410204], [Trương Xuân Hậu],
    [5], [25410338], [Lê Anh Vũ],
    [6], [25410176], [Trần Sơn Bình],
    [7], [25410247], [Lê Kim Long],
    [8], [25410337], [La Anh Vũ],
    [9], [25410209], [Lê Ngọc Hiệp],
    [10], [25410271], [Nguyễn Thị Ngọc Nhung],
  )]
  , kind: table,
  caption: [Nhóm 2 (Omega)]
  )

#pagebreak()

= Bài 1

Trong Gmail, anh/chị hãy cho biết:

+ Gmail đã cung cấp các tính năng gì để phục vụ cho việc tổ chức tốt các
  mails?
+ Cấu trúc đầy đủ của một email.
+ Phân loại mails.
+ Khái niệm mailgroup.
+ Hãy tạo thêm các thư mục (Label) sau: Giải Trí, Sức Khỏe, Thể Thao,
  Học Tập.
+ Hãy đánh dấu và di chuyển các mails vào các thư mục vừa tạo tương ứng.
+ Một account hiện tại có dung lượng tối đa bao nhiêu?
+ Hãy tạo ra một mailgroup trong gmail và cho biết lợi ích của nó? Tìm
  hiểu các tính năng admin/member.
+ Các tính năng tìm kiếm mail.
+ Tìm hiểu tính năng: Filter message like this.

== Các tính năng tổ chức mail

Gmail cung cấp các tính năng hỗ trợ công việc như:

- Tổ chức email bằng bộ lọc (Filter) và nhãn (Label),
- Tìm kiếm nhanh,
- Chặn spam hiệu quả và lưu trữ an toàn.
- Ngoài ra còn tích hợp Drive/Meet để chia sẻ tài liệu và trao đổi thuận tiện.

== Cấu trúc của một email

=== Header (Phần tiêu đề)

#figure(
  align(center)[#table(
    columns: 4,
    align: (left,left,left,left,),
    table.header([Thành phần], [Ý Nghĩa], [Mục đích], [Lưu ý],),
    table.hline(),
    [From], [Người gửi], [Địa chỉ email của bạn.], [Nên sử dụng một địa
    chỉ email chuyên nghiệp (ví dụ: `[tên].[họ]@congty.com`).],
    [To], [Người nhận], [Địa chỉ email của người/tổ chức bạn muốn gửi
    thư.], [Kiểm tra kỹ lưỡng, tránh gửi nhầm hoặc thiếu người quan
    trọng.],
    [Cc], [Carbon Copy], [Gửi bản sao cho những người cần nắm thông tin
    nhưng không cần phản hồi trực tiếp.], [Sử dụng khi cần thông báo cho
    cấp trên, đồng nghiệp liên quan.],
    [Bcc], [Blind Carbon Copy], [Gửi bản sao bí mật. Người nhận trong
    mục To và Cc sẽ không thấy danh sách email trong mục Bcc.], [Sử dụng
    để bảo mật danh sách người nhận (ví dụ: gửi email marketing).],
    [Subject], [Tiêu đề], [Tóm tắt nội dung email một cách ngắn gọn, rõ
    ràng, và thu hút.], [Quan trọng nhất! Cần rõ ràng, tối đa 5-7 từ, ví
    dụ: "#emph[Báo cáo tiến độ dự án A1 -- Tuần 3];" hoặc "#emph[Đề xuất
    họp khẩn về chiến lược kinh doanh];".],
  )]
  , kind: table
  , caption: [Header (Phần tiêu đề)]
  )

=== Các phần khác

- #strong[Salutation:] Lời chào.
- #strong[Body:] Nội dung chính.
- #strong[Closing:] Lời kết.
- #strong[Signature:] Chữ ký.
- #strong[Attachments:] Tệp đính kèm.

== Phân loại mails

== Khái niệm Mail Group

== Sắp xếp Email với Label

== Dung lượng tối đa

== Mail Group trong GMail

=== Cách tạo

=== Lợi ích

=== Vai trò Admin vs Member

== Tính năng tìm kiếm

=== Thanh tìm kiếm thông minh

=== Toán tử Tìm kiếm (Search Operators)

== "Filter messages like this"

=== Cơ chế Tạo Bộ lọc

=== Các Hành động Tự động của Bộ lọc (Quan trọng)



= Bài 2


= Bài 3


= Bài 4

== Ví Dụ

=== `AFTER` Trigger Example

Miêu tả: Cho mỗi câu lệnh `INSERT` vào bảng `BankAccounts`, tạo một bản
ghi tương ứng trong `UserLogs` ghi lại các thay đổi bao gồm:

- Ai thực hiện?
- Thực hiện gì?

DBMS: PostgreSQL:

```sql
-- Create an after-insert trigger for UserLogs
CREATE FUNCTION after_insert_trigger_function()
RETURNS TRIGGER AS $$
BEGIN
    -- Perform some action, like logging the insert
    INSERT INTO UserLogs (account_number, action)
    VALUES (NEW.account_number, CONCAT('New record inserted for ', NEW.account_holder));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Attach the trigger to the BankAccounts table
CREATE TRIGGER after_insert_trigger
AFTER INSERT ON BankAccounts
FOR EACH ROW
EXECUTE PROCEDURE after_insert_trigger_function();
```
