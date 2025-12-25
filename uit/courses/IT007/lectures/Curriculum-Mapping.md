# Hệ Điều Hành
## Chương 5: Đồng Bộ Tiến

Dưới đây là bảng ánh xạ chi tiết nội dung từ slide bài giảng **Chương 5: Đồng Bộ Tiến Trình** của UIT sang giáo trình **Operating System Concepts, 10th Edition**.

Nội dung này trong sách giáo khoa được chia làm hai chương riêng biệt: **Chương 6 (Synchronization Tools)** và **Chương 7 (Synchronization Examples)**.

### Phần 1: Các Khái Niệm Cơ Bản & Giải Pháp Phần Cứng

_(Tương ứng với slide: Week07-Chapter5-1)_

| Nội dung trong Slide UIT                                                                                                           | Nội dung tương ứng trong Textbook (10th Ed.)                                                            | Vị trí tham chiếu               |
| :--------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------ | :------------------------------ |
| **Race Condition** (Điều kiện đua)                                                                                                 | **6.1 Background** Giải thích về race condition và tại sao cần đồng bộ hóa.                             | **Chương 6.1** Trang 257 - 260, |
| **Critical Section Problem** (Vấn đề vùng tranh chấp)                                                                              | **6.2 The Critical-Section Problem** Định nghĩa 3 yêu cầu: Mutual Exclusion, Progress, Bounded Waiting. | **Chương 6.2** Trang 260 - 262, |
| **Peterson’s Solution** (Giải pháp phần mềm)                                                                                       | **6.3 Peterson’s Solution** Giải pháp phần mềm cổ điển cho 2 tiến trình.                                | **Chương 6.3** Trang 262 - 265, |
| **Hardware Support** (Hỗ trợ phần cứng)- Memory Barriers- Hardware Instructions (Test-and-Set, Compare-and-Swap)- Atomic Variables | **6.4 Hardware Support for Synchronization** Các chỉ thị phần cứng hỗ trợ đồng bộ hóa.                  | **Chương 6.4** Trang 265 - 270, |

### Phần 2: Các Công Cụ Đồng Bộ (Mutex, Semaphore, Monitor)

_(Tương ứng với slide: Week09-Chapter5-2)_

| Nội dung trong Slide UIT                                                                 | Nội dung tương ứng trong Textbook (10th Ed.)                                                                         | Vị trí tham chiếu               |
| :--------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------- | :------------------------------ |
| **Mutex Locks** (Spinlocks, Busy waiting)                                                | **6.5 Mutex Locks** Công cụ đơn giản nhất để bảo vệ vùng tranh chấp.                                                 | **Chương 6.5** Trang 270 - 272, |
| **Semaphores** - Định nghĩa (Wait/Signal)- Usage & Implementation- Deadlock & Starvation | **6.6 Semaphores** Bao gồm cả binary và counting semaphores, và cách cài đặt không dùng busy waiting (block/wakeup). | **Chương 6.6** Trang 272 - 276, |
| **Monitors** - Định nghĩa- Condition Variables                                           | **6.7 Monitors** Cấu trúc dữ liệu trừu tượng cấp cao, bao gồm cách dùng Condition Variables (x.wait, x.signal).      | **Chương 6.7** Trang 276 - 282, |
| **Liveness** - Deadlock- Priority Inversion                                              | **6.8 Liveness** Các vấn đề phát sinh khi đồng bộ hóa (tắc nghẽn, nghịch đảo độ ưu tiên).                            | **Chương 6.8** Trang 283 - 284, |

### Phần 3: Các Bài Toán Đồng Bộ Kinh Điển

_(Tương ứng với slide: Week10-Chapter5-3)_

Trong sách giáo khoa, các bài toán này được chuyển sang đầu **Chương 7**.

| Nội dung trong Slide UIT                                                  | Nội dung tương ứng trong Textbook (10th Ed.)                                                        | Vị trí tham chiếu                 |
| :------------------------------------------------------------------------ | :-------------------------------------------------------------------------------------------------- | :-------------------------------- |
| **Bounded-Buffer Problem** (Bài toán bộ đệm giới hạn/Sản xuất - Tiêu thụ) | **7.1.1 The Bounded-Buffer Problem** Sử dụng semaphore để giải quyết.                               | **Chương 7.1.1** Trang 290,       |
| **Readers-Writers Problem** (Bài toán Đọc - Ghi)                          | **7.1.2 The Readers-Writers Problem** Giải quyết xung đột giữa việc đọc song song và ghi độc quyền. | **Chương 7.1.2** Trang 290 - 293, |
| **Dining-Philosophers Problem** (Bài toán Triết gia ăn tối)               | **7.1.3 The Dining-Philosophers Problem** Giải pháp dùng Semaphore và Monitor để tránh deadlock.    | **Chương 7.1.3** Trang 293 - 295, |

### Lưu ý khi đọc sách

- **Java Synchronization:** Trong các slide UIT phần Monitor thường có ví dụ về Java. Trong sách, nội dung cụ thể về Java (Java Monitors, Reentrant Locks) nằm ở **Chương 7.4 (Synchronization in Java)**, trang 303,.
- **Linux/Windows:** Nếu slide có đề cập đến cách Linux hoặc Windows thực hiện đồng bộ hóa, bạn xem tại **Chương 7.2 (Synchronization within the Kernel)**, trang 295,.
