# Chương 2. Các Thành Phần Trong Hệ Điều Hành

Hệ điều hành cung cấp môi trường để các chương trình có thể được thực thi. Về mặt nội tại, các hệ điều hành đều có sự khác biệt về cấu trúc bởi chúng được phân thành nhiều dòng khác nhau. Thiết kế một hệ điều hành mới là một việc lớn, và quan trọng là các mục tiêu của hệ thống phải được xác định rõ ràng trước khi bắt đầu thiết kế. Các mục tiêu này chính là cơ sở để lựa chọn các giải thuật và chiến lược hợp lý.

Chúng ta có thể xem xét hệ điều hành từ nhiều góc độ khác nhau. Góc độ đầu tiên tập trung vào các dịch vụ mà hệ điều hành cung cấp. Góc độ khác là tập trung vào cơ chế giao tiếp mà hệ điều hành cung cấp cho người dùng và lập trình viên. Hoặc trong một góc độ khác nữa tập trung vào các thành phần của hệ điều hành và các kết nối của nó.

### Mục tiêu

**Sau khi học xong chương này, sinh viên có thể:**

- Liệt kê được các thành phần của hệ điều hành
- Mô tả được các dịch vụ mà hệ điều hành cung cấp
- Mô tả được các cấu trúc của hệ điều hành bao gồm: cấu trúc đơn giản, cấu trúc phân lớp, cấu trúc vi nhân, cấu trúc module, cấu trúc lai

### Nội dung

- Các thành phần của hệ điều hành
- Các dịch vụ hệ điều hành cung cấp
- Lời gọi hệ thống (system call)
- Các chương trình hệ thống (system programs)
- Cấu trúc hệ thống

### Trình bày

- ThS. Phan Đình Duy
- Giảng viên Khoa Kỹ thuật Máy tính

## Các thành phần của hệ điều hành

### VIDEO: THÀNH PHẦN QUẢN LÝ TIẾN TRÌNH

Hệ điều hành được tổ hợp từ nhiều thành phần khác nhau nhằm cung cấp những cơ chế quản lý và khai thác hiệu quả các thành phần bên trong một hệ thống máy tính. Trong đó, quản lý tiến trình là thành phần đặc biệt quan trọng khi phụ trách quản lý và vận hành các công việc bên trong máy tính.

- Quản lý tiến trình.
    - Tiến trình là gì?
    - Tiến trình khác chương trình ở điểm nào?
    - Tiến trình cần gì để thực thi?
    - Nhiệm vụ chính của quản lý tiến trình?
        - Tạo/hủy tiến trình.
        - Tạm dừng/tiếp tục thực thi tiến trình.
        - Cung cấp các cơ chế:
            - Đồng bộ hoạt động các tiến trình.
            - Giao tiếp giữa các tiến trình.
            - Khống chế tắc nghẽn.
- Quản lý bộ nhớ chính.
    - Bộ nhớ chính là gì?
    - Tại sao cần quản lý bộ nhớ chính?
    - Các nhiệm vụ chính:
        - Theo dõi, quản lý các vùng nhớ trống và đã cấp phát.
        - Quyết định sẽ nạp chương trình nào khi có vùng nhớ trống.
        - Cấp phát và thu hồi các vùng nhớ khi cần thiết.
- Quản lý file.
    - Hệ thống file là gì?
    - Các dịch vụ chính:
        - Tạo và xóa file.
        - Các thao tác xử lý file: copy/paste/move, ...
        - "Ánh xạ" file vào thiết bị thứ cấp tương ứng.
        - Sao lưu và phục hồi dữ liệu.
- Quản lý hệ thống I/O.
    - Abstract/che dấu sự khác biệt của các thiết bị I/O trước người dùng.
    - Chức năng:
        - Chơ chế: buffering, caching, spooling, ...
        - Cung cấp giao diện chung đến các trình điều khiển thiết bị.
        - Bộ điều khiển các thiết bị phần cứng.
- Quản lý hệ thống lưu trữ thứ cấp.
    - Hệ thống lưu trữ thứ cấp là gì? Khác biệt với bộ nhớ chính?
    - Phương tiện (media) lưu trữ thông dụng là gì?
    - Nhiệm vụ:
        - Quản lý không gian trống trên đĩa (free space management).
        - Cấp phát không gian lưu trữ (storage allocation).
        - Định thời hoạt động cho đĩa (disk scheduling) $\to$ tối ưu tuổi thọ, năng lượng, hiệu năng.
- Hệ thống bảo vệ.
    - Đa người dùng, đa tiến trình.
    - Kiểm soát tiến trình người dùng đăng nhập/xuất và sử dụng hệ thống.
    - Kiểm soát việc truy cập các tài nguyên trong hệ thống.
    - Bảo đảm những user/process chỉ được phép sử dụng các tài nguyên dành cho nó.
    - Các nhiệm vụ:
        - Cung cấp cơ chế kiểm soát đăng nhập/xuất.
        - Phân định được sự truy cập tài nguyên hợp pháp và bất hợp pháp (authorized/unauthorized).
        - Phương tiện thi hành các chính sách (enforcement of policies).
- Hệ thống thông dịch lệnh.
    - Là giao diện chủ yếu giữa người dùng và hệ điều hành.
    - User login:
        - Shell/CLI: dấu nhắc lệnh.
        - Lệnh $\to$ bộ điều khiển lệnh $\to$ hệ điều hành.
        - Các lệnh chủ yếu:
            - Tạo/hủy/quản lý tiến trình.
            - Kiểm soát I/O.
            - Quản lý bộ nhớ thứ cấp.
            - Quản lý bộ nhớ chính.
            - Truy cập hệ thống file và cơ chế bảo mật.

#### Quiz: Thành Phần Quản Lý Tiến Trình

> [!NOTE]
> Theo nội dung video bài giảng về các thành phần trong hệ điều hành mà các bạn vừa xem, thì thành phần nào không phải là một thành phần của hệ điều hành?
> 
> - [ ] Quản lý file
> - [ ] Quản lý tiến trình
> - [ ] Hệ thống bảo vệ
> - [x] Quản lý tiểu trình

> [!NOTE]
> Để hoàn thành công việc, một tiến trình KHÔNG bắt buộc phải có tài nguyên gì trong các tài nguyên phần cứng bên dưới?
> 
> - [x] Màn hình
> - [ ] Bộ nhớ
> - [ ] Thanh ghi
> - [ ] CPU

#### Quiz: Thành Phần Quản Lý Bộ Nhớ

> [!NOTE]
> Chọn đáp án đúng theo thứ tự tăng dần về tốc độ truy cập của bộ nhớ?
> 
> - [ ] Cache, RAM, SSD, RAM
> - [x] HDD, SSD, RAM, Cache
> - [ ] RAM, SSD, Cache, HDD
> - [ ] RAM, Cache, HDD, SSD

> [!NOTE]
> Quyết định sẽ nạp chương trình nào khi có vùng nhớ trống là chức năng của thành phần nào trong hệ điều hành?
> 
> - [ ] Quản lý tiến trình
> - [ ] Quản lý hệ thống I/O
> - [ ] Quản lý hệ thống lưu trữ thứ cấp
> - [x] Quản lý bộ nhớ chính

#### Quiz: Các Thành Phần Còn Lại

> [!NOTE]
> Hệ thống thông dịch lệnh (Shell/Terminal) là gì?
> 
> - [ ] Là giao diện chủ yếu giữa tiến trình và hệ điều hành
> - [ ] Là giao diện chủ yếu giữa người dùng và tiến trình
> - [x] Là giao diện chủ yếu giữa người dùng và hệ điều hành
> - [ ] Là giao diện chủ yếu giữa người dùng và phần cứng máy tính

> [!NOTE]
> Cung cấp giao diện chung đến các trình điều khiển thiết bị là chức năng của thành phần nào trong hệ điều hành?
> 
> - [ ] Quản lý hệ thống lưu trữ thứ cấp
> - [ ] Hệ thống bảo vệ
> - [x] Quản lý hệ thống I/O
> - [ ] Quản lý bộ nhớ chính

## Các dịch vụ hệ điều hành cung cấp

- Cấu trúc tổng quan của các dịch vụ của hệ điều hành.
- Thực thi chương trình.
- Thực hiện các thao tác I/O theo yêu cầu của chương trình.
- Các thao tác trên hệ thống file.
- Trao đổi thông in giữa các tiến trình:
    - Chia sẻ bộ nhớ (shared memory).
    - Chuyển thông điệp (message passing).
- Phát hiện lỗi:
    - Trong CPU, bộ nhớ, trên thiết bị I/O (dữ liệu hư, hết giấy, vv...).
    - Do chương trình: logic (chia cho 0), truy cập đến bộ nhớ không cho phép, vv...
- Cấp phát tài nguyên (resource allocation):
    - Tài nguyên: Phần cứng.
    - OS có các routing tương ứng.
- Kế toán (accounting):
    - Lưu vế user để tính phí hoặc đơn giản là để thống kê.
- Bảo vệ (protection) và an ninh (security):
    - Hai tiến trình khác nhau không được ảnh hưởng nhau.
    - Kiểm soát được các truy xuất tài nguyên của hệ thống.
    - Chỉ các user được phép sử dụng hệ thông mới truy cập được tài nguyên của hệ thống (username/password, etc.)
- Giao diện người dùng:
    - CLI
    - GUI

### Quiz: Các dịch vụ mà hệ điều hành cung cấp

> [!NOTE]
> Ý nào trong các ý sau KHÔNG phải là một dịch vụ do hệ điều hành cung cấp?
> 
> - [ ] Thực thi chương trình
> - [ ] Phát hiện lỗi
> - [x] Soạn thảo văn bản
> - [ ] Cấp phát tài nguyên

> [!NOTE]
> Loại giao diện người dùng nào KHÔNG được trình bày trong video bài giảng về giao diện người dùng?
> 
> - [x] Giao diện Hand Gestures
> - [ ] Giao diện Graphics User Interface (GUI)
> - [ ] Giao diện Touch-screen
> - [ ] Giao diện Command-Line (CLI)


## Lời gọi hệ thống (system call)

- Giao tiếp giữa tiến trình (process) và hệ điều hành (kernel), gọi đến các dịch vụ mà hệ điều hành cung cấp.
- C/C++.
- Truy cập thông qua API:
    - Win32 API (Windows).
    - POSIX API (POSIX-based).
    - Java API (JVM).
- Các phương pháp truyền thông số:
    - Thank ghi (register).
    - Qua một vùng nhớ (địa chỉ vùng nhớ được gửi qua register).
    - Stack.

## Các chương trình hệ thống (system programs)

- File system management: create, delete, rename, list
- Status:date, time, file system free space.
- Editor: cat, ed.
- Development: Compiler/assembler/interpreter.
- Debugger: loader/debugger
- Communication: email, talk, web browser.

## Cấu trúc hệ thống

- Architects:
    - Monolithic.
    - Layered Approach.
    - Microkernels.
    - Modules.
    - Hybrid Systems.
- Monolithic:
    - Original UNIX.
    - Simple.
    - Kernel:
        - file system
        - CPU scheduling
        - memory management, etc.
    - System programs.

## Câu hỏi ôn tập chương 2

1. Các thành phần chính của hệ điều hành?
2. Các dịch vụ mà hệ điều hành cung cấp?
3. Lời gọi hệ thống là gì? Nêu ví dụ.
4. Có mấy dạng cấu trúc hệ điều hành? Kể tên.
5. Tiến trình là gì? Các nhiệm vụ chính của thành phần quản lý tiến trình?
