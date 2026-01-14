#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <semaphore.h>

// Khai báo các semaphore.
// Mục đích điều phối thứ tự.
sem_t s1, s2, s3, s4;

// T1
void* t1(void* arg) {
    printf("T1\n");
    // Báo cho T2 là T1 đã hoàn thành
    sem_post(&s1);
    // Báo cho T3 là T1 đã hoàn thành
    sem_post(&s2);
    return NULL;
}

// T2
void* t2(void* arg) {
    // Kiểm tra nếu T1 đã hoàn thành
    sem_wait(&s1);
    printf("T2\n");
    // Báo cho T4 là T2 đã hoàn thành
    sem_post(&s3);
    return NULL;
}

// T3
void* t3(void* arg) {
    // Kiểm tra nếu T1 đã hoàn thành
    sem_wait(&s2);
    printf("T3\n");
    // Báo cho T4 là T3 đã hoàn thành
    sem_post(&s4);
    return NULL;
}

// T4
void* t4(void* arg) {
    // Chờ T2
    sem_wait(&s3);
    // Chờ T3
    sem_wait(&s4);
    printf("T4\n");
    return NULL;
}

int main() {
    // Khai báo các tiểu trình.
    pthread_t t1_id, t2_id, t3_id, t4_id;

    // Init các semaphore đã khai báo.
    sem_init(&s1, 0, 0);
    sem_init(&s2, 0, 0);
    sem_init(&s3, 0, 0);
    sem_init(&s4, 0, 0);

    // Tạo các tiểu trình.
    pthread_create(&t1_id, NULL, t1, NULL);
    pthread_create(&t2_id, NULL, t2, NULL);
    pthread_create(&t3_id, NULL, t3, NULL);
    pthread_create(&t4_id, NULL, t4, NULL);

    // Join các tiểu trình để đợi chúng kết thúc.
    pthread_join(t1_id, NULL);
    pthread_join(t2_id, NULL);
    pthread_join(t3_id, NULL);
    pthread_join(t4_id, NULL);

    // Hủy các semaphore
    sem_destroy(&s1);
    sem_destroy(&s2);
    sem_destroy(&s3);
    sem_destroy(&s4);

    return 0;
}
