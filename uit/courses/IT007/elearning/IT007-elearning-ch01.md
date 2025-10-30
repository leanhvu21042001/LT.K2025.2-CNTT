# Chương 1. Tổng Quan về Hệ Điều Hành

[TOC]

## 1.1 Tổng Quan về Hệ Điều Hành

### Quiz

Q1.

> [!important]
> Chọn đáp án đúng trong các đáp án sau để điền vào chỗ trống trong định nghĩa về hệ điều hành. “Hệ điều hành là chương trình trung gian giữa … và người sử dụng”.
> 
> - [ ] Các chương trình máy tính.
> - [ ] Bộ xử lý trung tâm.
> - [ ] Phần mềm máy tính.
> - [x] Phần cứng máy tính.

Q2.

> [!important]
> Bộ phận nào KHÔNG phải là một thành phần chính trong cấu trúc hệ thống máy tính?
> 
> - [x] Màn hình
> - [ ] Chương trình ứng dụng
> - [ ] Phần cứng
> - [ ] Hệ điều hành

Q3.

> [!important]
> Mục tiêu chính của hệ điều hành là gì?
> 
> - [ ] Giúp cho chúng ta xem phim, truy cập internet
> - [x] Quản lý và cấp phát tài nguyên hệ thống một các hiệu quả
> - [x] Giúp người dùng dễ dàng sử dụng hệ thống


## 1.2 Hoạt động bên trong máy tính

### VIDEO: HOẠT ĐỘNG BÊN TRONG MÁY TÍNH (PHẦN 1)

- [[Hệ điều hành] Chương 1.2.1: Tổ chức hệ thống máy tính (Phần 1/2)](https://www.youtube.com/watch?v=JlXiySDnNBc)

### Slide: Hoạt Động Bên Trong Máy Tính (Phần 1)

(nội dung ở đây)

### VIDEO: HOẠT ĐỘNG BÊN TRONG MÁY TÍNH (PHẦN 2)

#### Cấu Trúc Lưu Trữ

Phân cấp (hierarchy):

- Tốc độ truy xuất (speed)
- Chi phí (cost)
- Bất biến khi không có điện (Volatility).

Volatile Storage (Primary):

- Registers
- Cache
- Memory

Non-volatile Storage (Secondary):

- Non-volatile memory
- HDD

Tertiary:

- Optical Disk
- Magnetic Tapes

#### Cấu Trúc Nhập Xuất

Các cách:

1. Cách 1: Write-through. Sử dụng lệnh ngắt.
2. Cách 2: Write-back.

### Slide: Hoạt Động Bên Trong Máy Tính (Phần 2)

(nội dung ở đây)

### Quiz

Q1.

> [!NOTE]
> Trong các loại bộ nhớ sau, bộ nhớ nào có tốc độ truy xuất chậm nhất?
> 
> - [ ] Cache
> - [ ] RAM
> - [x] SSD
> - [ ] Register

Q2.

> [!NOTE]
> Ngắt chuyển điều khiển đến interrupt service routine thông qua thành phần nào?
> 
> - [ ] interrupt request (yêu cầu ngắt)
> - [x] interrupt vector (chứa địa chỉ của tất cả các service routine)
> - [ ] interrupt driven (hoạt động định hướng theo ngắt)

Q3.

> [!NOTE]
> Điền vào chỗ trống
> 
> Một máy tính hiện nay gồm CPU (một hoặc nhiều) và các trình điều khiển thiết bị (device controller) kết nối với nhau thông qua bus để truy xuất `____`.
> 
> - shared memory

## 1.3: Kiến trúc hệ thống máy tính

### VIDEO: KIẾN TRÚC HỆ THỐNG MÁY TÍNH

- [\[Hệ điều hành\] Chương 1.3: Kiến trúc hệ thống máy tính](https://www.youtube.com/watch?v=6sv-iFfB8lY)

Nội dung:

- SPM (Single-Processor Systems)
- MS (Multiprocessor Systems)
- CS (Clustered Systems)

### Slide: Kiến trúc hệ thống máy tính

- SPM (Single-Processor Systems)
- MS (Multiprocessor Systems)
    - symmetric systems
    - dual
    - NUMA (Non-Uniform Memory Access)
- CS (Clustered Systems)

### Quiz

> [!NOTE]
> Câu 7. Một con chip (vật lý) chứa một hoặc nhiều CPU là?
> 
> - [ ] Core (lõi/nhân)
> - [x] Processor (bộ xử lý)
> - [ ] Multicore (đa lõi)
> - [ ] Multiprocessor (đa bộ xử lý)


> [!NOTE]
> Câu 8. Đặc điểm nào không phải là ưu điểm của hệ thống đa bộ xử lý?
> 
> - [x] Tiết kiệm năng lượng
> - [ ] Kinh tế
> - [ ] Tăng cường năng suất hệ thống
> - [ ] Độ tin cậy cao


> [!NOTE]
> Câu 9. Trong hệ thống gom cụm bao gồm nhiều hệ thống làm việc với nhau thường chia sẻ không gian lưu trữ qua mạng loại nào?
> 
> - [ ] Wide Area Network - WAN
> - [ ] Local Area Network - LAN
> - [ ] Metropolitan Area Network – MAN
> - [x] Storage Area Network - SAN

## 1.4: Các thao tác trong hệ điều hành

### VIDEO: CÁC THAO TÁC TRONG HỆ ĐIỀU HÀNH

- Youtube: https://www.youtube.com/watch?v=ePyfQHRfCxk

Nội dung:

- Đơn chương
- Đa chương
    - Đa nhiệm
- Các chế độ hoạt động (bit mode)
    - User mode: `1`
    - Kernel mode `0`
        - System calls
- Lịch sử phát triển các hệ điều hành.
- Quá trình phát triển của một số hệ điều hành.

### Slide: Các thao tác trong hệ điều hành

(nội dung ở đây)

### Quiz: Các thao tác trong hệ điều hành

> [!NOTE]
> Chương trình Bootstrap làm nhiệm vụ nào trong các nhiệm vụ sau?
> 
> - [ ] Điều khiển ngắt của nhân
> - [ ] Yêu cầu các dịch vụ của hệ điều hành
> - [ ] Khởi động hệ thống nền
> - [x] Khởi động hệ thống, nạp nhân


> [!NOTE]
> Đặc điểm nào sau đây KHÔNG phải là đặc điểm của hệ thống đa chương?
> 
> - [ ] Một công việc được chọn và chạy bởi bộ định thời công việc
> - [ ] Khi một công việc phải chờ hệ điều hành chuyển sang thực thi công việc khác
> - [x] Chương trình được thi hành tuần tự
> - [ ] Nhiều công việc được nạp đồng thời vào bộ nhớ

