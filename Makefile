SHELL = /bin/sh
VERS = 1.43
PACK=acronym

tar:	tds
	[ `grep $(VERS) acronym.dtx |wc -l` -ge 2 ] || false
	ln -s . $(PACK)-$(VERS)
	latex acronym.ins
	pdflatex acronym.dtx
	tar -zcvf $(PACK)-$(VERS).tar.gz `awk '{print "$(PACK)-$(VERS)/"$$1}' MANIFEST`
	rm $(PACK)-$(VERS)

tds:
	-rm acronym.tds.zip
	mkdir -p doc/latex/acronym source/latex/acronym tex/latex/acronym
	cp acronym.pdf README acrotest.tex doc/latex/acronym
	cp acronym.sty tex/latex/acronym
	cp acronym.ins source/latex/acronym
	cp acronym.dtx source/latex/acronym
	zip -r acronym.tds.zip doc source tex
	rm -r doc source tex

dist:   tar
	gnome-open http://www.ctan.org/pkg/acronym
	
clean:
	rm -rf texbuild pdfbuild
