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
)

#set text(font: "Lora", weight: "regular")

#title-slide()

= Giới Thiệu Nhóm

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
    [01], [25410291], [_Đinh Xuân Sâm_], [02], [25410240], [_Nguyễn Tạ Quí Lan_],
    [03], [25410179], [Giang Hải Chương], [04], [25410171], [Lê Thị Tú Anh],
    [05], [25410338], [Lê Anh Vũ], [06], [25410183], [Nguyễn Đào Anh Đạt],
    [07], [25410193], [Nguyễn Minh Duy], [08], [25410204], [Trương Xuân Hậu],
    [09], [25410213], [Phan Chí Hiếu], [10], [25410220], [Vũ Huy Hoàng],
    [11], [25410239], [Phạm Tuấn Kiệt], [12], [25410244], [Nguyễn Thành Lộc],
    [13], [25410319], [Đặng Hữu Toàn], [14], [25410321], [Nguyễn Điền Triết],
    [15], [25410325], [Nguyễn Văn Trung],
  )
]

= Giới Thiệu Đề Tài

== Lý Do Chọn Đề Tài

=== Lý Do Chọn Đề Tài

- Tìm hiểu thực tế hạ tầng tại doanh nghiệp.

=== Tầm Quan Trọng

- Hạ tầng CNTT là xương sống của hoạt động vận hành.

=== Ý Nghĩa Nghiên Cứu

- Áp dụng kiến thức vào thực tiễn.

== Mục Tiêu

=== Phân Tích Hạ Tầng

- Hiểu rõ cấu trúc phần cứng, phần mềm và mạng.

=== Đánh Giá

- Xác định ưu điểm và nhược điểm của hệ thống hiện tại.

=== Đề Xuất Cải Tiến

- Đưa ra các giải pháp tối ưu hóa và khắc phục hạn chế.

== Phạm Vi Nghiên Cứu

=== Phần Cứng (Hardware)

- Hệ thống máy chủ (Server), thiết bị đầu cuối, thiết bị mạng.

=== Phần Mềm (Software)

- Phần mềm nền tảng, phần mềm quản lý, phần mềm ứng dụng và dịch vụ.

=== Các Quy Trình Hoạt Động (Processes)

- Quy trình quản trị và bảo mật, vận hành.

== Giới Thiệu Về Orient Software

=== Tên Đầy Đủ

- Orient Software Development Corporation.

=== Lĩnh Vực

- Outsourcing phần mềm hàng đầu tại Việt Nam, cung cấp dịch vụ AI, Software, Cloud.

=== Quy Mô

- 350+ nhân sự.

=== Sứ Mệnh

- "Education for a Better Future", tiên phong trong các kiến trúc AWS.

= Các Thành Phần Của Hạ Tầng

== Hạ Tầng Phần Cứng (Hardware)

=== Hệ Thống Máy Chủ (Server)

- Máy chủ ảo hóa (Hyper-V).
- Máy chủ lưu trữ.
- DNS Server.
- Active Directory Server.

=== Thiết Bị Đầu Cuối (End Devices)

- Laptop/PC.
- Printer (Máy in).
- Mobile (Thiết bị di động).
- Camera giám sát.
- VoIP Phone.
- FingerPrint (Máy chấm công).

=== Thiết Bị Mạng (Network Devices)

- Firewall (Tường lửa).
- Access Point (Wifi).
- Switch (Bộ chuyển mạch).
- Router (Bộ định tuyến).

== Hạ Tầng Phần Mềm (Software)

=== Phần Mềm Nền Tảng

- Hệ Điều Hành Windows.
- Hệ Điều Hành Linux.
- Nền Tảng Container Docker.

=== Phần mềm Quản Lý

- Quản lý dự án: Jira.
- ServiceDesk: GLPI.
- Quản lý tài sản: Snipe-IT.
- Công cụ khác: CCM, Patch Manage Engine, Admin by Request.

=== Phần mềm ứng dụng và dịch vụ

- Giao tiếp: Voice Cloud.
- Văn phòng: Microsoft Office 365.
- Kế toán: MISA.
- Quản trị doanh nghiệp: SAP.

== Tài Nguyên Mạng

- Phân quyền tài nguyên mạng.
- Hệ thống các lớp IP.
- Hệ thống mạng nội bộ (LAN).
- Dịch vụ Internet (ISP).
- Hệ thống tên miền (Domain).

== Quản Trị Và Bảo Mật

Các lớp bảo mật được triển khai:

1. Quản trị hệ thống: System Admin.
2. Quản trị nhân sự: Hệ thống nhân sự.
3. Bảo mật vật lý: Kiểm soát ra vào, camera.
4. Bảo mật mạng: Firewall, phân lớp mạng.
5. Quyền truy cập: Phân quyền người dùng chặt chẽ.

= Quy Trình Hoạt Động

== Quy Trình Quản Trị Và Bảo Mật

Áp dụng các tiêu chuẩn quốc tế:

- ISO/IEC 27001: Hệ thống quản lý an toàn thông tin.
- ISO 9001: Hệ thống quản lý chất lượng.

== Quy Trình Tuyển Dụng Nhân Sự

Quy trình gồm 6 bước khép kín:

1. Ứng viên nộp CV (Email/Job Site).
2. Sàng lọc hồ sơ (Bộ phận Talent Acquisition - TA).
3. Phỏng vấn kỹ thuật (Team Lead/Senior Dev).
4. Phỏng vấn quản lý (PM/Director).
5. Phỏng vấn nhân sự (Thương lượng lương, phúc lợi).
6. Nhận Offer Letter -> Kết thúc.

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

=== Nhược Điểm

- Chi phí vận hành cao: Do đầu tư thiết bị và bản quyền phần mềm lớn.
- Hệ thống phức tạp: Đòi hỏi nhân sự quản trị trình độ cao.
- Phụ thuộc Internet: Rủi ro khi mất kết nối diện rộng.
- Quy trình cứng nhắc: Có thể gây chậm trễ trong một số trường hợp khẩn cấp.

=== Giải Pháp Hoàn Thiện

1. Tối ưu chi phí: Rà soát tài nguyên cloud, license.
2. Tự động hóa và tích hợp: Tăng cường DevOps, CI/CD.
3. Nâng cao dự phòng: Backup định kỳ, phương án DR (Disaster Recovery).
4. Phát triển đội ngũ: Đào tạo nội bộ (Team Training) để làm chủ công nghệ.

= Kết Luận

== Kết Quả Nghiên Cứu & Đánh Giá Chung

- Kết quả: Đã phân tích chi tiết hạ tầng kỹ thuật (HW/SW) và các quy trình vận hành cốt lõi.
- Đánh giá: Hệ thống CNTT đóng vai trò là "xương sống" của doanh nghiệp, giúp Orient Software vận hành trơn tru và bảo mật.

== Định Hướng & Bài Học Kinh Nghiệm

- Định hướng: Hướng tới tự động hóa toàn diện, tối ưu hóa chi phí và tăng cường khả năng phục hồi hệ thống.
- Bài học: Hiểu rõ bản chất, định nghĩa và giá trị thực tiễn mà một hệ thống hạ tầng CNTT bài bản mang lại cho doanh nghiệp Outsourcing.

#slide[
  #align(center + horizon)[
    *CẢM ƠN THẦY VÀ CÁC BẠN ĐÃ LẮNG NGHE*
  ]
]
