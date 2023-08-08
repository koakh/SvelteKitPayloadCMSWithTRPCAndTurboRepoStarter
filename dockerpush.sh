#!/bin/sh

# env vars
DOCKER_REGISTRY_URL="registry.hub.docker.com"
DOCKER_IMAGE_VERSION="1.0.0"
DOCKER_IMAGE_BASE_NAME="koakh/koakh-sveltekit-payloadcms-trpc-turborepo-starter"
IMAGES=(web server)
# leave commented, only uncomment when push arm64 builded images
# PLATFORM="-ARM64"

message="do you wish to build images?"
printf "> $message (Yes/No/Cancel) " >&2
printf "\n"
while [ -z "$result" ] ; do
  read -s -n 1 choice
  case "$choice" in
    y|Y ) result='Y' ;;
    n|N ) result='N' ;;
  esac
done
# echo $result
if [ "$result" == "Y" ]; then
  # build
  docker-compose build
fi

unset result
message="do you wish to login to dockerhub?"
printf "> $message (Yes/No/Cancel) " >&2
printf "\n"
while [ -z "$result" ] ; do
  read -s -n 1 choice
  case "$choice" in
    y|Y ) result='Y' ;;
    n|N ) result='N' ;;
  esac
done
# echo $result
if [ "$result" == "Y" ]; then
  # login
  docker login ${DOCKER_REGISTRY_URL}
fi

for image in "${IMAGES[@]}"
do
  DOCKER_IMAGE_NAME="${DOCKER_IMAGE_BASE_NAME}-${image}${PLATFORM}"
  # tag and push
  docker tag "${DOCKER_IMAGE_NAME}:latest" "${DOCKER_REGISTRY_URL}/${DOCKER_IMAGE_NAME}:latest"
  printf "push : [${DOCKER_REGISTRY_URL}/${DOCKER_IMAGE_NAME}:latest]\n"
  docker push "${DOCKER_IMAGE_NAME}:latest"
  # read -n 1 -s -r -p "Press any key to continue";printf "\n"
  docker tag "${DOCKER_IMAGE_NAME}:latest" "${DOCKER_REGISTRY_URL}/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_VERSION}"
  printf "push : [${DOCKER_REGISTRY_URL}/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_VERSION}]\n"
  docker push "${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_VERSION}"
  # read -n 1 -s -r -p "Press any key to continue";printf "\n"  
done