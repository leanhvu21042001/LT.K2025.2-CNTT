# Ánh xạ chương trình Hệ Điều Hành (UIT) sang Giáo trình chuẩn (Textbooks)

Tài liệu này ánh xạ nội dung từ các slide bài giảng môn Hệ Điều Hành (UIT) sang hai giáo trình tham khảo chính:

1. **OSC 10th**: _Operating System Concepts, 10th Edition_ (Silberschatz, Galvin, Gagne).
2. **OSTEP**: _Operating Systems: Three Easy Pieces_ (Remzi H. Arpaci-Dusseau, Andrea C. Arpaci-Dusseau).

## Chương 3: Tiến trình & Tiểu trình (Process & Thread)

_(Nguồn: Week03-Chapter3-1, Week04-Chapter3-2)_

Trong sách OSC, nội dung này được tách thành 2 chương (Ch 3: Processes và Ch 4: Threads).

| **Nội dung trong Slide UIT**                                                                                                                                                                             | **Nội dung tương ứng trong OSC (10th Ed.)**                                                                                                         | **Nội dung tương ứng trong OSTEP**                                                                                      |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| **Khái niệm Tiến trình (Process)**<br><br>  <br><br>- Định nghĩa, Trạng thái (New, Running, Waiting...), PCB (Process Control Block).<br><br>  <br><br>- Context Switch (Chuyển ngữ cảnh).               | **3.1 Process Concept**<br><br>  <br><br>**3.2 Process Scheduling** (Context Switch)<br><br>  <br><br>_(Trang 106 - 116)_                           | **Chapter 4: The Abstraction: The Process**<br><br>  <br><br>**Chapter 6: Direct Execution** (Context Switch/Mechanism) |
| **Các tác vụ trên Tiến trình**<br><br>  <br><br>- Tạo tiến trình (`fork()`), kết thúc tiến trình (`exit()`, `wait()`).<br><br>  <br><br>- Cây tiến trình trên Linux/Windows.                             | **3.3 Operations on Processes**<br><br>  <br><br>Mô tả chi tiết `fork()`, `exec()`, `wait()`.<br><br>  <br><br>_(Trang 116 - 124)_                  | **Chapter 5: Interlude: Process API**<br><br>  <br><br>Giải thích rất kỹ về `fork()` và `wait()`.                       |
| **Giao tiếp liên tiến trình (IPC)**<br><br>  <br><br>- Shared Memory (Bộ nhớ chia sẻ).<br><br>  <br><br>- Message Passing (Trao đổi thông điệp).<br><br>  <br><br>- Client-Server (Sockets, RPC, Pipes). | **3.4 Interprocess Communication**<br><br>  <br><br>**3.5 - 3.6 IPC Systems / Communication**<br><br>  <br><br>_(Trang 124 - 146)_                  | **N/A**<br><br>  <br><br>(OSTEP tập trung vào Concurrency threads hơn là IPC truyền thống ở phần đầu).                  |
| **Tiểu trình (Threads)**<br><br>  <br><br>- Đơn luồng vs Đa luồng.<br><br>  <br><br>- Mô hình đa luồng (Many-to-One, One-to-One, Many-to-Many).<br><br>  <br><br>- User Threads vs Kernel Threads.       | **4.1 Overview**<br><br>  <br><br>**4.2 Multicore Programming**<br><br>  <br><br>**4.3 Multithreading Models**<br><br>  <br><br>_(Trang 160 - 176)_ | **Chapter 26: Concurrency: An Introduction**<br><br>  <br><br>Giới thiệu why threads, user threads.                     |

## Chương 4: Định thời CPU (CPU Scheduling)

_(Nguồn: Week05-Chapter4-1, Week06-Chapter4-2, Week06-Chapter4-3)_

_Lưu ý: Slide UIT gọi là Chương 4, tương ứng Chương 5 trong OSC._

|   |   |   |
|---|---|---|
|**Nội dung trong Slide UIT**|**Nội dung tương ứng trong OSC (10th Ed.)**|**Nội dung tương ứng trong OSTEP**|
|**Các khái niệm cơ bản**<br><br>  <br><br>- Chu kỳ CPU-I/O Burst.<br><br>  <br><br>- Preemptive vs Non-preemptive scheduling.<br><br>  <br><br>- Dispatcher.|**5.1 Basic Concepts**<br><br>  <br><br>_(Trang 199 - 204)_|**Chapter 7: Scheduling: Introduction**<br><br>  <br><br>Các metric cơ bản và giả định.|
|**Tiêu chuẩn định thời (Criteria)**<br><br>  <br><br>- CPU utilization, Throughput.<br><br>  <br><br>- Turnaround time, Waiting time, Response time.|**5.2 Scheduling Criteria**<br><br>  <br><br>_(Trang 204 - 205)_|**Chapter 7**<br><br>  <br><br>Đề cập đến Turnaround Time và Response Time như 2 chỉ số chính.|
|**Các giải thuật định thời cơ bản**<br><br>  <br><br>- FCFS (First-Come, First-Served).<br><br>  <br><br>- SJF (Shortest Job First) & SRTF.<br><br>  <br><br>- RR (Round Robin) & Time Quantum.<br><br>  <br><br>- Priority Scheduling.|**5.3 Scheduling Algorithms**<br><br>  <br><br>Chi tiết FCFS, SJF, RR, Priority.<br><br>  <br><br>_(Trang 205 - 218)_|**Chapter 7** (FCFS, SJF)<br><br>  <br><br>**Chapter 8: Scheduling: The Multi-Level Feedback Queue** (Giải thích rất hay về cách RR hoạt động trong MLFQ).|
|**Hàng đợi đa cấp (Multi-level Queue)**<br><br>  <br><br>- Multilevel Queue.<br><br>  <br><br>- Multilevel Feedback Queue (MLFQ).|**5.3.5 Multilevel Queue Scheduling**<br><br>  <br><br>**5.3.6 Multilevel Feedback Queue**<br><br>  <br><br>_(Trang 218 - 221)_|**Chapter 8: Scheduling: The Multi-Level Feedback Queue**<br><br>  <br><br>Dành cả 1 chương để nói về MLFQ.|
|**Định thời đa luồng (Thread Scheduling)**<br><br>  <br><br>- Contention Scope (PCS vs SCS).<br><br>  <br><br>- Pthread Scheduling.|**5.4 Thread Scheduling**<br><br>  <br><br>_(Trang 221 - 224)_|**N/A**|
|**Định thời đa bộ xử lý (Multi-Processor)**<br><br>  <br><br>- Asymmetric vs Symmetric (SMP).<br><br>  <br><br>- Load Balancing (Cân bằng tải).<br><br>  <br><br>- Processor Affinity (NUMA).|**5.5 Multi-Processor Scheduling**<br><br>  <br><br>_(Trang 224 - 231)_|**Chapter 10: Multiprocessor Scheduling** (Advanced)<br><br>  <br><br>Bàn về Caches, Cache Affinity và Locking.|
|**Định thời thời gian thực (Real-Time)**<br><br>  <br><br>- Soft vs Hard real-time.<br><br>  <br><br>- Rate Monotonic & EDF.|**5.6 Real-Time CPU Scheduling**<br><br>  <br><br>_(Trang 231 - 238)_|**N/A**|

## Chương 5: Đồng bộ tiến trình (Process Synchronization)

_(Nguồn: Week07-Chapter5-1, Week09-Chapter5-2, Week10-Chapter5-3)_

_Lưu ý: Trong OSC 10th, phần này được chia thành Chương 6 (Công cụ) và Chương 7 (Ví dụ)._

|   |   |   |
|---|---|---|
|**Nội dung trong Slide UIT**|**Nội dung tương ứng trong OSC (10th Ed.)**|**Nội dung tương ứng trong OSTEP**|
|**Vấn đề Vùng tranh chấp (Critical Section)**<br><br>  <br><br>- Race Condition.<br><br>  <br><br>- 3 Yêu cầu: Mutual Exclusion, Progress, Bounded Waiting.|**6.1 Background**<br><br>  <br><br>**6.2 The Critical-Section Problem**<br><br>  <br><br>_(Trang 257 - 262)_|**Chapter 26** (Race Conditions)<br><br>  <br><br>**Chapter 28: Locks** (Định nghĩa Critical Section).|
|**Giải pháp phần mềm & Peterson**<br><br>  <br><br>- Peterson's Solution.|**6.3 Peterson's Solution**<br><br>  <br><br>_(Trang 262 - 264)_|**Chapter 28**<br><br>  <br><br>Bàn về các nỗ lực ban đầu (software-only solutions).|
|**Hỗ trợ phần cứng (Hardware Support)**<br><br>  <br><br>- Memory Barriers.<br><br>  <br><br>- Hardware Instructions: `test_and_set()`, `compare_and_swap()`.<br><br>  <br><br>- Atomic Variables.|**6.4 Hardware Support for Synchronization**<br><br>  <br><br>_(Trang 264 - 271)_|**Chapter 28: Locks**<br><br>  <br><br>Giải thích cực kỳ chi tiết về `TestAndSet`, `CompareAndSwap` và `LoadLinked/StoreConditional`.|
|**Mutex Locks & Semaphores**<br><br>  <br><br>- Spinlock vs Sleeping lock.<br><br>  <br><br>- Semaphore usage (Counting vs Binary).<br><br>  <br><br>- Cài đặt Semaphore (wait/signal).|**6.5 Mutex Locks**<br><br>  <br><br>**6.6 Semaphores**<br><br>  <br><br>_(Trang 271 - 279)_|**Chapter 28** (Locks/Mutex)<br><br>  <br><br>**Chapter 31: Semaphores**<br><br>  <br><br>Hướng dẫn chi tiết cách dùng Semaphores cho cả lock và ordering.|
|**Monitors**<br><br>  <br><br>- Khái niệm Monitor type.<br><br>  <br><br>- Condition Variables (`wait`, `signal`, `broadcast`).<br><br>  <br><br>- Ví dụ Java Monitor.|**6.7 Monitors**<br><br>  <br><br>**7.4 Synchronization in Java** (Chi tiết về Java Monitor)<br><br>  <br><br>_(Trang 279 - 287)_|**Chapter 30: Condition Variables**<br><br>  <br><br>Giải thích cơ chế Monitor pattern dùng Locks + CVs.|
|**Liveness & Deadlock (Cơ bản)**<br><br>  <br><br>- Deadlock, Starvation, Priority Inversion.|**6.8 Liveness**<br><br>  <br><br>_(Trang 287 - 289)_<br><br>  <br><br>_(Chi tiết về Deadlock nằm ở OSC Chương 8)_|**Chapter 32: Common Concurrency Problems**<br><br>  <br><br>Bàn về Deadlock (Livelock, Starvation).|
|**Các bài toán đồng bộ kinh điển**<br><br>  <br><br>- Bounded-Buffer (Sản xuất - Tiêu thụ).<br><br>  <br><br>- Readers-Writers (Đọc - Ghi).<br><br>  <br><br>- Dining Philosophers (Triết gia ăn tối).|**7.1 Classic Problems of Synchronization**<br><br>  <br><br>- 7.1.1 Bounded-Buffer<br><br>  <br><br>- 7.1.2 Readers-Writers<br><br>  <br><br>- 7.1.3 Dining-Philosophers<br><br>  <br><br>_(Trang 299 - 308)_|**Chapter 30 & 31**<br><br>  <br><br>Producer/Consumer (Ch 30)<br><br>  <br><br>Reader-Writer & Philosophers (Ch 31).|

### Ghi chú sử dụng tài liệu

1. **Thứ tự đọc:**
    
    - Sinh viên nên đọc **OSTEP trước** nếu muốn hiểu bản chất thông qua các đoạn code C thực tế và văn phong dễ hiểu.
    - Đọc **OSC (Textbook)** để nắm các định nghĩa học thuật chuẩn xác, các mô hình lý thuyết tổng quát (như Monitor, Real-time scheduling) và các ví dụ về Java/Solaris/Windows.

2. **Khác biệt chính:**
    
    - **OSC:** Dùng mã giả (pseudo-code) hoặc C++ mix Java trong các ví dụ đồng bộ hóa (đặc biệt là Monitor).
    - **OSTEP:** Thuần túy C và Pthreads (POSIX threads), rất sát với các bài thực hành Lab (nếu dùng Linux).
