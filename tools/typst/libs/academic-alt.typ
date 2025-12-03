// University Assignment Template
// Usage: #import "template.typ": *
// Then call: #show: university-assignment.with(
//   title: "Your Title",
//   subtitle: "Your Subtitle",
//   author: "Your Name",
//   details: (
//     course: "ECSE 303",
//     supervisor: "Prof. Smith",
//     due-date: "September 19, 2025",
//     hardware: "Raspberry Pi, LED, resistor",
//     software: "C (WiringPi), Python (RPi.GPIO)",
//     duration: "~3 hours",
//   ),
//   date: datetime.today()
// )

#let university-assignment(
  title: "Bài Tập Thực Hành",
  subtitle: none,
  author: "",
  details: (:),
  date: datetime.today(),
  body
) = {
  // Page setup
  set page(margin: 2cm)
  set text(font: "Palatino", size: 12pt, weight: "regular")
  set heading(numbering: "1.")
  // Indent for List
  set list(indent: 1em)
  // Indent for Enum
  set enum(indent: 1em)
  // set par()
  
  // Custom code block styling
  // TODO: Line Number
  // TODO: Iosevka monofont
  show raw.where(block: true): it => align(left)[
    #block(
      radius: 8pt,
      fill: luma(240),
      inset: 1em,
      stroke: none,
      breakable: false,
      width: 100%,
    )[
    #text(font: "Iosevka")[
      #it
      ]
    ]
  ]
  
  show block.where(fill: rgb("#f0f8ff")): it => align(left, it)
  
  // MARK: Custom heading styles
  show heading.where(level: 1): it => [
    #set align(left)
    #set text(font: "Helvetica Neue", size: 20pt, weight: 200)
    #block()[#it.body]
    #line(length: 100%, stroke: 0.5pt + rgb("#000000"))
    #v(0.5em)
  ]
  
  show heading.where(level: 2): it => [
    #set text(font: "Helvetica Neue", size: 18pt, weight: 200, fill: rgb(50, 50, 50))
    #block(above: 1.2em, below: 0.8em)[#it.body]
  ]
  
  // Simple emphasis and strong styling
  show emph: it => text(style: "italic", weight: "medium")[#it.body]
  show strong: it => text(weight: "bold")[#it.body]
  
  // Simple list styling
  // show list: it => block(above: 0.6em, below: 0.6em)[#it]
  
  // Simple quote styling
  show quote: it => block(
    align(center),
    fill: luma(248),
    stroke: (left: 3pt + luma(180)),
    inset: (left: 1em, rest: 0.8em),
    radius: (right: 3pt),
  )[
    #set text(style: "italic")
    #it
  ]
  
  // Enhanced title page
  align(center)[
    #v(1.5em)
    #block(
      radius: 12pt,
      inset: 2em,
      stroke: 1pt,
    )[
      #text(font: "Helvetica Neue", size: 28pt, weight: 300)[
        #title
      ]
      #if subtitle != none [
        #v(0.5em)
        #text(size: 20pt, weight: "semibold")[
          #subtitle
        ]
      ]
    ]
    #v(0.3em)
    #stack(
      dir: ltr,
      spacing: 1em,
      text(size: 20pt, weight: "bold")[#author],
      // text(size: 20pt, fill: rgb(100, 100, 100))[#date.display("[month repr:long] [day], [year]")],
    )
    #v(1em)
  ]
  
  // Assignment Summary Box
  block(
    radius: 8pt,
    fill: rgb(248, 250, 252),
    stroke: 1pt + rgb(200, 220, 240),
    inset: 1.5em,
    width: 100%,
  )[
    #align(center)[
      #text(font: "Helvetica Neue", size: 16pt, weight: 200, fill: rgb(30, 70, 120))[
        Thông Tin Chung
      ]
    ]
    #v(0.8em)
    #grid(
      columns: (1fr, 1fr),
      column-gutter: 2em,
      row-gutter: 1em,
      // Left column
      [
        *Mục Lục:*
        #v(0.8em)
        #outline(
          title: none,
          indent: 1em,
          depth: 2,
        )
      ],
      // Right column
      [
        *Chi Tiết:*
        #v(0.8em)
        // TODO: Indent 2 spaces
        #if "course" in details [
          - *Môn:* #details.course
        ]
        #if "supervisor" in details [
          - *Giảng Viên:* #details.supervisor
        ]
        #if "instructor" in details [
          - *Giảng Viên:* #details.instructor
        ]
        #if "professor" in details [
          - *Professor:* #details.professor
        ]
        #if "due-date" in details [
          - *Thời Hạn:* #details.due-date
        ]
        #if "hardware" in details [
          - *Hardware:* #details.hardware
        ]
        #if "software" in details [
          - *Software:* #details.software
        ]
        #if "duration" in details [
          - *Thời Gian:* #details.duration
        ]
        #if "lab-number" in details [
          - *Bài Tập:* #details.lab-number
        ]
        #if "partner" in details [
          - *Lab Partner:* #details.partner
        ]
        #if "section" in details [
          - *Section:* #details.section
        ]
      ],
    )
  ]
  
  v(2em)
  // line(length: 100%, stroke: 0.5pt + rgb(200, 220, 240))
  v(0.5em)
  // v(2em)
  
  pagebreak()
  // TODO: Page number
  // Document body
  body
}

// Example usage:
/*
#show: university-assignment.with(
  title: "Lab 3: GPIO and LED Control",
  subtitle: "Embedded Systems",
  author: "Your Name",
  details: (
    course: "ECSE 303",
    supervisor: "Michael Goldberg",
    due-date: "September 19, 2025",
    hardware: "Raspberry Pi, LED, resistor",
    software: "C (WiringPi), Python (RPi.GPIO)",
    duration: "~3 hours",
  ),
  date: datetime.today()
)

= Introduction
Your content here...
*/