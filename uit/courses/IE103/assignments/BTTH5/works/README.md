# University Assignment Template

This is a Typst template for university assignments.

## Usage

1. **Clone/Copy** this directory.
2. **Edit `data.typ`**: Key in your report's details.
3. **Edit `main.typ`**:
    - Update the `university` dictionary with your school details.
    - Update `title`, `subtitle`, `author`, and `details`.
    - Include your content files (e.g., `quiz1.typ`, `quiz2.typ`).
4. **Compile**:
    - Run `make` to build `main.pdf`.
    - Run `make watch` to watch for changes and rebuild automatically.

## Structure

-   `data.typ`: The report metadata file. Edit this first.
-   `main.typ`: Main file. Edit this.
-   `libs/report.typ`: Template definition. Do not edit unless you want to change the style.
-   `author.typ`: Author details (optional, can be included in `report.typ`).
-   `quiz*.typ`: Content files.
