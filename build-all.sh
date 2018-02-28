#!/bin/bash
for i in 2.4.2 2.4.3 2.5.0; do
  cd $i && source ./build.sh && cd ..
done
ALL_IMAGES=`docker image ls jdickey/ruby --format '{{.ID}}\t {{.Repository}}:{{.Tag}}' | sort`
echo $ALL_IMAGES
echo
echo "There are `echo $ALL_IMAGES | wc -l` images"
