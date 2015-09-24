FROM ubuntu:14.04

RUN export DEBIAN_FRONTEND=noninteractive && \
	MQ_URL=http://public.dhe.ibm.com/ibmdl/export/pub/software/websphere/messaging/mqadv/mqadv_dev80_linux_x86-64.tar.gz  && \
	MQ_PACKAGES="MQSeriesRuntime-*.rpm MQSeriesServer-*.rpm MQSeriesJava*.rpm MQSeriesJRE*.rpm MQSeriesGSKit*.rpm MQSeriesSamples-*.rpm" && \
	echo "mq:8.0" > /etc/debian_chroot && \
	apt-get update -y && \
	apt-get install -y curl tar bash rpm bc && \
	mkdir -p /tmp/mq && \
	cd /tmp/mq && \
	curl -LO $MQ_URL && \
	tar -zxvf ./*.tar.gz && \
	groupadd --gid 1414 mqm && \
	useradd --uid 1414 --gid mqm --home-dir /var/mqm mqm && \
	usermod -G mqm root && \
	cd /tmp/mq/server && \
	./mqlicense.sh -text_only -accept && \
	rpm -ivh --force-debian $MQ_PACKAGES && \
	rm -rf /tmp/mq && \
	# Bypass defect in the "mqconfig" script
	sed -i -e "s;CheckShellDefaultOptions$;#CheckShellDefaultOptions;g" /opt/mqm/bin/mqconfig

COPY *.sh /usr/local/bin/
COPY listener.mqsc /etc/mqm/
COPY config.mqsc /etc/mqm/

RUN useradd ibmuser -G mqm && \
	echo ibmuser:passw0rd | chpasswd
COPY keystore/key.* /tmp/

# Make sure the MQ environment is available for "docker exec" under non-interactive Bash
ENV BASH_ENV=/usr/local/bin/mq-env.sh

# Support the latest functional cmdlevel by default
ENV MQ_QMGR_CMDLEVEL=801

RUN chmod +x /usr/local/bin/*.sh

EXPOSE 1414

VOLUME /var/mqm

ENTRYPOINT ["mq.sh"]
