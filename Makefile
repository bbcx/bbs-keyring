V=20160103

PREFIX = /usr/local

install:
	install -dm755 $(DESTDIR)$(PREFIX)/share/pacman/keyrings/
	install -m0644 bbs{.gpg,-trusted,-revoked} $(DESTDIR)$(PREFIX)/share/pacman/keyrings/

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/share/pacman/keyrings/bbs{.gpg,-trusted,-revoked}
	rmdir -p --ignore-fail-on-non-empty $(DESTDIR)$(PREFIX)/share/pacman/keyrings/

dist:
	git archive --format=tar --prefix=bbs-keyring-$(V)/ $(V) | gzip -9 > bbs-keyring-$(V).tar.gz
	gpg --detach-sign --use-agent bbs-keyring-$(V).tar.gz

#upload:
#	s3cmd put -P bbs-keyring-$(V).tar.gz s3://arch-linux-ami/packages/bbs-keyring/
#	s3cmd put -P bbs-keyring-$(V).tar.gz.sig s3://arch-linux-ami/packages/bbs-keyring/

.PHONY: install uninstall dist upload
