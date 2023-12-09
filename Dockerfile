FROM linuxserver/code-server:latest

ENV PYTHON_VERSION=3.9

#USER root

# install core packages
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    sudo \
    wget \
    curl \
    unzip \
    make \
    openjdk-11-jdk \
    build-essential \
    software-properties-common \
    libpq-dev \
    gcc \
    g++ \
    libsasl2-dev \
	  libsasl2-2 \
	  libsasl2-modules-gssapi-mit \
    unixodbc-dev \
    ssh \
    netcat \
    inetutils-ping \
    net-tools \
    vim \
    bash-completion \
    netcat \
    ncdu \
    && rm -rf /var/lib/apt/lists/*

## Install python
RUN apt-get update && apt-get install -y python${PYTHON_VERSION} python${PYTHON_VERSION}-dev

### Install kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin

### Install Helm
ENV HELM_VERSION=v3.10.1
ENV HELM_FILENAME helm-${HELM_VERSION}-linux-amd64.tar.gz
ENV HELM_URL https://get.helm.sh/${HELM_FILENAME}

RUN curl -o /tmp/$HELM_FILENAME ${HELM_URL} \
  && tar -zxvf /tmp/${HELM_FILENAME} -C /tmp \
  && mv /tmp/linux-amd64/helm /bin/helm \
  && rm -rf /tmp

