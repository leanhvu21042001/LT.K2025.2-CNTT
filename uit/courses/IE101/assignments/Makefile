.PHONY: all clean

all: main.pdf slides.pdf

main.pdf: main.typ
	# For each chapter in chapters, convert md to typst
	for chapter in $(wildcard chapters/*.md):
		pandoc -f $chapter -o $(chapter).typ
	typst compile main.typ

slides.pdf: slides.typ
    # TODO: Update the contents.md file to reflect the changes in the chapters/ files.
	pandoc -f contents.md -o contents.typ
	typst compile slides.typ

.PHONY: clean
clean:
	rm -f main.pdf slides.pdf
