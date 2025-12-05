# IE103 - Project

## Ý tưởng

- Tạo nội dung từ Markdown.
- Chuyển định dạng sang Typst để tạo báo cáo.
- Chuyển định dạng sang Typst để tạo slides.

## Cách Tổ Chức

### Markdown - Nội Dung

- File chính: `main.md`
- File khung nội dung: `contents.md`
  - Đây cũng chính là file nguyên liệu để tạo slides.
- Chapters/Sections: `chapters/chapter01.md`, `chapters/chapter02.md`, ...
  - Đây là các file chứa nội dung chi tiết từng chương.

### Typst - Báo Cáo

- Sử dụng template tại [https://github.com/lt20252cnttalpha/typst-report-template](https://github.com/lt20252cnttalpha/typst-report-template)
- File chính: `main.typ`
  - File này chứa `#include` các file `chapters/chapter01.typ`, `chapters/chapter02.typ`, ...
- Chapters/Sections: `chapters/chapter01.typ`, `chapters/chapter02.typ`, ...

### Typst - Slides

- File chính: `slides.typ`
  - File này chỉ chứa cấu hình, trình bày, bố cục, không chứa nội dung.
  - Chứa Tiêu Đề (Title, Intro Slide), và Outro Slide.
  - CHỈ CHỈNH SỬA NẾU THAY ĐỔI STYLE, THEME, METADATA.
- File nội dung: `contents.typ`
  - CHỈ CHỨA NỘI DUNG CHÍNH, hay các heading.
  - Được chuyển định dạng từ `contents.md`.
  - CHỈ CHỈNH SỬA NẾU THAY ĐỔI NỘI DUNG.

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

## Makefile

- Chuyển định dạng các file nội dung từ Markdown sang Typst.
- Chuyển định dạng từ Typst sang PDF tương ứng báo cáo/slides.

```Makefile
.PHONY: all clean

all: main.pdf slides.pdf

main.pdf: main.typ
	# For each chapter in chapters, convert md to typst
	for chapter in $(wildcard chapters/*.md):
		pandoc -s $chapter -o $(chapter).typ
	typst compile main.typ

slides.pdf: slides.typ
	pandoc -s contents.md -o contents.typ
	typst compile slides.typ

.PHONY: clean
clean:
	rm -f main.pdf slides.pdf
```
