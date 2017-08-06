#!/usr/bin/tclsh

set arch "x86_64"
set base "TclCurl-7.22.0_hg20160822"

file mkdir build/BUILD build/RPMS build/SOURCES build/SPECS build/SRPMS
file copy -force $base.tar.gz build/SOURCES
file copy -force tclcurl-types.patch build/SOURCES

set buildit [list rpmbuild --target $arch --define "_topdir [pwd]/build" -bb tclcurl.spec]
exec >@stdout 2>@stderr {*}$buildit

