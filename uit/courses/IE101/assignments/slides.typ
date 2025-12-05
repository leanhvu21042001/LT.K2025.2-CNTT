#import "@preview/touying:0.6.1": *
#import themes.stargazer: *

#import "@preview/numbly:0.1.0": numbly

#show: stargazer-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [PHÂN TÍCH CƠ SỞ HẠ TẦNG CÔNG NGHỆ THÔNG TIN],
    subtitle: [ORIENT SOFTWARE DEVELOPMENT CORPORATION],
    author: [Nhóm 1],
    date: datetime.today(),
    institution: [IE103 - Cơ Sở Hạ Tầng CNTT],
  ),
  lang: "vi",
  config-colors(
    primary: rgb("#5E8B65"),
    primary-dark: rgb("#004078"),
    secondary: rgb("#ffffff"),
    tertiary: rgb("#005bac"),
    neutral-lightest: rgb("#ffffff"),
    neutral-darkest: rgb("#003255"),
  ),
)

// TODO: Thay đổi style của list
#set list(
  marker: circle(radius: 0.2em, stroke: 0.2pt + rgb("#b51d69")),
  indent: 0.5em,
)

// Set font
#set text(font: "Lora", weight: "regular")

// Set heading level 3
#show heading.where(level: 3): it => [
  #set align(left)
  #set text(font: "Montserrat", size: 20pt, weight: "regular")
  #block(
    width: 100%,
    stroke: (bottom: 0.5pt + rgb("#808080")),
    inset: (bottom: 0.5em),
    below: 0.8em,
  )[
    #smallcaps[#it.body]
  ]
]

#title-slide()

= Giới Thiệu

== Lời Cảm Ơn

- Giảng Viên: Ths. Đỗ Minh Tiến, IE103
- Nhà Trường: Trung Tâm Phát Triển Công Nghệ Thông Tin - UIT
- Công Ty: Orient Software Development Corporation

== Nhóm 1

#align(center)[
  #show table.cell: current_cell => {
    if current_cell.x in (0, 1, 3, 4) {
      text(
        font: "Iosevka",
        weight: "light",
        size: 0.9em,
        fill: gray,
      )[#current_cell]
    } else {
      current_cell
    }
  }
  #table(
    columns: (auto, auto, auto, auto, auto, auto),
    inset: 0.5em,
    align: (right, right, left, right, right, left),
    stroke: (
      bottom: 0.5pt + gradient.linear(red, blue, green),
      top: none,
      left: none,
      right: none,
    ),
    [01], [25410291], [_Đinh Xuân Sâm_], [09], [25410213], [Phan Chí Hiếu],
    [02], [25410240], [_Nguyễn Tạ Quí Lan_], [10], [25410220], [Vũ Huy Hoàng],
    [03], [25410179], [Giang Hải Chương], [11], [25410239], [Phạm Tuấn Kiệt],
    [04], [25410171], [Lê Thị Tú Anh], [12], [25410244], [Nguyễn Thành Lộc],
    [05], [25410338], [Lê Anh Vũ], [13], [25410319], [Đặng Hữu Toàn],
    [06], [25410183], [Nguyễn Đào Anh Đạt], [14], [25410321], [Nguyễn Điền Triết],
    [15], [25410325], [Nguyễn Văn Trung],
  )
]

= Đề Tài

== Lý Do Chọn Đề Tài

=== Động Lực

- Tìm hiểu thực tế hạ tầng tại doanh nghiệp.
- Hạ tầng CNTT là xương sống của hoạt động vận hành.

=== Ý Nghĩa Nghiên Cứu

- Hiểu rõ một hạ tầng CNTT thông qua thực tế.
- Áp dụng kiến thức vào thực tiễn.

== Mục Tiêu

=== Phân Tích Hạ Tầng

- Hiểu rõ cấu trúc phần cứng, phần mềm và các quy trình hoạt động.

=== Đánh Giá

- Xác định ưu điểm và nhược điểm của hệ thống hiện tại.

=== Bài Học Kinh Nghiệm

- Phát huy ưu điểm, hạn chế nhược điểm khi xây dựng, vận hành.

=== Đề Xuất Cải Tiến

- Đưa ra các giải pháp tận dụng ưu điểm, khắc phục các hạn chế.

== Phạm Vi Nghiên Cứu

=== Phần Cứng (Hardware)

- Hệ thống máy chủ (Server), thiết bị đầu cuối, thiết bị mạng.

=== Phần Mềm (Software)

- Phần mềm nền tảng, phần mềm quản lý, phần mềm ứng dụng và dịch vụ.

=== Các Quy Trình Hoạt Động (Processes)

- Quy trình quản trị và bảo mật, vận hành.

== Orient Software Development Corporation.

_"Collaboration, Openness, and Learning Mindset"_. (Hợp Tác, Cởi Mở và Cầu Thị).

=== Lĩnh Vực

- Outsourcing phần mềm hàng đầu tại Việt Nam và khu vực.

=== Quy Mô

- 350+ nhân sự.

=== Sứ Mệnh

- "To provide exceptional software services to the world".

= Các Thành Phần Của Hạ Tầng

== Hạ Tầng Phần Cứng (Hardware)

=== Thông Tin Cơ Bản

- Server.
- Storage.
- Network Devices.
- End Device.

#pagebreak()

=== Hệ Thống Máy Chủ (Server)

- Máy chủ ảo hóa (Hyper-V).
- Máy chủ lưu trữ (NAS).

=== Thiết Bị Mạng (Network Devices)

- Firewall (Tường lửa).
- Access Point (Wifi).
- Switch (Bộ chuyển mạch).
- Router (Bộ định tuyến).

#pagebreak()

=== Thiết Bị Đầu Cuối (End Devices)

- Laptop/PC.
- Printer (Máy in).
- Mobile (Thiết bị di động).
- Camera giám sát.
- VoIP Phone.
- FingerPrint (Máy chấm công).

== Hạ Tầng Phần Mềm (Software)

=== Thông Tin Cơ Bản

- Hệ Điều Hành.
- Phần mềm Quản Lý.
- Phần mềm ứng dụng và dịch vụ.

#pagebreak()

=== Phần Mềm Nền Tảng

- Hệ Điều Hành Windows.
- Hệ Điều Hành Linux.
- Nền Tảng Container Docker.

#pagebreak()

=== Phần Mềm Quản Lý

- Quản lý dự án: Jira.
- ServiceDesk: GLPI.
- Quản lý tài sản: Snipe-IT.
- Công cụ khác: CCM, Patch Manage Engine, Admin by Request.

#pagebreak()

=== Phần Mềm Ứng Dụng Và Dịch Vụ

- Giao tiếp: Voice Cloud.
- Văn phòng: Microsoft Office 365.
- Kế toán: MISA.
- Quản trị doanh nghiệp: SAP.

== Tài Nguyên Mạng

=== Tổng Quan

- Phân quyền tài nguyên mạng.
- Hệ thống các lớp IP.
- Hệ thống mạng nội bộ (LAN).
- Dịch vụ Internet (ISP).
- Hệ thống tên miền (Domain).

= Quy Trình Hoạt Động

== Quản Trị Và Bảo Mật

=== Tiêu Chuẩn Quốc Tế

- ISO/IEC 27001: Hệ thống quản lý an toàn thông tin.
- ISO 9001: Hệ thống quản lý chất lượng.

=== Quản Trị

- System Admin.
- Nhân Sự.

=== Bảo Mật

- Vật lý: Kiểm soát ra vào, camera.
- Mạng: Firewall, phân lớp mạng.
- Quyền truy cập: Phân quyền chặt chẽ.

== Quy Trình Tuyển Dụng Nhân Sự

6 bước:

1. Ứng viên nộp CV (Email/Job Site).
2. Sàng lọc hồ sơ (Talent Acquisition).
3. Phỏng vấn kỹ thuật (Team Lead/Senior Dev).
4. Phỏng vấn quản lý (PM/Director).
5. Phỏng vấn nhân sự (Thương lượng lương, phúc lợi).
6. Nhận Offer Letter và Ký Hợp đồng.

== Quy Trình Quản Lý Tài Chính

=== Các thành phần cấu tạo

- Nguyên tắc quản lý tài chính & quỹ nội bộ.
- Quy trình lập ngân sách và kế hoạch tài chính.
- Chính sách thu - chi.
- Chính sách kiểm tra - giám sát tài chính.
- Phân quyền và trách nhiệm tài chính.

== Quy Trình Phát Triển Phần Mềm

Sơ đồ 5 giai đoạn:

1. *Khởi tạo (Initiation):* Xác định mục tiêu, phạm vi, phê duyệt (Project Charter).
2. *Lập kế hoạch (Planning):* Thu thập yêu cầu, thiết kế, ngân sách, nguồn lực.
3. *Thực hiện (Execution):* Coding, tích hợp module, tạo bản build.
4. *Giám sát & Kiểm soát:* Testing, QA, quản lý rủi ro, theo dõi tiến độ.
5. *Kết thúc (Closing):* Bàn giao, UAT, triển khai, rút kinh nghiệm.

== Quy Trình Quản Lý Dự Án

Tương tự quy trình phát triển nhưng tập trung vào quản lý:

- *Khởi tạo:* Xác định các bên liên quan.
- *Lập kế hoạch:* Kế hoạch quản lý rủi ro chi tiết.
- *Thực hiện:* Quản lý nhóm dự án, thực hiện mua sắm.
- *Giám sát:* Kiểm soát thay đổi, báo cáo hiệu suất.
- *Kết thúc:* Nghiệm thu dự án, giải phóng nguồn lực.

== Đánh Giá

=== Ưu Điểm

- Hạ tầng hiện đại: Đầu tư công nghệ mới (Cloud, AI).
- Quy trình chuẩn hóa: Áp dụng ISO, quy trình 5 bước rõ ràng.
- Tính bảo mật cao: Đa lớp từ vật lý đến mạng.
- Khả năng mở rộng: Linh hoạt theo quy mô dự án.

#pagebreak()

=== Nhược Điểm

- Chi phí vận hành cao
  - Do đầu tư thiết bị và bản quyền phần mềm lớn.
- Hệ thống phức tạp
  - Đòi hỏi nhân sự quản trị trình độ cao.
- Phụ thuộc Internet
  - Rủi ro khi mất kết nối diện rộng.
- Quy trình cứng nhắc
  - Có thể gây chậm trễ trong một số trường hợp khẩn cấp.

#pagebreak()

=== Giải Pháp Hoàn Thiện

- Rà soát tài nguyên phần cứng, license phần mềm.
  - Tối ưu chi phí.
- Tăng cường DevOps, CI/CD.
  - Tự động hóa và tích hợp
- Backup định kỳ, phương án DR (Disaster Recovery).
  - Nâng cao dự phòng
- Đào tạo nội bộ (Team Training) để làm chủ công nghệ.
  - Phát triển đội ngũ

= Kết Luận

== Đánh Giá Chung

*Hệ thống CNTT đóng vai trò là "xương sống" của doanh nghiệp, giúp Orient Software vận hành trơn tru và bảo mật.*

== Kết Quả Nghiên Cứu

- Đã phân tích chi tiết hạ tầng kỹ thuật (HW/SW) và các quy trình vận hành cốt lõi.

== Định Hướng

- Hướng tới tự động hóa toàn diện, tối ưu hóa chi phí và tăng cường khả năng phục hồi hệ thống.

== Bài Học Kinh Nghiệm

- Nắm bắt định nghĩa và giá trị thực tiễn mà một hệ thống hạ tầng CNTT bài bản mang lại cho doanh nghiệp nói chung và Orient Software nói riêng.

= The End

#slide[
  #align(center + horizon)[
    *XIN CẢM ƠN!*
  ]
  #align(center + horizon)[
    *Q&A*
  ]
]
