FROM apache/nifi:2.0.0-M4

LABEL maintainer="LIneA"

USER root

RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/python3 /usr/bin/python

RUN mkdir /opt/nifi/nifi-current/python_scripts
RUN mkdir /opt/nifi/nifi-current/python_requeriments

COPY nifi/lib /opt/nifi/nifi-current/lib
COPY nifi/python_extensions /opt/nifi/nifi-current/python_extensions
COPY nifi/python_requeriments/requirements.txt /opt/nifi/nifi-current/python_requeriments

RUN pip install --no-cache-dir -r /opt/nifi/nifi-current/python_requeriments/requirements.txt

EXPOSE 8443

CMD ["../scripts/start.sh"]