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
Architecture: all
Depends: \${misc:Depends}
Description: sinit is a suckless init, initially based on Rich Felker’s minimal init.
 .
 sinit is considered complete and no further development is expected to happen.
 "
DEBFOLDERNAME="../$DEBFOLDER-$DEBVERSION"

cd $DEBFOLDER

# Create your scripts source dir

# Copy your script to the source dir
cp $SOURCEBINPATH/ $DEBFOLDERNAME -r
cd $DEBFOLDERNAME

# Create the packaging skeleton (debian/*)
dh_make -s --indep --createorig
echo "$CONTROL_FILE" > debian/control

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
