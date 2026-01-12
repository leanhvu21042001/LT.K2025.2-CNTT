#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

// Khai báo mảng a
int *a;
// Biến n
int n;
// Biến count để dại diện độ lớn của mảng tại một thời điểm nhất định
int count = 0;

// Hàm in ra mảng a
void print_array() {
    printf(" | ");
    for (int i = 0; i < count; i++) {
        printf(" %d", a[i]);
    }
    printf("\n");
}

// Công việc của adder, người thêm vào
void* adder(void* arg) {
    while (1) {
        if (count < n) {
            a[count] = rand() % 10;
            count++;
            printf("ADDING   | Count = %d", count);
            print_array();
        }
    }
    return NULL;
}

// Công việc của remover, người lấy ra
void* remover(void* arg) {
    while (1) {
        if (count > 0) {
            count--;
            printf("REMOVING | Count = %d", count);
            print_array();
            if (count == 0) {
                printf(" | Khong con phan tu trong mang\n");
            } else {
                print_array();
            }
        } else {
            printf("REMOVING | Count = %d | Khong con phan tu trong mang\n", count);
        }
    }
    return NULL;
}

int main() {
    // Khai báo các tiểu trình.
    pthread_t adder_id, remover_id;

    // Yêu cầu người dùng nhập giá trị của n.
    printf("Moi nhap so luong phan tu toi da: ");
    scanf("%d", &n);

    // Khởi tạo mảng a, và lấp đầy bằng 0
    a = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        a[i] = 0;
        count++;
    }

    // Tạo các tiểu trình.
    pthread_create(&adder_id, NULL, adder, NULL);
    pthread_create(&remover_id, NULL, remover, NULL);

    // Join các tiểu trình để đợi chúng kết thúc.
    pthread_join(adder_id, NULL);
    pthread_join(remover_id, NULL);

    // Giải phóng bộ nhớ
    free(a);

    return 0;
}
