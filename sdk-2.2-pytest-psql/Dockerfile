FROM mcr.microsoft.com/dotnet/core/sdk:2.2-stretch

LABEL version="1.0"
LABEL maintainer="Bayo Oyekole <oyebayo@gmail.com>"
LABEL description="Ubuntu image with dotnetcore 2.2, including PyTest and postgres client for integration tests \
 and trx2junit for collecting unit test results"

ENV PATH="${PATH}:~/.dotnet/tools"
RUN apt-get update && \
apt-get install -y python3 python3-simplejson python-requests python-pytest postgresql-client && \
dotnet tool install -g trx2junit && \
apt-get clean autoclean && apt-get autoremove --yes && rm -rf /var/lib/apt/lists/*
