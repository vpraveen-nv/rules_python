FROM ubuntu:18.04

RUN apt-get update \
    && apt-get install -y curl \
    && curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash \
    && apt-get update \
    && apt-get install -y build-essential clang curl wget unzip python3-distutils python3.6-dev python-dev git git-lfs

# Install bazelisk
RUN curl -L https://github.com/bazelbuild/bazelisk/releases/download/v1.0/bazelisk-linux-amd64 -o /usr/local/bin/bazel \
    && chmod +x /usr/local/bin/bazel

# Install aws cli
RUN rm /usr/bin/python && ln -s /usr/bin/python3 /usr/bin/python
RUN curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip" \
    && unzip awscli-bundle.zip \
    && ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

WORKDIR /workspace
