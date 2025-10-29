# Tools

* Tools that support to create/modify/manage the materials.

## Obsidian

- [https://obsidian.md/](https://obsidian.md/)
- A Personal Knowledge Base (PKB) software.

## MarkMap

- Homepage: https://markmap.js.org/
- Tạo mindmap từ Markdown.
- Trích xuất SVG hoặc HTML.
- Ví dụ:
    - Download và mở trong trình duyệt: [khung-chuong-trinh-dao-tao.html](../thongbao/khung-chuong-trinh-dao-tao.html)
    - (TODO: bổ sung ví dụ SVG)

## Marpit

- Homepage: https://marpit.marp.app/
- Markdown slide deck framework.

How to:

1. Install the `marp-cli`.
2. Run the command:

```bash
marp --pdf-outline --allow-local-files -p --server path/to/md-folder/ --theme path/to/them-file.css
```

Ví dụ:

```bash
marp --pdf-outline --allow-local-files -p --server tools/marp/samples --theme tools/marp/themes/beam.css
```

In action:

![Ví dụ về marp](assets/tools-marp-in-action-sample.png)

## Marp Slides (obsidian-marp-slides)

* Name: [obsidian-marp-slides](https://github.com/samuele-cozzi/obsidian-marp-slides)
* An [Obsidian plugin](https://github.com/samuele-cozzi/obsidian-marp-slides) that helps to generate slides from a [MarpIt](https://marpit.marp.app/) format.
* Settings:
    * Theme folder: `tools/marp/themes`
* Check out a sample here:
    * The Markdown file: [l01](marp/samples/l01.md)
    * The generated PDF file: [l01](marp/samples/l01.pdf)
