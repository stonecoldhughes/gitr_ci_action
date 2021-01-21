from ubuntu:20.04

# Captain! Experiment with renaming this file to something more descriptive than "Dockerfile"

# This Dockerfile defines the GITR CI verification step.
env DEBIAN_FRONTEND noninteractive

# install system dependencies
run [ "bash", "-c", \
       "apt-get update && \
        apt-get install -y mpich && \
        apt-get install -y libhdf5-dev && \
        apt-get install -y cmake && \
        apt-get install -y git && \
        apt-get install -y g++ && \
        apt-get install -y m4 " ]

# build repo dependencies

# get libconfig dependency
copy [ "external/libconfig", "/libconfig"]

# obtain cached copy of repo
# build & install
run ["bash", "-c", \
      " \
      cd libconfig && \
      mkdir build && \
      pushd build && \
      cmake .. && make && make install" ]


copy [ "external/netcdf-c", "/netcdf-c" ]
# build
 run ["bash", "-c", \
      " \
      cd netcdf-c && \
      mkdir build && \
      pushd build && \
      cmake -DENABLE_DAP=OFF .. && make && make install" ]

copy [ "external/netcdf-cxx4", "/netcdf-cxx4" ]
run ["bash", "-c", \
      " \
      cd netcdf-cxx4 && \
      mkdir build && \
      pushd build && \
      cmake .. && make && make install"]

# header-only library - no build necessary
copy [ "external/thrust", "/thrust" ]

copy entrypoint.sh /entrypoint.sh

# Captain! for now, make this interactive so you can debug it
#entrypoint [ "/entrypoint.sh" ]

# Ahoy, Captain! Test garbage below this line. This is where your file digresses from the Github
# actions file
copy [ "GITR", "/GITR" ]

run [ "bash", "-c", \
      "apt-get update && \
      apt-get install -y \
      tmux \
      vim"]
