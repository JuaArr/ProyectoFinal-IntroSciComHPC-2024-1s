# Based on https://github.com/iluvatar1/IntroSciCompHPC-2024-1s/tree/master

FROM python:3.11-slim
    LABEL maintainer="Juan Arroyo <julopezar@unal.edu.co>"
#ARG CACHEBUST=0 # reset cache at this point, change to 1 to reset cache

# Install packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gcc \
    g++ \
    libffi-dev \
    gdb \
    make \
    cmake \
    clang \
    libeigen3-dev \
    bat \
    neovim \
    gnuplot-nox \
    git \
    htop \
    curl \
    unzip \
    sudo \
    gnupg \
    tmux \
    cpplint \
    xfonts-100dpi \
    ddd \
    valgrind \
    libspdlog-dev \
    parallel \
    time \
    gawk \
    sed \
    coreutils \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# install the notebook package
RUN pip install --upgrade pip && \
    pip install notebook jupyterlab

# Copy only the requirements file first
COPY requirements.txt .

# Install extra Python packages
RUN python3 -m pip install -r requirements.txt

# Install catch2
RUN git clone https://github.com/catchorg/Catch2.git
RUN cd Catch2 && \
    cmake -Bbuild -H. -DBUILD_TESTING=OFF && \
    sudo cmake --build build/ --target install --parallel $(nproc)

# Install fmt
RUN git clone https://github.com/fmtlib/fmt.git
RUN cd fmt && \
    cmake -Bbuild -H. -DBUILD_SHARED_LIBS=TRUE -DFMT_TEST=OFF && \
    sudo cmake --build build/ --target install --parallel $(nproc)

# Install starship to show git branch in prompt plus some other stuff
RUN curl -fsSL https://starship.rs/install.sh | sh -s -- -y

# Install OpenFOAM v. 2312 from source https://develop.openfoam.com/Development/openfoam/-/wikis/precompiled
RUN curl https://dl.openfoam.com/add-debian-repo.sh | sudo bash
RUN sudo apt-get update && \
    sudo apt-get install -y --no-install-recommends openfoam2312-default

# Fix timezone
ENV TZ=America/Bogota
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Set the SHELL environment variable to /bin/bash
ENV SHELL=/bin/bash

# create user with a home directory
ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --shell /bin/bash \
    --uid ${NB_UID} \
    ${NB_USER}

# Copy the rest of the files
COPY . ${HOME}

# Set ownership of files
USER root
RUN chown -R ${NB_UID} ${HOME}

USER ${USER}
WORKDIR ${HOME}

# Run matplotlib config to generate the font cache
RUN MPLBACKEND=Agg python3 -c "import matplotlib.pyplot"
# Setup starship
RUN echo 'eval "$(starship init bash)"' >> ${HOME}/.bashrc

# Fix permissions on .local
USER root
RUN mkdir ${HOME}/.local && \
    chown -R ${NB_UID} ${HOME}/.local
USER ${USER}

## NOTES for Installing perf : for ubuntu you must use
# USER root
# RUN sudo apt-get update && \
#     sudo apt-get install -y linux-tools-common linux-tools-generic linux-tools-$(uname -r) && \
#     sudo apt-get clean && \
#     sudo rm -rf /var/lib/apt/lists/*
## For debian:
# RUN apt-get update && apt-get -y install linux-perf
# USER ${USER}
