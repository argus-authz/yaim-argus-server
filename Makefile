prefix=/opt/glite
package=glite-yaim-argus-server
version:=1.5.1
release:=1

.PHONY: configure install clean rpm

all: install

install: 
	@echo Installing $(package) $(version)-$(release) in $(prefix)...
	@mkdir -p $(prefix)/yaim/functions
	@mkdir -p $(prefix)/yaim/node-info.d
	@mkdir -p $(prefix)/yaim/defaults
	@mkdir -p $(prefix)/yaim/etc/versions
	@mkdir -p ${prefix}/yaim/examples/siteinfo/services

	@echo "$(package) $(version)-$(release)" > $(prefix)/yaim/etc/versions/$(package)

	@install -m 0644 config/functions/config* $(prefix)/yaim/functions
	@install -m 0644 config/node-info.d/glite* $(prefix)/yaim/node-info.d
	@install -m 0644 config/defaults/glite* $(prefix)/yaim/defaults
	@install -m 0644 config/services/glite-* ${prefix}/yaim/examples/siteinfo/services


clean::
	rm -f *~ test/*~ etc/*~ doc/*~ src/*~  
	rm -rf rpmbuild 

rpm:
	@mkdir -p  rpmbuild/RPMS/noarch
	@mkdir -p  rpmbuild/SRPMS/
	@mkdir -p  rpmbuild/SPECS/
	@mkdir -p  rpmbuild/SOURCES/
	@mkdir -p  rpmbuild/BUILD/
	
ifneq ("$(tag)","ame:")
	@sed -i 's/^Version:.*/Version: $(version)/' $(package).spec
	@sed -i 's/^Release:.*/Release: $(release)/' $(package).spec
endif
	@tar --gzip --exclude='*CVS*' -cf rpmbuild/SOURCES/${package}.src.tgz *
	@rpmbuild -ba ${package}.spec


