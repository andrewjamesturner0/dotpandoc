VERSION = 0.0.0
FILENAME = example
HOME = /home/ajt

PANDOC_FLAGS = -smart \
    --standalone \
    --filter=pandoc-citeproc \
    --variable version=$(VERSION) \
    --bibliography=$(FILENAME).bib

PANDOC_PDF_FLAGS = --variable fontfamily=libertine \
    --template=latex-version-number.template \
    --variable geometry:margin=3cm

PANDOC_HTML_FLAGS = --include-in-header=$(HOME)/.pandoc/buttondown.css \
    --template=html-version-number.template

PANDOC_ODT_FLAGS = --reference-doc=$(HOME)/.pandoc/reference.odt

PANDOC_DOCX_FLAGS = --reference-doc=$(HOME)/.pandoc/reference-plain.docx



all: $(FILENAME)_v$(VERSION).pdf \
    $(FILENAME)_v$(VERSION).html \
    $(FILENAME)_v$(VERSION).docx \
    $(FILENAME)_v$(VERSION).odt

pdf: $(FILENAME)_v$(VERSION).pdf
html: $(FILENAME)_v$(VERSION).html
docx: $(FILENAME)_v$(VERSION).docx
odt: $(FILENAME)_v$(VERSION).odt



%.pdf: $(FILENAME).md $(FILENAME).bib
	pandoc $< $(PANDOC_FLAGS) $(PANDOC_PDF_FLAGS) -o $@

%.html: $(FILENAME).md $(FILENAME).bib
	pandoc $< $(PANDOC_FLAGS) $(PANDOC_HTML_FLAGS) -o $@

%.docx: $(FILENAME).md $(FILENAME).bib
	pandoc $< $(PANDOC_FLAGS) $(PANDOC_DOCX_FLAGS) -o $@

%.odt: $(FILENAME).md $(FILENAME).bib
	pandoc $< $(PANDOC_FLAGS) $(PANDOC_ODT_FLAGS) -o $@



cleanhtml:
	rm $(FILENAME)_v$(VERSION).html

cleanpdf:
	rm $(FILENAME)_v$(VERSION).pdf

cleandocx:
	rm $(FILENAME)_v$(VERSION).docx

cleanodt:
	rm $(FILENAME)_v$(VERSION).odt

clean: cleanhtml cleanpdf cleandocx cleanodt

