# Variables for installation directories
PREFIX ?= /usr/local
PREFIX ?= /tmp/install-test
BINDIR ?= $(PREFIX)/bin
MANDIR ?= $(PREFIX)/share/man
MAN1DIR ?= $(MANDIR)/man1

# Tools to build the docs
HELP2MAN ?= help2man
PANDOC ?= pandoc

# Files to install
SCRIPT = src/gmenu3
MANPAGE = man/gmenu3.1

# Install mode for files and directories
INSTALL_PROG_MODE = 755
INSTALL_DATA_MODE = 644

# Use install command with standard options
INSTALL = install

.PHONY: all all-doc install install-bin install-man uninstall clean

all: all-doc

all-doc: man/gmenu3.1 doc/usage.md

man/gmenu3.1: doc/gmenu3.1.h2m src/gmenu3
	$(HELP2MAN) -N -i $< \
	--name='GTK XDG Application Menu' src/gmenu3 | \
	sed -e 's/ (\(enabled\|disabled\))//' > $@

doc/usage.md: man/gmenu3.1
	@env PANDOC=$(PANDOC) tool/mantomd.sh $< > $@

install: install-bin install-man

install-bin:
	$(INSTALL) -d $(BINDIR)
	$(INSTALL) -m $(INSTALL_PROG_MODE) $(SCRIPT) $(BINDIR)/

install-man:
	$(INSTALL) -d $(MAN1DIR)
	$(INSTALL) -m $(INSTALL_DATA_MODE) $(MANPAGE) $(MAN1DIR)/

uninstall:
	rm -fv $(BINDIR)/gmenu3 $(MAN1DIR)/$(MANPAGE)

clean:
	rm -fv man/gmenu3.1 doc/usage.md

