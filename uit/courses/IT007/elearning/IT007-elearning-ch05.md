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



