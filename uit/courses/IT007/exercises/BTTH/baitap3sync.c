#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

int *a;
int n;
int count = 0;
pthread_mutex_t mutex;

void print_array() {
    printf(" |");
    for (int i = 0; i < count; i++) {
        printf(" %d", a[i]);
    }
    printf("\n");
}

void* adder(void* arg) {
    while (1) {
        if (count < n) {
            // Khóa mutex, đảm bảo loại trừ tương hỗ.
            pthread_mutex_lock(&mutex);
            a[count] = rand() % 10;
            count++;
            printf("ADDING   | Count = %d", count);
            print_array();
            // Mở khóa mutex, nhường lượt cho tiểu trình khác
            pthread_mutex_unlock(&mutex);
        }
    }
    return NULL;
}

void* remover(void* arg) {
    while (1) {
        if (count > 0) {
            // Khóa mutex, đảm bảo loại trừ tương hỗ.
            pthread_mutex_lock(&mutex);
            count--;
            printf("REMOVING | Count = %d", count);
            if (count == 0) {
                printf(" | Khong con phan tu trong mang\n");
            } else {
                print_array();
            }
            // Mở khóa mutex, nhường lượt cho tiểu trình khác
            pthread_mutex_unlock(&mutex);
        } else {
            printf("REMOVING | Count = %d | Khong con phan tu trong mang\n", count);
        }
    }
    return NULL;
}

int main() {
    // Khai báo các tiểu trình.
    pthread_t adder_id, remover_id;

    // Khởi tạo biến mutex.
    pthread_mutex_init(&mutex, NULL);

    // Yêu cầu người dùng nhập giá trị của n.
    printf("Moi nhap so luong phan tu toi da: ");
    scanf("%d", &n);

    // Tạm thời lấp đầy mảng a với 0
    // Và nâng giá trị của count tới n
    a = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        a[i] = 0;
        count++;
    }

    // Tạo các tiểu trình tương ứng
    pthread_create(&adder_id, NULL, adder, NULL);
    pthread_create(&remover_id, NULL, remover, NULL);

    // Join các tiểu trình vào main để đảm bảo main không return trước
    pthread_join(adder_id, NULL);
    pthread_join(remover_id, NULL);

    // Giải phóng các biến đã dùng trước khi thoát.
    // Nhưng do thoát bằng Ctrl + C nên cũng không quan trọng lắm.
    pthread_mutex_destroy(&mutex);
    free(a);

    return 0;
}
