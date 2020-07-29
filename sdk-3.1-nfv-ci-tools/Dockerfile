FROM mcr.microsoft.com/dotnet/core/sdk:3.1-alpine

LABEL version="2.0"
LABEL maintainer="Bayo Oyekole <oyebayo.oyekole@t.com>"
LABEL description="Alpine image with dotnetcore 3.1, including CI build & versioning tools: \
 PyTest, semver, postgres client, jq, docker and git"

RUN apk update \
  && apk -Uv add \
    bash \
    curl \
    docker-cli \
    git \
    gzip \
    jq \
    openjdk11-jre \
    openssh-client \
    postgresql-client \
    python3 \
    py3-pip \
    py3-simplejson \
    py3-requests \
    py3-pytest \
    tar \
    wget \
  && pip3 install --upgrade pip \
  && pip3 install awscli --upgrade \
  && apk --purge -v del py3-pip \
  && rm /var/cache/apk/*
  
RUN dotnet tool install -g Amazon.Lambda.Tools \
  && dotnet tool install --global dotnet-sonarscanner \
  && dotnet tool install --global coverlet.console

RUN VERSION=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt) \
  && curl -L https://storage.googleapis.com/kubernetes-release/release/${VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
  && chmod +x /usr/local/bin/kubectl

RUN SEMVER_VERSION=3.0.0 \
  && curl -L https://github.com/fsaintjacques/semver-tool/archive/$SEMVER_VERSION.tar.gz -o semver-$SEMVER_VERSION.tar.gz \
  && tar -zxf semver-$SEMVER_VERSION.tar.gz \
  && chmod +x ./semver-tool-$SEMVER_VERSION/src/semver \
  && mv ./semver-tool-$SEMVER_VERSION/src/semver /usr/local/bin/semver.sh \
  && rm -rf ./semver-tool-$SEMVER_VERSION

ENV PATH="/root/.local/bin:${PATH}"

