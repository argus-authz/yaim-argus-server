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

name=glite-yaim-argus-server

version=1.6.0
release=1

# glite prefix and name
prefix=/opt/glite

tmp_dir=$(CURDIR)/tmp

all: 
	@echo "Nothing to compile ;)"
	@echo "make DESTDIR=<destdir> install"

clean:
	rm -rf $(tmp_dir) *.tar.gz 

dist:
	@echo "Packaging sources"
	test ! -d $(tmp_dir) || rm -fr $(tmp_dir)
	mkdir -p $(tmp_dir)/$(name)-$(version)
	cp Makefile $(tmp_dir)/$(name)-$(version)
	cp COPYRIGHT LICENSE README.md CHANGELOG $(tmp_dir)/$(name)-$(version)
	cp -r src $(tmp_dir)/$(name)-$(version)
	test ! -f $(name)-$(version).tar.gz || rm $(name)-$(version).tar.gz
	tar -C $(tmp_dir) -czf $(name)-$(version).tar.gz $(name)-$(version)
	rm -fr $(tmp_dir)


install: 
	@echo "Installing $(glite_name) $(version)-$(release) in $(DESTDIR)$(prefix)..."
	install -d $(DESTDIR)$(prefix)/yaim/etc/versions
	echo "$(name) $(version)-$(release)" > $(name)
	install -m 0644 $(name) $(DESTDIR)$(prefix)/yaim/etc/versions
	install -d $(DESTDIR)$(prefix)/yaim/functions
	install -m 0644 src/functions/config* $(DESTDIR)$(prefix)/yaim/functions
	install -d $(DESTDIR)$(prefix)/yaim/node-info.d
	install -m 0644 src/node-info.d/glite-* $(DESTDIR)$(prefix)/yaim/node-info.d
	install -d $(DESTDIR)$(prefix)/yaim/defaults
	install -m 0644 src/defaults/glite-* $(DESTDIR)$(prefix)/yaim/defaults
	install -d $(DESTDIR)${prefix}/yaim/examples/siteinfo/services
	install -m 0644 src/services/glite-* $(DESTDIR)${prefix}/yaim/examples/siteinfo/services

