FROM ubuntu:16.04
MAINTAINER cperezprieto

# Install dependencies
RUN apt-get update && apt-get install -y openssh-server git

# SSH
RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd
RUN mkdir -p /var/run/sshd
RUN adduser --disabled-password --gecos "" jenkins
RUN echo "jenkins:jenkins" | chpasswd

# JDK
RUN apt-get install -y default-jdk

# Install jMeter
COPY apache-jmeter-5.0 /apache-jmeter-5.0
RUN chown -R jenkins ./apache-jmeter-5.0

RUN mkdir /var/lib/jenkins && chown -R jenkins /var/lib/jenkins

EXPOSE 4441
EXPOSE 4442

CMD ["/usr/sbin/sshd", "-D"]
