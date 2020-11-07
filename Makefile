
#PREFIX=/usr/local
PREFIX=/opt/cakeway
DESTDIR=
CONFDIR=/opt/cakeway/etc
DATADIR=/opt/cakeway/var
KEYSDIR=/opt/cakeway/keys

install:
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	#cp cakeway $(DESTDIR)$(PREFIX)/bin
	mkdir -p $(CONFDIR)/etc
	#cp cakeway.default $(CONFDIR)/cakeway
	mkdir -p $(DATADIR)
	mkdir -p $(KEYSDIR)
