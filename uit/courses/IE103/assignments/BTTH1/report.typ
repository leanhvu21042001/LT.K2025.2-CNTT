// MARR: imports

#import "libs/report.typ": *

// MARK: THE TARGET for BACK TO TOP
#metadata("top") <top>

// MARK: The Template

// Define the author in a variable
#let details = (
  university: (
    name: "Trường Đại Học TP. Hồ Chí Minh",
    college: "Đại Học Công Nghệ Thông Tin",
    center: "Trung Tâm Phát Triển Công Nghệ Thông Tin",
    logo: "",
  ),
  course: (
    id: "IE103",
    name: "Quản Lý Thông Tin (Data Management)",
    class: "LT.K2025.2.CNTT",
  ),
  instructor: "Ths. Nguyễn Thành Luân",
  author: (
    name: "Nhóm 1",
    members: (
      (
        name: "Đinh Xuân Sâm",
        id: "25410291",
      ),
      (
        name: "Đặng Hữu Toàn",
        id: "25410319",
      ),
      (
        name: "Nguyễn Điền Triết",
        id: "25410321",
      ),
      (
        name: "Trương Xuân Hậu",
        id: "25410204",
      ),
      (
        name: "Lê Anh Vũ",
        id: "25410338",
      ),
      (
        name: "Trần Sơn Bình",
        id: "25410176",
      ),
      (
        name: "Lê Kim Long",
        id: "25410247",
      ),
      (
        name: "La Anh Vũ",
        id: "25410337",
      ),
      (
        name: "Lê Ngọc Hiệp",
        id: "25410209",
      ),
      (
        name: "Nguyễn Thị Ngọc Nhung",
        id: "25410271",
      ),
    ),
  ),
  assignment: (
    title: "Bài Tập Thực Hành 1",
    subtitle: "Thiết Kế Cơ Sở Dữ Liệu",
    type: "Bài Tập Thực Hành",
    date: "Dec, 2025",
    duration: "15 phút",
  ),
)

#show: university-assignment.with(
  university: details.university,
  course: details.course,
  author: details.author,
  instructor: details.instructor,
  assignment: details.assignment,
)

// MARK: AUTHOR

#unheading[#details.author.name]
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
