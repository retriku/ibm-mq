FROM ibmimages/mqadvanced

COPY config.mqsc /etc/mqm/

RUN echo mqm:mqm | chpasswd

RUN useradd ibmuser -G mqm && \
	echo ibmuser:passw0rd | chpasswd