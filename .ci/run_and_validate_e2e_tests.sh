set -euo pipefail
SCRIPT_DIRPATH="$(cd "$(dirname "${0}")" && pwd)"
ROOT_DIRPATH="$(dirname "${SCRIPT_DIRPATH}")"

DOCKER_REPO="964377072876.dkr.ecr.us-east-1.amazonaws.com"

# login to AWS for byzantine images
aws ecr get-login-password --region "${AWS_DEFAULT_REGION}" | docker login --username AWS --password-stdin "${DOCKER_REPO}"

DEFAULT_CONTROLLER_TAG="kurtosistech/ava-e2e-tests_controller"   # TODO This is hardcoded in the full_rebuild_and_run.sh script - this should be parameterized!!!!
GECKO_IMAGE="${DOCKER_REPO}/gecko-internal:latest"
BYZANTINE_IMAGE="${DOCKER_REPO}/gecko-byzantine:latest"

# Kurtosis will try to pull Docker images, but as of 2020-08-09 it doesn't currently support pulling from Docker repos that require authentication
#  so we have to do the pull here
docker pull "${BYZANTINE_IMAGE}"
docker pull "${GECKO_IMAGE}"

E2E_TEST_COMMAND="${ROOT_DIRPATH}/scripts/full_rebuild_and_run.sh"
BYZANTINE_IMAGE_ARG="--byzantine-image-name=${BYZANTINE_IMAGE}"
GECKO_IMAGE_ARG="--gecko-image-name=${GECKO_IMAGE}"
return_code=0
if ! bash "${E2E_TEST_COMMAND}" "${BYZANTINE_IMAGE_ARG}" "${GECKO_IMAGE_ARG}"; then
    echo "Ava E2E tests failed"
    return_code=1
else
    echo "Ava E2E tests succeeded"
    return_code=0
fi

# Clear containers.
echo "Clearing Ava Docker containers..."
docker rm $(docker stop $(docker ps -a -q --filter ancestor="${GECKO_IMAGE}" --format="{{.ID}}")) >/dev/null
docker rm $(docker stop $(docker ps -a -q --filter ancestor="${BYZANTINE_IMAGE}" --format="{{.ID}}")) >/dev/null
docker rm $(docker stop $(docker ps -a -q --filter ancestor="${DEFAULT_CONTROLLER_TAG}" --format="{{.ID}}")) >/dev/null
echo "Ava Docker containers cleared successfully"

exit "${return_code}"
