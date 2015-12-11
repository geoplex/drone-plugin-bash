FROM ubuntu:14.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -qq && \
    apt-get install -y \
        curl zip unzip ca-certificates python python-pip \
        bzr git mercurial \
        --no-install-recommends && \
    pip install docker-py

ADD drone-plugin-bash /bin/
ENTRYPOINT ["/bin/drone-plugin-bash"]
