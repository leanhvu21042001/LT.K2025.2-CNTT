#import "../../../../../tools/typst/libs/academic-alt.typ": *

// YOUR CONTENT

= Bài 4. Trigger & Views trong DBMS.
<bai-4>

- Vai trò của Trigger, View?
- Phân loại Trigger?
- Tất cả hệ quản trị CSDL quan hệ có hỗ trợ Trigger không?

== Giới Thiệu

Trong kiến trúc CSDL hiện đại, việc lưu trữ dữ liệu (trong các bảng - Table) chỉ là phần nổi của tảng băng chìm. Để đảm bảo tính bảo mật, hiệu năng và toàn vẹn dữ liệu, View và Trigger đóng vai trò như những công cụ kiểm soát và điều hướng logic nghiệp vụ ngay tại tầng dữ liệu (Data
Tier).

== View (Khung nhìn)

View thực chất là một "bảng ảo" (virtual table). Nó không lưu trữ dữ liệu vật lý (trừ Materialized View) mà chỉ lưu trữ câu lệnh truy vấn định nghĩa nên nó.

- #strong[Tính trừu tượng hóa và đơn giản hóa (Abstraction & Simplification):]
  - View giúp che giấu sự phức tạp của cấu trúc bảng bên dưới.
  - Thay vì yêu cầu lập trình viên viết những câu lệnh `JOIN` phức tạp giữa 5-6 bảng mỗi lần truy xuất, ta có thể gói gọn logic đó vào một View.
  - Ví dụ: `CREATE VIEW v_BaoCaoDoanhThu AS...` giúp tầng ứng dụng chỉ cần `SELECT * FROM v_BaoCaoDoanhThu` mà không cần quan tâm đến các bảng hóa đơn chi tiết bên dưới.
- #strong[Cơ chế bảo mật (Security Layer):]
  - Đây là vai trò quan trọng nhất.
  - View cho phép quản trị viên (DBA) giới hạn quyền truy cập. Bạn có thể cho phép người dùng xem dữ liệu qua View nhưng không cấp quyền truy cập trực tiếp vào bảng gốc (Base Table).
  - Điều này giúp ẩn đi các cột nhạy cảm (như lương, mật khẩu, thông tin cá nhân).
- #strong[Tính độc lập logic (Logical Data Independence):]
  - Khi cấu trúc bảng vật lý thay đổi (ví dụ: tách bảng), ta chỉ cần sửa lại định nghĩa View.
  - Các ứng dụng đang gọi View đó sẽ không bị ảnh hưởng (không bị gãy code).

Ví dụ:

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

== Trigger

Trigger là một thủ tục lưu trữ đặc biệt (special stored procedure) được hệ thống tự động thực thi khi có một sự kiện thay đổi dữ liệu (`INSERT`, `UPDATE`, `DELETE`) xảy ra.

- #strong[Đảm bảo toàn vẹn dữ liệu (Data Integrity):]
  - Trong khi `CONSTRAINT` (ràng buộc) chỉ kiểm tra được các quy tắc tĩnh (ví dụ: số dương, không trùng lặp), Trigger có thể thực thi các quy tắc nghiệp vụ phức tạp liên quan đến nhiều bảng.
  - Ví dụ: Khi bán một sản phẩm, Trigger tự động kiểm tra kho hàng (bảng Inventory). Nếu số lượng `< 0`, nó sẽ chặn giao dịch (#emph[Rollback];).
- #strong[Tự động hóa và Đồng bộ hóa (Automation):]
  - Trigger giúp tự động tính toán hoặc cập nhật dữ liệu liên quan.
  - Ví dụ: Khi thêm chi tiết hóa đơn, Trigger tự động cộng dồn vào tổng tiền của hóa đơn chính.
- #strong[Kiểm toán và Giám sát (Auditing & Logging):]
  - Trigger là công cụ đắc lực để theo dõi "ai làm gì, khi nào".
  - Khi dữ liệu bị thay đổi, Trigger có thể âm thầm ghi lại giá trị cũ và mới vào một bảng lịch sử (History Log) để phục vụ tra soát sau này.

== Phân loại Trigger

Trong chuẩn SQL và các hệ quản trị lớn (Oracle, SQL Server, PostgreSQL), Trigger được phân loại dựa trên thời điểm kích hoạt và cấp độ tác động.

=== Theo thời điểm (Timing)

+ #strong[`BEFORE` Trigger:]
  - Cơ chế: Chạy #emph[trước] khi dữ liệu thực sự được ghi vào bảng.
  - Mục đích: Dùng để xác thực dữ liệu (Validation) hoặc chuẩn hóa dữ liệu đầu vào.
  - Đây là chốt chặn đầu tiên, nếu logic trong Before Trigger thất bại, lệnh SQL sẽ bị hủy bỏ ngay lập tức.
+ #strong[`AFTER` Trigger:]
  - Cơ chế: Chạy #emph[sau] khi dữ liệu đã được ghi vào bảng thành công (nhưng vẫn nằm trong transaction).
  - Mục đích: Dùng để cập nhật các bảng khác (Cascading updates), gửi thông báo, hoặc ghi log kiểm toán.
+ #strong[`INSTEAD OF` Trigger:]
  - Cơ chế: Thay thế hoàn toàn câu lệnh SQL gốc bằng logic được định nghĩa trong Trigger.
  - Mục đích: Thường dùng cho View. Vì View là bảng ảo nên ta không thể INSERT trực tiếp vào View phức tạp. `INSTEAD OF` Trigger sẽ đón nhận dữ liệu đó và phân phối chúng vào các bảng gốc tương ứng một cách chính xác.

Ví dụ: `AFTER` Trigger

Miêu tả: Cho mỗi câu lệnh `INSERT` vào bảng `BankAccounts`, tạo một bản
ghi tương ứng trong `UserLogs` ghi lại các thay đổi bao gồm:

- Ai thực hiện?
- Thực hiện gì?

DBMS: PostgreSQL:

#figure(
```sql
-- Tạo một trigger
CREATE FUNCTION after_insert_trigger_function()
RETURNS TRIGGER AS $$
BEGIN
    -- Thực hiện thao tác, thêm bản ghi mới
    INSERT INTO UserLogs (account_number, action)
    VALUES (NEW.account_number, CONCAT('New record inserted for ', NEW.account_holder));
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Gán trigger vào một bảng cụ thể
CREATE TRIGGER after_insert_trigger
AFTER INSERT ON BankAccounts
FOR EACH ROW
EXECUTE PROCEDURE after_insert_trigger_function();
```,
caption: "Bài 4. AFTER Trigger"
)

=== Theo cấp độ (Scope)

+ #strong[Row-Level Trigger] (Kích hoạt theo dòng):
  - Thực thi một lần cho #emph[mỗi dòng] dữ liệu bị ảnh hưởng.
  - Ví dụ: Nếu bạn UPDATE 1000 dòng lương nhân viên, Trigger này sẽ chạy 1000 lần. Nó cho phép truy cập vào giá trị cũ (OLD) và giá trị mới (NEW) của từng dòng.
+ #strong[Statement-Level Trigger] (Kích hoạt theo câu lệnh):
  - Thực thi đúng một lần cho #emph[mỗi câu lệnh] SQL, bất kể câu lệnh đó ảnh hưởng đến bao nhiêu dòng (thậm chí là 0 dòng).
  - Mục đích: Thường dùng cho các tác vụ quản trị hoặc kiểm tra tổng quát.

#strong[Lưu ý chuyên sâu:] Ngoài ra, một số hệ quản trị như Oracle còn hỗ trợ DDL Triggers (bắt sự kiện `CREATE`, `DROP`, `ALTER` bảng) hoặc System Triggers (bắt sự kiện đăng nhập/đăng xuất database), mở rộng khả năng quản trị hệ thống.

== Trigger và các DBMS

- Câu trả lời là: #strong[KHÔNG.]

Mặc dù Trigger là một phần của chuẩn SQL (#link("https://en.wikipedia.org/wiki/SQL:1999")[SQL:1999]), nhưng mức độ hỗ trợ và việc có hỗ trợ hay không phụ thuộc hoàn toàn vào nhà phát triển của RDBMS đó và mục đích sử dụng của hệ quản trị.

Phân tích chi tiết sự khác biệt:

+ #strong[Nhóm Enterprise RDBMS] (Oracle, SQL Server, PostgreSQL, MySQL,
  DB2):
  - Hỗ trợ: Có, hỗ trợ đầy đủ và mạnh mẽ.
  - Đây là các hệ thống được thiết kế cho các ứng dụng phức tạp, yêu cầu tính toàn vẹn dữ liệu cao. Trigger là thành phần bắt buộc trong các hệ thống này.
+ #strong[Nhóm Lightweight/Embedded RDBMS] (SQLite):
  - Hỗ trợ: Có, nhưng hạn chế.
  - SQLite hỗ trợ Trigger, nhưng cú pháp và chức năng giới hạn hơn nhiều so với các "đàn anh". Ví dụ, SQLite Trigger chỉ có thể thực thi các câu lệnh SQL đơn giản, không thể gọi các thủ tục lưu trữ (Stored Procedures) phức tạp hay thực hiện các logic điều khiển dòng (IF/ELSE, LOOPS) mạnh mẽ như PL/SQL của Oracle hay T-SQL của Microsoft.
  - Lý do: Giữ cho bộ máy database nhỏ gọn, nhanh và nhẹ.
+ #strong[Nhóm Desktop/Legacy Databases] (Microsoft Access, FoxPro cũ):
  - Hỗ trợ: Không hoặc rất khác biệt.
  - Microsoft Access (các phiên bản cũ) không hỗ trợ Trigger theo chuẩn SQL. Đến các phiên bản mới hơn (từ Access 2010), nó giới thiệu khái niệm "Data Macros" có chức năng tương tự Trigger, nhưng không phải là SQL Trigger chuẩn mực.
  - Các hệ thống cũ như dBase, FoxPro thời đầu hoàn toàn không có khái niệm Trigger tại tầng CSDL; việc kiểm tra logic hoàn toàn phụ thuộc vào code của ứng dụng (Application Level).
+ #strong[Các hệ thống NewSQL/NoSQL] (Mở rộng):
  - Dù câu hỏi tập trung vào RDBMS, nhưng cần lưu ý rằng nhiều hệ thống dữ liệu phân tán hiện đại (như Google Cloud Spanner hay CockroachDB \- vốn tương thích SQL) có hỗ trợ Trigger nhưng đi kèm khuyến cáo hạn chế sử dụng do ảnh hưởng nghiêm trọng đến hiệu năng trong môi trường phân tán (Distributed Systems).

Kết luận:

- Không phải mọi RDBMS đều hỗ trợ Trigger.
- Sự hỗ trợ này tỷ lệ thuận với quy mô và mục đích của hệ quản trị: Hệ thống càng lớn, càng hướng tới doanh nghiệp (Enterprise) thì hỗ trợ Trigger càng mạnh.
- Các hệ thống nhúng hoặc hướng người dùng cá nhân thường cắt giảm hoặc thay thế tính năng này để tối ưu tài nguyên.

