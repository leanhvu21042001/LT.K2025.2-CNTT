1. Tự động hóa có thể dùng AI:

- Áp dụng AI Agent vào các quy trình bảo mật và quản lý hệ thống (Monitoring, Alert), cấu hình các thiết bị mạng giúp phản ứng nhanh với các tai nạn tấn công từ bên ngoài. AI Agent sẽ lấy yêu cầu từ end user để thực hiện các câu hỏi về các quy trình như cấp phát, thu hồi thiết bị hoặc các yêu cầu liên quan tới ServiceDesk. Từ đó giảm thiểu gánh nặng cho các IT Support và System.
- Áp dụng vào quy trình tuyển dụng nhân sự. Marchine Learning sẽ lấy data từ các nhân sự và các nền tảng tuyển dụng hoặc các data liên quan tới nhân sự, từ đó có thể nghiên cứu và thực hiện các phép toán để phân tích ra là nhân sự nên tìm ứng viên trên nền tảng nào, hoặc các thông tin liên quan nào từ ứng viên sẽ phù hợp với công ty.
- Áp dụng vào quy trình phát triển phần mềm và quy trình quản lý dự án, AI Agent có thể phân tích các PM/Leader dựa vào chi tiết mà dự án đó sẽ làm gì, sau đó đưa ra 1 chặng đường phù hợp cho cả team/dự án. AI Agent củng có thể theo dõi và nhắc nhở các thành viên về lịch trình và công việc phải hoàn thành.

2. Nâng cao chất lượng nhân sự.

- Trong 3 trụ cột: People, Process, Technology, thì Nhân sự, ở đâu, và thời điểm nào cũng quan trọng nhất. Nhân sự là tài sản duy nhất có khả năng học hỏi và sáng tạo, tạo ra sự khác biệt mà đối thủ khó sao chép, sản phẩm mang tính trọn đời thì khách hàng có khả năng quay lại (khả năng hoàn vốn nhanh) điều này dẫn đến hiệu suất bền vững, việc nâng cao kỹ năng thì thúc đẩy trực tiếp vào doanh thu.
- Thêm nữa, việc đầu tư vào nhân viên, sẽ tạo động lực cho chính nhân viên, thúc đẩy sự làm việc có trách nhiệm, sáng tạo cao, từ đó tiếp tục thúc đẩy trực tiếp công ty phát triển lâu dài, điều này tạo ra sự khác biệt với bất kì nâng cấp phần cứng nào.
- Các phương án nâng cao chất lượng: các khóa học, các seminar chia sẻ; các bài lab; hoàn thành và đạt các chứng chỉ trong nghành, vv.. đều cần chi phí (và thời gian) nhất định.

3. Trên hình là các thành phần theo dạng block, chưa có biểu diễn theo logic phân cấp. Vì vậy, để biểu diễn lại theo dạng phân cấp, ta có thể viết lại như sau theo đường đi của network traffic từ public internet đến client: RT -> FW -> SW -> AP -> End Devices. Trong đó, RT là Router, FW là Firewall, SW là Switch, AP là Access Point, End Devices là thiết bị kết nối cuối cùng.

- Nếu coi router được cung cấp từ nhà mạng: nó sẽ làm chức năng nhận tín hiệu và đường truyền từ nhà mạng (ISP), sau đó dây tín hiệu này (dây quang, cat) sẽ đi vào firewall các port tương ứng. Từ đó firewall sẽ có mạng (Gateway) và phân các lưu lượng mạng tới Switch Core, sau đó là Switch Access và đi vào các thiết bị cần sử dụng mạng dây. Song song với đó, Switch Core sẽ phân các lưu lượng mạng này tới các Access Point (trunk) ở các vị trí tương ứng đối với các thiết bị không dây.
=> Như vậy: phân cấp đúng phải là Router > Firewall > Switch > Access Point.

- Nếu coi router được cung cấp từ nhà mạng: nó sẽ làm chức năng nhận tín hiệu và đường truyền từ nhà mạng (ISP), sau đó dây tín hiệu này (dây quang, cat) sẽ đi vào firewall các port tương ứng. Từ đó firewall sẽ có mạng (Gateway) và phân các lưu lượng mạng tới Switch Core, sau đó là Switch Access và đi vào các thiết bị cần sử dụng mạng dây. Song song với đó, Switch Core sẽ phân các lưu lượng mạng này tới các Access Point (trunk) ở các vị trí tương ứng đối với các thiết bị không dây.
=> Như vậy: phân cấp đúng phải là Router > Firewall > Switch > Access Point.

Ngoại lệ, hoặc cục bộ cho Server Farm, mô hình có thể là: Internet -> Border Router (VXLAN/BGP/VPN) -> Firewall (Lọc tinh/Bảo mật) -> Core L3 Switch/Internal Router (Phân phối) -> L2 Switch (Kết nối thiết bị) -> Servers.
