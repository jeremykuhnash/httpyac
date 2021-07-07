#!/bin/bash
set -e

export CONTAINER_NAME="httpyac"
export GIT_SHA=$(git rev-parse HEAD | cut -c 1-8)
export IMAGE="jeremykuhnash/$CONTAINER_NAME:$GIT_SHA"
export IMAGE_LATEST="jeremykuhnash/$CONTAINER_NAME:latest"

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
THIS_DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
echo "This Dir: $THIS_DIR"

echo "Building httpyac image..."
docker build \
    -t $IMAGE \
    -t $IMAGE_LATEST \
    -f $THIS_DIR/Dockerfile.httpyac \
    .

docker push $IMAGE
docker push $IMAGE_LATEST
