Tìm hiểu cách thức tổ chức dữ liệu của Explorer/Finder:

+ Explorer dùng mô hình gì để tổ chức dữ liệu?
+ Explorer mô tả một ổ đĩa, folder, file bằng những thuộc tính gì? Ích lợi?
+ Phân biệt sự giống và khác nhau giữa các thuộc tính?
+ Read-only và hidden.
+ Các chức năng xử lý một folder, file.

== Giới thiệu

File Explorer (Trình quản lý files) là một chương trình có chức năng làm việc với Files System (Hệ Thống Files) để giúp người dùng quản lý files nói chung và dữ liệu trên một hệ điều hành cụ thể.

Explorer hay File Explorer (Trình quản lý files) là một chương trình đồ họa của Windows, nằm trong bộ Desktop Experience. Explorer là một phần không tách rời của Hệ Điều Hành Windows Desktop, phục vụ mục đích quản lý file, tức là tương tác với Hệ Thống Files (Files System). Ngoài ra, Explorer còn có một số chức năng khác như Desktop Management (Quản lý các tiến trình liên quan đến giao diện đồ họa của Windows), Window Manager (Quản lý cửa sổ).

Các chương trình tương tự như:

- Finder (macOS)
- Nautilus (GNOME, Linux)
- Dolphin (KDE, Linux).
- #link("http://ranger.fm")[ranger.fm] (Python, Terminal, Curses, Linux)

Tuy nhiên, có thể có vài khác biệt, ví dụ như Nautilus trên GNOME chỉ là một File Manager (Trình quản lý File) thuần túy, không có chức năng Window Manager hay Desktop Management, nên có thể được gỡ bỏ, thay thế tùy ý. Explorer (Windows), hay Finder (macOS) thì không.

Trong bài này, xin phép được trình bày các câu trả lời sử dụng Finder của macOS, một chương trình tương đương về chức năng và nhiệm vụ, chỉ khác hệ điều hành.

== Mô hình tổ chức dữ liệu

Finder sử dụng mô hình Cây thư mục (Directory Tree) hay đầy đủ hơn là Hệ Thống File Phân Cấp (Filesystem Hierarchy Standard (FHS)) để tổ chức dữ liệu, với gốc là thư mục `/` (root).

Lưu ý: root trong trường hợp này là tên của thư mục gốc/rễ, không phải là tên của người dùng tối cao trong hệ thống Unix-based/Unix-like.

Ví dụ:

- Finder với giao diện đồ họa, biểu diễn Cây thư mục như dưới đây, bắt
  đầu từ `/` tới `System` \> `Volumes`.

  ```ini
  /System/Volumes/
  ```

Đồ họa:

#figure(image("assets/macos-fhs-root-system-finder.png"),
  caption: [
    Cây thư mục trong Finder của macOS.
  ]
)

- Để đối chiếu, đây là đường dẫn khi ở chế độ dòng lệnh (CLI).

#figure(image("assets/macos-fhs-root-system.png"),
  caption: [
    Cây thư mục trong CLI của macOS.
  ]
)

- Lưu ý: macOS hay bất kỳ hệ điều hành POSIX (Unix-like/Unix-based) nào đều phân biệt HOA/thường trong đường dẫn, vì vậy hãy đảm bảo các ký tự luôn chính xác, vì HOA/Hoa/hoa là các từ hoàn toàn khác nhau.

== Thuộc tính và Ý nghĩa

Mỗi đối tượng (File, Folder, Volume) đều có metadata (siêu dữ liệu).

- #strong[Ý nghĩa:]
  - Giúp định danh, quản lý vị trí.
  - Xác định ứng dụng mở mặc định và kiểm soát bảo mật.
- #strong[Lợi ích:]
  - Hỗ trợ tìm kiếm (theo ngày, loại),
  - Quản lý dung lượng.
  - Bảo vệ dữ liệu (phân quyền).

== Thuộc tính của Ổ đĩa, Thư mục và File

Bảng so sánh nhanh các thuộc tính của các đối tượng khác nhau.

#figure(
  align(center)[#table(
    columns: 4,
    align: (left,left,left,left,),
    table.header([#strong[Thuộc tính];], [#strong[Ổ đĩa
      (Volume/Drive)];], [#strong[Thư mục (Folder)];], [#strong[Tập tin
      (File)];],),
    table.hline(),
    [#strong[Tên (Name)];], [Tên phân vùng (VD: Macintosh HD).], [Tên
    thư mục.], [Tên file + Đuôi mở rộng (Extension).],
    [#strong[Loại (Kind)];], [Định dạng (APFS,
    NTFS…).], [Folder.], [Định dạng (PDF, JPG, Docx…).],
    [#strong[Kích thước (Size)];], [Dung lượng tổng / Khả dụng.], [Tổng
    kích thước nội dung.], [Kích thước thực của file.],
    [#strong[Ngày tháng];], [Ngày tạo phân vùng.], [Ngày tạo, ngày sửa
    đổi nội dung.], [Ngày tạo, sửa đổi, mở gần nhất.],
    [#strong[Quyền (Permissions)];], [Quản trị hệ thống (System
    R/W).], [Read/Write/Execute (truy cập).], [Read/Write/Execute (thao
    tác).],
    [#strong[Khác];], [Mount point, thông tin phần cứng.], [Số lượng mục
    con (items count).], [App mặc định (Open with).],
  )]
  , kind: table
  , caption: [Thuộc tính của Ổ đĩa, Thư mục, và File.]
  )

Ví dụ:

- Thuộc tính của một file được tô đỏ như trong hình, bao gồm:

  - Thể loại (MIME type).
  - Dung lượng.
  - Ngày tạo.
  - Ngày chỉnh sửa.
  - Lần cuối truy cập.

#figure(image("assets/macos-fhs-file-properties.png"),
  caption: [
    Thuộc tính của một file.
  ]
)

- Thuộc tính của một ổ đĩa (Volume):
  - Loại.
  - Ngày tạo.
  - Định dạng.
  - Dung lượng.
  - Tên.
  - Phân quyền.
  - vv…

#figure(image("assets/macos-fhs-volume-properties.png"),
  caption: [
    Thuộc tính của một ổ đĩa (Volume).
  ]
)
