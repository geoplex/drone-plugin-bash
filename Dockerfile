FROM ubuntu:14.04
ADD drone-plugin-bash /bin/
ENTRYPOINT ["/bin/drone-plugin-bash"]
