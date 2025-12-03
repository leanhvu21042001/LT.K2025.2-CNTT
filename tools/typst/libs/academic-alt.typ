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

// TODO: Roman page number for non-main content pages

// Wrapper function for rounded tables
#let rounded-table(..args) = {
  block(
    radius: 8pt, // Adjust this for more/less roundness
    stroke: 1pt + luma(220), // The outer border color
    clip: true,  // This cuts off the square corners
    width: 100%, // Ensures it fits the page
    inset: 0pt,  // No gap between border and table
    
    // The inner table
    table(
      ..args,
      stroke: none, // We turn off the default grid to avoid double borders
      // We add horizontal lines between rows for a clean look
      align: (x, y) => if y == 0 { center } else { left },
    )
  )
}

// Rounded border table with lines

#let rounded-table-lined(..args) = block(
  radius: 8pt,
  stroke: 1pt + luma(220), // Outer Border
  clip: true,
  width: 100%,
  inset: 0pt,
  table(
    ..args,
    // Define stroke: Only draw bottom lines, and NOT on the last row
    stroke: (x, y) => (
      bottom: 1pt + luma(230), 
      // thick white line for vertical separation looks nice on gray backgrounds:
      right: none
    )
  )
)

#let info = (
  title: "Bài Tập Thực Hành 1",
  author: "Nhóm 2 (Omega)",
  id: "25410000",
  course: "IE103"
)

// TODO: Rounded border image

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
  // set text(font: "CMU Concrete", size: 12pt, weight: "regular")
  set text(font: "Lora", size: 12pt, weight: "regular")

  // Paragraph
  set par(
    leading: 0.8em, // Controls space between lines WITHIN a paragraph
    justify: true,   // Recommended for assignments to align text edges
    spacing: 1.5em
  )
  set heading(numbering: "1.")
  // Indent for List
  set list(indent: 1em)
  // Indent for Enum
  set enum(indent: 1em)
  // set par()
  
  // Custom code block styling
  // TODO: Line Number

  // Rename "Figure" to "Mã nguồn" for code blocks
  show figure.where(kind: raw): set figure(supplement: "Mã nguồn")

  // Table formatting
  set table(
    stroke: 0.5pt + gray,
    fill: (x, y) =>
      if x == 0 or y == 0 {
        gray.lighten(40%)
      },
    align: right,
  )

  // Raw: font, and size
  show raw: set text(font: "Iosevka", 1.2em)

  // Inline-raw
  show raw.where(block: false): box.with(
    fill: luma(240),
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
  )

  // Code block
  show raw.where(block: true): it => align(start)[
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

  // vspace after/below every heading
  show heading: set block(below: 1.2em)

  // MARK: Custom heading styles
  show heading.where(level: 1): it => [
    #set align(left)
    #set text(font: "Montserrat", size: 20pt, weight: "regular")
    #block()[#it.body]
    #line(length: 100%, stroke: 0.5pt + rgb("#808080"))
    #v(0.5em)
  ]
  
  // show heading.where(level: 2): it => [
  //   #set text(font: "Montserrat", size: 18pt, weight: "regular", fill: rgb(50, 50, 50))
  //   #block(above: 1.2em, below: 0.8em)[#it.body]
  // ]

  // show heading.where(level: 3): it => [
  //   #set text(font: "Montserrat", size: 16pt, weight: "regular", fill: rgb(50, 50, 50))
  //   #block(above: 1.2em, below: 0.8em)[#it.body]
  // ]
  
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
      stroke: 1pt + gray,
    )[
      #text(font: "Montserrat", size: 28pt, weight: "regular")[
        #smallcaps[#title]
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
      text(font: "Montserrat", size: 20pt, weight: "regular")[#author],
      // text(size: 20pt, fill: rgb(100, 100, 100))[#date.display("[month repr:long] [day], [year]")],
    )
    #v(1em)
  ]
  
  // TODO: Truncate long headings in the outline
  // Assignment Summary Box
  block(
    radius: 8pt,
    fill: rgb(248, 250, 252),
    stroke: 1pt + rgb(200, 220, 240),
    inset: 1.5em,
    width: 100%,
  )[
    #align(center)[
      #text(font: "Montserrat", size: 16pt, weight: "regular", fill: rgb(30, 70, 120))[
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
        - *Mã Môn:*
        - *Tên Môn:*
        - *Giảng Viên:*
        - *Thực Hiện:*
      ],
      // Right column
      [
        #list(
          marker: none,
          [IE103],
          [Quản Lý Thông Tin],
          [Ths. Nguyễn Thành Luân],
          [Nhóm 2 (Omega)]
        )
      ],
    )
  ]
  
  // Table of Contents
  block(
    radius: 8pt,
    fill: rgb(248, 250, 252),
    stroke: 1pt + rgb(200, 220, 240),
    inset: 1.5em,
    width: 100%,
  )[
    #outline(
      title: [Mục Lục],
      indent: auto,
      depth: 2,
    )
  ]

  // List of Tables
  block(
    radius: 8pt,
    fill: rgb(248, 250, 252),
    stroke: 1pt + rgb(200, 220, 240),
    inset: 1.5em,
    width: 100%,
  )[
    #outline(
      title: [Danh Sách Bảng], // Sets the title of the list
      target: figure.where(kind: table) // Selects only tables
    )
  ]

  // List of Figures
  block(
    radius: 8pt,
    fill: rgb(248, 250, 252),
    stroke: 1pt + rgb(200, 220, 240),
    inset: 1.5em,
    width: 100%,
  )[
    #outline(
      title: [Danh Sách Hình Ảnh], // Title: "List of Images"
      target: figure.where(kind: image), // Filter: Only show images
    )
  ]

  // List of Code Snippets
  block(
    radius: 8pt,
    fill: rgb(248, 250, 252),
    stroke: 1pt + rgb(200, 220, 240),
    inset: 1.5em,
    width: 100%,
  )[
    #outline(
      title: [Danh Sách Mã Nguồn], 
      target: figure.where(kind: raw), // Targets figures containing code
    )
  ]

  v(2em)
  // line(length: 100%, stroke: 0.5pt + rgb(200, 220, 240))
  v(0.5em)
  // v(2em)
  
  pagebreak()

  // --- PAGE NUMBERING SETUP ---
  // set page(
  //   numbering: "1", 
  //   number-align: right
  // )
  // counter(page).update(1) // Optional: Resets count so this page starts at 1

  // SETUP FOOTER WITH BACK-TO-TOP
  set page(
    footer: context [
      // We use a stack or grid to align items
      #set text(size: 10pt, fill: gray)
      #grid(
        columns: (1fr, 1fr),
        align: (left, right),
        
        // TODO: Un-blue the link here
        // LEFT: The clickable link
        link(<top>)[↑ Back to Top],
        
        // RIGHT: The page number
        counter(page).display("1")
      )
    ]
  )
  counter(page).update(1)

  // --- LINK STYLING ---
  // We put this HERE so it only affects the actual content, not the TOC.
  show link: set text(fill: rgb("#0000EE"))

  // GLOBAL RULE: All tables inside this document get rounded
  show table: it => block(
    radius: 8pt,
    stroke: 1pt + luma(200),
    clip: true,
    width: 100%,
    it
  )

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