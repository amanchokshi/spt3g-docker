FROM ubuntu:focal

MAINTAINER Aman Chokshi <achokshi@student.unimelb.edu.au>

ENV GCC_VERSION=10 \
    CC=/usr/bin/gcc \
    CXX=/usr/bin/g++ \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    CMAKE_VERSION_FULL=3.18.2 \
    DEBIAN_FRONTEND=noninteractive

# Install build dependancies
# RUN apt-get -qq update && apt -y install software-properties-common \
#     && add-apt-repository ppa:ubuntu-toolchain-r/test && apt-get -qq update \
#     && apt-get -qq install -y --no-install-recommends --no-install-suggests \
#         binutils \
#         wget \
#         curl \
#         git \
#         tini \
#         nginx \
#         cmake \
#         run-one \
#         locales \
#         libc6-dev \
#         g++-${GCC_VERSION} \
#         libgmp-dev \
#         libmpfr-dev \
#         libmpc-dev \
#         gfortran-8 \
#         libffi-dev \
#         libssl-dev \
#         pkg-config \
#         subversion \
#         zlib1g-dev \
#         libbz2-dev \
#         libsqlite3-dev \
#         libreadline-dev \
#         libhdf5-dev \
#         python3-pip \
#         libgsl0-dev \
#         libflac-dev \
#         libfftw3-dev \
#         libnetcdf-dev \
#         build-essential \
#         libboost-all-dev \
#         libgdbm-dev \
#         libnss3-dev \
#         xz-utils \
#         libncurses5-dev \
#         libncursesw5-dev \
#         liblzma-dev \
#         fonts-liberation \
#         ca-certificates \
#         autoconf-archive \
#     && ln -s /usr/bin/gfortran-8 /usr/bin/gfortran \
#     && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-${GCC_VERSION} 100 \
#     && update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++-${GCC_VERSION} 100 \
#     && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-${GCC_VERSION} 100 \
#     && update-alternatives --install /usr/bin/cc cc /usr/bin/gcc-${GCC_VERSION} 100 \
#     && ln -s /usr/include/locale.h /usr/include/xlocale.h \
#     && rm -rf /var/lib/apt/lists/* && ln -s /usr/bin/python3.8 /usr/bin/python \
#     && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
#     && locale-gen

# RUN apt-get -qq update && apt -y install software-properties-common \
    # && add-apt-repository ppa:ubuntu-toolchain-r/test && apt-get -qq update \
RUN apt-get update \
    && apt-get -qq install -y --no-install-recommends --no-install-suggests \
        build-essential \
        ca-certificates \
        cmake \
        curl \
        g++-8 \
        gcc-8 \
        gfortran-8 \
        git \
        locales \
        libbz2-dev \
        libffi-dev \
        libfftw3-dev \
        libgsl-dev \
        liblzma-dev \
        libncurses5-dev \
        libncursesw5-dev \
        libreadline-dev \
        libsqlite3-dev \
        libssl-dev \
        libboost-all-dev \
        libflac-dev \
        libnetcdf-dev \
        wget \
        xz-utils \
        zlib1g-dev \
    && ln -s /usr/bin/gfortran-8 /usr/bin/gfortran \
    && ln -s /usr/include/locale.h /usr/include/xlocale.h \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen \
    && rm -rf /var/lib/apt/lists/*


## setup unprivileged user
ENV USER spt3g
ENV SPT3G_HOME=/home/$USER
RUN adduser --disabled-password --gecos ${USER} --uid 1000 $USER
USER $USER

# dynamically linked python
RUN curl https://pyenv.run | bash
ENV PYENV_ROOT $SPT3G_HOME/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
RUN PYTHON_CONFIGURE_OPTS="--enable-shared" pyenv install 3.8.3
RUN pyenv global 3.8.3


# Upgrade pip
RUN pip3 install \
        --upgrade \
        --no-cache-dir \
        pip

# Python packages
RUN pip3 install \
        --no-cache-dir \
        astropy==4.3.1 \
        camb==1.3.2 \
        Cython==0.29.24 \
        ephem==4.1 \
        h5py==3.5.0 \
        healpy==1.15.0 \
        IDLSave==1.0.0 \
        ipdb==0.13.9 \
        ipython==7.28.0 \
        joblib==1.1.0 \
        jsonschema==4.1.2 \
        jupyter==1.0.0 \
        jupyterlab==3.2.1 \
        lmfit==1.0.3 \
        matplotlib==3.4.3 \
        memory-profiler==0.58.0 \
        numba==0.54.1 \
        numexpr==2.7.3 \
        numpy==1.20.3 \
        pandas==1.3.4 \
        pyFFTW==0.12.0 \
        pyfits==3.5 \
        pytest==6.2.5 \
        PyYAML==6.0 \
        rst2html5==2.0 \
        scipy==1.7.1 \
        simplejson==3.17.5 \
        skyfield==1.39 \
        spectrum==0.8.0 \
        Sphinx==4.2.0 \
        SQLAlchemy==1.4.26 \
        tables==3.6.1 \
        tornado==6.1 \
        urwid==2.1.2 \
        xhtml2pdf==0.2.5

# Install SPT3G
WORKDIR $SPT3G_HOME
COPY --chown=1000 ./spt3g_software spt3g_software
RUN cd spt3g_software && \
        mkdir build && \
        cd build && \
        cmake .. && \
        make -j 4 && \
        ./env-shell.sh make docs && \
        chown 1000:1000 /var/www && \
        mkdir -p /var/www/html && \
        cp -r ./docs/* /var/www/html

# Set SPT3G environment
RUN echo 'echo "\n##############################################\n"' >> $SPT3G_HOME/.bashrc && \
    echo 'echo "Welcome to the SPT3G Docker Container"' >> $SPT3G_HOME/.bashrc && \
    echo '/root/spt3g_software/build/env-shell.sh' >> $SPT3G_HOME/.bashrc && \
    echo 'export SPT3G_SOFTWARE_PATH=/root/spt3g_software' >> $SPT3G_HOME/.bashrc && \
    echo 'export SPT3G_SOFTWARE_BUILD_PATH=$SPT3G_SOFTWARE_PATH/build' >> $SPT3G_HOME/.bashrc && \
    echo 'export PATH=$SPT3G_SOFTWARE_BUILD_PATH/bin:$PATH' >> $SPT3G_HOME/.bashrc && \
    echo 'export LD_LIBRARY_PATH=$SPT3G_SOFTWARE_BUILD_PATH/bin:$LD_LIBRARY_PATH' >> $SPT3G_HOME/.bashrc && \
    echo 'export PYTHONPATH=$SPT3G_SOFTWARE_BUILD_PATH:$PYTHONPATH' >> $SPT3G_HOME/.bashrc && \
    echo '/usr/sbin/nginx' >> $SPT3G_HOME/.bashrc && \
    echo 'echo "SPT3G Docs Availabel at http://localhost:3141"' >> $SPT3G_HOME/.bashrc && \
    echo 'echo "\n##############################################\n"' >> $SPT3G_HOME/.bashrc && \
    chown 1000:1000 /etc/nginx/sites-enabled/default && sed -i 's/listen 80/listen 3141/g' /etc/nginx/sites-enabled/default

# Expose ports: 3141 - nginx docs, 8888 - jupyter
EXPOSE 3141 8888

# Bash login shell
WORKDIR $SPT3G_HOME
ENTRYPOINT /bin/bash
