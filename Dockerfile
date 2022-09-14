#Recuperation de limage wildfly
FROM quay.io/wildfly/wildfly:26.1.1.Final

#Variables d'environnement
ENV DEPLOYMENT_DIR /opt/jboss/wildfly/standalone/deployments/
ENV JBOSS_CLI /opt/jboss/wildfly/bin/jboss-cli.sh
ENV DB_IP db:3306
ENV DB_NAME dbmovie

#deploiement de lapplication
#ADD target/movieapi.war $DEPLOYMENT_DIR

#Creation des identifiants admin dans wildfly
RUN /opt/jboss/wildfly/bin/add-user.sh admin azerty123!! --silent

#Demarrage du server pour ajouter le driver et le datasource
RUN echo "=> Starting WildFly server" && \
      bash -c '$JBOSS_HOME/bin/standalone.sh &' && \
    echo "=> Waiting for the server to boot" && \
      bash -c 'until `$JBOSS_CLI -c ":read-attribute(name=server-state)" 2> /dev/null | grep -q running`; do echo `$JBOSS_CLI -c ":read-attribute(name=server-state)" 2> /dev/null`; sleep 1; done'

#Ajout du driver
#RUN $JBOSS_CLI --connect --command="deploy target/mariadb-java-client-3.0.7.jar"


#Ajout du datasource
RUN echo "=> Creating a new datasource"
#RUN $JBOSS_CLI --connect --command="data-source add \
#	--name=MovieDSMaria \
#	--jndi-name=java:/movieDS \
#	--user-name=movie \
#	--password=azerty123!! \
#	--driver-name=mariadb-java-client-3.0.7.jar \
#	--connection-url=jdbc:mariadb://${DB_IP}/${DB_NAME} \
#	--use-ccm=false \
#	--max-pool-size=25 \
#	--min-pool-size=5 \
#	--blocking-timeout-wait-millis=5000 \
#	--enabled=true"

#Fermeture du server
RUN $JBOSS_CLI --connect --command=":shutdown"

#acces au port du container cree
EXPOSE 8080 9990

#Lancement du server
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
