// MARR: imports

#import "libs/report.typ": *

// MARK: THE TARGET for BACK TO TOP
#metadata("top") <top>

// MARK: The Template

// Define the author in a variable
#let assignment-author = "Nhóm 1 (Alpha)"

#show: university-assignment.with(
  university: (
    name: "Đại Học TP. Hồ Chính Minh",
    college: "Đại Học Công Nghệ Thông Tin",
    center: "Trung Tâm Phát Triển Công Nghệ Thông Tin",
  ),
  course: (
    id: "IE103",
    name: "Quản Lý Thông Tin",
    class: "Lớp IE103",
  ),
  instructor: lorem(3),
  author: (
    name: assignment-author,
    members: (),
  ),
  assignment: (
    title: "BTTH1",
    subtitle: "Quản Lý Thông Tin",
    type: "Bài Tập Thực Hành",
    date: datetime.today(),
    duration: "~3 hours",
  ),
)

// MARK: AUTHOR

#unheading[#assignment-author]
#include "author.typ"

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
