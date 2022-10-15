#!/bin/sh
#
# postprocess.sh
#

SUFFIX=$1
echo 'SUFFIX: '${SUFFIX}

h2root gplumi.hbook
rm gplumi.hbook
mv gplumi.root gplumi-${SUFFIX}.root

exit
