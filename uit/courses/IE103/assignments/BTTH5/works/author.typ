#import "libs/report.typ": *
#import "data.typ": *

// YOUR CONTENT HERE

#unheading[#details.author.name]

Thành viên của nhóm và bảng nhiệm vụ.

#figure(
  align(center)[
    // Mono font in column 0, 1
    #show table.cell: current_cell => {
      // Check if row (y > 0) AND the column is (0, 1)
      if current_cell.y > 0 and current_cell.x in (0, 1) {
        // Use a monofont: Iosevka
        text(
          font: "Iosevka",
          weight: "regular",
        )[#current_cell]
      } else {
        // Return normal formatting for other columns
        current_cell
      }
    }
    // TODO: Span full width automatically
    // TODO: import/use csv data instead of hardcoding
    #rounded-table-lined(
      columns: (10%, 20%, 70%),
      align: (right, right, left),
      table.header([*No*], [*MSSV*], [*Họ và Tên*]),
      table.hline(),
      [01],
      [25410291],
      [Đinh Xuân Sâm],
      [02],
      [25410319],
      [Đặng Hữu Toàn],
      [03],
      [25410321],
      [Nguyễn Điền Triết],
      [04],
      [25410204],
      [Trương Xuân Hậu],
      [05],
      [25410338],
      [Lê Anh Vũ],
      [06],
      [25410176],
      [Trần Sơn Bình],
      [07],
      [25410247],
      [Lê Kim Long],
      [08],
      [25410337],
      [La Anh Vũ],
      [09],
      [25410209],
      [Lê Ngọc Hiệp],
      [10],
      [25410271],
      [Nguyễn Thị Ngọc Nhung],
    )],
  kind: table,
  caption: [#details.author.name],
  outlined: false, // Hides it from the List of Tables
  numbering: none, // Hides the "Table X:" prefix (optional)
)
