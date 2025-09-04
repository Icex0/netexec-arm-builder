## Build NetExec Binary for ARM64 (aarch64)

Build the `NetExec` binary for ARM using Docker. Change the Python3 version in the Dockerfile to the one matching the target env

```bash
# Build Docker image using the dockerfile in your CWD
# MacOS (ARM)
docker build -t netexec-builder-arm64 .

# Linux/Windows (AMD64)
docker build --platform linux/arm64 -t netexec-builder-arm64 .


# Create the container and copy the binary out of it
# MacOS (ARM)
CONTAINER_ID=$(docker create netexec-builder-arm64)
docker cp $CONTAINER_ID:/opt/NetExec/dist/nxc .

# Linux
CONTAINER_ID=$(docker create --platform linux/arm64 netexec-builder-arm64)
docker cp $CONTAINER_ID:/opt/NetExec/dist/nxc .

# Windows
$container_id = docker create --platform linux/arm64 netexec-builder-arm64
docker cp "${container_id}:/opt/NetExec/dist/nxc" .
