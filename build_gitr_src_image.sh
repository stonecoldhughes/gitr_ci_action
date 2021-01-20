DOCKER_BUILDKIT=1 docker build --file Dockerfile --network host --tag test_image --ssh default=/home/5n4/.ssh/key.priv .
