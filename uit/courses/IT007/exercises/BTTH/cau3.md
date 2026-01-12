# **Câu 3** | Tự đánh giá: .../4 điểm

*(sinh viên điền điểm tự đánh dựa trên quy tắc chấm điểm được cung cấp)

## **Nội dung*

Cho một mảng `a` được khai báo toàn cục là một mảng số nguyên có thể chứa `n` phần tử. Viết chương trình bao gồm 2 thread chạy song song:
*   Một thread làm nhiệm vụ sinh ra một số nguyên ngẫu nhiên sau đó bỏ vào a. Sau đó đếm và xuất ra số phần tử của a có được ngay sau khi thêm vào.
*   Thread còn lại lấy ra một phần tử trong a (phần tử bất kỳ, phụ thuộc vào người lập trình). Sau đó đếm và xuất ra số phần tử của a có được ngay sau khi lấy ra, nếu không có phần tử nào trong a thì xuất ra màn hình “Khong con phan tu trong mang”.
Hiện thực mô hình trên với 2 trường hợp:
*   Trường hợp 1: Không đồng bộ, tìm và giải thích vấn đề xảy ra khi đồng bộ.
*   Trường hợp 2: Đồng bộ hóa và chứng minh các vấn đề trong trường hợp 1 đã được giải quyết.

**INPUT:**
*   Số phần tử tối đa trong mảng: `n`

**OUTPUT:**
*   Trường hợp 1: Đếm số lượng phần tử trong mảng và danh sách các phần tử khi không đồng bộ.
*   Trường hợp 2: Đếm số lượng phần tử trong mảng và danh sách các phần tử khi có đồng bộ.

**CÁCH TÍNH ĐIỂM:**
*   Source code và kết quả thực thi trường hợp 1: **1 điểm**
*   Nhận xét về kết quả thực thi và giải thích vấn đề xảy ra khi không đồng bộ: **1 điểm**
*   Source code và kết quả thực thi trường hợp 2: **1 điểm**
*   Báo cáo giải thích về cách đồng bộ: **0.5 điểm**
*   Nhận xét về kết quả thực thi, chứng minh cách làm là đúng: **0.5 điểm**

**Mẫu thực thi:**

Trường hợp 1: Không đồng bộ

```
!./baitap3unsync
# Không có kết quả mẫu, sinh viên tự thực hiện và giải thích vấn đề xảy ra.
```

Trường hợp 2: Đồng bộ

```
!./baitap3sync

```

**Mẫu kết quả trả về:**

```
Moi nhap so luong phan tu toi da: 5
ADDING   | Count = 1 | 4
ADDING   | Count = 2 | 4 2
ADDING   | Count = 3 | 4 2 7
ADDING   | Count = 4 | 4 2 7 9
ADDING   | Count = 5 | 4 2 7 9 1
REMOVING | Count = 4 | 2 7 9 1
REMOVING | Count = 3 | 7 9 1
REMOVING | Count = 2 | 9 1
REMOVING | Count = 1 | 1
REMOVING | Count = 0 | Khong con phan tu trong mang
ADDING   | Count = 1 | 9
ADDING   | Count = 2 | 9 2
ADDING   | Count = 3 | 9 2 5
REMOVING | Count = 2 | 2 5
REMOVING | Count = 1 | 2
ADDING   | Count = 2 | 2 7
...

```
