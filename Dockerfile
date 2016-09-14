FROM java:8-jre

ENV JMETER_VERSION 2.13
ENV ES_VERSION 2.3.1
ENV JMETER_PATH /opt/apache-jmeter

# Install Apache JMeter
WORKDIR /opt
RUN wget -O - http://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz | tar xzf - \
&& mv /opt/apache-jmeter-${JMETER_VERSION} ${JMETER_PATH}

# Download the required dependencies
WORKDIR ${JMETER_PATH}/lib
RUN wget https://github.com/rflorenc/Elasticmeter/blob/master/utils/pull_jars.sh && \
./pull_jars.sh $ES_VERSION $JMETER_VERSION

COPY 231elasticsearch.jar ./ext/

# Run jmeter in server mode
WORKDIR ${JMETER_PATH}/bin
CMD ["./jmeter", "-s"]
