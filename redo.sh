#!/bin/sh

VERSION=$1
echo 'VERSION set to '${VERSION}
rm imode.f
ln -s imode${VERSION}.f imode.f
cat imode.f

# Recompile
./cl.sh

# Run executable
./digest

exit
