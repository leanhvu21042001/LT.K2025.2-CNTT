# University Assignment Template

This is a Typst template for university assignments.

## Usage

1.  **Clone/Copy** this directory.
2.  **Edit `main.typ`**:
    *   Update the `university` dictionary with your school details.
    *   Update `title`, `subtitle`, `author`, and `details`.
    *   Include your content files (e.g., `quiz1.typ`, `quiz2.typ`).
3.  **Compile**:
    *   Run `make` to build `main.pdf`.
    *   Run `make watch` to watch for changes and rebuild automatically.

## Structure

*   `main.typ`: Main file. Edit this.
*   `libs/report.typ`: Template definition. Do not edit unless you want to change the style.
*   `author.typ`: Author details (optional, can be included in `report.typ`).
*   `quiz*.typ`: Content files.
