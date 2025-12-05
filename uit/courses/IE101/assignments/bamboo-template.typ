// main.typ
#import "@preview/touying:0.6.1": *
#import "bamboo.typ": *

#show: bamboo-theme.with(
  aspect-ratio: "16-9",
  footer: self => self.info.institution,
  config-info(
    title: [Title],
    subtitle: [Subtitle],
    author: [Authors],
    date: datetime.today(),
    institution: [Institution],
  ),
)

#title-slide()

= First Section

== First Slide

A slide with a title and an *important* information.

#focus-slide[
  Focus on it!
]
