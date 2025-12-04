#import "libs/report.typ": *

// YOUR CONTENT

= Bài 4. Trigger & Views trong DBMS.
<bai-4>

== #lorem(5)

#lorem(30)

#lorem(20)

#figure(
```sql
-- Tạo mới VIEW (hoặc thay thế)
CREATE OR REPLACE VIEW account_activity_view AS
SELECT
    ba.account_number,
    ba.account_holder,
    ba.balance,
    ul.action AS latest_action,
    ul.timestamp AS latest_action_time
FROM
    BankAccounts ba
-- Join nhiều bảng
LEFT JOIN
    (
        -- Một truy vấn cụ thể
        SELECT DISTINCT ON (account_number)
            account_number,
            action,
            timestamp
        FROM
            UserLogs
        ORDER BY
            account_number,
            timestamp DESC
    ) ul ON ba.account_number = ul.account_number;
```,
caption: "Bài 4. Khai báo/Khởi tạo VIEW"
)

#figure(
```sql
-- Truy vấn từ VIEW như một bảng bình thường
SELECT * FROM account_activity_view;
```,
caption: "Bài 4. Truy vấn VIEW"
)

== #lorem(5)

#lorem(30)

#lorem(20)
