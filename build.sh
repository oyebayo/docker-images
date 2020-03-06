#!/bin/bash
tag=$1
docker build -t oyekoleb/sdk-3.1-nfv-ci-tools:$tag -f sdk-3.1-nfv-ci-tools/Dockerfile .
docker push oyekoleb/sdk-3.1-nfv-ci-tools:$tag
