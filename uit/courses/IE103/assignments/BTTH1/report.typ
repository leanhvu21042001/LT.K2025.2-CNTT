// MARR: imports

#import "libs/report.typ": *

// MARK: THE TARGET for BACK TO TOP
#metadata("top") <top>

// MARK: The Template

  // Define the author in a variable
#let assignment-author = "Nhóm 1 (Alpha)"

#show: university-assignment.with(
  title: "BTTH1",
  subtitle: "Quản Lý Thông Tin",
  author: assignment-author,
  details: (
    course: lorem(1),
    instructor: lorem(3),
    due-date: datetime.today(),
    duration: "~3 hours",
    lab-number: lorem(1),
  )
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
