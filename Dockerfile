FROM geoplex/ci-node-aws

RUN pip install docker-py

ADD drone-plugin-bash /bin/
ENTRYPOINT ["/bin/drone-plugin-bash"]
