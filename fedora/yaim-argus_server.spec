Name: yaim-argus_server

Version: 1.5.1
Release: 1%{?dist}

Summary: Yaim ARGUS_server config

License: ASL 2.0
Group: System Environment/Libraries
URL: 

Source: %{name}-%{version}.tar.gz
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
BuildArch: noarch

Requires: glite-yaim-core
Requires: glite-info-provider-service
Requires: glite-yaim-bdii

%description
yaim configuration for the ARGUS_server nodetype (EMI)


%prep
%setup -q


%build


%install
rm -rf $RPM_BUILD_ROOT
make DESTDIR=$RPM_BUILD_ROOT install


%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root,-)
%dir /opt/glite/yaim/etc/versions/
/opt/glite/yaim/etc/versions/glite-yaim-argus-server

%dir /opt/glite/yaim/examples/siteinfo/services/
/opt/glite/yaim/examples/siteinfo/services/glite-argus_server

%dir /opt/glite/yaim/node-info.d/
/opt/glite/yaim/node-info.d/glite-argus_server

%dir /opt/glite/yaim/functions/
/opt/glite/yaim/functions/config_info_glue2_service_argus
/opt/glite/yaim/functions/config_pep_service
/opt/glite/yaim/functions/config_pdp_service
/opt/glite/yaim/functions/config_pap_service

%dir /opt/glite/yaim/defaults/
/opt/glite/yaim/defaults/glite-argus_server.post
/opt/glite/yaim/defaults/glite-argus_server.pre

%changelog
* Tue Apr 3 2012 Valery Tschopp <valery.tschopp@switch.ch> 1.5.1-1
- Initial yaim ARGUS_server config for EMI 2.



