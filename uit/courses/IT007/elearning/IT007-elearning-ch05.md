# Đồng Bộ Tiến Trình
## Race Condition

> Bài toán Producer vs. Consumer mô tả về 02 tiến trình bao gồm: “Sản xuất” và “Bán hàng”. Nếu gọi biến count mô tả số lượng hàng hóa, thì tiến trình “Sản xuất” sẽ làm tăng giá trị của count; ngược lại, tiến trình “Bán hàng” sẽ làm giảm giá trị này. Khi ”Sản xuất” và “Bán hang” diễn ra đồng thời, biến count sẽ chịu tác động của việc tăng và giảm cùng lúc. Khi đó, liệu rằng giá trị của count có còn đúng với logic?

