FROM jenkins:2.19.4
RUN /usr/local/bin/install-plugins.sh kubernetes:0.10 workflow-aggregator:2.4 credentials-binding:1.10 git:3.0.1 gitlab:1.4.5 docker-build-publish:1.3.2 \
    && mkdir -p /usr/share/jenkins/ref/secrets/ \
    && echo "false" > /usr/share/jenkins/ref/secrets/slave-to-master-security-kill-switch

