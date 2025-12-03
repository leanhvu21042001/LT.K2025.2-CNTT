#import "../../../../../tools/typst/libs/academic-alt.typ": *

#show: university-assignment.with(
  title: "Bài Tập Thực Hành 1",
  subtitle: "IE103 - Quản Lý Thông Tin",
  author: "Nhóm 2",
  details: (
    course: "IE103",
    instructor: "Ths. Nguyễn Thành Luân",
    due-date: "Tháng 12, 2025",
    duration: "~3 hours",
    lab-number: "BTTH1",
  )
)

= Nhóm 2

#figure(
  align(center)[
  #table(
    columns: (10%, 20%, 70%),
    align: (right,left,left,),
    table.header([#strong[No];], [#strong[MSSV];], [#strong[Họ và Tên];],),
    table.hline(),
    [1], [25410291], [Đinh Xuân Sâm],
    [2], [25410319], [Đặng Hữu Toàn],
    [3], [25410321], [Nguyễn Điền Triết],
    [4], [25410204], [Trương Xuân Hậu],
    [5], [25410338], [Lê Anh Vũ],
    [6], [25410176], [Trần Sơn Bình],
    [7], [25410247], [Lê Kim Long],
    [8], [25410337], [La Anh Vũ],
    [9], [25410209], [Lê Ngọc Hiệp],
    [10], [25410271], [Nguyễn Thị Ngọc Nhung],
  )]
  , kind: table,
  caption: [Nhóm 2 (Omega)]
  )

#pagebreak()

= Bài 1. GMail & Mail Group

#include "quiz1.typ"

= Bài 2. Explorer/Finder

#include "quiz2.typ"


= Bài 3


= Bài 4

== Ví Dụ

=== `AFTER` Trigger Example

Miêu tả: Cho mỗi câu lệnh `INSERT` vào bảng `BankAccounts`, tạo một bản
ghi tương ứng trong `UserLogs` ghi lại các thay đổi bao gồm:

- Ai thực hiện?
- Thực hiện gì?

DBMS: PostgreSQL:

```sql
-- Create an after-insert trigger for UserLogs
CREATE FUNCTION after_insert_trigger_function()
RETURNS TRIGGER AS $$
BEGIN
    -- Perform some action, like logging the insert
    INSERT INTO UserLogs (account_number, action)
    VALUES (NEW.account_number, CONCAT('New record inserted for ', NEW.account_holder));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Attach the trigger to the BankAccounts table
CREATE TRIGGER after_insert_trigger
AFTER INSERT ON BankAccounts
FOR EACH ROW
EXECUTE PROCEDURE after_insert_trigger_function();
```
