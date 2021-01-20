from ubuntu:20.04

# This Dockerfile defines the GITR CI verification step.
env DEBIAN_FRONTEND noninteractive



copy entrypoint.sh /entrypoint.sh

entrypoint [ "/entrypoint.sh" ]
