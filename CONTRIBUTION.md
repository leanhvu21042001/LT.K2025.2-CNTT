# CONTRIBUTION - ĐÓNG GÓP

Chào mừng, rất vui nếu bạn tham gia đóng góp!

## Các Quy Tắc Chung về Soạn Thảo File

### File Format (New Line) - Định Dạng File

-   `EOL` (End Of Line) hay *newline*: `\n` (Unix/Linux).
    -   Tức là `LF`, không phải `CRLF` (Windows) hay `CR` (macOS).
    -   Tham khảo: https://en.wikipedia.org/wiki/Newline

Tips:

-   Git `attributes`:

```ini
* text=auto eol=lf
```

-   Vim: `:set ff=unix`
-   Các editor khác: Chọn *Line Ending* hoặc thuật ngữ tương tự và chọn Linux/Unix.

### Tab

-   Khoảng trắng, kích thước: 4.
-   Dùng khoảng trắng, không dùng ký tự Tab, nhằm nhất quán kích thước.

Tips:

-   `.vimrc`:

```ini
set tabstop=4
set shiftwidth=4
set softtabstop=4
```

-   Các Editor: tùy chỉnh trong Setting tương ứng, ví dụ:

```json
{
    // Newline/EOL to Unix (\n)
    "default_line_ending": "unix",
    // Set to true to insert spaces when tab is pressed
    "translate_tabs_to_spaces": true,
    // The number of spaces a tab is considered equal to
    "tab_size": 4,
    "fallback_encoding": "UTF-8",
    "font_face": "Iosevka",
}
```

### End Of File (EOF) - Hay dòng cuối của File.

-   Hãy để một dòng cuối của file là dòng trống (empty line)
-   Tức chỉ tồn tại duy nhất 1 ký tự (không nhìn thấy được) là xuống dòng (`\n`), không chứa bất kỳ ký tự nhìn thấy được nào khác.
-   Có thể mọi người ít quan tâm.

Ví dụ 1: Dòng 2 có ký tự khác ngoài `\n` ở cuối dòng.

```text
Đây là ví dụ không có EOF.
\ No newline at end of file
```

Ví dụ 2: Dòng thứ 2 trống, và chỉ chứa duy nhất ký tự `\n` (không hiện lên màn hình).

```text
Đây là ví dụ có EOF.

```

## Các Quy Tắc về Đặt Tên File và Thư Mục

-   Sắp xếp theo thứ tự:
    -   **Numberic**: `01`, `02`, `03`, …
        -   Lý do: có `0` ở trước để phân biệt `1` vs `10` khi sắp xếp, tránh trường hợp chúng cạnh nhau vì thực tế cách 9 đơn vị/file khác.
    -   **Alphabet**: `a`, `b`, `c`, … `A`, `B`, `C`, …
    -   **Date time**: 251025, 251026, … (`yymmdd` tương đương: 2025-10-25, 2025-10-26).
        -   Lý do: Năm trước, tháng sau, ngày cuối cùng.
        -   Chỉ dùng 2 ký tự cho Năm, vì không cần lo lắng nhầm lẫn đó là 2025, hay 1925, hay 2125, vì có lẽ chúng ta không sống đủ lâu để quan tâm 2125, và không đủ sớm để quan tâm 1925.
-   Sử dụng chữ thường, không khoảng trắng, không có dấu tiếng Việt (hoặc bất kỳ tiếng khác), không ký tự đặc biệt (chỉ dùng bảng ASCII):
    -   Ví dụ: `250105-huong-dan-sinh-vien-ra-vao-cong-thu-duc`

Kết quả:

-   Tạo thành một cấu trúc cây chặt chẽ với đường dẫn hoàn toàn liền mạch.
-   Ví dụ:
    -   `uit/courses/IE005/lectures/l01.pdf`
    -   `uit/courses/IE005/reports/buoi-2/IE005-reports-buoi-2-Nhom-1.pdf`

Ví dụ bổ sung:

-   `ch01`, `ch02`, `ch03`, …
-   `ch01a`, `ch01b`, `ch01c`, …
-   Thư mục thông báo và các file bên trong được sắp xếp theo `yymmdd`.

## Git và Phân Nhánh

-   Luôn phân nhánh khi cần thiết, có thể cân nhắc sử dụng git-flow.
-   Quy tắt đặt tên nhánh: nhất quán, để gom vào chung cây phân nhánh.
    -   `courses/course-id`: `courses/MA003`, `tools/IE005`, …
    -   `tools/tool-name`: `tool/marp-slides`, `tools/obsidian`, …

## Thuộc Tính của File

-   Luôn bổ sung thuộc tính của file nếu có.
-   Sử dụng YAML header, hoặc File Property menu của Obsidian.

Ví dụ:

-   Mã môn: IE005
-   Loại (của file) là Khóa học.
-   Cung cấp bởi: UIT
-   Tên môn.
-   Tiêu đề.
-   Tags.

```yaml
---
id: IE005
type: Course
provider: UIT
subject: Giới Thiệu Nghành Công Nghệ Thông Tin
title: Bài 1. Giới Thiệu Nghành Công Nghệ Thông Tin
tags:
  - CNTT
---
```

## Các Quy Tắc Soạn Thảo

### Fonts

-   Sans: [Source Sans 3](https://fonts.google.com/specimen/Source+Sans+3?preview.text=GI%E1%BB%9AI%20THI%E1%BB%86U%20NG%C3%80NH%20C%C3%94NG%20NGH%E1%BB%86%20TH%C3%94NG%20TIN&query=Source+C) (ví dụ).
-   Serif: [Lora](https://fonts.google.com/specimen/Lora?preview.text=GI%E1%BB%9AI%20THI%E1%BB%86U%20NG%C3%80NH%20C%C3%94NG%20NGH%E1%BB%86%20TH%C3%94NG%20TIN) (ví dụ) hoặc [Source Serif 4](https://fonts.google.com/specimen/Source+Serif+4?preview.text=GI%E1%BB%9AI%20THI%E1%BB%86U%20NG%C3%80NH%20C%C3%94NG%20NGH%E1%BB%86%20TH%C3%94NG%20TIN).
-   Monospace: [Iosevka](https://typeof.net/Iosevka/) (khuyến nghị).

### Công Thức Toán Học

-   Dùng `$ ... $` cho các công thức ngắn: `$2x + 3y = 0$`, kết quả: $2x + 3y = 0$
-   Luôn dùng `$$ ... $$` cho các công thức dài, ví dụ:

Code:

```latex
A = B \quad \forall A, B \in M_{m \times n} (\mathbb{R}) \iff
\begin{cases}
a_{ij} = b_{ij} \\
1 \le i \le m, 1 \le j \le n
\end{cases}
```



Kết quả:
$$
A = B \quad \forall A, B \in M_{m \times n} (\mathbb{R}) \iff
\begin{cases}
a_{ij} = b_{ij} \\
1 \le i \le m, 1 \le j \le n
\end{cases}
$$


### Cross Referrence - Tham Chiếu Chéo

