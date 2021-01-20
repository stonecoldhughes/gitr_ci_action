from ubuntu:20.04

# This Dockerfile defines the GITR CI verification step.
env DEBIAN_FRONTEND noninteractive

run [ "bash", "-c", \
       "apt-get update && \
        apt-get install -y mpich && \
        apt-get install -y libhdf5-dev && \
        apt-get install -y cmake && \
        apt-get install -y m4 " ]

copy entrypoint.sh /entrypoint.sh

entrypoint [ "/entrypoint.sh" ]
