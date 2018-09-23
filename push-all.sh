#!/bin/bash
echo "Will push all LOCALLY EXISTING jdickey/ruby images to Docker Hub in 5 seconds"
echo "Hit Control-C *NOW* if this is not what you want!"
for i in 5 4 3 2 1; do
  echo -n $i; echo -n '... '
  sleep 1
done
for i in `docker image ls jdickey/ruby --format '{{.ID}} {{.Repository}}:{{.Tag}}' | sort | cut -f 2 -d ' '`; do
  echo "Pushing $i"
  docker push $i
  echo "Done pushing $i"; echo
done
