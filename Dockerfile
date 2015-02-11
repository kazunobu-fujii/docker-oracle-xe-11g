FROM ubuntu:14.04.1

MAINTAINER Kazunobu FUJII

ENV ORACLE_SYS_PASSWORD oracle

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY config.sh /usr/src/app/

COPY chkconfig /sbin/chkconfig
COPY *.ora /usr/src/app/
ADD initXETemp.ora /usr/src/app/
ADD oracle-xe_11.2.0-1.0_amd64.debaa /usr/src/app/
ADD oracle-xe_11.2.0-1.0_amd64.debab /usr/src/app/
ADD oracle-xe_11.2.0-1.0_amd64.debac /usr/src/app/
# ADD oracle-xe_11.2.0-1.0_amd64.deb /usr/src/app/
RUN cat /usr/src/app/oracle-xe_11.2.0-1.0_amd64.deba* > /usr/src/app/oracle-xe_11.2.0-1.0_amd64.deb

# Prepare to install Oracle
RUN apt-get install -y libaio1 net-tools bc
RUN ln -s /usr/bin/awk /bin/awk
RUN mkdir /var/lock/subsys
RUN chmod 755 /sbin/chkconfig

# Install Oracle
RUN dpkg --install /usr/src/app/oracle-xe_11.2.0-1.0_amd64.deb

RUN ln -s /u01/app/oracle/product/11.2.0/xe/bin/oracle_env.sh /etc/profile.d/oracle_env.sh
RUN mv /usr/src/app/*.ora /u01/app/oracle/product/11.2.0/xe/config/scripts

# Remove installation files
RUN rm /usr/src/app/oracle-xe_11.2.0-1.0_amd64.deb*

RUN sh config.sh
RUN /etc/init.d/oracle-xe configure responseFile="/usr/src/app/xe.rsp"

COPY docker-entrypoint.sh /usr/src/app/
ENTRYPOINT ["/usr/src/app/docker-entrypoint.sh"]

EXPOSE 8080 1521
CMD ["tail", "-f", "/dev/null"]
