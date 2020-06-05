FROM openjdk:8-jdk-alpine

USER root

RUN apk add openssh \
    bash \
    && mkdir /root/.ssh \
    && chmod 0700 /root/.ssh \
    && ssh-keygen -A \
    && echo "root:Docker!" | chpasswd  \
    && rm -rf /tmp/* /var/cache/apk/*

COPY init_container.sh /usr/local/bin/init_container.sh
RUN chmod +x /usr/local/bin/init_container.sh

COPY sshd_config /etc/ssh/


EXPOSE 80 2222

ENV SSH_PORT 2222

ARG JAR_FILE=target/*.jar
COPY target/gs-spring-boot-docker-0.1.0.jar /app.jar
CMD [ "sh", "/usr/local/bin/init_container.sh" ]
# CMD [java","-jar","/gs-spring-boot-docker-0.1.0.jar]
# ENTRYPOINT

