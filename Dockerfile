from ubuntu:20.04

# This Dockerfile defines the GITR CI verification step.
env DEBIAN_FRONTEND noninteractive

run [ "bash", "-c", \
       "apt-get update && \
        apt-get install -y mpich && \
        apt-get install -y libhdf5-dev && \
        apt-get install -y cmake && \
        apt-get install -y git && \
        apt-get install -y g++ && \
        apt-get install -y m4 " ]

# clone
run --mount=type=ssh git clone git@github.com:hyperrealm/libconfig.git

# build - this uses the newest version, not the one tested
 run ["bash", "-c", \
      " \
      pushd libconfig && \
      mkdir build && \
      pushd build && \
      cmake .. && make && make install" ]

# clone
run --mount=type=ssh git clone git@github.com:Unidata/netcdf-c.git

# build
 run ["bash", "-c", \
      " \
      pushd netcdf-c && \
      mkdir build && \
      pushd build && \
      cmake -DENABLE_DAP=OFF .. && make && make install" ]

# clone
run --mount=type=ssh git clone git@github.com:Unidata/netcdf-cxx4.git

# build
 run ["bash", "-c", \
      " \
      pushd netcdf-cxx4 && \
      mkdir build && \
      pushd build && \
      cmake .. && make && make install"]

# clone - no build necessary
run --mount=type=ssh git clone git@github.com:NVIDIA/thrust.git


copy entrypoint.sh /entrypoint.sh

#entrypoint [ "/entrypoint.sh" ]
