#Recuperation de limage wildfly
FROM quay.io/wildfly/wildfly:26.1.1.Final

#Variables d'environnement
ENV DEPLOYMENT_DIR /opt/jboss/wildfly/standalone/deployments/

#Creation des identifiants admin dans wildfly
RUN /opt/jboss/wildfly/bin/add-user.sh admin azerty123!! --silent

#create folders
ADD jdbc /opt/jdbc
ADD config /opt/config

#add rights 
USER root
RUN chmod +x /opt/config/execute.sh
USER jboss

#add jdbc and datasource
RUN /opt/config/execute.sh commands.cli

#Cleanup
RUN rm -rf /opt/jboss/wildfly/standalone/configuration/standalone_xml_history

#Deploy api
COPY target/movieapi.war $DEPLOYMENT_DIR


#Lancement du server
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0", "-c", "standalone.xml"]
