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
  pip install -U distribute && \
  pip install -U pip

# Lazy install of required packages and python libraries
WORKDIR /usr/src/app
COPY install_requirements.sh .
# Copy git files to application directory
ONBUILD COPY . /usr/src/app
# Lazily install packages and python libraries
ONBUILD RUN /usr/src/app/install_requirements.sh
