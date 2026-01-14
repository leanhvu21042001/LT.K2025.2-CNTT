#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

// Bước 1. Khai báo công việc của các tiểu trình.
// Công việc của T1.
void* t1(void* arg) {
    printf("T1\n");
    return NULL;
}

// Công việc của T2.
void* t2(void* arg) {
    printf("T2\n");
    return NULL;
}

// Công việc của T3.
void* t3(void* arg) {
    printf("T3\n");
    return NULL;
}

// Công việc của T4.
void* t4(void* arg) {
    printf("T4\n");
    return NULL;
}

int main() {
    // Khai báo các tiến trình.
    // Bước 2. trong Tạo tiểu trình.
    pthread_t t1_id, t2_id, t3_id, t4_id;

    // Tạo các tiểu trình.
    // Bước 3. trong Tạo tiểu trình.
    pthread_create(&t1_id, NULL, t1, NULL);
    pthread_create(&t2_id, NULL, t2, NULL);
    pthread_create(&t3_id, NULL, t3, NULL);
    pthread_create(&t4_id, NULL, t4, NULL);

    // Join các tiểu trình để đợi chúng kết thúc.
    // Đảm bảo rằng các dòng Tx luôn được in ra trước khi main kết thúc.
    pthread_join(t1_id, NULL);
    pthread_join(t2_id, NULL);
    pthread_join(t3_id, NULL);
    pthread_join(t4_id, NULL);

    // Nếu không, phải dùng vòng lặp sau để main chờ các tiểu trình con.
    //while(1) {}

    return 0;
}
