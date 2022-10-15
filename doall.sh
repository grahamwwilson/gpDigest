#!/bin/sh

WHICH=$1
NAME=Run${WHICH}

# Remove possibly old symbolic link to lumi file and replace with new one
rm lumi.ee.out
ln -s lumi-${NAME}.ee.out lumi.ee.out

./redo.sh 0
#mv gplumi.hbook gplumi-${NAME}.hbook
./postprocess.sh ${NAME}

./redo.sh 1
#mv gplumi.hbook gplumi-${NAME}-pluszv.hbook
./postprocess.sh ${NAME}-pluszv

./redo.sh 2
#mv gplumi.hbook gplumi-${NAME}-minuszv.hbook
./postprocess.sh ${NAME}-minuszv

./redo.sh 3
#mv gplumi.hbook gplumi-${NAME}-bigzv.hbook
./postprocess.sh ${NAME}-bigzv

./redo.sh 4
#mv gplumi.hbook gplumi-${NAME}-smallzv.hbook
./postprocess.sh ${NAME}-smallzv

exit
