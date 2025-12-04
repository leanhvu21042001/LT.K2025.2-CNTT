// MARR: imports

#import "../../../../../tools/typst/libs/academic-alt.typ": *

// MARK: THE TARGET for BACK TO TOP
#metadata("top") <top>

// MARK: The Template

#show: university-assignment.with(
  title: "Bài Tập Thực Hành 1",
  subtitle: "IE103 - Quản Lý Thông Tin",
  author: "Nhóm 2",
  details: (
    course: "IE103",
    instructor: "Ths. Nguyễn Thành Luân",
    due-date: "Tháng 12, 2025",
    duration: "~3 hours",
    lab-number: "BTTH1",
  )
)

// MARK: AUTHOR

#include info.author_filename + ".typ"

#pagebreak()

// IMPORTANT Switch page number style and reset its counter
#set page(numbering: "1")
#counter(page).update(1)

// MARK: MAIN CONTENT

#include "quiz1.typ"
#include "quiz2.typ"
#include "quiz3.typ"
#include "quiz4.typ"

// THE END
