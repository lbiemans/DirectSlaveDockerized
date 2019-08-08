FROM centos:latest
RUN yum clean all && yum -y update
RUN yum install -y wget bind
RUN cd /usr/local && wget https://directslave.com/download/directslave-3.2-advanced-all.tar.gz
RUN cd /usr/local && tar zxf directslave-3.2-advanced-all.tar.gz
RUN cp /usr/local/directslave/etc/directslave.conf.sample /usr/local/directslave/etc/directslave.conf
RUN touch /usr/local/directslave/etc/passwd
RUN sed -i 's/ssl\t\ton/ssl\t\toff/' /usr/local/directslave/etc/directslave.conf
RUN sed -i 's/53/25/' /usr/local/directslave/etc/directslave.conf
RUN chown -R named:named /usr/local/directslave
RUN dspwd=`< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};` && echo $dspwd > /root/DirectSlavePassword && /usr/local/directslave/bin/directslave-linux-amd64 --password admin:$dspwd
EXPOSE 2222:2222
