FROM registry.access.redhat.com/rhel7.5:v2
#FROM centos:centos7
MAINTAINER Weblogic 13 <venerari@ontario.com>

RUN yum -y update; yum clean all
RUN yum -y install openssh-server passwd iproute lsof less net-tools libselinux-python; yum clean all
RUN yum -y install unzip binutils compat-libcap1 gcc.x86_64 gcc-c++.x86_64 glibc.x86_64; yum clean all
RUN yum -y install glibc-devel.x86_64 libaio.x86_64 libaio-devel.x86_64 libgcc.x86_64; yum clean all
RUN yum -y install libstdc++.x86_64 libstdc++-devel.x86_64 ksh make sysstat sshpass zip; yum clean all

ADD ./start.sh /start.sh
RUN mkdir /var/run/sshd  # will fail if images already commited
RUN yum install sudo -y

RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' 

RUN chmod 755 /start.sh
EXPOSE 22 80
RUN ./start.sh
RUN echo 'user ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
ENTRYPOINT ["/usr/sbin/sshd", "-D"]
