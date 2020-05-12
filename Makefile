TEXNAME=talk
PDFNAME=talk

all: clean latexmk

#svg: figs/problem-definition.pdf figs/epochs.pdf

figs/%.pdf: figs/%.svg
	inkscape -D -z --file=$< --export-pdf=$@ --export-latex

latexmk: latexmk_clean
	# For some reason using -auxdir=build/ will result in failed builds
	latexmk -xelatex ${TEXNAME}

texi2pdf: texi2pdf_clean
	texi2pdf --build-dir=build/ ${TEXNAME}.tex -o ${PDFNAME}.pdf

clean: texi2pdf_clean latexmk_clean
	rm -f ${PDFNAME}.pdf

latexmk_clean:
	rm -f *.fls *.fdb_latexmk *.dvi *.synctex.gz

texi2pdf_clean:
	rm -rf build/
	rm -f *.nav *.snm *.aux *.blg *.lof *.lot *.log *.bbl *.blg *.toc *.out
