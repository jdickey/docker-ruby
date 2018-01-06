#!/bin/bash
cd 2.4 && source ./build.sh && cd ..
cd 2.5.0 && source ./build.sh && cd ..
docker image ls jdickey/ruby --format '{{.ID}}\t {{.Repository}}:{{.Tag}' | sort
