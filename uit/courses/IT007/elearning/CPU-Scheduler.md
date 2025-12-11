# CPU Scheduler

Dưới đây là bảng **Chuẩn hóa công thức** dùng cho **MỌI** giải thuật định thời CPU (FCFS, SJF, Round Robin, Priority, v.v.). Tôi sẽ map (ánh xạ) ký hiệu của bạn với ký hiệu chuẩn quốc tế (thường dùng trong giáo trình như Silberschatz hay Tanenbaum) để bạn dễ tra cứu.

## Các Công Thức

### 1. Bảng Công Thức "Bất Di Bất Dịch"

| **Khái niệm**           | **Ký hiệu Chuẩn**         | **Ký hiệu của bạn** | **Công thức (Công thức gốc)**       | **Ý nghĩa**                                                  |
| ----------------------- | ------------------------- | ------------------- | ----------------------------------- | ------------------------------------------------------------ |
| **Thời gian đến**       | **AT** (Arrival Time)     | $r$ (release)       | Dữ liệu đề bài                      | Thời điểm tiến trình xuất hiện trong hàng đợi.               |
| **Thời gian thực hiện** | **BT** (Burst Time)       | $E$ (Execution)     | Dữ liệu đề bài                      | Tổng thời gian CPU cần để hoàn thành công việc.              |
| **Thời gian hoàn tất**  | **CT** (Completion Time)  | $f$ (finish)        | Nhìn trên Gantt (Mốc cuối cùng)     | Thời điểm tiến trình hoàn toàn rời khỏi hệ thống.            |
| **Thời gian lưu lại**   | **TAT** (Turnaround Time) | $F$ (Flow Time)     | $$TAT = CT - AT$$ $$(F = f - r)$$   | Tổng thời gian tiến trình "sống" trong hệ thống (từ lúc đến tới lúc đi). |
| **Thời gian chờ**       | **WT** (Waiting Time)     | $W$ (Waiting)       | $$WT = TAT - BT$$ $$(W = F - E)$$   | Tổng thời gian tiến trình **đứng chơi** trong hàng đợi (Ready Queue). |
| **Thời gian đáp ứng**   | **RT** (Response Time)    | $R$ (Response)      | $$RT = t_0 - AT$$ $$(R = t_0 - r)$$ | Thời gian từ lúc gõ lệnh đến lúc thấy phản hồi **đầu tiên**. |

### 2. Đánh giá các định nghĩa bạn cung cấp

Các định nghĩa bạn đưa ra trong ảnh `SCR-20251209-lblq.png` và phần text là **CHÍNH XÁC VỀ MẶT HỌC THUẬT**.

- **$W = F - E$ (Waiting = Flow - Execution):** Đây là công thức đúng và an toàn nhất.
  - Nhiều bạn hay tính thủ công bằng cách cộng các khoảng trống trên Gantt ($Wait = Gap_1 + Gap_2...$). Cách này dễ sai sót.
  - Cách dùng $TAT - Burst$ (Flow - Execution) là cách "lấy tổng trừ đi phần làm việc" $\rightarrow$ ra phần chờ. Nó luôn đúng, bất kể giải thuật phức tạp cỡ nào.
- **$R = t_0 - r$:** Đây là định nghĩa cốt lõi của Response Time. Bạn chỉ cần nhớ: **$t_0$ là lần chạm mặt CPU đầu tiên**.

### 3. Sự khác biệt tử thần: Có trưng dụng (Preemptive) vs Không trưng dụng (Non-preemptive)

Tại sao bạn lại nhầm lẫn ở bài trước? Vì trong các bài tập FCFS đơn giản, RT và WT thường bằng nhau.

Dưới đây là quy tắc để phân loại:

#### **A. Nhóm Non-Preemptive (FCFS, SJF thường)**

- **Đặc điểm:** Tiến trình chạy một mạch từ đầu đến cuối (`Start` trùng với `First Start`). Không bao giờ bị ngắt.
- **Hệ quả:**
  - Thời gian đáp ứng ($RT$) **LUÔN BẰNG** Thời gian chờ ($WT$).
  - $$RT = WT$$

#### **B. Nhóm Preemptive (SRTF, Round Robin, Priority Preemptive)**

- **Đặc điểm:** Tiến trình chạy, bị dừng, chờ, rồi chạy tiếp.

- **Hệ quả:**

  - **Response Time ($RT$):** Chỉ quan tâm lần đầu tiên ($t_0 - r$).

  - **Waiting Time ($WT$):** Quan tâm tổng thể ($Wait_{đầu} + Wait_{giữa\_1} + Wait_{giữa\_2}...$).

  - $$RT \le WT$$

     (Thời gian đáp ứng luôn nhỏ hơn hoặc bằng thời gian chờ).

### 4. Minh họa trực quan (Visual Cheat Sheet)

Để bạn không bao giờ nhầm nữa, hãy lưu hình dung này vào đầu:

```asciiarmor
Trục thời gian (Time Axis) --->

      (r) Arrival        (t0) First Start                                    (f) Finish
       |                  |                                                   |
       v                  v                                                   v
-------|..................|//////////|..................|//////////|//////////|---->
       <--- Wait 1 ------> <--Exec1--> <-- Wait 2 -----> <--Exec2--> <--Exec3-->

       |__________________|
          Response Time
             (R)

       |______________________________________________________________________|
                            Turnaround / Flow Time (F)

Wait Time (W) = (Wait 1) + (Wait 2)
              = Total Flow (F) - Total Exec (E)
```

## Resources

- [Hands-On with sched_ext: Building Custom eBPF CPU Schedulers](https://free5gc.org/blog/20250509/20250509/)
- https://speakerdeck.com/ennael/sched-ext-pluggable-scheduling-in-the-linux-kernel
- https://www.youtube.com/watch?v=jsLjg9tGuVI
- https://docs.kernel.org/scheduler/sched-ext.html
- https://medium.com/@pooyan.azadparvar/exploring-linux-kernel-internals-779ec5b377e9
- https://0xax.gitbooks.io/linux-insides/content/

