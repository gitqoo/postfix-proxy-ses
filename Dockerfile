FROM alpine:3.10

MAINTAINER "qoo"

WORKDIR /qoo

RUN echo "https://mirrors.aliyun.com/alpine/v3.12/main/" >> /etc/apk/repositories
RUN echo "https://mirrors.aliyun.com/alpine/v3.12/community/" >> /etc/apk/repositories
RUN apk update
RUN apk upgrade
RUN apk add --no-cache bash postfix postfix-pcre rsyslog iproute2 curl openssl util-linux vim busybox-extras rsyslog cyrus-sasl-plain

COPY ./sasl_passwd /etc/postfix/
RUN postmap hash:/etc/postfix/sasl_passwd
RUN postconf -e 'smtp_tls_CAfile = /etc/ssl/certs/ca-bundle.crt'
COPY ./qoo.sh /qoo/
RUN chmod +x /qoo/qoo.sh

#RUN echo "set from=qooooo@ms.mogafx.com   smtp="localhost"" > /etc/mail.rc
#RUN rsyslogd
#RUN touch /run/openrc/softlevel

RUN echo "alias ll='ls -l'" > /root/.bashrc

ENV NAME qoo
EXPOSE 25

#CMD ["postfix", "start-fg"]
CMD ["/bin/sh", "-c", "/qoo/qoo.sh"]
#ENTRYPOINT ["/qoo/qoo.sh"]
