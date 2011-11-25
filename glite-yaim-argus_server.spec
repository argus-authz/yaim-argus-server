%define topdir %(pwd)/rpmbuild
%define _topdir %{topdir} 
Summary: glite-yaim-argus-server module configures the ARGUS Authorization service. 
Name: glite-yaim-argus-server
Version:   
Vendor: EGEE
Release:   
License: Apache License 2.0
Group: EGEE
Source: %{name}.src.tgz
BuildArch: noarch
Prefix: /opt/glite
Requires: glite-yaim-core
BuildRoot: %{_tmppath}/%{name}-%{version}-build
Packager: EGEE

%description
This package contains the yaim functions necessary to configure the ARGUS Authorization service. 

%prep

%setup -c

%build
make install prefix=%{buildroot}%{prefix}

%files
%defattr(-,root,root)
%{prefix}/yaim/functions/config_*
%config(noreplace) %{prefix}/yaim/node-info.d/glite-*
%{prefix}/yaim/defaults/glite-*
%doc LICENSE
%{prefix}/yaim/etc/versions/%{name}
%{prefix}/yaim/examples/siteinfo/services/glite-*



%clean
rm -rf %{buildroot}

