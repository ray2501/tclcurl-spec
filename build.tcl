#!/usr/bin/tclsh

set arch "x86_64"
set base "TclCurl-7.22.0_git20210318"

if {[file exists build]} {
    file delete -force build
}

set var [list git clone https://github.com/flightaware/tclcurl-fa.git $base]
exec >@stdout 2>@stderr {*}$var

cd $base
set var2 [list git checkout ed4856901dee2784ceeb6d2ee0d621fe05aa0134]
exec >@stdout 2>@stderr {*}$var2

# Remove git log
file delete -force $base/.git

cd ..
set var2 [list tar czvf ${base}.tar.gz $base]
exec >@stdout 2>@stderr {*}$var2

file mkdir build/BUILD build/RPMS build/SOURCES build/SPECS build/SRPMS
file copy -force $base.tar.gz build/SOURCES
file copy -force tclcurl-types.patch build/SOURCES

set buildit [list rpmbuild --target $arch --define "_topdir [pwd]/build" -bb tclcurl.spec]
exec >@stdout 2>@stderr {*}$buildit

# Remove files
file delete -force $base
file delete -force $base.tar.gz
