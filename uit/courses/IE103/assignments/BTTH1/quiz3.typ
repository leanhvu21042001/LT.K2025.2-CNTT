#import "../../../../../tools/typst/libs/academic-alt.typ": *

// YOUR CONTENT

= Bài 3. FAT32 vs NTFS. Windows File System.
<bai-3>

+ Tìm hiểu cách tổ chức dữ liệu của FAT32, NTFS và so sánh.
+ HĐH dùng nguyên lý nào để khôi phục tập tin đã xóa?

#todo[Bài 3. Giới Thiệu, hoặc Mở Đầu, trước khi vào nội dung chính.]

== Windows File System

Hệ điều hành Windows tổ chức dữ liệu theo mô hình #strong[Cấu trúc cây phân cấp (Hierarchical Tree Structure)];.

- #strong[Gốc (Root):]
  - Là các ổ đĩa logic.
  - Ví dụ: `C:`, `D:`, `E:`.
- #strong[Nhánh (Branches):]
  - Là các thư mục (Folders/Directories).
  - Thư mục đóng vai trò là vật chứa logic để nhóm các tệp tin lại với nhau.
- #strong[Lá (Leaves):]
  - Là các tệp tin (Files).
  - Đơn vị lưu trữ thông tin cơ bản chứa dữ liệu thực tế.

== So sánh FAT32 và NTFS

FAT32 và NTFS là hai hệ thống tệp tin (File System) quy định cách dữ liệu được ghi và quản lý trên đĩa vật lý.

#figure(
  align(center)[#table(
    columns: 3,
    align: (left,left,left,),
    table.header([Đặc điểm], [FAT32 (File Allocation Table 32)], [NTFS (New Technology File System)],),
    table.hline(),
    [Kích thước tệp tối đa], [Giới hạn ở #strong[4 GB];. Không thể lưu các file video 4K hay file ISO lớn.], [Lý thuyết lên tới #strong[16 Exabytes] (gần như vô hạn với nhu cầu hiện tại).],
    [Kích thước phân vùng], [Giới hạn phổ biến là 2TB (Windows thường giới hạn format ở 32GB).], [Hỗ trợ phân vùng cực lớn (lên tới 8 Petabytes).],
    [Bảo mật], [Không hỗ trợ phân quyền truy cập hay mã hóa.], [Hỗ trợ #strong[ACL (Access Control List)] để phân quyền người dùng và mã hóa tệp tin (EFS).],
    [Độ an toàn], [Dễ bị lỗi dữ liệu khi mất điện đột ngột.], [Có tính năng #strong[Journaling (Ghi nhật ký)];: Tự động ghi lại thay đổi trước khi thực hiện để phục hồi nếu gặp lỗi hệ thống.],
    [Tương thích], [Cao (Windows, Mac, Linux, Game Consoles, USB).], [Tối ưu cho Windows; Mac/Linux có thể chỉ đọc được mà không ghi được (cần phần mềm hỗ trợ).],
  )]
  , kind: table
  , caption: [Bài 3. So Sánh FAT32 vs NTFS]
  )

== Khôi phục tệp tin đã xóa

Khi xóa một tệp tin (và dọn sạch Thùng rác), hệ điều hành #strong[không] xóa dữ liệu vật lý khỏi ổ cứng ngay lập tức. Quá trình diễn ra như sau:

- #strong[Đánh dấu trong MFT:]
  - Đối với NTFS, hệ thống sử dụng #strong[Master File Table (MFT)] để quản lý tệp.
  - Khi xóa, HĐH chỉ đơn giản là thay đổi trạng thái của bản ghi tệp đó trong MFT từ "In-Use" (Đang dùng) sang #strong["Free" (Trống)];.
- #strong[Dữ liệu vẫn tồn tại:]
  - Các bit dữ liệu thực tế của tệp tin vẫn nằm nguyên vẹn trên bề mặt đĩa từ hoặc chip nhớ.
- #strong[Cơ chế khôi phục:]
  - Các phần mềm khôi phục dữ liệu sẽ quét bảng MFT để tìm các mục được đánh dấu là "Free" này.
  - Nếu vùng không gian đĩa chứa dữ liệu cũ chưa bị tệp tin mới ghi đè lên, phần mềm có thể khôi phục lại tệp tin đó hoàn toàn.

#strong[Lưu ý quan trọng:]

- Nguyên lý này dẫn đến việc dữ liệu sẽ bị mất vĩnh viễn nếu bị #strong[ghi đè (Overwritten)];.
- Nếu bạn chép dữ liệu mới vào ổ đĩa, HĐH sẽ thấy vùng "Free" đó và ghi dữ liệu mới lên, lúc này cấu trúc từ tính cũ bị thay đổi và không thể khôi phục bằng phần mềm thông thường.

Ví dụ:

#todo[Bài 3. Chương trình khôi phục dữ liệu `testdisk`: #link("https://www.cgsecurity.org/wiki/TestDisk")[TestDisk].]

- Một quá trình khôi phục dữ liệu dùng `testdisk`.
  - (Sử dụng một USB FAT32/NTFS, format, copy file vào, xóa, và chạy testdisk để thử tìm kiếm/khôi phục lại, vv..)
#todo[Bài 3. Dùng `fdisk` để kiểm tra và xem thông số của phân vùng.]
#todo[Bài 3. Dùng `mk.fs` để định dạng phân vùng.]


#pagebreak()
