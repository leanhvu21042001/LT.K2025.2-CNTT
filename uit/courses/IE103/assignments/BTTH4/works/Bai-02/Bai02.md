# Bài 02: Các loại Report trong Visual Studio

## 1. Ngoài Crystal Report, Visual Studio còn hỗ trợ những loại Report nào?

Ngoài **Crystal Report**, Visual Studio còn hỗ trợ một số loại Report phổ biến sau:

### 1.1 RDLC (Local Report) – Microsoft Report Viewer

- Dùng tốt cho WinForms, WPF, ASP.NET MVC, WebForms.
- File report: .rdlc
- Thiết kế report bằng designer kéo-thả trong Visual Studio

---

### 1.2 SSRS (SQL Server Reporting Services) – Server Report

- Dùng khi muốn tạo report chạy trên server.
- Thiết kế file .rdl (khác với .rdlc).
- Report chạy trên Report Server: Web, API.

---

### Ví dụ thực tế

Hiện nay, một số phần mềm bệnh viện đang sử dụng **RDLC** và **SSRS**, ví dụ:
- Hoàn Mỹ
- Nam Sài Gòn
- Gia An
- Truyền máu Huyết Học

---

## 2. Hiện tại, loại Report nào phổ biến và hay được dùng nhất?

Hiện nay, **Local Report (RDLC)** và **SSRS** là hai loại report được sử dụng nhiều nhất trong thực tế, đặc biệt trong các hệ thống lớn:

- Quản lý doanh nghiệp (ERP)
- Quản lý bệnh viện (HIS)
- Quản lý tài chính – kế toán

---

## 3. Nếu không dùng Visual Studio thì có cách nào tạo Report không?

Ngoài Visual Studio, vẫn có thể tạo report bằng cách:

### 3.1 Sử dụng Report Builder

- Công cụ kéo-thả giao diện
- Kết nối trực tiếp với Database
- Thiết kế report mà **không cần code**

---

