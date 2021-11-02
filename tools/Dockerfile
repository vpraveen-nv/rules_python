FROM ubuntu:20.04

RUN apt-get update \
    && apt-get install -y curl \
    && curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common build-essential clang curl wget unzip git git-lfs

RUN add-apt-repository ppa:deadsnakes/ppa \
    && apt-get update \
    && apt-get install python3.6 python3.6-dev -y \
    && rm /usr/bin/python3 \
    && ln -s /usr/bin/python3.6 /usr/bin/python3 \
    && ln -s /usr/bin/python3 /usr/bin/python

# Install bazelisk
RUN curl -L https://github.com/bazelbuild/bazelisk/releases/download/v1.0/bazelisk-linux-amd64 -o /usr/local/bin/bazel \
    && chmod +x /usr/local/bin/bazel

# Install aws cli
RUN rm /usr/bin/python && ln -s /usr/bin/python3 /usr/bin/python
RUN curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip" \
    && unzip awscli-bundle.zip \
    && ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

WORKDIR /workspace
