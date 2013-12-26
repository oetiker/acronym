SHELL = /bin/sh
VERS = 1.38
PACK=acronym

tar:	
	[ `grep $(VERS) acronym.dtx |wc -l` -ge 2 ] || false
	ln -s . $(PACK)-$(VERS)
	latex acronym.ins
	pdflatex acronym.dtx
	tar -zcvf $(PACK)-$(VERS).tar.gz `awk '{print "$(PACK)-$(VERS)/"$$1}' MANIFEST`
	rm $(PACK)-$(VERS)

tds:
	-rm -f acronym.tds.zip
	mkdir -p doc/latex/acronym source/latex/acronym tex/latex/acronym
	cp acronym.pdf README acrotest.tex doc/latex/acronym
	cp acronym.sty tex/latex/acronym
	cp acronym.ins source/latex/acronym
	cp acronym.dtx source/latex/acronym
	zip -r acronym.tds.zip doc source tex
	rm -rf doc source tex

dist:	tar tds
	lftp -e 'cd incoming;mkdir $(PACK)-$(VERS);cd $(PACK)-$(VERS);mput $(PACK)-$(VERS).tar.gz $(PACK).tds.zip;quit' ftp.tex.ac.uk
	(echo -e "Robin,\n\nI have uploaded $(PACK)-$(VERS) to ftp.tex.ac.uk:/incoming/$(PACK)-$(VERS).\n\nThanks and cheers\ntobi\n\n\nRecent Changes:\n---------------------------------------------------";head -20 CHANGES;echo "...\n-------------------------------------------------\n\n--";fortune -s shakes goethe) | mailx -s "$(PACK)-$(VERS) uploaded" ctan@dante.de,tobi@oetiker.ch

clean:
	rm -rf texbuild pdfbuild
