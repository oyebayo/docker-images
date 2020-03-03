FROM docker:18.06.0-ce-git

LABEL version="1.0"
LABEL maintainer="Bayo Oyekole <oyebayo@gmail.com>"
LABEL description="Docker CE image with git, GNU bash & AWS CLI for pushing to ECR repos"

ENV PATH="~/.local/bin:${PATH}"
RUN apk update && apk upgrade && \
apk -Uuv add bash curl wget python3 py-pip && \
pip3 install --upgrade pip && \
pip3 install awscli --upgrade && \
apk --purge -v del py-pip && \
rm /var/cache/apk/*

ADD scripts/* /usr/local/bin/
RUN chmod +x /usr/local/bin/*
