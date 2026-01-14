%%writefile baitap1.cpp

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <semaphore.h>

// 4 số cuối của Mã Số Sinh Viên: 0291
// Đây chính là lượng tồn kho tối đa theo yêu cầu.
#define MSSV 291

// Khai báo các semaphore tương ứng; bài toán bounded buffer
sem_t full, empty;

// Khai báo mutex để đảm bảo loại trừ tương hỗ
pthread_mutex_t mutex;

// Khai báo các biến products/sells
int products = 0;
int sells = 0;

// Công việc của Producer
// Đây là Bước 1. trong Tạo tiểu trình
// Con trỏ hàm mô tả công việc của tiểu trình producer
void* producer(void* arg) {
    while(1) {
        sem_wait(&empty);
        pthread_mutex_lock(&mutex);
        products++;
        printf("PRODUCE | Tong so hang duoc san xuat la: %d\n", products);
        pthread_mutex_unlock(&mutex);
        sem_post(&full);
    }
    return NULL;
}

// Công việc của Consumer
// Đây là Bước 1. trong Tạo tiểu trình
// Con trỏ hàm mô tả công việc của tiểu trình consumer
void* consumer(void* arg) {
    while(1) {
        sem_wait(&full);
        pthread_mutex_lock(&mutex);
        sells++;
        printf("CONSUME | Tong so hang duoc ban ra la: %d\n", sells);
        pthread_mutex_unlock(&mutex);
        sem_post(&empty);
    }
    return NULL;
}

int main()
{
    // Khởi tạo biến mutex
    pthread_mutex_init(&mutex, NULL);

    // Khai báo tiểu trình
    // Đây là Bước 2. trong Tạo tiểu trình
    pthread_t tproducer, tconsumer;

    // Khởi tạo semaphore full;
    // tham số thứ 2 = 0 => đây là semaphore cục bộ giữa các tiến trình
    // tham số thứ 3 = 0 => đây là giá trị khởi tạo ban đầu của full
    sem_init(&full, 0, 0);

    // Khởi tạo semaphore empty;
    // tham số thứ 2 = 0 => đây là semaphore cục bộ giữa các tiến trình
    // tham số thứ 3 = MSSV => đây là giá trị khởi tạo ban đầu của empty
    sem_init(&empty, 0, MSSV);

    // Khởi tạo tiểu trình Producer.
    // Đây là Bước 3. trong Tạo tiểu trình
    pthread_create(
        // tham số 1. tiểu trình đã khai báo
        &tproducer,
        NULL,
        // tham số 3. công việc của tiểu trình tương ứng
        &producer,
        NULL
    );

    // Khởi tạo tiểu trình Consumer.
    pthread_create(
        &tconsumer,
        NULL,
        &consumer,
        NULL
    );

    // Giữ cho main chạy để quan sát.
    while (1) {}

    return 0;
}
