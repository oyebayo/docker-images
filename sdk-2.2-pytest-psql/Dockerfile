FROM mcr.microsoft.com/dotnet/core/sdk:2.2-alpine

LABEL version="1.6"
LABEL maintainer="Bayo Oyekole <oyebayo@gmail.com>"
LABEL description="Ubuntu image with dotnetcore 2.2, including PyTest and postgres client for integration tests \
 and trx2junit for collecting unit test results"

RUN apk update && apk upgrade && \
apk -Uv add bash jq git curl openssh-client tar gzip python3 py3-simplejson py3-requests py3-pytest postgresql-client && \
rm /var/cache/apk/*
