## A. TỔ CHỨC DỮ LIỆU

### Kiểu dữ liệu (data type) và cách sử dụng

Các kiểu dữ liệu (data type) dùng cho các trường (field) và cách sử dụng chúng.

- **Kiểu số (Exact Numerics)**:
  - `INT`: Lưu số nguyên (4 bytes). Dùng cho ID, số lượng.
  - `BIGINT`: Số nguyên lớn (8 bytes). Dùng khi dữ liệu vượt quá 2 tỷ.
  - `BIT`: Giá trị `0` hoặc `1` (tương tự Boolean). Dùng cho trạng thái (Đúng/Sai).
  - `DECIMAL(p,s) `/ `NUMERIC`: Số thực chính xác. Dùng cho tiền tệ, tính toán khoa học.

- **Kiểu chuỗi ký tự (Character Strings)**:
  - `VARCHAR(n)`: Chuỗi ký tự độ dài thay đổi (không dấu). Dùng cho tên tiếng Anh, mã số.
  - `NVARCHAR(n)`: Chuỗi ký tự Unicode (có dấu tiếng Việt). Lưu ý: Tốn gấp đôi dung lượng so với `VARCHAR`.
  - `CHAR(n)`: Chuỗi ký tự độ dài cố định. Dùng cho các mã có độ dài cố định (VD: Mã bưu điện).

- **Kiểu ngày giờ (Date and Time)**:
  - `DATETIME`: Ngày và giờ chính xác đến mili-giây.
  - `DATE`: Chỉ lưu ngày (`YYYY-MM-DD`).

### Dung lượng (KB) tối đa của 1 row

Dung lượng (KB) tối đa của 1 row trong 1 table mà SQL Server cho phép.

- Dung lượng tối đa của một dòng (row) trong SQL Server được giới hạn bởi kích thước của một trang dữ liệu (Page).
- Giới hạn này là **8.060 bytes** (xấp xỉ 8KB).

### Dung lượng (KB) tối đa của 1 table

Dung lượng (KB) tối đa của 1 table mà SQL Server cho phép.

- Về lý thuyết, kích thước bảng chỉ bị giới hạn bởi dung lượng lưu trữ của hệ điều hành (File System) và phiên bản SQL Server.
- Dung lượng tối đa của Database là **524,272 Terabytes**.
  - Do đó, 1 table có thể chứa lượng dữ liệu khổng lồ gần như không giới hạn trong thực tế, miễn là lưu trữ còn chỗ trống và xử lý được vấn đề hiệu năng.

### Ý nghĩa các table hệ thống (System tables)

Tìm hiểu ý nghĩa các table hệ thống (System tables) trong CSDL Master như: `sysusers`; `syssservers`; `sysxlogin`.

- `sysusers`:
  - Chứa thông tin về mỗi người dùng (user) hoặc nhóm (role) được phép truy cập trong cơ sở dữ liệu.
  - Đổi thành [sys.database_principals (Transact-SQL)](https://learn.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-database-principals-transact-sql?view=sql-server-ver17) ở các phiên bản SQL Server hiện đại.
- `sysservers`:
  - Chứa thông tin về các server liên kết (Linked Servers) hoặc remote servers mà SQL Server này có thể giao tiếp.
  - Đổi thành [sys.servers (Transact-SQL)](https://learn.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-servers-transact-sql?view=sql-server-ver17) ở các phiên bản SQL Server hiện đại.
- `sysxlogins`:
  - Chứa thông tin về tài khoản đăng nhập (Login account) và mật khẩu (đã mã hóa) cấp server.
  - Hoặc `syslogins`
  - Hiện nay là [sys.server_principals](https://learn.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-server-principals-transact-sql?view=sql-server-ver17) hoặc [sys.sql_logins](https://learn.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-sql-logins-transact-sql?view=sql-server-ver17).

Tham khảo: [Mapping System Tables to System Views (Transact-SQL)](https://learn.microsoft.com/en-us/sql/relational-databases/system-tables/mapping-system-tables-to-system-views-transact-sql?view=sql-server-ver17)

### Các file của một Cơ Sở Dữ Liệu (DB)

Khi người dùng tạo 1 CSDL, SQL Server yêu cầu tạo ra tối thiểu bao nhiêu file? Ý nghĩa mỗi file? Chú ý câu lệnh:

```sql
CREATE DATABASE AAA;
```

Khi tạo một CSDL (lệnh CREATE DATABASE AAA), SQL Server yêu cầu tạo ra tối thiểu 2 file:

1. **File dữ liệu chính (Primary Data File - đuôi `.mdf`):**
   - Ý nghĩa: Chứa thông tin khởi tạo database và lưu trữ dữ liệu chính của các bảng, view, index...
   - Mỗi database bắt buộc phải có 1 file này.

2. **File nhật ký giao dịch (Transaction Log File - đuôi ``.ldf`):**
   - Ý nghĩa: Ghi lại tất cả các giao dịch (`insert`, `update`, `delete`) và các sửa đổi CSDL.
   - Dùng để khôi phục dữ liệu (restore) khi có sự cố, đảm bảo tính toàn vẹn (*ACID*).

Ngoài ra có thể có Secondary Data Files (`.ndf`) nếu cần chia nhỏ ra (optional).

### Số user có thể connect cùng 1 thời điểm là bao nhiêu?

Số lượng kết nối tối đa (user connections) mà SQL Server hỗ trợ là **32.767** kết nối ([Server configuration: user connections](https://learn.microsoft.com/en-us/sql/database-engine/configure-windows/configure-the-user-connections-server-configuration-option?view=sql-server-ver17)).

- "SQL Server allows a maximum of 32,767 user connections."
