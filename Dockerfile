FROM jenkins

ENV FLYWAY_VERSION 4.0.3 
ENV FLYWAY_DOWNLOAD_URL https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/$FLYWAY_VERSION/flyway-commandline-$FLYWAY_VERSION.tar.gz
USER root

RUN apt-get update

# Install Flyway (Non JRE version)
RUN wget -c -O /tmp/flyway.tar.gz $FLYWAY_DOWNLOAD_URL && \
    tar -xf /tmp/flyway.tar.gz -C /opt && \
    chmod 0755 /opt/flyway-$FLYWAY_VERSION/flyway && \
    ln -s /opt/flyway-$FLYWAY_VERSION/flyway /usr/local/bin/flyway && \
    rm /tmp/flyway.tar.gz

# Update flyway.conf
COPY flyway.conf /opt/flyway-"$FLYWAY_VERSION"/conf/flyway.conf
    
USER jenkins