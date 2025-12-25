# Chapter 1: The Anomaly

## 1. Lời nói dối ngọt ngào

Khi bắt đầu học lập trình, đặc biệt là C, chúng ta thường hình dung bộ nhớ máy tính (RAM) giống như một dải băng dài vô tận, hoặc một mảng (array) khổng lồ.

Trong trí tưởng tượng đó:

1. Bộ nhớ bắt đầu từ địa chỉ 0 và tăng dần lên (1, 2, 3...).
2. Khi chúng ta khai báo biến, chúng sẽ được xếp hàng ngay ngắn, biến sau nằm liền kề biến trước tại địa chỉ cao hơn.
3. Mọi thứ đều ngăn nắp và tuyến tính.

Đó là một mô hình tư duy tuyệt vời. Nó đơn giản, dễ hiểu.

Nhưng nó sai hoàn toàn.

Hãy để code tự nói lên sự thật. Chúng ta sẽ thực hiện một thí nghiệm nhỏ: tạo ra các biến ở các vùng nhớ khác nhau (Toàn cục, Stack, Heap) và xem Hệ điều hành thực sự đặt chúng ở đâu.

## 2. Bằng chứng thực nghiệm (The Evidence)

Hãy tạo một file `memory_anomaly.c` và biên dịch nó.

```c
#include <stdio.h>
#include <stdlib.h>

// 1. Biến toàn cục (Global Variable)
// Dự đoán: Nó sẽ nằm ở đâu đó cố định?
int globalVar = 10;

int main() {
    // 2. Biến cục bộ (Stack Variables)
    // Chúng ta khai báo var1 trước, var2 sau.
    int stackVar1 = 10;
    int stackVar2 = 20;

    // 3. Biến cấp phát động (Heap Variable)
    // Xin cấp phát một vùng nhớ trong khi chương trình đang chạy
    int *heapVar1 = (int*)malloc(sizeof(int));
    int *heapVar2 = (int*)malloc(sizeof(int));

    printf("=== BẢN ĐỒ BỘ NHỚ ===\n");
    printf("[Global] globalVar : %p\n", (void*)&globalVar);
    printf("----------------------------------------\n");
    printf("[Heap]   heapVar1  : %p\n", (void*)heapVar1);
    printf("[Heap]   heapVar2  : %p  (Cách heapVar1: %ld bytes)\n", 
           (void*)heapVar2, (long)heapVar2 - (long)heapVar1);
    printf("----------------------------------------\n");
    printf("[Stack]  stackVar1 : %p\n", (void*)&stackVar1);
    printf("[Stack]  stackVar2 : %p  (Cách stackVar1: %ld bytes)\n", 
           (void*)&stackVar2, (long)&stackVar2 - (long)&stackVar1);

    // Dọn dẹp
    free(heapVar1);
    free(heapVar2);
    return 0;
}
```

## 3. Quan sát (The Observation)

Khi chạy đoạn code trên (trên kiến trúc x86-64, ví dụ như Linux hoặc macOS), bạn sẽ nhận được một kết quả tương tự như sau (địa chỉ cụ thể sẽ thay đổi mỗi lần chạy, nhưng _mô hình_ thì không):

```
=== BẢN ĐỒ BỘ NHỚ ===
[Global] globalVar : 0x601040
----------------------------------------
[Heap]   heapVar1  : 0x142b010
[Heap]   heapVar2  : 0x142b030  (Cách heapVar1: 32 bytes)
----------------------------------------
[Stack]  stackVar1 : 0x7ffebb7e44fc
[Stack]  stackVar2 : 0x7ffebb7e44f8  (Cách stackVar1: -4 bytes)
```

Hãy nhìn kỹ vào các con số. Có **3 điều bất thường (Anomaly)** đang diễn ra ở đây:

### Bất thường #1: Sự phân cực khổng lồ

Hãy so sánh địa chỉ của `Global` và `Stack`.

- Global: `0x0000000000601040` (Con số rất nhỏ)
- Stack: `0x00007ffebb7e44fc` (Con số cực kỳ lớn - hàng nghìn tỷ)

Giữa chúng là một khoảng trống mênh mông (Void). Tại sao dữ liệu của cùng một chương trình lại bị ném ra hai đầu cực của vũ trụ bộ nhớ như vậy?

### Bất thường #2: Heap "mọc" xuôi

Tại vùng Heap, `heapVar2` được cấp phát sau `heapVar1`.

- Địa chỉ `heapVar2` > `heapVar1`.
- Điều này có vẻ đúng với logic thông thường: cái sau xếp nối tiếp cái trước.

### Bất thường #3: Stack "mọc" ngược (The Inverse Growth)

Đây là điểm thú vị nhất.

- `stackVar2` được khai báo **sau** `stackVar1`.
- Theo logic "xếp hàng", nó phải nằm ở địa chỉ cao hơn (ví dụ `...500`).
- **Thực tế:** Địa chỉ của nó lại **nhỏ hơn** 4 byte (`...4f8`).

Tại sao vùng Stack lại đi lùi? Giống như việc bạn xây một tòa tháp, nhưng thay vì xây từ móng lên trời, bạn lại bắt đầu từ trần nhà và xây ngược xuống đất.

## 4. Kết luận tạm thời

Những con số hex khô khan này đang kể cho chúng ta một câu chuyện bí ẩn về thiết kế máy tính:

1. Bộ nhớ không phẳng (flat). Nó có cấu trúc vùng miền rõ rệt.
2. Có một quy luật ngầm định khiến Stack và Heap phát triển theo hai hướng ngược nhau.

Ai là người đứng sau sự sắp xếp "kỳ quặc" này? Là phần cứng (CPU/RAM) hay là phần mềm (Hệ điều hành)? Tại sao họ lại làm vậy?

Trong chương tiếp theo, chúng ta sẽ gặp gỡ nhân vật quyền lực nhất trong máy tính của bạn: **The Illusionist (Kẻ tạo ảo giác)**.
