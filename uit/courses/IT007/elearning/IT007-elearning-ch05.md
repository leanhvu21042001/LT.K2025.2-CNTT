# Đồng Bộ Tiến Trình

Một hệ thống thông thường sẽ bao gồm nhiều (có thể là hàng trăm, thậm chí là hàng ngàn) các tiểu trình thực thi đồng thời hoặc song song với nhau. Các tiểu trình này thường sẽ chia sẻ dữ liệu của người dùng. Trong khi đó, hệ điều hành sẽ thường xuyên cập nhật các cấu trúc dữ liệu để hỗ trợ việc thực thi đa tiểu trình. Hiện tượng *race condition* sẽ xuất hiện khi việc truy cập đến dữ liệu được chia sẻ không được kiểm soát, và có thể dẫn đến việc làm hỏng giá trị các dữ liệu.

*Đồng bộ hóa tiến trình* là việc sử dụng các công cụ để kiểm soát việc truy cập đến các dữ liệu được chia sẻ để tránh hiện tượng race condition. Các công cụ này phải được sử dụng cẩn thận, bởi nếu xảy ra sai sót thì có thể dẫn đến tình trạng giảm sút nghiêm trọng của hệ thống, bao gồm cả hiện tượng deadlock.

Mục tiêu:

- PHẦN 1
    - Mô tả được các vấn đề liên quan đến vùng tranh chấp (critical section) và phát biểu được điều kiện tranh chấp
    - Mô tả được các giải pháp được đề xuất để xử lý tranh chấp
    - Phát biểu được các yêu cầu đối với các giải pháp xử lý tranh chấp
    - Mô tả và phân tích được các giải pháp đồng bộ dựa trên ngắt (giải pháp phần mềm)
    - Mô tả được các giải pháp hỗ trợ từ phần cứng
- PHẦN 2
    - Diễn tả được cơ chế hoạt động của mutex lock, semaphore và monitor trong việc giải quyết bài toán vùng tranh chấp
    - Phân tích chương trình ứng dụng mutex lock và semaphore
    - Viết được chương trình sử dụng mutex lock và semaphore để thực hiện đồng bộ thứ tự hoạt động của tiến trình/tiểu trình
    - Trình bày được vấn đề Liveness trong hoạt động đồng bộ tiến trình
- PHẦN 3
    - Giải thích được bài toán đồng bộ bounded-buffer
    - Giải thích được bài toán đồng bộ readers-writers
    - Phân tích các vấn đề thường gặp khi thực hiện đồng bộ tiến trình/tiểu trình

Nội dung:

- PHẦN 1
    - Race Condition
    - Vấn đề vùng tranh chấp
    - Lời giải cho vấn đề vùng tranh chấp
    - Các giải pháp dựa trên ngắt (giải pháp phần mềm)
    - Các giải pháp phần cứng
- PHẦN 2
    - Mutex
    - Semaphore
    - Monitor
    - Các vấn đề khi đồng bộ
- PHẦN 3
    - Bài toán Bounded Buffer
    - Bài toán Readers - Writers
    - Bài toán Dining Philosophers

## Race Condition

Mục Tiêu:

- Trình bày được khái niệm race condition và mô tả được vấn đề vùng tranh chấp
- Mô tả được các yêu cầu dành cho lời giải của bài toán vùng tranh chấp
- Liệt kê được các giải pháp đồng bộ dựa trên ngắt (giải pháp phần mềm) và vấn đề của chúng
- Trình bày được giải pháp đồng bộ dựa trên phần cứng bao gồm `test_and_set`, `compare_and_swap`, và biến đơn nguyên

Nội Dung:

1. Race condition
2. Vấn đề vùng tranh chấp
3. Lời giải cho vấn đề vùng tranh chấp
4. Các giải pháp dựa trên ngắt (giải pháp phần mềm)
5. Giải pháp phần cứng

### Bài toán Producer vs. Consumer

Bài toán Producer vs. Consumer mô tả về 02 tiến trình bao gồm: “Sản xuất” và “Bán hàng”. Nếu gọi biến count mô tả số lượng hàng hóa, thì tiến trình “Sản xuất” sẽ làm tăng giá trị của count; ngược lại, tiến trình “Bán hàng” sẽ làm giảm giá trị này. Khi ”Sản xuất” và “Bán hang” diễn ra đồng thời, biến count sẽ chịu tác động của việc tăng và giảm cùng lúc. Khi đó, liệu rằng giá trị của count có còn đúng với logic?

- Gồm 02 tiến trình diễn ra đồng thời với nhau:
    - Producer: liên tục tạo ra hàng hóa → tăng biến `count`
    - Consumer: liên tục bán hàng → giảm biến `count`
- Thông thường các tiến trình đều sẽ được đặt trong vòng `while(1)` để thực thi liên tục.
- Khi các tiến trình thực thi đồng thời, các dữ kiện sau sẽ **KHÔNG** thể xác định được:
    - Tiến trình nào thực thi trước?
    - Tiến trình nào thực thi lâu hơn (do giải thuật định thời CPU)?
    - Tiến trình sẽ hết quantum time khi nào?

Producer:

```c
item nextProduce;

while (1) {
    while (count == BUFFER_SIZE);
        /* Khong lafm gi */
    buffer[in] = nextProducer;
    count++;
    in = (in+1) %BUFFER_SIZE;
}
```

Consumer:

```c
item nextConsumer;

while (1) {
    while (count == 0) {
        /* Khong lam gi */
    }
    
    nextConsumer = buffer[out];
    count--;
    out = (out+1) %BUFFER_SIZE;
}
```

`ProdvsCons.c`:

```c
#include <stdio.h>
#include <pthread.h>

#define BUFFER_SIZE 5

int count = 0;
int buffer[BUFFER_SIZE];

void *Producer(){
    int nextProduce = 1;
    int in = 0;
    while(1){
            while (count == BUFFER_SIZE);
            buffer[in] = nextProduce;
            count++;
            printf("PRODUCER | count = %d\n", count);
            in = (in + 1)%BUFFER_SIZE;
    }
}

void *Consumer(){
    int nextConsume;
    int out = 0;
    while(1){
        while (count == 0);
        nextConsume = buffer[out];
        count--;
        printf("CONSUMER | count = %d\n", count);
        out = (out + 1)%BUFFER_SIZE;
    }
}

int main(){
    pthread_t thread[2];
    pthread_create(
        &thread[0],
        NULL,
        &Producer,
        NULL
    );
    pthread_create(
        &thread[1],
        NULL,
        &Consumer,
        NULL
    );
    while(1){}

    return 0;
}
```

Knowledge Check 1

> [!NOTE]
> Chọn phát biểu đúng khi nói về thực thi *song song* và thực thi *đồng thời*?
> 
> - [x] Hai hay nhiều tác vụ có thể được thực thi đồng thời chỉ với một core CPU
> - [ ] Nếu hai tác vụ được thực thi đồng thời với nhau thì hệ thống cần có ít hai core CPU
> - [ ] Ta có 2 tiến trình PA và PB thực thi đồng thời với nhau, nếu CPU core thực thi PA thì PB sẽ vào trạng thái Terminated
> - [ ] Trong hệ thống có nhiều core CPU, mỗi core CPU chỉ cần phải thực thi một tác vụ

- Concurrency: Đồng thời, không cần nhiều core, dùng Context Switching.
- Parallel: Song song, cần nhiều core.

Knowledge Check 2

Sử dụng công thức đã cho `index = (index + 1)%BS`, với `BS = 8`, index ban đầu bằng 0, hãy hoàn thành chuỗi index bên dưới:

```
0 --> 1 --> 2 --> 3 --> 4 --> 5 --> 6 --> 7 --> 0 --> 1 --> 2 --> ...
```

- Công thức `index = (index + 1) % 8` là công thức tính toán cho **hàng đợi vòng (circular buffer)**. Khi giá trị đạt đến 7, phép chia lấy dư cho 8 sẽ đưa nó quay trở lại 0.
- "Nó cứ cộng lên dần dần, hễ đụng trần (bằng BS) thì nó nhảy về 0".

`buffer_index_calculator.c`:

```c
#include <stdio.h>

/* Dinh nghia kich thuoc Buffer Size */
#define BS 8

int main() {
    int n;
    int index = 0;
    int i;
    
    /* Yeu cau nguoi dung nhap n */
    printf("Nhap so luong phan tu n (mac dinh n = %d): ", BS);
    
    /* Kiem tra dau vao: Neu khong phai so hoac n <= 0 thi dung mac dinh */
    if (scanf("%d", &n) != 1 || n <= 0) {
        n = BS;
        printf("\n=> Dau vao khong hop le hoac bi bo qua.");
        printf(" Su dung gia tri mac dinh n = %d\n", n);
    }

    printf("\nChuoi gia tri index:\n");
    
    for (i = 0; i < n; i++) {
        /* In ra gia tri hien tai */
        printf("%d", index);
        
        /* In dau mui ten neu chua phai phan tu cuoi cung */
        if (i < n - 1) {
            printf(" --> ");
        }
        
        /* Tinh toan index tiep theo theo cong thuc vong */
        index = (index + 1) % BS;
    }
    
    printf("\n");
    
    return 0;
}
```

#### Các giải pháp khác

- Giải pháp "Cờ hiệu" (Branching / If-Else)

```c
index++;
if (index == BS) {
    index = 0;
}
```

- Bitwise
    - Đây là cách **nhanh nhất**, ít overhead nhất, nhưng có **một điều kiện nghiêm ngặt**: **`BS` phải là lũy thừa của 2** (2, 4, 8, 16, 32, 64...).
    - Phép `&` (AND) là lệnh cơ bản của CPU, chỉ tốn **1 chu kỳ máy (clock cycle)**. Trong khi đó phép chia lấy dư `%` (thực chất là phép chia `DIV`) có thể tốn từ **15-40 chu kỳ máy** tùy kiến trúc CPU.

```c
/* Thay vì: index = (index + 1) % 8; */
/* Hãy dùng: */
index = (index + 1) & 7;
```

#### So sánh tổng quan (Tại sao người ta vẫn dùng Modulo?)

| **Giải thuật**  | **Tốc độ CPU**           | **Ưu điểm**                                                                    | **Nhược điểm**                                                     |
| --------------- | ------------------------ | ------------------------------------------------------------------------------ | ------------------------------------------------------------------ |
| **Modulo (%)**  | Chậm (do dùng phép chia) | Code ngắn, logic toán học đẹp, dùng được cho **mọi kích thước** BS (lẻ, chẵn). | Tốn tài nguyên CPU nhất.                                           |
| **If-Else**     | Trung bình               | Dễ đọc, dễ debug.                                                              | Bị lỗi "dự đoán rẽ nhánh" làm chậm luồng xử lý.                    |
| **Bitwise (&)** | **Siêu nhanh**           | Tối ưu tuyệt đối cho phần cứng.                                                | **Chỉ dùng được** khi kích thước Buffer là lũy thừa của 2 ($2^n$). |

### Slide: Producer vs. Consumer

![Week07-Chapter5-1-2024](../lectures/Week07-Chapter5-1-2024.pdf#page=5-9)

### Quiz: Producer vs. Consumer

> [!NOTE]
> Trong chương trình `ProdvsCons.c`, khi chạy chương trình, vấn đề gì đã phát sinh?
> 
> - [ ] Tất cả đều đúng
> - [x] Các giá trị count của tiến trình Producer và Consumer không tăng/giảm theo logic
> - [ ] Mảng `buffer[in]` bị ghi sai vị trí
> - [ ] Tiến trình Producer và Consumer không thực thi xen kẽ nhau làm biến count bị tăng liên tục hoặc giảm liên tục

> [!NOTE]
> Trong bài toán Producer vs. Consumer, chúng ta sử dụng bounded buffer để lưu các giá trị, đặc điểm của bounded buffer là gì?
> 
> - [ ] Khi ghi giá trị liên tục vào bounded buffer, mảng sẽ bị tràn
> - [ ] Tất cả đều đúng
> - [ ] Các chỉ số được tạo ra ngẫu nhiên
> - [x] Khi mảng đầy, phần tử tiếp theo sẽ được ghi lại vào đầu mảng

> [!NOTE]
> Điền vào chỗ trống:
> 
> Trong bài toán Producer vs. Consumer, biến  `____` được chia sẻ chung giữa hai tiến trình và được gọi là dữ liệu được chia sẻ - shared data.
> 
> - `count`

### VIDEO: PHÂN TÍCH BÀI TOÁN PRODUCER VS. CONSUMER

Trong video này, ta sẽ đi phân tích lý do dẫn đến việc biến count không nhất quán giữa hai tiến trình Producer và Consumer.

Quantum Time = 3:

> [!NOTE]
> Giả sử giá trị ban đầu `count = 5`, mỗi thao tác load, gán, store tốn 01 chu kỳ lệnh. Nếu quantum `time = 03` chu kỳ lệnh, biết tiến trình Producer (`count++`) được thực thi trước Consumer (`count--`), hãy sắp xếp thứ tự thực thi của các thao tác dưới đây?
> 
> - CHU KỲ I: `reg1=count`
> - CHU KỲ II: `reg1 = reg1 + 1`
> - CHU KỲ III: `count = reg1`
> - CHU KỲ IV: `reg2 = count`
> - CHU KỲ V: `reg2 = reg2 - 1`
> - CHU KỲ VI: `count = reg2`

Vì **Quantum time (3) $\ge$ số lệnh cần thiết của tiến trình (3)**, nên Producer đã thực hiện trọn vẹn quá trình cập nhật biến (Atomic Operation) trước khi bị ngắt. Do đó, không xảy ra hiện tượng **Race Condition** (Điều kiện đua), và dữ liệu vẫn đảm bảo tính toàn vẹn (đúng đắn).

Quantum Time = 2:

> [!NOTE]
> Giả sử giá trị ban đầu `count = 5`, mỗi thao tác load, gán, store tốn 01 chu kỳ lệnh. Nếu quantum `time = 02` chu kỳ lệnh, biết tiến trình Producer (`count++`) được thực thi trước Consumer (`count--`), hãy sắp xếp thứ tự thực thi của các thao tác dưới đây?
> 
> - CHU KỲ I: `reg1=count`
> - CHU KỲ II: `reg1 = reg1 + 1`
> - CHU KỲ III: `reg2 = count`
> - CHU KỲ IV: `reg2 = reg2 - 1`
> - CHU KỲ V:  `count = reg1`
> - CHU KỲ VI: `count = reg2`

### Slide: Phân tích Bài toán Producer vs. Consumer

![Week07-Chapter5-1-2024](../lectures/Week07-Chapter5-1-2024.pdf#page=11)

### Quiz: Phân tích Bài toán Producer vs. Consumer

> [!NOTE]
> Thuật ngữ nào sau đây được sử dụng để chỉ vấn đề xảy ra ra bởi việc không đồng bộ tiến trình?
> 
> - [ ] Data consistency
> - [ ] Data missing
> - [ ] Process confliction
> - [x] Data inconsistency

> [!NOTE]
> CÁC yếu tố nào sau đây gây ra giá trị biến `count` của bài toán Producer - Consumer trở nên không nhất quán?
> 
> - [ ] Consumer thực hiện các lệnh sau Producer
> - [x] Mã máy của các lệnh thao tác lên biến `count` bị thực thi xen kẽ
> - [x] Biến `count` được chia sẻ cho 02 tiến trình
> - [ ] Các lệnh thao tác lên biến count là đơn nguyên

> [!NOTE]
> Nhận định sau đúng (True) hay sai (False)?
> 
> Giá trị cuối cùng của biến `count` không phụ thuộc vào việc tiến trình nào thực thi trước.
> 
> - [ ] True
> - [x] False

Bài toán Cấp phát PID

- `fork()`
- `next_available_pid`


### Race Condition

Qua các ví dụ trước đó, ta thấy việc tranh chấp dữ liệu được chia sẻ đã gây nên vấn đề bất đồng bộ. Việc tranh chấp này còn được gọi là Race Condition? Video này sẽ giúp bạn hiểu rõ hơn về Race Condition.

**Race condition** là hiện tượng xảy ra khi các tiến trình cùng truy cập đồng thời vào dữ liệu được chia sẻ. Kết quả cuối cùng sẽ phụ thuộc vào thứ tự thực thi của các tiến trình đang chạy đồng thời với nhau.

Trong bài toán Producer vs. Consumer dữ liệu được chia sẻ là biến `count` bị tác động đồng thời bởi cả 02 tiến trình Producer và Consumer.

Trong bài toán cấp phát PID, dữ liệu được chia sẻ là biến `next_available_pid` bị tranh giành bởi tiến trình thực thi đồng thời là P0 và P1.

> Race condition có thể dẫn đến việc dữ liệu bị sai và không nhất quán (inconsistency).

Để dữ liệu chia sẻ được nhất quán, cần bảo đảm sao cho tại mỗi thời điểm chỉ có một tiến trình được thao tác lên dữ liệu chia sẻ. Do đó, cần có cơ chế đồng bộ hoạt động của các tiến trình này.

### Quiz: Race Condition là gì?

> [!NOTE]
> Chọn phát biểu đúng khi nói về race condition?
> 
> - [ ] Race condition là hiện tượng xảy ra khi dữ liệu chia sẻ không thay đổi dưới tác động của các tiến trình.
> - [ ] Race condition là hiện tượng xảy ra khi các tiến trình không thể truy cập vào dữ liệu được chia sẻ cùng một lúc.
> - [ ] Race condition là hiện tượng xảy ra khi các tiến trình chỉ truy cập vào dữ liệu được chia sẻ một cách tuần tự.
> - [x] Race condition là hiện tượng xảy ra khi các tiến trình cùng truy cập đồng thời vào dữ liệu được chia sẻ, kết quả cuối cùng phụ thuộc vào thứ tự thực thi của các tiến trình.

> [!NOTE]
> Race condition có thể dẫn đến:
> 
> - [ ] Dữ liệu được cập nhật chính xác và nhất quán
> - [x] Dữ liệu bị sai và không nhất quán
> - [ ] Các tiến trình không thể hoạt động đồng thời
> - [ ] Dữ liệu được chia sẻ không bị ảnh hưởng bởi race condition

## Vấn đề vùng tranh chấp

Vùng tranh chấp (hay còn gọi là critical section) là vùng code mà ở đó các tiến trình thực hiện tác động lên dữ liệu được chia sẻ. Vấn đề vùng tranh chấp là một vấn đề phức tạp, do đó, ta cần có những yêu cầu cụ thể để đảm bảo rằng lời giải cho bài toán này có thể đáp ứng được các tiêu chuẩn như các tiến trình đều phải được thực thi, không bị xảy ra hiện tượng đói, dữ liệu không bị thiếu nhất quán hay không để xảy ra tình trạng deadlock.

### VIDEO 5.2 - 5.3: VẤN ĐỀ VÙNG TRANH CHẤP

```c
while(1) {
    entry section
        critical section
    exit section
        remainder section
}
```

> [!NOTE]
> Kéo thả các mô tả chức năng sau vào các section tương ứng?
> 
> - Entry section: Kiểm tra điều kiện
> - Critical section: Truy cập và thao tác
> - Exit section: Cài đặt các điều kiện sau khi truy cập
> - Remainder section: Thực hiện các thao tác bình thường

Methods:

- Mutual exclusion (loại trừ tương hỗ).
- Progress (tính tiến triển).
    - deadlock (tắc nghẽn)
- Bounded waiting (chờ đợi giới hạn).
    - Bao lâu.
        - ms
        - count

### Slide: Vấn đề vùng tranh chấp

### Đọc thêm: Starvation vs. Deadlock

If you write a program in which several concurrent threads are competing for resources, you must take precautions to ensure fairness. A system is fair when each thread gets enough access to limited resources to make reasonable progress. A fair system prevents starvation and deadlock. 

|Starvation|Deadlock|
|---|---|
|occurs when one or more threads in your program are blocked from gaining access to a resource and, as a result, cannot make progress.|the ultimate form of starvation, occurs when two or more threads are waiting on a condition that cannot be satisfied. Deadlock most often occurs when two (or more) threads are each waiting for the other(s) to do something.|

### Quiz: Vấn đề vùng tranh chấp

> [!NOTE]
> Mutual exclusion (loại trừ tương hỗ) trong bài toán vùng tranh chấp đảm bảo điều gì?
> 
> - [ ] Tiến trình chỉ được phép vào vùng tranh chấp sau khi đã thực thi trong vùng khác.
> - [ ] Mỗi tiến trình chỉ được phép thực thi trong vùng tranh chấp của nó.
> - [ ] Không có tiến trình nào được ngăn cản vào vùng tranh chấp.
> - [x] Không có tiến trình nào cùng thực thi trong vùng tranh chấp.

> [!NOTE]
> Progress (tính tiến triển) trong bài toán vùng tranh chấp đảm bảo điều gì?
> 
> - [x] Tiến trình không bị chặn trong vùng tranh chấp khi không có tiến trình khác thực thi vùng tranh chấp.
> - [ ] Tiến trình không bị ngăn cản vào vùng tranh chấp.
> - [ ] Tiến trình chỉ được thực thi trong vùng tranh chấp.
> - [ ] Mỗi tiến trình phải chờ đợi trong vùng tranh chấp.

> [!NOTE]
> Bounded waiting (chờ đợi giới hạn) trong bài toán vùng tranh chấp đảm bảo điều gì?
> 
> - [ ] Tiến trình chỉ được phép vào vùng tranh chấp sau khi đã thực thi trong vùng khác trong một khoảng thời gian xác định.
> - [ ] Mỗi tiến trình phải chờ đợi vô thời hạn để vào vùng tranh chấp.
> - [ ] Tiến trình không bị ngăn cản vào vùng tranh chấp.
> - [x] Mỗi tiến trình chỉ phải chờ đợi trong một khoảng thời gian xác định để vào vùng tranh chấp.

> [!NOTE]
> Chọn CÁC phát biểu đúng khi nói về starvation và deadlock?
> 
> - [x] Starvation xảy ra khi tiến trình bị ngăn cản nhận tài nguyên, từ đó dẫn đến việc tiến trình không thể thực thi
> - [ ] Deadlock và starvation đều bị gây ra bởi hiện tượng tiến trình có độ ưu tiên thấp bị các tiến trình có độ ưu tiên cao trưng dụng tài nguyên
> - [x] Deadlock thường xảy ra khi hai hay nhiều tiến trình chờ đợi lẫn nhau các điều kiện nào đó
> - [x] Deadlock và starvation đều làm cho tiến trình bị chờ vô hạn định

## Các giải pháp dựa trên ngắt (giải pháp phần mềm)

### VIDEO 5.4.1: GIẢI PHÁP PHẦN MỀM SỐ 01

Ý tưởng của giải pháp này sử dụng biến một biến `turn` để kiểm tra xem tiến trình tới lượt thực hiện của tiến trình nào với sự hỗ trợ của 2 thao tác đơn nguyên là `load` và `store`.

- $P_i$, $P_j$
- `load`, `store`
- `turn`
    - `int turn`

Kiểm tra yêu cầu Mutual Exclusion với giải pháp phần mềm số 1.

$P_0$:

```c
{
    while (true) {
        while (turn = = 1);
            /* critical section */
        turn = 1;
            /* remainder section */
    }
}
```

$P_1$:

```c
{
    while (true) {
        while (turn = = 0);
            /* critical section */
        turn = 0;
            /* remainder section */
    }
}
```

> [!NOTE]
> GIẢ ĐỊNH giải pháp KHÔNG THỎA MÃN yêu cầu Mutual Exclusion, như vậy ta có P0 và P1 `đồng thời` tiến vào vùng tranh chấp.
> 
> - P0 tiến vào vùng tranh chấp khi và chỉ khi turn = `0`
> - P1 tiến vào vùng tranh chấp khi và chỉ khi turn = `1`
> - => `turn =  1 = 0` => `vô lý`
> 
> Như vậy, GIẢ ĐỊNH đặt ra là `sai` $\to$ Mutual Exclusion `thỏa mãn`.

### Slide: Giải pháp phần mềm số 01

### Quiz: Giải pháp phần mềm số 01

> [!NOTE]
> Trong giải pháp phần mềm số 1, CÁC yêu cầu nào không được đáp ứng?
> 
> - [ ] Mutual Exclusion, Bounded waiting, và Progress
> - [x] Progress và Bounded waiting
> - [ ] Mutual Exclusion và Progress
> - [ ] Mutual Exclusion và Bounded waiting

> [!NOTE]
> Điền vào chỗ trống:
> 
> Để hiện thực giải pháp phần mềm số 1, các thao tác load và store phải là những thao tác `____`.
> 
> - đơn nguyên

### VIDEO 5.4.2: GIẢI PHÁP PETERSON

Giải pháp phần mềm 1 đã đưa ra ý tưởng về cách đảm bảo mutual exclusion tuy vẫn chưa thực hiện tốt việc đảm bảo progress và bounded waiting. Khắc phục các nhược điểm của giải pháp trên, Peterson đã đề xuất một giải pháp đảm bảo được cả 03 yêu cầu về lời giải của bài toán vùng tranh chấp.

- $P_i$, $P_j$
- `load`, `store`
- `turn`, `flag`
    - `int turn`
    - `boolean flag[2]`

$P_i$:

```c
{
    while (true) {
        flag[i] = true;
        turn = j;
        while (flag[j] && turn == j);
        
        /* critical section */
        
        flag[j] = false;
        
        /*remainder section */
    }
}
```

$P_0$:

```c
{
    while (true) {
        flag[0] = true;
        turn = 1;
        while (flag[1] && turn == 1);
        
        /* critical section */
        
        flag[0] = false;
        
        /*remainder section */
    }
}
```

$P_1$:

```c
{
    while (true) {
        flag[1] = true;
        turn = 0;
        while (flag[0] && turn == 0);
        
        /* critical section */
        
        flag[1] = false;
        
        /*remainder section */
    }
}
```

**Kiểm tra yêu cầu Mutual Exclusion với giải pháp Peterson.**

> [!NOTE]
> GIẢ ĐỊNH giải pháp KHÔNG THỎA MÃN yêu cầu Mutual Exclusion, như vậy ta có P0 và P1 cùng lúc tiến vào vùng tranh chấp.
> 
> - P0 tiến vào vùng tranh chấp khi turn = `0` HOẶC `flag[1] = false`
> - P1 tiến vào vùng tranh chấp khi turn =  `1` HOẶC `flag[0] = false`
> 
> P0 và P1 cùng tiến vào vùng tranh chấp, có nghĩa 2 tiến trình đã phải thực hiện `entry` section trước đó, do đó, ta có thể loại bỏ khả năng `flag[0] = false` và `flag[1] = false`, như vậy chỉ còn điều kiện turn = `0` = `1`  => `vô lý` 
> 
> Như vậy, GIẢ ĐỊNH đặt ra là `sai` => Mutual Exclusion `thỏa mãn`.

**Kiểm tra yêu cầu Progress với giải pháp Peterson.**

> [!NOTE]
> GIẢ ĐỊNH giải pháp KHÔNG THỎA MÃN yêu cầu Progress, như vậy ta có P0 không thực hiện CS nhưng lại ngăn cản P1 vào CS.
> 
> - P1 bị ngăn cản vào CS khi và chỉ khi: flag[0] = `true`  VÀ turn = `0` 
> - P0 không thực hiện CS thì có 2 khả năng xảy ra:
>     - P0 đang thực hiện Entry section => turn =  `1`
>     - P0 đã/đang thực hiện Exit section => flag[0] = `false`
>     - P0 không vào CS thì `không thể`  ngăn cản P1 vào CS.
> 
> Như vậy, GIẢ ĐỊNH đặt ra là `sai` => Progress `thỏa mãn`.

**Kiểm tra Bounded Waiting **

- Đảm bảo.

### Slide: Giải pháp Peterson

### Quiz: Giải pháp Peterson

> [!NOTE]
> Phát biểu nào sau đây là sai khi nói về giải thuật Peterson?
> 
> - [ ] Biến `turn` đóng vai trò kiểm tra lượt của tiến trình và cờ `flag[]` thể hiện sự sẵn sàng của tiến trình khi muốn tiến vào vùng tranh chấp
> - [ ] Giải thuật Peterson có thể gây ra hiện tượng deadlock
> - [ ] Giải thuật Peterson có thể gây ra hiện tượng starvation
> - [x] Giải thuật Peterson có thể áp dụng cho `n` tiến trình

> [!NOTE]
> Giải thuật Peterson thỏa mãn CÁC yêu cầu nào dành cho lời giải bài toán đồng bộ?
> 
> - [x] Bounded Waiting
> - [x] Progress
> - [x] Mutual Exclusion
> - [ ] Không yêu cầu nào cả

Điền vào chỗ trống.

Trong giải thuật Peterson, nếu muốn vào vùng tranh chấp, tiến trình P1 phải chờ tối đa là `____` lần P0 vào CS.

- `1`

### Giải pháp Peterson và kiến trúc hiện đại

Mặc dù giải pháp Peterson đã được chứng minh là hiệu quả ở trên, tuy nhiên trên các kiến trúc hiện đại thì việc này chưa chắc. Trên các hệ thống hiện đại, để cải thiện hiệu suất của hệ thống thì bộ vi xử lý và/hoặc trình biên dịch có thể sắp xếp lại các thao tác độc lập với nhau. Hãy cùng quan sát xem liệu việc này sẽ tác động như thế nào đến giải pháp Peterson trong phần này.

Ví dụ:

- `boolean flag = false;`
- `int x = 0;`

Điền vào chỗ trống?

Giá trị kỳ vọng của x được in ra sau khi chương trình thực thi là `___`?

- `100`

> [!NOTE]
> Xét giải pháp Peterson được thực hiện trong kiến trúc hiện đại với các thao tác được sắp xếp lại như hình trên, ta thấy:
> 
> - Khi P1 muốn vào CS thì turn = `0`, flag[0] = `false`, flag[1] = `true` . Kiểm tra điều kiện, ta thấy P1 `được phép` tiến vào CS.
> - Khi P0 muốn vào CS thì turn = `0`, flag[0] = `true`, flag[1] = `true`. Kiểm tra điều kiện, ta thấy P0 `được phép` tiến vào CS.
> 
> => Mutual Exclustion `không được` đảm bảo.

- Phải sử dụng **Memory Barrier**.

### Slide: Giải pháp Peterson và kiến trúc hiện đại

### Quiz: Giải pháp Peterson và kiến trúc hiện đại

> [!NOTE]
> Chọn phát biểu sai khi phát biểu về kiến trúc hiện đại?
> 
> - [ ] Các tiến trình đơn tiểu trình không bị ảnh hưởng bởi viêc sắp xếp lại các thao tác
> - [x] Vi xử lý/trình biên dịch sắp xếp lại tất cả thao tác trong mã nguồn để gia tăng hiệu suất xử lý
> - [ ] Các kết quả không dự đoán được có thể xuất hiện trên các tiến trình đa tiểu trình
> - [ ] Các thao tác độc lập với nhau có khả năng bị sắp xếp lại thứ tự thực hiện

> [!NOTE]
> Cơ chế nào sau đây được đề xuất để có thể hiện thực được giải pháp Peterson trên kiến trúc hiện đại?
> 
> - [x] Memory Barrier
> - [ ] Signaling
> - [ ] Interrupts
> - [ ] Exception handling

## Các giải pháp phần cứng

Bên cạnh các giải pháp phần mềm, phần cứng cũng đóng vai trò rất quan trọng trọng việc cũng cấp các cơ chế, các lệnh nhằm đảm bảo việc hiện thực các giải pháp cho bài toán vùng tranh chấp. Trong video này, ta sẽ đi tìm hiểu chi tiết về cơ chế Memory Barrier (rào chắn bộ nhớ).

- Memory model
    - Strongly ordered memory model: instantly
    - Weakly ordered memory model: may not be instantly
- Memory barrier
    - `load` và `store` hoàn thành trước khi các `load` và `store` khác thực hiện.

Thread1:

```c
while (!flag)
    memory_barier();
print(x)
```

Thread2:

```c
x = 100;
memory_barrier();
flag = true;
```

### Slide: Memory Barrier

### Quiz: Memory Barrier

> [!NOTE]
> Memory Barrier được chia thành các loại nào?
> 
> - [ ] Exclusive barrier và Inclusive barrier
> - [ ] Static ordered memory model và Dynamic ordered memory model
> - [x] Strongly ordered memory model và Weakly ordered memory model
> - [ ] Atomic barrier và Non-atomic barrier

> [!NOTE]
> Mục đích chính của Memory Barrier là gì?
> 
> - [ ] Ngăn chặn truy cập không đồng bộ vào bộ nhớ.
> - [ ] Loại bỏ các lỗi thời gian thực thi
> - [ ] Tăng hiệu suất thực thi của chương trình
> - [x] Đảm bảo thứ tự thực thi các câu lệnh

> [!NOTE]
> Nhận định sau đúng (True) hay sai (False): Sử dụng memory barrier có thể là giảm hiệu suất của chương trình?
> 
> - [x] True
> - [ ] False

### Slide: Các giải pháp phần cứng

## Mutex Locks

### VIDEO: GIỚI THIỆU CHƯƠNG 5 - PHẦN 2

Tiếp nối nội dung phần 1, trong phần này, các công cụ đồng bộ cấp cao do hệ điều hành hỗ trợ sẽ được giới thiệu. Lập trình viên có thể dễ dàng sử dụng các công cụ này để thực hiện việc đảm bảo loại trừ tương hỗ, kiểm soát thứ tự thực thi của tiến trình.

6. Mutex Locks
7. Semaphore
8. Monitor
9. Liveness

### Slide: Review

### VIDEO: MUTEX LOCKS

Mutex locks (hay "khoá mutex") là công cụ do hệ điều hành cung cấp, được sử dụng đơn giản để bảo loại trừ tương hỗ khi tác tiến trình thực hiện vùng tranh chấp. Các đặc điểm và cách hiện thực khoá mutex sẽ được ThS. Trần Hoàng Lộc trình bày trong video sau.

```c
acccquire()

release()
```

> [!NOTE]
> Mutex lock đảm bảo loại trừ tương hỗ bằng cách nào?
> 
> - [x] Đảm bảo khoá mutex chỉ có thể được khoá bởi một tiến trình tại mọi thời điểm, các tiến trình yêu cầu sau sẽ bị block
> - [ ] Các tiến trình phải vào trạng thái ngủ trước khi vào vùng tranh chấp, tiến trình nào thức dậy trước sẽ được tiến vào vùng tranh chấp trước
> - [ ] Tiến trình bị block bởi mutex sẽ được đánh thức sau một quãng thời thời gian q, sau đó trưng dụng CPU của tiến trình đang thực thi vùng tranh chấp trước đó

### Slide: Mutex Locks

### Quiz: Mutex Locks

Code:

```c
int var1 = 0, var2, var3;

processA()
{
    var1++;
    var2 = var1 / 2;

}

processB()
{
    if (var1 < 100)
        var3 = var1 / 2;
    else
        var1 = 0;
}
```

> [!NOTE]
> Cho đoạn mã giả như hình trên, hãy xác định những dòng nào thuộc vùng tranh chấp của tiến trình A và tiến trình B?
> 
> Điền các số dòng vào trong chỗ trống bên dưới, mỗi số dòng cách nhau bởi dấu phẩy và **không** có khoảng trắng giữa chúng. Ví dụ: 1,2,3,4
> 
> - Vùng tranh chấp của tiến trình processA gồm (các) dòng: 5,6
> - Vùng tranh chấp của tiến trình processB gồm (các) dòng: 11,12,13,14

Đọc phần Reading về chương trình mẫu sử dụng mutex và điền vào chỗ trống bên dưới:

Trong thư viện POSIX thread, để khai báo một mutex có tên là spinlock thì ta dùng lệnh:

```c
pthread_mutex_t spinlock;

int main() {
    pthread_mutex_init(&spinlock, NULL);
}

pthread_mutex_lock(&spinlock);

pthread_mutex_unlock(&spinlock);

```

Cho đoạn mã giả như hình trên, mutex _mut_ được sử dụng để đồng bộ cho 2 tiến trình processA và processB. Giả sử mutex mut đã được khai báo và khởi tạo, hãy kéo thả các dòng code vào đúng vị trí để đảm bảo loại trừ tương hỗ giữa 2 tiến trình?

```c
int var1 = 0, var2, var3;

processA()
{
    pthread_mutex_lock(&mut);
    var1++;
    var2 = var1 / 2;
    pthread_mutex_unlock(&mut);

}

processB()
{
    pthread_mutex_lock(&mut);
    if (var1 < 100)
        var3 = var1 / 2;
    else
        var1 = 0;
}
```

## Semaphores

Nếu mutex locks chỉ có thể đảm bảo loại trừ tương hỗ, semaphores lại cung cấp cơ chế đồng bộ mạnh mẽ và linh hoạt hơn với khả năng kiểm soát thứ tự thực thi của tiến trình, thậm chí của từng thao tác bên trong tiến trình. Hãy cùng đi tìm hiểu về khái niệm và đặc điểm của semaphores trong video sau.

```c
wait(S) {
    while (S <= 0) {
        // busy wait
    }
    S--;
}

signal(S) {
    S++;
}
```

> [!NOTE]
> Điền vào chỗ trống
> 
> Mỗi vị khách vào nhà hàng sẽ phải thực hiện thao tác `wait(freeTable)` và số lượng bàn trống sẽ tương ứng với giá trị của `freetable = 5`.

- Counting semaphore
    - integer
- Binary semaphore
    - 0
    - 1

### Slide: Semaphores

### Quiz: Semaphores

> [!NOTE]
> Semaphore kiểm soát việc thực thi của tiến trình bằng cách nào?
> 
> - [ ] Nếu tiến trình tạo ra/trả lại tài nguyên thì tăng semaphore lên một đơn vị
> - [ ] Nếu semaphore không dương thì tiến trình phải chờ
> - [x] Tất cả đều đúng
> - [ ] Nếu tiến trình sử dụng tài nguyên thì giảm semaphore đi một đơn vị

> [!NOTE]
> Về mặt bản chất, semaphore là?
> 
> - [ ] Biến số thực
> - [ ] Biến nhị phân
> - [ ] Hằng số
> - [x] Biến số nguyên

### VIDEO: HIỆN THỰC SEMAPHORES

Ý tưởng của semaphore tưởng chừng như đơn giản nhưng để hiện thực một cách hiệu quả, chúng ta vẫn cần đến sự hỗ trợ của hệ điều hành tương như với mutex. Video sau sẽ giúp người học hình dung rõ hơn về cách mà semaphore được hiện thực, từ đó hiểu rõ cách sử dụng của công cụ đồng bộ này.

#### Không Busy Waiting

- Hàng đợi
- Mỗi phần tử trong hàng đợi có 2 phần:
    - Giá trị của semaphore
    - Con trỏ đến phần tử tiếp theo
- Thao tác:
    - `block`
    - `wakeup`

`waiting queue`:

```c
typedef struct{

}
```

> [!NOTE]
> Danh sách liên kết đơn trong cấu trúc của semaphore có NHỮNG vai trò nào sau đây?
> 
> - [x] Quản lý danh sách các tiến trình bị `block`
> - [ ] Lựa chọn tiến trình bị block
> - [ ] Quản lý danh sách các tiến trình đã tiến vào vùng tranh chấp
> - [x] Kiểm soát thứ tự các tiến trình muốn sử dụng tài nguyên

> [!NOTE]
> Biết rằng khi tiến trình bị `block` thì nó sẽ vào trạng thái `waiting`, vậy sau khi tiến trình được `wake up` thì nó sẽ chuyển sang trạng thái nào?
> 
> - [ ] Terminated
> - [ ] New
> - [ ] Running
> - [x] Ready

### Slide: Hiện thực semaphores

### Quiz: Hiện thực semaphores

> [!NOTE]
> Hàng chờ trên semaphore hoạt động theo cơ chế nào?
> 
> - [x] First-in, First-out
> - [ ] First-in, Last-out
> - [ ] Tiến trình được chọn ngẫu nhiên
> - [ ] Cơ chế stack

> [!NOTE]
> Chọn phát biểu SAI về semaphore?
> 
> - [ ] Thao tác signal(S) làm tăng giá trị của semaphore
> - [x] Tiến trình gọi lệnh wait(S) sẽ bị chặn nếu giá trị của semaphore dương
> - [ ] Thao tác signal(S) sẽ khôi phục tiến trình đã bị chặn bởi lệnh wait(S) trước đó nếu giá trị của semaphore S sau khi tăng nhưng vẫn âm
> - [ ] Thao tác wait(S) làm giảm giá trị của semaphore S

> [!NOTE]
> Để hiện thực semaphore, hê điều hành cần cung cấp NHỮNG tác vụ nào sau đây?
> 
> - [x] Tác vụ đặc biệt dùng để hồi phục một tiến trình
> - [x] Tác vụ đặc biệt dùng để block tiến trình gọi nó
> - [ ] Tác vụ đặc biệt dùng để block tiến trình từ một tiến trình khác
> - [ ] Tác vụ đặc biệt dùng để tiến trình tự hồi phục

## Ứng dụng của Semaphores

Trong video này, ThS. Trần Hoàng Lộc sẽ trình bày cụ thể các trường hợp ứng dụng của semaphore. Việc sử dụng semaphore đòi hỏi lập trình viên cần phân tích rõ bài toán, đặt các hàm wait và signal đúng chỗ và gán đúng giá trị khởi tạo cho semaphore. Nếu sử dụng sai cách, semaphore có thể phản tác dụng và gây ra hiện tượng deadlock.

#### Đảm bảo loại trừ tương hỗ

> [!NOTE]
> Khi khởi tạo giá trị semaphore bằng 1 thì NHỮNG phát biểu nào sau đây là đúng?
> 
> - [x] Chỉ có tối đa 01 tiến trình bị block khi yêu cầu được vào vùng tranh chấp
> - [ ] Chỉ có tối đa 01 tiến trình được vào vùng tranh chấp cùng lúc
> - [ ] Tiến trình cuối cùng gọi hàm wait() sẽ được vào vùng tranh chấp trước
> - [x] Tiến trình gọi hàm wait() đầu tiên sẽ được vào vùng tranh chấp

- Chính xác! Do giá trị khởi tạo của semaphore là 1, sau khi tiến trình gọi lệnh `wait()`, giá trị này sẽ giảm xuống 0. Các tiến trình tới sau gọi lệnh `wait()` khi giá trị semaphore không dương đều sẽ bị block => Chỉ có 1 tiến trình được vào vùng tranh chấp cùng lúc.
- Chính xác! Do giá trị khởi tạo của semaphore là 1, tiến trình đầu tiên gọi lệnh `wait()` sẽ giảm giá trị này sẽ xuống 0. Các tiến trình tới sau gọi lệnh `wait()` khi giá trị semaphore không dương đều sẽ bị block. Khi tiến trình đầu tiên kia ra khỏi vùng tranh chấp và gọi hàm `signal()` thì lúc này những tiến trình bị block kia mới có thể được unblock và thực hiện vùng tranh chấp

> [!NOTE]
> Phát biểu sau Đúng (True) hay Sai (False)?
> 
> Sử dụng semaphore sẽ luôn đảm bảo được loại trừ tương hỗ giữa các tiến trình.
> 
> - [ ] True
> - [x] False

- Việc đảm bảo loại trừ tương hỗ chỉ đúng khi semaphore được cài đặt là 1 kết hợp với việc đặt hàm `wait()` và `signal()` đúng vị trí. Mặt khác nếu giá trị của semaphore lớn hơn 1, đồng nghĩa với việc có nhiều hơn 1 tiến trình có thể thực hiên thao tác `wait()` mà không bị block, từ đó có thể truy cập vùng tranh chấp --> Loại trừ tương hỗ không đảm bảo.

#### Đảm bảo thứ tự thực thi

- S1, S2.
- S1 luôn thực thi trước.
- `synch = 0`

> [!NOTE]
> Điền vào chỗ trống:
> 
> Để đồng bộ được bài toán này, ta cần đảm bảo:
> 
> - Nếu S2 (P2) chạy trước S1 (P1) thì sẽ bị chặn lại => Cần có một lệnh ĐỨNG TRƯỚC lệnh S2 để đảm bảo điều kiện này => Sử dụng lệnh: `wait(synch)`
> - Khi S1(P1) chạy xong => Cần có một lệnh ĐỨNG SAU lệnh S1 để báo hiệu cho S2 (P2) để lệnh này được phép chạy => Sử dụng lệnh: `signal(synch)`

> [!NOTE]
> Điền vào chỗ trống:
> 
> Hàm wait(synch) sẽ block tiến trình P2 khi và chỉ khi semaphore synch = `0`.

#### Đảm bảo điều kiện

- Đồng bộ tiến trình `Produce` và `Consume` sao cho: `sells <= products`.
    - Số đơn vị mà `sells` được tăng lên.
    - Số lượng semaphore
    - `wait()` và `signal()`
    - Xác định giá trị của semaphore: `stocks`

> [!NOTE]
> Điền vào chỗ trống:
> 
> Số lượng hàng hoá có thể được tính dựa trên độ chênh lệch giữa tổng số hàng đã bán và tổng số hàng đã sản xuất, tức là:
> 
> ```c
> stocks =  products - sells
> ```
> 

### Slide: Ứng dụng của semaphores

### Quiz: Ứng dụng của semaphores

Cho 2 tiến trình như sau:

```c
processA()
{ A1; A2; }
```

```c
processB()
{ B1; B2; }
```

Sắp xếp các mã giả sau để đảm bảo được điều kiện A1, B1, thực hiện trước A2, B2, biết rằng:

- s1 là semaphore đồng bộ cho điều kiện A1 thực hiện trước A2, B2
- s2 là semaphore đồng bộ cho điều kiện B1 thực hiện trước A2, B2

```c
processA()
{
    A1;
    signal(s1);
    wait(s2);
    A2;
}
```

```c
processB()
{
    B1;
    signal(s2);
    wait(s1);
    B2;
}
```

> [!NOTE]
> Semaphore là một công cụ đồng bộ rất mạnh mẽ, ta có thể sử dụng semaphore để thực hiện CÁC mục đích nào sau đây?
> 
> - [x] Đảm bảo loại trừ tương hỗ
> - [x] Kiểm soát thứ tự thực thi của các tiến trình
> - [x] Kiểm soát số lần thực thi một thao tác bất kỳ của tiến trình
> - [ ] Kiểm soát thời gian thực thi của các tiến trình

> [!NOTE]
> Điền vào chỗ trống:
> 
> Để cho phép 5 tiến trình cùng lúc thực thi thao tác `wait()` mà không bị `block`, cần khởi tạo giá trị của semaphore là `5`.

Cho P1, P2, cài đặt để S1 -> S2 -> S3 -> S4:

```c
P1 {
    S1;
    S3;
}

P3 {
    S2;
    S4;
}
```

Bài làm:

```c
int s1, s2, s3 = 0;
// int s4 = 0;

P1 {
    S1;
    signal(s1);
    wait(s2);
    S3;
    signal(s3);
    wait(s4)
}

P3 {
    wait(s1);
    S2;
    signal(s2);
    wait(s3);
    S4;
    // signal(s4);
}

```

### VIDEO: LƯU Ý KHI SỬ DỤNG SEMAPHORES

#### Một số nhận xét về semaphore

- Khi `s >= 0`: số lần mà các tiến trình/tiểu trình có thể thực thi `wait(S)` mà không bị blocked.
- Khi `s <5`: số tiến trình/tiểu trình đang đợi trên S là `|S|`
- Atomic và mutual exclusion: `wait(S)` và `signal(S)` là CS.
    - Uniprocessor: disable interrupt.
    - Multiprocessor: Dekker, Peterson (software); TestAndSet, Swap (hardware)
    - CS rất nhỏ.

#### Các vấn đề khi sử dụng semaphore

- Giá trị của S phải có ý nghĩa và chính xác.

```c
// P1
wait(S);
wait(Q);
...
signal(S);
signal(Q);

// P2
wait(Q);
wait(S);
...
signal(Q);
signal(S);
```

Giải pháp:

```c
// P1
// Đảo vị trí của wait()
wait(Q);
wait(S);
...
signal(S);
signal(Q);

// P2
wait(Q);
wait(S);
...
signal(Q);
signal(S);
```

### Slide: Lưu ý khi sử dụng semaphores

### Quiz: Lưu ý khi sử dụng semaphores

> [!NOTE]
> Tình trạng nào sau đây có thể xảy ra khi sử dụng semaphore sai cách?
> 
> - [x] Cả 2 vấn đề được nêu 
> - [ ] Deadlock
> - [ ] Trì hoãn vô hạn định

> [!NOTE]
> Hai thao tác wait() và signal() cần được đảm bảo loại trừ tương hỗ vì?
> 
> - [ ] Thao tác signal() có thể chuyển trạng thái tiến trình từ waiting sang running và xung đột với các tiến trình khác
> - [ ] Thao tác wait() có thể block tiến trình, từ đó dẫn đến tiến trình bị chờ đợi không giới hạn
> - [x] Đoạn mã của hai thao tác này sử dụng chung giá trị của semaphore dẫn đến đây cũng là vùng tranh chấp

> [!NOTE]
> Khi cài đặt semaphore, cần lưu ý những vấn đề nào sau đây?
> 
> - [x] Tất cả các vấn đề được nêu
> - [ ] Số lượng semaphore sử dụng
> - [ ] Vị trí đặt thao tác wait() và signal()
> - [ ] Giá trị khởi tạo của semaphore

## Monitors

### VIDEO: MONITORS

> [!NOTE]
> **Điền vào chỗ trống:**
> 
> Việc cài đặt semaphore _mutex_ như trong mã giả sẽ đảm bảo được yêu cầu `loại trừ tương hỗ` cho từng thủ tục.

### Slide: Monitors

### Quiz: Monitors

> [!NOTE]
> Điểm khác biệt khi sử dụng thêm biến điều kiện (condition variable) so với với monitor gốc là gì?
> 
> - [ ] Tiến trình truy cập vào monitor thông qua việc gọi các thủ tục    
> - [ ] Tiến trình truy cập vào monitor thông qua việc truy xuất biến điều kiện
> - [x] Tiến trình có thể chờ thêm trong hàng chờ của biến điều kiện
> - [ ] Tất cả đều đúng

> [!NOTE]
> Đặc điểm nào sau đây KHÔNG phải là của monitor?
> 
> - [ ] Là một cấu trúc cấp cao, bên trong có chứa các biến cục bộ, các thủ tục và một đoạn mã nguồn khởi tạo
> - [x] Có thể cho phép nhiều hơn 1 tiến trình vào monitor tại cùng một thời điểm
> - [ ] Biến cục bộ chỉ có thể được truy xuất bởi các thủ tục của monitor
> - [ ] Tiến trình vào monitor bằng cách gọi một trong các thủ tục của nó

## Liveness

### VIDEO: LIVENESS

Liveness là thuật ngữ dùng để chỉ trạng thái còn hoạt động của tiến trình. Một tiến trình bị xem là không đảm bảo liveness nếu nó không tạo hoạt động hay tạo ra tiến triển gì mới. Thể hiện cơ bản nhất của việc không đảm bảo liveness chính là "chờ đợi không giới hạn" và deadlock. Hãy theo dõi video sau để hiểu rõ hơn về liveness.

### Slide: Liveness

## Bài kiểm tra Tiểu kết Chương 5


