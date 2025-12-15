# Đồng Bộ Tiến Trình
## Race Condition

### VIDEO: BÀI TOÁN PRODUCER VS. CONSUMER

> Bài toán Producer vs. Consumer mô tả về 02 tiến trình bao gồm: “Sản xuất” và “Bán hàng”. Nếu gọi biến count mô tả số lượng hàng hóa, thì tiến trình “Sản xuất” sẽ làm tăng giá trị của count; ngược lại, tiến trình “Bán hàng” sẽ làm giảm giá trị này. Khi ”Sản xuất” và “Bán hang” diễn ra đồng thời, biến count sẽ chịu tác động của việc tăng và giảm cùng lúc. Khi đó, liệu rằng giá trị của count có còn đúng với logic?

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

|**Giải thuật**|**Tốc độ CPU**|**Ưu điểm**|**Nhược điểm**|
|---|---|---|---|
|**Modulo (%)**|Chậm (do dùng phép chia)|Code ngắn, logic toán học đẹp, dùng được cho **mọi kích thước** BS (lẻ, chẵn).|Tốn tài nguyên CPU nhất.|
|**If-Else**|Trung bình|Dễ đọc, dễ debug.|Bị lỗi "dự đoán rẽ nhánh" làm chậm luồng xử lý.|
|**Bitwise (&)**|**Siêu nhanh**|Tối ưu tuyệt đối cho phần cứng.|**Chỉ dùng được** khi kích thước Buffer là lũy thừa của 2 ($2^n$).|
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
> CÁC yếu tố nào sau đây gây ra giá trị biến count của bài toán Producer - Consumer trở nên không nhất quán?
> 
> - [ ] Consumer thực hiện các lệnh sau Producer
> - [x] Mã máy của các lệnh thao tác lên biến count bị thực thi xen kẽ
> - [x] Biến count được chia sẻ cho 02 tiến trình
> - [ ] Các lệnh thao tác lên biến count là đơn nguyên

> [!NOTE]
> Nhận định sau đúng (True) hay sai (False)?
> 
> Giá trị cuối cùng của biến count không phụ thuộc vào việc tiến trình nào thực thi trước.
> 
> - [ ] True
> - [x] False
