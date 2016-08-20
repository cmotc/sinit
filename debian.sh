#! /bin/sh
# Configure your paths and filenames
SOURCEBINPATH=.
SOURCEBIN=sinit
SOURCEDOC=README.md
DEBFOLDER=sinit
DEBVERSION=$(date +%Y%m%d)
CONTROL_FILE="Source: sinit
Section: admin
Priority: optional
Maintainer: Dimitris Papastamos <sin@2f30.org>
Build-Depends: debhelper (>= 9)
Standards-Version: 3.9.5
Homepage: http://core.suckless.org/sinit
Vcs-Git: git://git.suckless.org/sinit
Vcs-Browser: http://git.suckless.org/sinit

Package: sinit
Architecture: any
Depends: \${misc:Depends}
Description: sinit is a suckless init, initially based on Rich Felker’s minimal init.
 sinit is considered complete and no further development is expected to happen. This
 sinit is awesome.
 .
 "
RULE_FILE='#!/usr/bin/make -f
# See debhelper(7) (uncomment to enable)
# output every command that modifies files on the build system.
#DH_VERBOSE = 1

# see EXAMPLES in dpkg-buildflags(1) and read /usr/share/dpkg/*
DPKG_EXPORT_BUILDFLAGS = 1
include /usr/share/dpkg/default.mk

# see FEATURE AREAS in dpkg-buildflags(1)
#export DEB_BUILD_MAINT_OPTIONS = hardening=+all

# see ENVIRONMENT in dpkg-buildflags(1)
# package maintainers to append CFLAGS
#export DEB_CFLAGS_MAINT_APPEND  = -Wall -pedantic
# package maintainers to append LDFLAGS
#export DEB_LDFLAGS_MAINT_APPEND = -Wl,--as-needed


# main packaging script based on dh7 syntax
%:
        dh $@

# debmake generated override targets
# This is example for Cmake (See http://bugs.debian.org/641051 )
#override_dh_auto_configure:
#       dh_auto_configure -- \
#       -DCMAKE_LIBRARY_PATH=$(DEB_HOST_MULTIARCH)

override_dh_strip:
        dh_strip -Xsinit
'

DEBFOLDERNAME="../$DEBFOLDER-$DEBVERSION"

cd $DEBFOLDER

# Create your scripts source dir

# Copy your script to the source dir
cp $SOURCEBINPATH/ $DEBFOLDERNAME -r
cd $DEBFOLDERNAME

# Create the packaging skeleton (debian/*)
dh_make --indep --createorig
echo "$CONTROL_FILE" > debian/control
echo "$RULE_FILE" > debian/rules
# Remove make calls
#grep -v makefile debian/rules > debian/rules.new
#mv debian/rules.new debian/rules

# debian/install must contain the list of scripts to install
# as well as the target directory
#echo $DEBFOLDER usr/bin > debian/install
#echo $SOURCEDOC usr/share/doc/apt-git >> debian/install

# Remove the example files
rm debian/*.ex

# Build the package.
# You  will get a lot of warnings and ../somescripts_0.1-1_i386.deb
debuild -us -uc > ../log
