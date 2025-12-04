#import "libs/report.typ": *

// YOUR CONTENT

= Bài 2. #lorem(6)
<bai-2>

#lorem(30)

#figure(image("assets/macos-fhs-root-system.png"),
  caption: [
    Bài 2. Cây thư mục trong CLI của macOS.
  ]
)

#lorem(20)

#todo[@bai-2[Bài]: #lorem(5).]

== #lorem(5)

#lorem(30)

#lorem(20)

#figure(
  align(center)[#table(
    columns: 4,
    align: (left,left,left,left,),
    table.header([Thuộc tính], [Ổ đĩa (Volume/Drive)], [Thư mục (Folder)], [Tập tin (File)],),
    table.hline(),
    [Tên (Name)], [Tên phân vùng (VD: Macintosh HD).], [Tên thư mục.], [Tên file + Đuôi mở rộng (Extension).],
    [Loại (Kind)], [Định dạng (APFS, NTFS…).], [Folder.], [Định dạng (PDF, JPG, Docx…).],
    [Kích thước (Size)], [Dung lượng tổng / Khả dụng.], [Tổng kích thước nội dung.], [Kích thước thực của file.],
    [Ngày tháng], [Ngày tạo phân vùng.], [Ngày tạo, ngày sửa đổi nội dung.], [Ngày tạo, sửa đổi, mở gần nhất.],
    [Quyền (Permissions)], [Quản trị hệ thống (System R/W).], [Read/Write/Execute (truy cập).], [Read/Write/Execute (thao tác).],
    [Khác], [Mount point, thông tin phần cứng.], [Số lượng mục con (items count).], [App mặc định (Open with).],
  )]
  , kind: table
  , caption: [@bai-2[Bài]. Thuộc tính của Ổ đĩa, Thư mục, và File.]
  )

#pagebreak()
