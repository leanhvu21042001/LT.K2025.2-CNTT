# **CHƯƠNG II. THÀNH PHẦN CẤU TẠO CƠ SỞ HẠ TẦNG CÔNG NGHỆ THÔNG TIN**

## **Hạ Tầng Phần Cứng**

### **Sơ Đồ Tổng Quan**

(Sơ đồ tổng quan).

### **Thiết Bị Mạng**

TODO: Phân loại Data Center network vs Campus/Office network.

| Tên thiết bị | Mục đích |
| ----- | ----- |
| Media Converter | Chuyển đổi tín hiệu quang sang Ethernet trước khi kết nối vào Router. |
| Router | Thiết bị dùng để cung cấp Internet của nhà mạng, dùng để kết nối vào Firewall để các thiết bị có thể truy cập Internet. |
| Switch | Kết nối các thiết bị trong cùng một mạng nội bộ (LAN) với nhau. Chuyển tiếp dữ liệu một cách có chủ đích giữa các thiết bị với nhau. Là thiết bị đóng vài trò tạo nên xương sống của hệ thống mạng LAN. |
| Firewall | Bảo vệ mạng nội bộ khỏi các mối đe dọa từ bên ngoài Internet. Kiểm soát lưu lượng mạng vào/ra dựa trên các quy tắc ưu tiên (QoS \- Quality of Service). Ngăn chặn truy cập trái phép, phần mềm độc hại. |
| Access Point | Phát sóng Wi-Fi, cho phép các thiết bị không dây kết nối với nhau qua mạng nội bộ. Mở rộng vòng phủ sóng của mạng. |

3. ### **Hệ thống máy chủ (Server) và Lưu Trữ**

| Tên thiết bị | Mục đích |
| :---: | ----- |
| Server | Lưu trữ và cung cấp dữ liệu, truy cập cho các máy trạm trong mạng nội bộ. Trung tâm xử lý dữ liệu trong các hệ thống lớn. |
| Máy chủ ảo hóa (Hyper-V) | Dựa trên công nghệ ảo hóa của Microsoft. Triển khai công cụ ảo hóa các dịch vụ và máy chủ khác để tối ưu hóa chi phí và nguồn lực. |
| Máy chủ lưu trữ | Sử dụng Synology NAS nội bộ và Cloud Storage (Onedrive). Lưu trữ và truy cập các dữ liệu nhanh chóng và tiện lợi. |
| DNS Server | Sử dụng DNS Server nội bộ để truy cập các dịch vụ dễ dàng hơn. Ngoài ra còn sử dụng DNS Cloudflare. |
| Active Directory Server | Quản lý truy cập và phân quyền cho tất cả các thiết bị đầu cuối và người dùng trong hệ thống nội bộ. Là xương sống trong quản lý hệ thống để liên kết với các dịch vụ khác (Azure, Cloud). |

### **Thiết bị đầu cuối**

| Tên thiết bị | Mục đích |
| :---: | ----- |
| Laptop/PC | Thiết bị làm việc của người dùng đầu cuối. Kết nối với nhau qua mạng nội bộ. |
| Printer | In ấn, quét, sao chép tài liệu. |
| Mobile | Liên lạc (gọi điện, nhắn tin, email). |
| Camera | Giám nát an ninh. |
| VoiIP Phone | Gọi điện thoại thông qua kết nối Internet. |
| FingerPrint | Kiểm soát ra/vào của các người dùng. |

## **Hạ tầng phần mềm**

### **Phần mềm nền tảng**

#### **Windows:**

* Phiên bản:  
  * Server: 2022, 2025\.  
  * Desktop: 10, 11\.  
* Mục đích:  
  * Server: HyperV  
  * Desktop: Máy cá nhân.

#### **Linux:**

* Phân phối:  
  * Arch/Ubuntu/Gentoo.  
  * SUSE.  
* Phiên bản:  
  * 2.6.x  
  * 6.x.  
* Mục đích:  
  * SAP.

#### **K8s:**

* Phiên bản:  
  * 1.3.2

| Thành Phần | Mục đích |
| :---: | ----- |
| Windows | Hệ điều hành Windows, là nền tảng cơ bản để người dùng đầu cuối có thể chạy các ứng dịch và phục vụ cho nhu cầu công việc. |
| Linux | Hệ điều hành Linux, là hệ điều hành nhẹ, ít tốn tài nguyên phần cứng, phù hợp để triển khai các dịch vụ và máy chủ thực hiện các tác vụ liên tục. Chủ yếu dùng để ảo hóa các may chủ và dịch vụ trên máy chủ phần cứng. |
| Docker | Nền tảng ảo hóa container, hỗ trợ triển khai và quản lý các ứng dụng, dịch vụ mà không cần phải triển khai dựa trên một hệ điều hành. |

### **Phần mềm quản lý**

| Tên thiết bị             | Mục đích                                                                                                                                                              |
| :----------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Jira (Project Management | Phần mềm đa nền tảng hỗ trợ trong việc quản lý dự án của các nhóm. Theo dõi công việc và hợp tác trong môi trường phát triển phần mềm.                                |
| GLPI (ServiceDesk)       | Phần mềm đa nền tảng trong việc quản lý yêu cầu hỗ trợ, giải quyết vấn đề và nâng cao trải nghiệm của người dùng trong quá trình làm việc.                            |
| Snipe-IT (Asset)         | Phần mềm đa nền tảng trong việc quản lý toàn diện các tài sản vật lý và kỹ thuật số. Hỗ trợ việc báo cáo, thống kê các thiết bị từ khi mua sắm đến khi ngừng sử dụng. |
| Moodle (Elearning)       | Phần mềm đa nền tảng trong việc cung cấp kiến thức, đào tạo và phát triển kỹ năng cho cán bộ nhân viên về hệ thống thông tin.                                         |
| CCM                      | Quản lý toàn diện các thiết bị đầu cuối qua Active Directory service. Đảm bảo bảo mật và tuân thử trong môi trường doanh nghiệp.                                      |
| Microsoft Intune         | Quản lý các thiết bị di động (điện thoại, máy tính, …). Bảo vệ dữ liệu và đảm bảo tuân thủ trên các thiết bị.                                                         |
| Microsoft Defender       | Bảo vệ toàn diện và mạnh mẽ trước các mối đe dọa đến từ các nền tảng khác nhau trên hệ điều hành.                                                                     |
| Patch Manage Engine      | Quản lý, cập nhật phần mềm và và lối bảo mật để đảm bảo sự ổn định của hệ thống.                                                                                      |
| Admin by Request         | Quản lý, kiểm soát chặt chẽ quyền truy cập của người dùng vào các tài nguyên dữ liệu giúp tăng cường bảo mật và giảm thiểu rủi ro trong hệ thống.                     |

### **Phần mềm ứng dụng và dịch vụ**

| Tên thiết bị         | Mục đích                                                                                                                                                                          |
| :------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Voice Cloud          | Phần mềm kết nối với VoiceIP server để liên lạc qua các kênh truyền thông.                                                                                                        |
| Microsoft Office 365 | Bộ công cụ dùng để làm việc trong môi trường văn phòng kỹ thuật số. Có thể truy cập dữ liệu mọi nơi chỉ cần có mạng.                                                              |
| SAP                  | Hệ thống ERP, CRM quản lý tài nguyên cho doanh nghiệp, triển khai trên Cloud để đảm bảo truy cập.                                                                                 |
| Misa                 | Quản lý tài chính, kế toán và các nghiệp vụ khác cho doanh nghiệp tại Việt Nam, giúp tối ưu hóa hoạt động và các quy trình thanh toán. Triển khai trên Cloud để đảm bảo truy cập. |

## **Tài nguyên mạng**

| Tên thiết bị               | Mục đích                                                                                                                                                                                |
| :------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Hệ thống mạng nội bộ       | Hệ thống mạng dây và không dây, kết nối tất cả các thiết bị đầu cuối, tạo thành một mạng nội bộ thống nhất.                                                                             |
| Dịch vụ Internet           | Đường truyền Internet từ các nhà mạng, sử dụng để kết nối Internet cho các thiết bị trong doanh nghiệp.                                                                                 |
| Hệ thống tên miền          | Hệ thống tên miền của công ty.                                                                                                                                                          |
| Tài nguyên các lớp IP      | Phân chia các lớp mạng dựa trên nhu cầu và phong ban, đảm bảo lưu lượng mạng không bị quá tải. Giúp cho các thiết bị đầu cuối có thể nhận diện và kết nối lẫn nhau và kết nối Internet. |
| Phân quyền tài nguyên mạng | Hệ thống mạng và các lớp địa chỉ được phân quyền truy cập dựa trên nhu cầu để tối ưu hóa luồng dữ liệu.                                                                                 |

## **Quản trị và bảo mật**

Orient Software triển khai các giải pháp quản trị và bảo mật tiên tiến, rất phù hợp để học tập cho các nội dụng về an ninh thông tin:

* ISO/IEC 27001: Hệ thổng quản lý an toàn thông tin (ISMS).
* ISO 9001: Hệ thống Quản lý Chất lượng (QMS)

| Hệ thống | Mục đích |
| :---- | ----- |
| Quản trị hệ thống (System Admin) | Quản lý máy chủ, hạ tầng mạng, hệ thống công nghệ thông tin trong doanh nghiệp. Tối ưu hóa hạ tầng công nghệ thông tin, đảm bảo hoạt động trơn tru của mội dịch vụ và thiết bị. |
| Quản trị hệ thống nhân sự | Quản lý hệ thống nhân viên, phúc lợi, danh sách, … |
| Biện pháp bảo mật – Vật lý | Kiểm soát, quản lý truy cập vật lý, các khu vực hạn chế. Đảm bảo an toàn thông tin trên phạm vị các thiết bị vật lý và khu vực hạn chế. |
| Biện pháp bảo mật – Hệ thống mạng | Các thiết bị Firewall, kiểm soát lưu lương truy cập. Phát hiện xâm nhập, phần mềm độc hại từ không gian mạng. |
| Biện pháp bảo mật – Quyền truy cập | Hệ thống phân quyền truy cập chặt chẽ khi truy cập vào dữ liệu, tài nguyên hệ thống. |

## 3. Phân tích và Tái hiện Hạ tầng từ góc độ Quản trị (CTO Perspective)

Dựa trên quy mô 350 nhân sự và đặc thù ngành gia công phần mềm (Outsourcing), dưới đây là phân tích chi tiết và tái hiện cấu hình hạ tầng thực tế mà một CTO sẽ xây dựng để đảm bảo hiệu năng, bảo mật và tính sẵn sàng cao.

### 3.1. Quy hoạch Mạng và Băng thông (Capacity Planning)

*   **Băng thông Internet (ISP):**
    *   **Line chính (Leased Line):** 1Gbps quốc tế cam kết (VNPT/Viettel) để đảm bảo kết nối ổn định cho Video Conference, VPN site-to-site với khách hàng nước ngoài, và upload/download source code.
    *   **Line dự phòng (Backup):** 2 đường FTTH Business (500Mbps - 1Gbps) từ nhà mạng khác (FPT/CMC) chạy chế độ Load Balancing hoặc Failover.
*   **Quy hoạch IP & VLAN:**
    *   **VLAN 10 (Server Farm):** Dành riêng cho máy chủ, NAS, giới hạn truy cập chặt chẽ.
    *   **VLAN 20 (Corp/Staff):** Mạng wifi/lan cho nhân viên văn phòng (HR, Admin, Sales).
    *   **VLAN 30 (Dev/Test):** Mạng cho đội ngũ phát triển, có thể mở một số port đặc thù để test sản phẩm.
    *   **VLAN 40 (Guest):** Mạng Wifi khách, cách ly hoàn toàn với mạng nội bộ.
    *   **VLAN 50 (Management):** Dành cho quản trị thiết bị mạng (Switch, Firewall, AP).

### 3.2. Chi tiết Thiết bị Phần cứng (Hardware Specifications)

Để vận hành ổn định cho 350 user, hệ thống cần các thiết bị chuyên dụng (Enterprise Grade). Dưới đây là cấu hình tham khảo thực tế:

| Thiết bị              | Số lượng     | Model                                                     | Cấu hình/Ghi chú                                                                                                                                                                             |
| --------------------- | :----------- | :-------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Firewall (NGFW)**   | 02 (HA Pair) | **Fortinet FortiGate 200F** hoặc **Palo Alto PA-850**     | Chạy chế độ High Availability (Active-Passive). Đảm bảo Deep Packet Inspection (DPI), VPN SSL cho 350 user, IPS/IDS.                                                                         |
| **Core Switch**       | 02 (Stack)   | **Cisco Catalyst 9300 Series**                            | Layer 3 Switch, 24/48 port quang (SFP+) để kết nối xuống Access Switch và Server với tốc độ 10Gbps.                                                                                          |
| **Access Switch**     | 8 - 10       | **Cisco Catalyst 9200L** hoặc **Aruba 2930F**             | 48 Port Gigabit PoE+ để cấp nguồn cho Camera và Access Point. Uplink 10G về Core.                                                                                                            |
| **Wifi Access Point** | 15 - 20      | **Aruba AP-535** hoặc **Meraki MR46**                     | Chuẩn Wifi 6 (802.11ax), chịu tải cao (High Density), hỗ trợ 50-70 user/AP đồng thời.                                                                                                        |
| **Physical Server**   | 03           | **Dell PowerEdge R750** hoặc **HPE ProLiant DL380 Gen10** | **CPU:** 2x Intel Xeon Gold (24 cores/CPU). <br>**RAM:** 256GB - 512GB DDR4 ECC. <br>**Disk:** Chạy RAID 10 SSD/NVMe cho OS và VM. <br>Dùng để chạy ảo hóa (Hyper-V Cluster/VMware vSphere). |
| **Storage (NAS/SAN)** | 01           | **Synology RackStation RS3621xs+**                        | Dung lượng khả dụng ~50TB - 100TB (RAID 6). Dùng làm File Server nội bộ, Backup Target và lưu trữ Image máy ảo.                                                                              |

### Mô hình Kết nối (Topology)

*   **Mô hình:** Star Topology (Hình sao) mở rộng.
*   **Core Layer:** Cặp Core Switch làm trung tâm, chịu tải routing giữa các VLAN.
*   **Distribution/Access Layer:** Các Access Switch kết nối về Core bằng cáp quang (Fiber Optic) 10Gbps (Link Aggregation) để đảm bảo băng thông không bị nghẽn.
*   **Redundancy:** Mọi kết nối quan trọng (Server -> Switch, Switch -> Switch, Firewall -> ISP) đều có dự phòng (Redundant Links/Power Supplies).

### Chiến lược "Cloud Hybrid"

Với xu hướng hiện đại, Orient Software không đặt toàn bộ server tại văn phòng (On-premise) mà sử dụng mô hình lai:
*   **On-premise (Tại văn phòng):** Chỉ giữ lại các dịch vụ cần độ trễ thấp (AD, DNS, Print Server, File Server nội bộ) và Firewall bảo mật.
*   **Cloud (AWS/Azure):** Các môi trường Staging, Production của dự án, Source Code (GitLab/GitHub), và ERP/CRM (SAP) đều nằm trên Cloud để đảm bảo uptime 99.9% và truy cập từ xa dễ dàng.
