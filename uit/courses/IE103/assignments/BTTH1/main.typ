// MARR: imports

#import "libs/report.typ": *
#import "data.typ": *

// MARK: THE TARGET for BACK TO TOP
#metadata("top") <top>

// MARK: The Template Details Page
#show: university-assignment.with(
  university: details.university,
  course: details.course,
  author: details.author,
  instructor: details.instructor,
  assignment: details.assignment,
)

// MARK: AUTHOR INFO
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
