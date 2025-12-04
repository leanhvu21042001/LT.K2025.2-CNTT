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

// MARK: MAIN CONTENT
#set page(numbering: "1")
#counter(page).update(1)

= Bài 1. GMail & Mail Group.
<bai-1>

#include "quiz1.typ"

= Bài 2. Explorer/Finder.
<bai-2>

#include "quiz2.typ"

= Bài 3. FAT32 vs NTFS. Windows File System.
<bai-3>

#include "quiz3.typ"

= Bài 4. Trigger & Views trong DBMS.
<bai-4>

#include "quiz4.typ"

// THE END
