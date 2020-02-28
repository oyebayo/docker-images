FROM mcr.microsoft.com/dotnet/core/sdk:3.1-alpine

LABEL version="1.0"
LABEL maintainer="Bayo Oyekole <oyebayo@gmail.com>"
LABEL description="Alpine image with dotnetcore 3.1, including CI build tools: \
 PyTest, postgres client, trx2junit, jq, docker and git"

RUN apk update \
  && apk -Uv add \
    bash \
    curl \
    docker-cli \
    git \
    gzip \
    jq \
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
  && rm /var/cache/apk/* \
  && dotnet tool install -g trx2junit

RUN curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/aws-iam-authenticator \
  && chmod +x ./aws-iam-authenticator \
  && mv ./aws-iam-authenticator /usr/local/bin

ENV PATH="/root/.local/bin:${PATH}"

