# IE103 - Project

## Ý tưởng

- Tạo nội dung từ Markdown.
- Chuyển định dạng sang Typst để tạo báo cáo.
- Chuyển định dạng sang Typst để tạo slides.

## Cách Tổ Chức

### Markdown - Nội Dung

- File chính: `main.md`
- Chapters/Sections: `chapters/chap01.md`, `chapters/chap02.md`, ...

### Typst - Báo Cáo

- Sử dụng template tại [https://github.com/lt20252cnttalpha/typst-report-template](https://github.com/lt20252cnttalpha/typst-report-template)
- File chính: `main.typ`
- Chapters/Sections: `chapters/chap01.typ`, `chapters/chap02.typ`, ...

### Typst - Slides

- File chính: `slides.typ`
  - File này chỉ chứa cấu hình, trình bày, bố cục, không chứa nội dung.
- File nội dung: `contents.typ`
  - File này chỉ chứa các nội dung chính, hay các heading.

## Slides

### Công cụ

- Pandoc: Chuyển định dạng từ Markdown sang Typst.
- Typst: Tạo Slides từ Typst.

### Hướng dẫn

Nếu thay đổi cấu hình:

- Phần này không ảnh hưởng đến nội dung.
- Chỉ ảnh hưởng tới bố cục, hình thức.
- Chỉnh sửa file `slides.typ`.
- Chạy lệnh `typst compile slides.typ`.

Nếu thay đổi nội dung:

- Phần này ảnh hưởng đến nội dung.
- Không ảnh hưởng tới bố cục, hình thức.
- Chỉnh sửa file `contents.typ`.
- Chạy lệnh `typst compile slides.typ`.

Nếu đổi nội dung qua Markdown:

- Phục vụ mục đích cập nhật nội dung dễ dàng hoặc chuyển định dạng.

```bash
pandoc -s contents.typ -o contents.md
```

Nếu đổi/cập nhật nội dung từ Markdown:

- Nếu thay đổi nội dung và cần chuyển sang Typst, chạy lệnh:

```bash
pandoc -s contents.md -o contents.typ
```
