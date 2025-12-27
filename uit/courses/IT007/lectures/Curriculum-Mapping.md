# Hệ Điều Hành

Dưới đây là bảng ánh xạ nội dung các chương còn lại trong chương trình Hệ điều hành của UIT (dựa trên các slide bài giảng được cung cấp) sang giáo trình **Operating System Concepts, 10th Edition**.

Tài liệu được sắp xếp theo thứ tự chương trong đề cương môn học của UIT.

## Chương 1: Tổng Quan về Hệ Điều Hành

_(Tương ứng với slide: Week01-Chapter1)_

### Phần 1: Giới Thiệu & Cấu Trúc Máy Tính

| Nội dung trong Slide UIT                                                                 | Nội dung tương ứng trong Textbook (10th Ed.)                                                               | Vị trí tham chiếu              |
| :--------------------------------------------------------------------------------------- | :--------------------------------------------------------------------------------------------------------- | :----------------------------- |
| **Hệ điều hành là gì?** Định nghĩa, mục tiêu (quản lý tài nguyên, giao diện người dùng). | **1.1 What Operating Systems Do** Vai trò của OS, góc nhìn người dùng và hệ thống.                         | **Chương 1.1** Trang 4 - 7     |
| **Cấu trúc hệ thống máy tính** Phần cứng, CPU, Memory, I/O devices, Interrupts (ngắt).   | **1.2 Computer-System Organization** Ngắt, cấu trúc lưu trữ (storage structure), cấu trúc nhập xuất (I/O). | **Chương 1.2** Trang 7 - 15    |
| **Cấu trúc lưu trữ** Phân cấp bộ nhớ (Hierarchy): thanh ghi, cache, main memory, disk.   | **1.2.2 Storage Structure** Phân cấp bộ nhớ, tốc độ, tính biến động (volatility).                          | **Chương 1.2.2** Trang 11 - 14 |

### Phần 2: Kiến Trúc & Các Thao Tác

|Nội dung trong Slide UIT|Nội dung tương ứng trong Textbook (10th Ed.)|Vị trí tham chiếu|
|:--|:--|:--|
|**Kiến trúc hệ thống máy tính** Đơn xử lý, Đa xử lý (SMP), Gom cụm (Clustered).|**1.3 Computer-System Architecture** Single-processor, Multiprocessor (SMP, Multicore), Clustered Systems.|**Chương 1.3** Trang 15 - 21|
|**Các thao tác trong hệ điều hành** Đa chương (Multiprogramming), Đa nhiệm (Multitasking).|**1.4 Operating-System Operations** Multiprogramming, Multitasking.|**Chương 1.4** Trang 21 - 24|
|**Chế độ hoạt động (Modes)** User mode vs Kernel mode, Dual-mode operation.|**1.4.2 Dual-Mode and Multimode Operation** Bit mode, chuyển đổi giữa user và kernel mode.|**Chương 1.4.2** Trang 24 - 26|

## Chương 2: Cấu Trúc Hệ Điều Hành

_(Tương ứng với slide: Week02-Chapter2)_

### Phần 1: Thành Phần & Dịch Vụ

|Nội dung trong Slide UIT|Nội dung tương ứng trong Textbook (10th Ed.)|Vị trí tham chiếu|
|:--|:--|:--|
|**Các dịch vụ của OS** Giao diện người dùng, thực thi chương trình, I/O, quản lý file.|**2.1 Operating-System Services** Các dịch vụ cung cấp cho người dùng và hệ thống.|**Chương 2.1** Trang 55 - 58|
|**Giao diện người dùng** CLI (Command Line), GUI, Touch-screen.|**2.2 User and Operating-System Interface** Command Interpreters, GUI, Touch-Screen Interface.|**Chương 2.2** Trang 58 - 62|
|**Lời gọi hệ thống (System Calls)** Cơ chế, API, truyền tham số.|**2.3 System Calls** Cách hoạt động, API (POSIX, Win32), các loại system calls.|**Chương 2.3** Trang 62 - 74|

### Phần 2: Cấu Trúc Hệ Thống

|Nội dung trong Slide UIT|Nội dung tương ứng trong Textbook (10th Ed.)|Vị trí tham chiếu|
|:--|:--|:--|
|**Cấu trúc Monolithic** UNIX truyền thống.|**2.8.1 Monolithic Structure** Cấu trúc đơn khối, ví dụ UNIX, Linux.|**Chương 2.8.1** Trang 82|
|**Cấu trúc Phân lớp (Layered)**|**2.8.2 Layered Approach** Chia hệ thống thành các lớp từ phần cứng (0) đến người dùng (N).|**Chương 2.8.2** Trang 83 - 84|
|**Vi nhân (Microkernels)** Mach OS, chuyển dịch vụ sang user space.|**2.8.3 Microkernels** Cấu trúc vi nhân, ví dụ Mach, QNX.|**Chương 2.8.3** Trang 84 - 86|
|**Cấu trúc Modules** Loadable Kernel Modules (LKM).|**2.8.4 Modules** Các mô-đun hạt nhân có thể nạp được (Linux, Solaris).|**Chương 2.8.4** Trang 86|
|**Cấu trúc Lai (Hybrid)** macOS, iOS, Android.|**2.8.5 Hybrid Systems** Kết hợp nhiều cấu trúc (macOS, iOS, Android).|**Chương 2.8.5** Trang 86 - 91|

## Chương 3: Quản Lý Tiến Trình

_(Tương ứng với slide: Week03-Chapter3-1 & Week04-Chapter3-2)_

Lưu ý: Chương 3 của UIT bao hàm nội dung của cả **Chương 3 (Processes)** và **Chương 4 (Threads)** trong sách giáo khoa.

### Phần 1: Khái Niệm & Trạng Thái

|Nội dung trong Slide UIT|Nội dung tương ứng trong Textbook (10th Ed.)|Vị trí tham chiếu|
|:--|:--|:--|
|**Khái niệm Tiến trình** Định nghĩa, Layout bộ nhớ (Text, Data, Heap, Stack).|**3.1 Process Concept** Process in memory, Stack, Heap.|**Chương 3.1** Trang 106 - 108|
|**Trạng thái Tiến trình** New, Ready, Running, Waiting, Terminated.|**3.1.2 Process State** Biểu đồ chuyển trạng thái.|**Chương 3.1.2** Trang 108 - 109|
|**Process Control Block (PCB)** Cấu trúc dữ liệu quản lý tiến trình.|**3.1.3 Process Control Block** Thông tin lưu trong PCB (PC, Registers, Scheduling info...).|**Chương 3.1.3** Trang 109 - 110|

### Phần 2: Thao Tác & Giao Tiếp (IPC)

|Nội dung trong Slide UIT|Nội dung tương ứng trong Textbook (10th Ed.)|Vị trí tham chiếu|
|:--|:--|:--|
|**Tạo và hủy tiến trình** `fork()`, `exec()`, `wait()`, `exit()`.|**3.3 Operations on Processes** Process Creation (fork/exec) & Termination.|**Chương 3.3** Trang 116 - 123|
|**Giao tiếp liên tiến trình (IPC)** Tổng quan Shared Memory vs Message Passing.|**3.4 Interprocess Communication** So sánh hai mô hình IPC.|**Chương 3.4** Trang 123 - 125|
|**Shared Memory** Bài toán Producer-Consumer.|**3.5 IPC in Shared-Memory Systems** Bounded-buffer problem sử dụng shared memory.|**Chương 3.5** Trang 125 - 127|
|**Message Passing** Direct/Indirect communication, Blocking/Non-blocking.|**3.6 IPC in Message-Passing Systems** Gửi nhận thông điệp, đồng bộ hóa.|**Chương 3.6** Trang 127 - 132|

### Phần 3: Tiểu Trình (Threads)

|Nội dung trong Slide UIT|Nội dung tương ứng trong Textbook (10th Ed.)|Vị trí tham chiếu|
|:--|:--|:--|
|**Khái niệm Tiểu trình** Đơn vị sử dụng CPU, chia sẻ tài nguyên.|**4.1 Overview** Định nghĩa luồng, lợi ích (Responsiveness, Resource sharing...).|**Chương 4.1** Trang 160 - 162|
|**Các mô hình đa tiểu trình** Many-to-One, One-to-One, Many-to-Many.|**4.3 Multithreading Models** Mô tả các mô hình ánh xạ giữa user thread và kernel thread.|**Chương 4.3** Trang 166 - 168|

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

## Chương 6: Tắc Nghẽn (Deadlock)

_(Tương ứng với slide: Week11-Chapter6)_

Lưu ý: Nội dung này tương ứng với **Chương 8 (Deadlocks)** trong sách giáo khoa.

### Phần 1: Đặc Điểm & Điều Kiện

|Nội dung trong Slide UIT|Nội dung tương ứng trong Textbook (10th Ed.)|Vị trí tham chiếu|
|:--|:--|:--|
|**Định nghĩa Deadlock** Tình trạng chờ đợi vòng tròn, ví dụ tắc nghẽn giao thông.|**8.1 System Model** Mô hình hệ thống tài nguyên và tiến trình.|**Chương 8.1** Trang 318|
|**4 Điều kiện cần** Mutual exclusion, Hold and wait, No preemption, Circular wait.|**8.3.1 Necessary Conditions** 4 điều kiện bắt buộc để xảy ra deadlock.|**Chương 8.3.1** Trang 321|
|**Đồ thị cấp phát tài nguyên** Resource-Allocation Graph (RAG).|**8.3.2 Resource-Allocation Graph** Sử dụng đồ thị để phát hiện chu trình.|**Chương 8.3.2** Trang 323 - 326|

### Phần 2: Các Phương Pháp Xử Lý

|Nội dung trong Slide UIT|Nội dung tương ứng trong Textbook (10th Ed.)|Vị trí tham chiếu|
|:--|:--|:--|
|**Ngăn chặn (Prevention)** Phủ định 1 trong 4 điều kiện cần.|**8.5 Deadlock Prevention** Các chiến lược ngăn chặn Mutual exclusion, Hold and wait, v.v.|**Chương 8.5** Trang 327 - 330|
|**Tránh (Avoidance)** Trạng thái an toàn (Safe state), Banker's Algorithm.|**8.6 Deadlock Avoidance** Giải thuật Banker, Resource-Allocation-Graph Algorithm.|**Chương 8.6** Trang 330 - 337|
|**Phát hiện (Detection)** Wait-for graph, giải thuật phát hiện.|**8.7 Deadlock Detection** Phát hiện khi có 1 hoặc nhiều instance tài nguyên.|**Chương 8.7** Trang 337 - 341|
|**Phục hồi (Recovery)** Chấm dứt tiến trình hoặc trưng dụng tài nguyên.|**8.8 Recovery from Deadlock** Process Termination, Resource Preemption.|**Chương 8.8** Trang 341 - 343|

## Chương 7: Quản Lý Bộ Nhớ

_(Tương ứng với slide: Week12-Chapter7)_

Lưu ý: Nội dung này tương ứng với **Chương 9 (Main Memory)** trong sách giáo khoa.

### Phần 1: Khái Niệm Cơ Bản

|Nội dung trong Slide UIT|Nội dung tương ứng trong Textbook (10th Ed.)|Vị trí tham chiếu|
|:--|:--|:--|
|**Địa chỉ Logic vs Vật lý** Logical/Virtual address, Physical address, MMU.|**9.1.3 Logical Versus Physical Address Space** Khái niệm không gian địa chỉ, vai trò của MMU.|**Chương 9.1.3** Trang 353 - 355|
|**Liên kết địa chỉ** Compile time, Load time, Execution time.|**9.1.2 Address Binding** Quá trình binding tại các thời điểm khác nhau.|**Chương 9.1.2** Trang 352 - 353|
|**Dynamic Loading/Linking**|**9.1.4 Dynamic Loading & 9.1.5 Dynamic Linking**|**Chương 9.1.4 - 9.1.5** Trang 355 - 356|

### Phần 2: Cấp Phát & Phân Trang

|Nội dung trong Slide UIT|Nội dung tương ứng trong Textbook (10th Ed.)|Vị trí tham chiếu|
|:--|:--|:--|
|**Cấp phát liên tục** Fixed/Dynamic partitioning, First-fit, Best-fit, Worst-fit.|**9.2 Contiguous Memory Allocation** Memory allocation, Fragmentation (Nội/Ngoại).|**Chương 9.2** Trang 356 - 360|
|**Phân trang (Paging)** Frames, Pages, Page Table, PTBR, TLB.|**9.3 Paging** Cơ chế phân trang cơ bản, phần cứng hỗ trợ (TLB).|**Chương 9.3** Trang 360 - 371|
|**Cấu trúc bảng trang** Phân trang phân cấp (Hierarchical), Hashed, Inverted.|**9.4 Structure of the Page Table** Hierarchical Paging, Hashed Page Tables, Inverted Page Tables.|**Chương 9.4** Trang 371 - 375|
|**Swapping** Cơ chế tráo đổi tiến trình.|**9.5 Swapping** Standard swapping, Swapping with paging.|**Chương 9.5** Trang 376 - 378|

## Chương 8: Bộ Nhớ Ảo

_(Tương ứng với slide: Week13-Chapter8)_

Lưu ý: Nội dung này tương ứng với **Chương 10 (Virtual Memory)** trong sách giáo khoa.

### Phần 1: Cơ Chế Cơ Bản

|Nội dung trong Slide UIT|Nội dung tương ứng trong Textbook (10th Ed.)|Vị trí tham chiếu|
|:--|:--|:--|
|**Tổng quan bộ nhớ ảo** Lợi ích, không gian địa chỉ ảo.|**10.1 Background** Virtual memory concept.|**Chương 10.1** Trang 389 - 392|
|**Phân trang theo yêu cầu** Demand Paging, Page Fault, Lazy swapper.|**10.2 Demand Paging** Cơ chế xử lý lỗi trang (Page Fault).|**Chương 10.2** Trang 392 - 399|
|**Copy-on-Write**|**10.3 Copy-on-Write** Tối ưu hóa khi tạo tiến trình (fork).|**Chương 10.3** Trang 399 - 401|

### Phần 2: Thay Thế Trang & Cấp Phát

|Nội dung trong Slide UIT|Nội dung tương ứng trong Textbook (10th Ed.)|Vị trí tham chiếu|
|:--|:--|:--|
|**Giải thuật thay thế trang** FIFO, Optimal (OPT), LRU, Second-chance.|**10.4 Page Replacement** Basic Page Replacement, FIFO, Optimal, LRU, LRU-Approximation.|**Chương 10.4** Trang 401 - 413|
|**Cấp phát khung trang** Fixed/Priority allocation, Global vs Local allocation.|**10.5 Allocation of Frames** Minimum frames, Allocation algorithms.|**Chương 10.5** Trang 413 - 419|
|**Thrashing (Trì trệ)** Nguyên nhân, Mô hình tập làm việc (Working-Set Model).|**10.6 Thrashing** Cause of Thrashing, Working-Set Model, Page-Fault Frequency.|**Chương 10.6** Trang 419 - 425|

## Chương 9: Hệ Điều Hành Linux và Windows

_(Tương ứng với slide: Week14-Chapter9)_

Lưu ý: Nội dung này được tách thành hai chương riêng biệt trong sách giáo khoa: **Chương 20 (The Linux System)** và **Chương 21 (Windows 10)**.

### Phần 1: Hệ Điều Hành Linux

|Nội dung trong Slide UIT|Nội dung tương ứng trong Textbook (10th Ed.)|Vị trí tham chiếu|
|:--|:--|:--|
|**Lịch sử & Thiết kế** Lịch sử phát triển, Nguyên tắc thiết kế.|**20.1 History & 20.2 Design Principles**|**Chương 20.1 - 20.2** Trang 775 - 783|
|**Quản lý tiến trình & Định thời** Process identity, fork/clone, CFS scheduler.|**20.4 Process Management & 20.5 Scheduling**|**Chương 20.4 - 20.5** Trang 786 - 795|
|**Quản lý bộ nhớ** Physical memory, Virtual memory, Slab allocator.|**20.6 Memory Management**|**Chương 20.6** Trang 795 - 803|
|**Hệ thống tập tin** VFS, ext3/ext4, procfs.|**20.7 File Systems**|**Chương 20.7** Trang 803 - 810|

### Phần 2: Hệ Điều Hành Windows

|Nội dung trong Slide UIT|Nội dung tương ứng trong Textbook (10th Ed.)|Vị trí tham chiếu|
|:--|:--|:--|
|**Lịch sử & Thiết kế** Lịch sử các phiên bản, Nguyên tắc thiết kế (Security, Reliability...).|**21.1 History & 21.2 Design Principles**|**Chương 21.1 - 21.2** Trang 821 - 838|
|**Thành phần hệ thống** HAL, Kernel, Executive (Object manager, VM manager...).|**21.3 System Components**|**Chương 21.3** Trang 838 - 858|
|**Hệ thống tập tin (NTFS)** Cấu trúc NTFS, Recovery.|**21.5 File System**|**Chương 21.5** Trang 875 - 880|
|**Networking** Giao thức mạng, NDIS.|**21.6 Networking**|**Chương 21.6** Trang 880 - 884|
