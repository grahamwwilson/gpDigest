#!/bin/sh
#
# Make ntuple for finer grained investigations using makentuple.C
#

WHICH=$1
NAME=Run${WHICH}

# Remove possibly old symbolic link to lumi file and replace with new one
rm lumi.ee.out
ln -s lumi-${NAME}.ee.out lumi.ee.out

root -l -b -q makentuple.C

mv gptuple.root gptuple-${NAME}.root

exit
