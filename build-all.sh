#!/bin/bash
cd 2.4 && source ./build.sh && cd ..
cd 2.5.0 && source ./build.sh && cd ..
ALL_IMAGES=`docker image ls jdickey/ruby --format '{{.ID}}\t {{.Repository}}:{{.Tag}' | sort`
echo $ALL_IMAGES
echo
echo "There are `echo $ALL_IMAGES | wc -l` images"
