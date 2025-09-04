## Build NetExec Binary for ARM64 (aarch64)

Build the `NetExec` binary for ARM using Docker. Change the Python3 version in the Dockerfile if needed.

```bash
# Build Docker image using the dockerfile in your dir
docker build -t netexec-builder-arm64 .

# Create the container and copy the binary out of it
# Macos/Linux
CONTAINER_ID=$(docker create netexec-builder-arm64)
docker cp $CONTAINER_ID:/opt/NetExec/dist/nxc .
docker rm $CONTAINER_ID

# Windows
$container_id = docker create netexec-builder-arm64
docker cp "${container_id}:/opt/NetExec/dist/nxc" .
