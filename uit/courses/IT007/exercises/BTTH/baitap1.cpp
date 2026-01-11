%%writefile baitap1.cpp

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <semaphore.h>
#include <unistd.h>

volatile int keep_running = 1;

// 4 số cuối của Mã Số Sinh Viên: 0291
#define MSSV 291

int buffer[MSSV];

sem_t full, empty;
pthread_mutex_t mutex;

int products = 0;
int sells = 0;

// Công việc của Producer
void* producer(void* arg) {
    while(keep_running) {
        sem_wait(&empty);
        pthread_mutex_lock(&mutex);
        products++;
        printf("PRODUCE | Tong so hang duoc san xuat la: %d\n", products);
        pthread_mutex_unlock(&mutex);
        sem_post(&full);
    }

    printf("[Producer] Tôi Thoát Đây!");
    pthread_exit(NULL);
}

// Công việc của Consumer
void* consumer(void* arg) {
    while(keep_running) {
        sem_wait(&full);
        pthread_mutex_lock(&mutex);
        sells++;
        printf("CONSUME | Tong so hang duoc ban ra la: %d\n", sells);
        pthread_mutex_unlock(&mutex);
        sem_post(&empty);
    }

    printf("[Consumer] Tôi Thoát Đây!");
    pthread_exit(NULL);
}

int main()
{
    // Khai báo tiểu trình
    pthread_t tproducer, tconsumer;

    pthread_mutex_init(&mutex, NULL);

    // semaphore 'full' cục bộ giữa các tiểu trình, bắt đầu với 0 sản phẩm có sẵn
    sem_init(&full, 0, 0);
    // semaphore 'empty' cục bộ, bắt đầu với số lượng 'mssv' tồn kho tối đa
    sem_init(&empty, 0, MSSV);

    // Khởi tạo tiểu trình Produce.
    pthread_create(
        &tproducer,
        NULL,
        &producer,
        NULL
    );

    // Khởi tạo tiểu trình Consume.
    pthread_create(
        &tconsumer,
        NULL,
        &consumer,
        NULL
    );

    // Giữ cho tiểu trình main tồn tại để quan sát idthreadA và idthreadB
    sleep(5); // Chạy trong 1 giây để quan sát kết quả

    // main thức dậy và tắt cờ running
    keep_running = 0;

    // Hợp các tiểu trình con để chúng "hấp thụ" giá trị của cờ vừa thay đổi
    pthread_join(tproducer, NULL);
    pthread_join(tconsumer, NULL);

    pthread_mutex_destroy(&mutex);
    sem_destroy(&full);
    sem_destroy(&empty);

    return 0;
}
