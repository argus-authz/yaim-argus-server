#############################################################################
# Copyright (c) Members of the EGEE Collaboration. 2006-2010.
# See http://www.eu-egee.org/partners/ for details on the copyright holders.
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#############################################################################

name=yaim-argus_server
spec_file=fedora/$(name).spec
version=$(shell grep "Version:" $(spec_file) | sed -e "s/Version://g" -e "s/[ \t]*//g")
release=1
arch=noarch
rpmbuild_dir=$(shell pwd)/rpmbuild
stage_dir=$(shell pwd)/stage

# glite prefix and name
prefix=/opt/glite
glite_name=glite-yaim-argus-server

.PHONY: dist install clean rpm

all: install

dist:
	@echo "Packaging sources"
	rm -fr $(name)-$(version)
	mkdir $(name)-$(version)
	cp -r src $(name)-$(version)
	cp Makefile $(name)-$(version)
	cp COPYRIGHT LICENSE README.md CHANGELOG $(name)-$(version)
	test ! -f $(name)-$(version).tar.gz || rm $(name)-$(version).tar.gz
	tar -czf $(name)-$(version).tar.gz $(name)-$(version)
	rm -fr $(name)-$(version)

clean:
	@echo "Cleaning..."
	rm -fr $(name)-$(version) *.tar.gz rpmbuild RPMS tgz

install: 
	@echo "Installing $(glite_name) $(version)-$(release) in $(DESTDIR)$(prefix)..."
	install -d $(DESTDIR)$(prefix)/yaim/etc/versions
	@echo "$(glite_name) $(version)-$(release)" > $(glite_name)
	install -m 0644 $(glite_name) $(DESTDIR)$(prefix)/yaim/etc/versions
	install -d $(DESTDIR)$(prefix)/yaim/functions
	install -m 0644 src/functions/config* $(DESTDIR)$(prefix)/yaim/functions
	install -d $(DESTDIR)$(prefix)/yaim/node-info.d
	install -m 0644 src/node-info.d/glite-* $(DESTDIR)$(prefix)/yaim/node-info.d
	install -d $(DESTDIR)$(prefix)/yaim/defaults
	install -m 0644 src/defaults/glite-* $(DESTDIR)$(prefix)/yaim/defaults
	install -d $(DESTDIR)${prefix}/yaim/examples/siteinfo/services
	install -m 0644 src/services/glite-* $(DESTDIR)${prefix}/yaim/examples/siteinfo/services

rpm: dist
	@echo "Building RPM in $(rpmbuild_dir)"
	mv -v $(name)-$(version).tar.gz $(name)-$(version).src.tar.gz
	mkdir -p $(rpmbuild_dir)/BUILD $(rpmbuild_dir)/RPMS $(rpmbuild_dir)/SOURCES $(rpmbuild_dir)/SPECS $(rpmbuild_dir)/SRPMS
	cp $(name)-$(version).src.tar.gz $(rpmbuild_dir)/SOURCES/$(name)-$(version).tar.gz
	rpmbuild -v -ba $(spec_file) --define "_topdir $(rpmbuild_dir)"

etics: 
	@echo "Publishing RPMs and tarballs"
	mkdir -p RPMS tgz
	test -f $(rpmbuild_dir)/RPMS/$(arch)/$(name)-$(version)-*.$(arch).rpm 
	test -f $(rpmbuild_dir)/SRPMS/$(name)-$(version)-*.src.rpm
	cp -r $(rpmbuild_dir)/RPMS/* $(rpmbuild_dir)/SRPMS/* RPMS
	test -f $(name)-$(version).src.tar.gz && cp -v $(name)-$(version).src.tar.gz tgz
	test ! -f $(name)-$(version).bin.tar.gz || cp -v $(name)-$(version).bin.tar.gz tgz/$(name)-$(version).tar.gz

