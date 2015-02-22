FROM businessoptics/ubuntu:precise
MAINTAINER Jason Brownbridge <jason@businessoptics.biz>

# Install python and build tools
# Create directory /usr/src/app for application
RUN \  
  apt-get -y --no-install-recommends install \
    build-essential \
    git \
    python2.7 \
    python2.7-dev \
    python-distribute \
    python-pip && \
  mkdir -p /usr/src/app && \
  pip install distribute && \
  pip install pip

# Lazy install of required packages and python libraries
WORKDIR /usr/src/app
# Copy git files to application directory
ONBUILD COPY . /usr/src/app
# Lazily install packages and python libraries
ONBUILD RUN \
  if [ -e packages.txt ] ; then \
    DEBIAN_FRONTEND=noninteractive \
    while read p; do \
      apt-get -y --no-install-recommends install $p \
    done < packages.txt \
  fi && \
  if [ -e requirements.txt ] ; then \
    while read r; do \
      pip install $r \
    done < requirements.txt \
  fi
