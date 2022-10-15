#!/bin/sh

WHICH=$1
NAME=Run${WHICH}

# Remove possibly old symbolic link to lumi file and replace with new one
rm lumi.ee.out
ln -s lumi-${NAME}.ee.out lumi.ee.out

./redo.sh 0
#mv gplumi.hbook gplumi-${NAME}.hbook
./postprocess.sh ${NAME}

exit
