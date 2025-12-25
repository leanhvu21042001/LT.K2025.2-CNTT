# Hệ Điều Hành

## Chương 4: Định thời CPU

Dưới đây là bảng ánh xạ chi tiết nội dung từ slide bài giảng **Chương 4: Định thời CPU** của UIT sang giáo trình **Operating System Concepts, 10th Edition**.

Lưu ý quan trọng: Chương 4 trong giáo trình của UIT tương ứng với **Chương 5 (CPU Scheduling)** trong sách giáo khoa (Textbook). Trong sách, Chương 4 là về Threads & Concurrency.

### Phần 1: Các Khái Niệm Cơ Bản & Tiêu Chuẩn Định Thời

_(Tương ứng với slide: Week05-Chapter4-1)_

Nội dung này giới thiệu về chu kỳ CPU-I/O, các bộ định thời và các tiêu chí để đánh giá hiệu quả của giải thuật.

| Nội dung trong Slide UIT                                                                                                      | Nội dung tương ứng trong Textbook (10th Ed.)                                                                            | Vị trí tham chiếu              |
| :---------------------------------------------------------------------------------------------------------------------------- | :---------------------------------------------------------------------------------------------------------------------- | :----------------------------- |
| **Các khái niệm cơ bản** (Basic Concepts) Chu kỳ CPU-I/O Burst, Định thời dài/trung/ngắn (Long/Medium/Short-term scheduling)  | **5.1 Basic Concepts** Mô tả chu kỳ CPU-I/O Burst, CPU Scheduler, và các loại định thời (Preemptive vs Non-preemptive). | **Chương 5.1** Trang 200 - 204 |
| **Dispatcher** (Bộ phân phối) Chuyển ngữ cảnh, Dispatch latency.                                                              | **5.1.4 Dispatcher** Mô tả module trao quyền điều khiển CPU cho tiến trình được chọn.                                   | **Chương 5.1.4** Trang 203     |
| **Các tiêu chuẩn định thời** (Scheduling Criteria) CPU utilization, Throughput, Turnaround time, Waiting time, Response time. | **5.2 Scheduling Criteria** Định nghĩa 5 tiêu chí dùng để so sánh các giải thuật định thời.                             | **Chương 5.2** Trang 204 - 205 |

### Phần 2: Các Giải Thuật Định Thời

_(Tương ứng với slide: Week05-Chapter4-1 và Week06-Chapter4-2)_

Phần này đi sâu vào các thuật toán cụ thể để lập lịch cho CPU.

| Nội dung trong Slide UIT                                                                                                    | Nội dung tương ứng trong Textbook (10th Ed.)                                                                        | Vị trí tham chiếu                |
| :-------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------ | :------------------------------- |
| **First-Come, First-Served (FCFS)** Đến trước phục vụ trước.                                                                | **5.3.1 First-Come, First-Served Scheduling** Giải thuật đơn giản nhất, hiệu ứng Convoy.                            | **Chương 5.3.1** Trang 206       |
| **Shortest-Job-First (SJF)** & **SRTF** Công việc ngắn nhất trước (bao gồm cả phiên bản độc quyền và không độc quyền/SRTF). | **5.3.2 Shortest-Job-First Scheduling** Bao gồm cách dự đoán độ dài CPU burst tiếp theo (exponential averaging).    | **Chương 5.3.2** Trang 207 - 209 |
| **Round-Robin (RR)** Định thời quay vòng, Quantum time.                                                                     | **5.3.3 Round-Robin Scheduling** Giải thuật sử dụng time quantum, phù hợp cho hệ thống chia sẻ thời gian.           | **Chương 5.3.3** Trang 209 - 211 |
| **Priority Scheduling** Định thời theo độ ưu tiên, vấn đề Starvation và giải pháp Aging.                                    | **5.3.4 Priority Scheduling** Cơ chế ưu tiên tĩnh/động, vấn đề đói tài nguyên và kỹ thuật lão hóa.                  | **Chương 5.3.4** Trang 211 - 213 |
| **Multilevel Queue** Hàng đợi đa cấp.                                                                                       | **5.3.5 Multilevel Queue Scheduling** Phân chia hàng đợi cho các loại tiến trình khác nhau (foreground/background). | **Chương 5.3.5** Trang 214 - 215 |
| **Multilevel Feedback Queue** Hàng đợi phản hồi đa cấp.                                                                     | **5.3.6 Multilevel Feedback Queue Scheduling** Cho phép tiến trình di chuyển giữa các hàng đợi.                     | **Chương 5.3.6** Trang 216       |

### Phần 3: Định Thời Nâng Cao (Tiểu trình, Đa xử lý, Thời gian thực)

_(Tương ứng với slide: Week06-Chapter4-3)_

Phần này mở rộng định thời sang các hệ thống phức tạp hơn như đa luồng, đa nhân và thời gian thực.

| Nội dung trong Slide UIT                                                                                                                                   | Nội dung tương ứng trong Textbook (10th Ed.)                                                                                                             | Vị trí tham chiếu              |
| :--------------------------------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------- | :----------------------------- |
| **Định thời tiểu trình** (Thread Scheduling) Phạm vi định thời: PCS (Process-contention scope) vs SCS (System-contention scope).                           | **5.4 Thread Scheduling** Phân biệt định thời giữa các luồng người dùng và luồng hạt nhân (LWP).                                                         | **Chương 5.4** Trang 217 - 218 |
| **Định thời đa bộ xử lý** (Multi-Processor Scheduling) Bất đối xứng vs Đối xứng (SMP), Multicore, Cân bằng tải (Load Balancing), Processor Affinity, NUMA. | **5.5 Multi-Processor Scheduling** Các vấn đề khi định thời trên hệ thống nhiều CPU hoặc đa nhân, bao gồm tính năng gán cứng (affinity) và cân bằng tải. | **Chương 5.5** Trang 220 - 226 |
| **Định thời thời gian thực** (Real-Time Scheduling) Soft vs Hard real-time, Rate Monotonic, Earliest Deadline First (EDF).                                 | **5.6 Real-Time CPU Scheduling** Các giải thuật đảm bảo thời gian phản hồi cho hệ thống thời gian thực.                                                  | **Chương 5.6** Trang 227 - 233 |

### Phần 4: Ví Dụ Hệ Điều Hành Thực Tế

_(Tương ứng với slide: Week06-Chapter4-3)_

Ánh xạ các lý thuyết vào các hệ điều hành cụ thể.

| Nội dung trong Slide UIT                                                          | Nội dung tương ứng trong Textbook (10th Ed.)                                                           | Vị trí tham chiếu                |
| :-------------------------------------------------------------------------------- | :----------------------------------------------------------------------------------------------------- | :------------------------------- |
| **Linux Scheduling** Completely Fair Scheduler (CFS), Nice value, Load balancing. | **5.7.1 Example: Linux Scheduling** Chi tiết về cách Linux sử dụng CFS và Red-black tree để định thời. | **Chương 5.7.1** Trang 234 - 238 |
| **Windows Scheduling** Priority classes, Dispatcher, 32 mức ưu tiên.              | **5.7.2 Example: Windows Scheduling** Cách Windows sử dụng 32 mức ưu tiên và biến đổi ưu tiên động.    | **Chương 5.7.2** Trang 239 - 242 |
| **Solaris Scheduling** Các lớp định thời (TS, IA, RT...), bảng dispatch.          | **5.7.3 Example: Solaris Scheduling** Hệ thống định thời dựa trên 6 lớp ưu tiên của Solaris.           | **Chương 5.7.3** Trang 242 - 244 |

## Chương 5: Đồng Bộ Tiến Trình

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
