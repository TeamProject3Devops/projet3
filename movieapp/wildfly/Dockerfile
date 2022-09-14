FROM quay.io/wildfly/wildfly:26.1.1.Final
RUN /opt/jboss/wildfly/bin/add-user.sh movie azerty123!! --silent
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
