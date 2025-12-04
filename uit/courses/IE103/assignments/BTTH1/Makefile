all: report.pdf

report.pdf: report.typ
	typst compile report.typ

watch:
	typst watch report.typ

clean:
	rm -f report.pdf
