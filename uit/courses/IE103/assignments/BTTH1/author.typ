#import "../../../../../tools/typst/libs/academic-alt.typ": *

#align(center)[
  #text(font: "Montserrat", size: 28pt, weight: "regular")[
  #info.author
  ]
]

Thành viên của nhóm và bảng nhiệm vụ.

#figure(
  align(center)[#rounded-table-lined(
    columns: (10%, 20%, 40%, 30%),
    align: (right,right,left,left,),
    table.header([No], [MSSV], [Họ và Tên], [Phụ Trách],),
    table.hline(),
    [`01`], [`25410291`], [Đinh Xuân Sâm], [],
    [`02`], [`25410319`], [Đặng Hữu Toàn], [],
    [`03`], [`25410321`], [Nguyễn Điền Triết], [],
    [`04`], [`25410204`], [Trương Xuân Hậu], [],
    [`05`], [`25410338`], [Lê Anh Vũ], [],
    [`06`], [`25410176`], [Trần Sơn Bình], [],
    [`07`], [`25410247`], [Lê Kim Long], [],
    [`08`], [`25410337`], [La Anh Vũ], [],
    [`09`], [`25410209`], [Lê Ngọc Hiệp], [],
    [`10`], [`25410271`], [Nguyễn Thị Ngọc Nhung], [],
  )]
  , kind: table
  , caption: [#info.author]
  , outlined: false // Hides it from the List of Tables
  , numbering: none  // Hides the "Table X:" prefix (optional)
)
