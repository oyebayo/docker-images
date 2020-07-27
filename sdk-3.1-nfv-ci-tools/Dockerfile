FROM mcr.microsoft.com/dotnet/core/sdk:3.1-alpine

LABEL version="1.0"
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

RUN curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/aws-iam-authenticator \
  && chmod +x ./aws-iam-authenticator \
  && mv ./aws-iam-authenticator /usr/local/bin
  
RUN VERSION=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt) \
  && curl -L https://storage.googleapis.com/kubernetes-release/release/${VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
  && chmod +x /usr/local/bin/kubectl

RUN curl -L https://github.com/fsaintjacques/semver-tool/archive/3.0.0.tar.gz -o semver-3.0.0.tar.gz \
  && tar -zxf semver-3.0.0.tar.gz \
  && chmod +x ./semver-tool-3.0.0/src/semver \
  && mv ./semver-tool-3.0.0/src/semver /usr/local/bin/semver.sh \
  && rm -rf ./semver-tool-3.0.0

ENV PATH="/root/.local/bin:${PATH}"

