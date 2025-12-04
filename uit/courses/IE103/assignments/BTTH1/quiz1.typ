#import "../../../../../tools/typst/libs/academic-alt.typ": *

Trong Gmail, anh/chị hãy cho biết:

+ Gmail đã cung cấp các tính năng gì để phục vụ cho việc tổ chức tốt các mails?
+ Cấu trúc đầy đủ của một email.
+ Phân loại mails.
+ Khái niệm mailgroup.
+ Hãy tạo thêm các thư mục (Label) sau: Giải Trí, Sức Khỏe, Thể Thao, Học Tập.
+ Hãy đánh dấu và di chuyển các mails vào các thư mục vừa tạo tương ứng.
+ Một account hiện tại có dung lượng tối đa bao nhiêu?
+ Hãy tạo ra một mailgroup trong gmail và cho biết lợi ích của nó? Tìm hiểu các tính năng admin/member.
+ Các tính năng tìm kiếm mail.
+ Tìm hiểu tính năng: Filter message like this.

#todo[Bài 1. Giới Thiệu, hoặc Mở Đầu, trước khi vào nội dung chính.]

== Các tính năng tổ chức mail
<chuc-nang-gmail>

Gmail cung cấp các tính năng hỗ trợ công việc như:

- Tổ chức email bằng bộ lọc (Filter) và nhãn (Label),
- Tìm kiếm nhanh,
- Chặn spam hiệu quả và lưu trữ an toàn.
- Ngoài ra còn tích hợp Drive/Meet để chia sẻ tài liệu và trao đổi thuận tiện.

== Cấu trúc của một email
<cau-truc-email>

=== Header (Phần tiêu đề)

#figure(
  align(center)[
  #table(
    columns: 4,
    align: (left,left,left,left,),
    table.header([Thành phần], [Ý Nghĩa], [Mục đích], [Lưu ý],),
    table.hline(),
    [From], [Người gửi], [Địa chỉ email của bạn.], [Nên sử dụng một địa chỉ email chuyên nghiệp (ví dụ: `[tên].[họ]@congty.com`).],
    [To], [Người nhận], [Địa chỉ email của người/tổ chức bạn muốn gửi thư.], [Kiểm tra kỹ lưỡng, tránh gửi nhầm hoặc thiếu người quan
    trọng.],
    [Cc], [Carbon Copy], [Gửi bản sao cho những người cần nắm thông tin nhưng không cần phản hồi trực tiếp.], [Sử dụng khi cần thông báo cho cấp trên, đồng nghiệp liên quan.],
    [Bcc], [Blind Carbon Copy], [Gửi bản sao bí mật. Người nhận trong mục To và Cc sẽ không thấy danh sách email trong mục Bcc.], [Sử dụng để bảo mật danh sách người nhận (ví dụ: gửi email marketing).],
    [Subject], [Tiêu đề], [Tóm tắt nội dung email một cách ngắn gọn, rõ ràng, và thu hút.], [Quan trọng nhất! Cần rõ ràng, tối đa 5-7 từ, ví dụ: "#emph[Báo cáo tiến độ dự án A1 -- Tuần 3];" hoặc #emph["Đề xuất họp khẩn về chiến lược kinh doanh"];.],
  )]
  , kind: table
  , caption: [Bài 1. Header (Phần tiêu đề)]
  )

=== Các phần khác

- #strong[Salutation:] Lời chào.
- #strong[Body:] Nội dung chính.
- #strong[Closing:] Lời kết.
- #strong[Signature:] Chữ ký.
- #strong[Attachments:] Tệp đính kèm.

== Phân loại Mails
<phan-loai-mails>

Phân loại mail là sắp xếp email theo nhãn (Label), thư mục hoặc tiêu chí nhất định để dễ quản lý.

- Công Việc

#figure(image("assets/1.3.2.1.2_CongViec.png"),
  caption: [
    Bài 1. Công Việc
  ]
)

- Quan Trọng

#figure(image("assets/1.3.2.1.2_QuanTrong.png"),
  caption: [
    Bài 1. Quan Trọng
  ]
)

== Mail Group
<mailgroup>

Mail group là nhóm gồm nhiều địa chỉ email được gom lại dưới một tên chung. Khi gửi email đến mail group, hệ thống sẽ tự động gửi cho tất cả các thành viên trong nhóm.

#figure(image("assets/1.3.2.1.3_MailGroup_DanhBa.png"),
  caption: [
    Bài 1. Danh Bạ Mail Group
  ]
)

#figure(image("assets/1.3.2.1.3_MailGroup_Send.png"),
  caption: [
    Bài 1. Gửi Mail tới Mail Group
  ]
)

== Sắp xếp Email với Label

Đã thực hiện tạo các nhãn: Giải Trí, Sức Khỏe, Thể Thao, Học Tập và di chuyển mail tương ứng.

#figure(image("assets/1.3.2.2_Email_Folders.png"),
  caption: [
    Bài 1. Sắp xếp emails với các label/thư mục tương ứng.
  ]
)

== Dung lượng tối đa Gmail

- #strong[Gmail miễn phí:] 15 GB (dùng chung cho Gmail, Drive, Photos).
- #strong[Google Workspace (Trả phí):] Từ 30 GB đến 5 TB hoặc không giới hạn tùy gói.

== Mail Group trong GMail

=== Cách tạo

- #strong[Truy cập: groups.google.com] và đăng nhập bằng tài khoản Google của bạn.
- #strong[Tạo nhóm:] Nhấp vào #strong["Create group"];.
- #strong[Thiết lập cơ bản:]
  - #strong[Tên nhóm:] Tên hiển thị (#strong[ví dụ: "Ban Phát triển Sản phẩm"];).
  - #strong[Địa chỉ Email Nhóm:] Địa chỉ email độc nhất (ví dụ: `pds@googlegroups.com`).
  - #strong[Mô tả:] Giải thích mục đích của nhóm.
- #strong[Thiết lập quyền riêng tư:] Chọn giữa các loại nhóm:
  - #strong[Công khai (Public):] Bất kỳ ai cũng có thể tìm kiếm và xem cuộc hội thoại.
  - #strong[Đồng bộ riêng tư (Private):] Chỉ các thành viên mới được xem, yêu cầu phải mời hoặc phải duyệt.

=== Lợi ích

- #strong[Giao tiếp Tập trung:]
  - Chỉ cần gửi thư đến một địa chỉ nhóm để tiếp cận tất cả thành viên, lý tưởng cho thông báo toàn công ty, phòng ban, hoặc dự án.
- #strong[Kho lưu trữ Thảo luận:]
  - Tất cả email gửi đến nhóm được tự động lưu trữ trong Kho lưu trữ (Archive) của Google Groups, tạo một cơ sở kiến thức có thể tìm
    kiếm.
- #strong[Quản lý Quyền truy cập:]
  - Dùng địa chỉ nhóm làm đối tượng cấp quyền truy cập vào các tài nguyên khác của Google (Google Drive, Calendar, Sites) thay vì cấp quyền cho từng cá nhân.
- #strong[Tính linh hoạt:]
  - Thành viên có thể tùy chỉnh cách họ nhận thư (nhận ngay lập tức, tổng hợp hàng ngày, tổng hợp ngắn gọn, hoặc không nhận qua email mà chỉ đọc trên web).

=== Vai trò của Admin vs Member

==== Admin

#figure(
  align(center)[#table(
    columns: (30%, 70%),
    align: (left,left,),
    table.header([Tính năng], [Miêu Tả],),
    table.hline(),
    [Quản lý Thành viên], [Thêm/Xóa thành viên, Cấm (Ban) người dùng, Đặt vai trò (Owner, Manager, Member), Duyệt yêu cầu tham gia.],
    [Kiểm duyệt (Moderation)], [Đặt cài đặt cho phép/không cho phép thành viên đăng bài, Phê duyệt/Từ chối các bài đăng đang chờ.],
    [Quản lý Cài đặt Thư], [Đặt chân chữ ký (footer) chung cho tất cả email của nhóm, cấu hình phản hồi tự động (auto-reply).],
    [Cài đặt Quyền], [Quyết định ai có thể Xem thành viên, ai có thể Đăng bài, ai có thể Xem Kho lưu trữ.],
  )]
  , kind: table
  , caption: [Bài 1. Vai trò của Admin]
  )

==== Member

#figure(
  align(center)[#table(
    columns: (30%, 70%),
    align: (left,left,),
    table.header([Tính năng], [Miêu Tả],),
    table.hline(),
    [Đăng bài (Post)], [Gửi email đến địa chỉ nhóm để bắt đầu cuộc thảo luận mới hoặc trả lời các cuộc thảo luận hiện có.],
    [Truy cập Kho lưu trữ], [Tìm kiếm và xem lại toàn bộ lịch sử thảo luận của nhóm trên giao diện web của Google Groups (nếu được phép).],
    [Tùy chọn Email], [Thay đổi tần suất nhận thư (mỗi thư, tóm tắt, tổng hợp), Rời nhóm (Leave group).],
  )]
  , kind: table
  , caption: [Bài 1. Vai trò của Member]
  )

== Tính năng tìm kiếm

Để tìm kiếm hiệu quả trong vô số email, Gmail cung cấp các tính năng sau.

=== Thanh tìm kiếm thông minh

- #strong[Tìm kiếm ngữ cảnh:] Tự động đề xuất các từ khóa, người gửi hoặc nhãn liên quan khi bạn gõ.
- #strong[Tìm kiếm nhanh:] Gõ từ khóa và Gmail tìm kiếm trong Chủ đề, Nội dung thư, Tên người gửi/người nhận, và cả Nội dung tệp đính kèm (đối với các định dạng phổ biến như PDF, Docx).

=== Toán tử Tìm kiếm (Search Operators)

Cách để thu hẹp kết quả tìm kiếm một cách chính xác nhất.

- #strong[Kết hợp điều kiện:]
  - Sử dụng khoảng trắng (Space) hoặc `AND` để tìm thư khớp với tất cả các điều kiện.
  - Sử dụng `OR` để tìm thư khớp với một trong các điều kiện.
- #strong[Tìm kiếm chính xác cụm từ:] Đặt cụm từ khóa trong dấu ngoặc kép (`"..."`).
  - Ví dụ: `"Báo cáo tài chính Q3"`
- #strong[Tìm kiếm thời gian:]
  - `after:YYYY/MM/DD` và `before:YYYY/MM/DD`: Lọc theo ngày.
  - `older_than:3d` hoặc `newer_than:2m`: Lọc theo khoảng thời gian tương đối (#strong[ngày 'd', tháng 'm', năm 'y'];).
- #strong[Tìm kiếm theo kích thước:]
  - `size:10m`: Tìm thư có kích thước lớn hơn 10MB.
  - `larger:5m` hoặc `smaller:20k`.

== "Filter messages like this"

Tính năng "#strong[Filter messages like this];" được thiết kế để tạo bộ lọc nhanh dựa trên email hiện tại, nhằm #strong[Tự động hóa việc quản lý email];.

=== Cơ chế Tạo Bộ lọc

- Bạn chọn một #strong[email] và kích hoạt tính năng này từ Menu.
- #strong[Gmail] tự động điền các #strong[tiêu chí tìm kiếm] vào công cụ
  #strong[Tìm kiếm Nâng cao];.
  - #strong[Ví dụ:] Nếu bạn chọn thư từ `john.doe@email.com`, Gmail sẽ điền ngay `from:john.doe@email.com` vào tiêu chí tìm kiếm#strong[.]
  - Bạn có thể thay đổi hoặc thêm các tiêu chí khác #strong[(ví dụ: chỉ lọc thư từ John có kèm tệp đính kèm).]

=== Các Hành động Tự động của Bộ lọc (Quan trọng)

Sau khi định nghĩa tiêu chí tìm kiếm, bạn chọn một hoặc nhiều hành động để áp dụng cho các email mới và (tùy chọn) các email cũ khớp với tiêu chí:

- #strong[Lưu trữ (Archive):] Bỏ qua Hộp thư đến (#strong[Skip the
  Inbox];).
  - Thư sẽ không hiển thị trong hộp thư chính nhưng vẫn có thể tìm thấy.
- #strong[Gán Nhãn:] Tự động áp dụng một nhãn cụ thể (#strong[Label];) để phân loại.
- #strong[Đánh dấu quan trọng:] Đánh dấu là đã đọc, đã gắn sao, hoặc #strong[quan trọng.]
- #strong[Chuyển tiếp (Forward):] Tự động gửi bản sao email đó đến một địa chỉ khác.
- #strong[Xóa:] Tự động chuyển thư vào thùng rác.

#pagebreak()
