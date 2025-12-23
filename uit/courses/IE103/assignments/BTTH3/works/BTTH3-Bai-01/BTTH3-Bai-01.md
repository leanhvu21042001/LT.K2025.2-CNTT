**A. TỔ CHỨC DỮ LIỆU**

**1. Các kiểu dữ liệu (data type) dùng cho các trường (field) và cách sử dụng nó.**

SQL Server chia các kiểu dữ liệu thành các nhóm chính:

- **Kiểu số (Exact Numerics):**
- INT: Lưu số nguyên (4 bytes). Dùng cho ID, số lượng.
- BIGINT: Số nguyên lớn (8 bytes). Dùng khi dữ liệu vượt quá 2 tỷ.
- BIT: Giá trị 0 hoặc 1 (tương tự Boolean). Dùng cho trạng thái (Đúng/Sai).
- DECIMAL(p,s) / NUMERIC: Số thực chính xác. Dùng cho tiền tệ, tính toán khoa học.

- **Kiểu chuỗi ký tự (Character Strings):**
- VARCHAR(n): Chuỗi ký tự độ dài thay đổi (không dấu). Dùng cho tên tiếng Anh, mã số.
- NVARCHAR(n): Chuỗi ký tự Unicode (có dấu tiếng Việt). **Lưu ý:** Tốn gấp đôi dung lượng so với Varchar.
- CHAR(n): Chuỗi ký tự độ dài cố định. Dùng cho các mã có độ dài cố định (VD: Mã bưu điện).

- **Kiểu ngày giờ (Date and Time):**
- DATETIME: Ngày và giờ chính xác đến mili-giây.
- DATE: Chỉ lưu ngày (YYYY-MM-DD).

**2. Dung lượng (KB) tối đa của 1 row trong 1 table mà SQL Server.

- Dung lượng tối đa của một dòng (row) trong SQL Server được giới hạn bởi kích thước của một trang dữ liệu (Page).
- Giới hạn này là **8.060 bytes** (xấp xỉ 8KB).

**3. Dung lượng (KB) tối đa của 1 table mà SQL Server cho phép.
l

- Về lý thuyết, kích thước bảng chỉ bị giới hạn bởi dung lượng lưu trữ của hệ điều hành và phiên bản SQL Server.
- Dung lượng tối đa của Database là **524,272 Terabytes**. Do đó, 1 table có thể chứa lượng dữ liệu khổng lồ gần như không giới hạn trong thực tế, miễn là ổ cứng còn chỗ trống.

**4. Tìm hiểu ý nghĩa các table hệ thống (System tables) trong CSDL Master như: Sysusers; Syssserver; Sysxlogin.

- **Sysusers:** Chứa thông tin về mỗi người dùng (user) hoặc nhóm (role) được phép truy cập trong cơ sở dữ liệu.
- **Sysservers:** Chứa thông tin về các server liên kết (Linked Servers) hoặc remote servers mà SQL Server này có thể giao tiếp.
- **Sysxlogins:** Chứa thông tin về tài khoản đăng nhập (Login account) và mật khẩu (đã mã hóa) cấp server. Hiện nay thường dùng sys.server_principals hoặc sys.sql_logins.

**5. Khi người dùng tạo 1 CSDL, SQL Server yêu cầu tạo ra tối thiểu bao nhiêu file? Ý nghĩa mỗi file? Chú ý câu lệnh: CREATE DATABASE AAA.

Khi tạo một CSDL (lệnh CREATE DATABASE AAA), SQL Server yêu cầu tạo ra tối thiểu 2 file:
![](assets/Pasted%20image%2020251222210109.png)
1. **File dữ liệu chính (Primary Data File - đuôi** **.mdf****):

- _Ý nghĩa:_ Chứa thông tin khởi tạo database và lưu trữ dữ liệu chính của các bảng, view, index...
- Mỗi database bắt buộc phải có 1 file này.

2. **File nhật ký giao dịch (Transaction Log File - đuôi** **.ldf****):

- _Ý nghĩa:_ Ghi lại tất cả các giao dịch (insert, update, delete) và các sửa đổi CSDL. Dùng để khôi phục dữ liệu (restore) khi có sự cố, đảm bảo tính toàn vẹn (ACID).

Ngoài ra có thể có Secondary Data Files (.ndf) nếu cần chia nhỏ ra (optional).

**6. Số user có thể connect cùng 1 thời điểm là bao nhiêu?

Số lượng kết nối tối đa (user connections) mà SQL Server hỗ trợ là **32.767** kết nối

**B. AN TOÀN DỮ LIỆU**

**7. Hãy backup CSDL AAA thành 1 file AAA.BAK, sau đó xóa CSDL AAA và hãy khôi phục AAA nhờ vào AAA.BAK. 
Thực hiện bằng 2 cách: 
- Cách 1: Dùng giao diện. Yêu cầu: Chụp màn hình các bước thực hiện (Chụp đúng phần cần thiết và rõ nét, có thể dùng công cụ Snipping Tool). 
- Cách 2: Dùng câu lệnh. Yêu cầu: Dùng các lệnh SQL để thực hiện.

**Cách 1: Dùng giao diện (SSMS)**

1. **Backup (Sao lưu):**
- Click chuột phải vào CSDL AAA -> **Tasks** -> **Back Up...**
![](assets/Pasted%20image%2020251222223425.png)
- Mục _Destination_: Chọn **Disk**, chọn đường dẫn lưu file AAA.BAK.
![](assets/Pasted%20image%2020251222223731.png)
- Nhấn **OK**. (Chụp màn hình thông báo "The backup of database 'AAA' completed successfully").
![](assets/Pasted%20image%2020251222223759.png)

2. **Delete (Xóa):**
- Click chuột phải vào CSDL AAA -> **Delete**.
- Check vào ô **Close existing connections** (để ngắt các kết nối đang chạy).
![](assets/Pasted%20image%2020251222223945.png)
- Nhấn **OK**. 

3. **Restore (Khôi phục):**
- Click chuột phải vào thư mục **Databases** -> **Restore Database...**
- Chọn **Database -> Nhấn nút ... -> Chọn file AAA.BAK vừa tạo.
 ![](assets/Pasted%20image%2020251222224154.png)
 - Nhấn **OK**.
![](assets/Pasted%20image%2020251222224330.png)
**Cách 2: Dùng câu lệnh 

Bạn mở cửa sổ _New Query_ và chạy lần lượt các đoạn lệnh sau (Chụp màn hình từng đoạn code và kết quả thông báo bên dưới):

- **Sao lưu (Backup):**

BACKUP DATABASE AAA
TO DISK = 'C:\Users\Admin\Desktop\Backup\AAA.BAK'
WITH FORMAT;
GO
![](assets/Pasted%20image%2020251222224625.png)
- **Xóa (Delete):**

ALTER DATABASE AAA SET SINGLE_USER WITH ROLLBACK IMMEDIATE; -- để đảm bảo không có ai đang dùng Database
DROP DATABASE AAA;

![](assets/Pasted%20image%2020251222225033.png)

- **Khôi phục (Restore):**

RESTORE DATABASE AAA
FROM DISK =  'C:\Users\Admin\Desktop\Backup\AAA.BAK;
GO
![](assets/Pasted%20image%2020251222230047.png)
**8. Hãy đọc SQL Server Log trong phần SQL Enterprice → Management → SQL Server Log. Trình bày màn hình các bước thực hiện và ý nghĩa của mỗi trường thông tin trong bảng Log.

- **Đường dẫn:** Trong SQL Server Management Studio (SSMS), mở rộng mục **Management** -> Mở rộng **SQL Server Logs**. Click đúp vào **Current** (hoặc Archive #1, #2).
![](assets/Pasted%20image%2020251222230755.png)
- **Ý nghĩa các trường thông tin trong Log:**
![](assets/Pasted%20image%2020251222231937.png)
- **Date:** Thời gian (ngày/giờ) sự kiện xảy ra.
- **Source:** Nguồn gốc của thông báo (thường là Server, Logon, hoặc spid - Session Process ID).
- **Message:** Nội dung chi tiết của thông báo ("Database backed up...", "Login failed for user...").

- _Mục đích:_ Giúp quản trị viên theo dõi sức khỏe hệ thống, phát hiện lỗi đăng nhập, kiểm tra các tác vụ backup thành công hay thất bại.

**9. Cho bảng Employees có cấu trúc như sau:
![](assets/Pasted%20image%2020251222232525.png)

Giả sử tạo 1 View tên là EmployeeNames như sau:
![](assets/Pasted%20image%2020251222232649.png)

**==>Câu lệnh INSERT này KHÔNG thực hiện được.**

**Giải thích:**

1. **Cấu trúc bảng (****Employees****):
- Cột BirthDate được định nghĩa là NOT NULL (Bắt buộc có dữ liệu).
- Cột HireDate được định nghĩa là NOT NULL (Bắt buộc có dữ liệu).
- Không có giá trị mặc định (DEFAULT) nào được khai báo cho 2 cột này.

1. **Cấu trúc View (****EmployeeNames****):
- Chỉ chứa 2 cột: FirstName và LastName.

1. **Hành động INSERT:**
- Câu lệnh: INSERT INTO EmployeeNames (FirstName, LastName) VALUES (...)
- Khi insert vào View, SQL Server thực chất sẽ cố gắng insert vào bảng gốc Employees.
- Câu lệnh trên cung cấp FirstName, LastName và EmployeeID (nếu ID tự tăng - Identity, nếu không tự tăng thì câu lệnh cũng thiếu cả ID).
- Tuy nhiên, nó **không cung cấp giá trị** cho BirthDate và HireDate.

**Kết luận:** Do bảng gốc yêu cầu BirthDate và HireDate không được để trống (NOT NULL), nhưng câu lệnh Insert thông qua View lại không cung cấp giá trị cho chúng, nên SQL Server sẽ báo lỗi vi phạm ràng buộc dữ liệu.

**10. Cho hình bên dưới.
![](assets/Pasted%20image%2020251222234203.png)

Hỏi hình trên đang mô tả mã hóa dữ liệu ở trạng thái nào? Vì sao? Biết dữ liệu có 3 trạng thái là: Data at rest (trạng thái nghỉ), Data in use (trạng thái đang sử dụng), Data in motion/transit (trạng thái lưu chuyển).

**Data in motion/transit (Trạng thái lưu chuyển):

Có thể thấy mũi tên từ bộ phận điều khiển ADO.NET (phía ứng dụng/Client) gửi đến Database có ghi chú "SQL Query with Cipher Parameters" (Truy vấn SQL với các tham số mật mã). Điều này có nghĩa là dữ liệu đã được mã hóa ngay tại phía máy khách (Client-side) trước khi nó được gửi đi qua mạng. Do đó, trên đường truyền, dữ liệu hoàn toàn ở dạng mã hóa, bảo vệ nó khỏi việc bị nghe lén.

**Data at rest (Trạng thái nghỉ):

 Ở phía bên phải (Database), hình ảnh biểu diễn dữ liệu được lưu trong ổ cứng (hình trụ) là "Encrypted Data" (Dữ liệu đã mã hóa). Ngay cả DBA (người quản trị cơ sở dữ liệu) khi truy xuất vào bảng cũng chỉ thấy chuỗi mã hóa vô nghĩa (ví dụ: 0x823ksk...). Điều này chứng tỏ dữ liệu nằm trên đĩa cứng của server luôn ở trạng thái được mã hóa.