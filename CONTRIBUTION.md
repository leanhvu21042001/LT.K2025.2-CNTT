# CONTRIBUTION - ĐÓNG GÓP

Chào mừng, rất vui nếu bạn tham gia đóng góp!

## Các Quy Tắc Chung về File

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

