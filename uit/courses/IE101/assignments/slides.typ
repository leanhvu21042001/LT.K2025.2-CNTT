#import "@preview/touying:0.6.1": *
#import themes.stargazer: *

#import "@preview/numbly:0.1.0": numbly

#show: stargazer-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [PHÂN TÍCH CƠ SỞ HẠ TẦNG CÔNG NGHỆ THÔNG TIN],
    subtitle: [ORIENT SOFTWARE DEVELOPMENT CORPORATION],
    author: [Nhóm 1],
    date: datetime.today(),
    institution: [IE103 - Cơ Sở Hạ Tầng CNTT],
  ),
  lang: "vi",
  config-colors(
    primary: rgb("#5E8B65"),
    primary-dark: rgb("#004078"),
    secondary: rgb("#ffffff"),
    tertiary: rgb("#005bac"),
    neutral-lightest: rgb("#ffffff"),
    neutral-darkest: rgb("#003255"),
  ),
)

// TODO: Thay đổi style của list
#set list(
  marker: move(dy: 0.15em, box(circle(radius: 0.2em, stroke: 0.2pt + rgb("#b51d69")))),
  indent: 0.5em,
)

// Set font
#set text(font: "Lora", weight: "regular")

// Set heading level 3
#show heading.where(level: 3): it => [
  #set align(left)
  #set text(font: "Montserrat", size: 20pt, weight: "regular")
  #block(
    width: 100%,
    stroke: (bottom: 0.5pt + rgb("#808080")),
    inset: (bottom: 0.5em),
    below: 0.8em,
  )[
    #smallcaps[#it.body]
  ]
]

#title-slide()

#include "contents.typ"
