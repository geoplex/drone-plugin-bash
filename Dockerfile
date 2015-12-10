FROM ubuntu:14.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
	curl ca-certificates
ADD drone-plugin-bash /bin/
ENTRYPOINT ["/bin/drone-plugin-bash"]
