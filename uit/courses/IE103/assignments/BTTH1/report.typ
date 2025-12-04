// MARR: imports

#import "libs/report.typ": *

// MARK: THE TARGET for BACK TO TOP
#metadata("top") <top>

// MARK: The Template

// Define the author in a variable
#let details = (
  university: (
    name: "UNIVERSITY_NAME",
    college: "COLLEGE_NAME",
    center: "CENTER_NAME",
    logo: "",
  ),
  course: (
    id: "COURSE_ID",
    name: "COURSE_NAME",
    class: "CLASS_NAME",
  ),
  instructor: "INSTRUCTOR_NAME",
  author: (
    name: "AUTHOR_NAME",
    members: (),
  ),
  assignment: (
    title: "ASSIGNMENT_TITLE",
    subtitle: "ASSIGNMENT_SUBTITLE",
    type: "ASSIGNMENT_TYPE",
    date: "Dec, 2025",
    duration: "ASSIGNMENT_DURATION",
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
