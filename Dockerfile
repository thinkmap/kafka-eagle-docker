FROM openjdk:8-alpine3.9

ENV KE_HOME=/opt/kafka-eagle
ENV EAGLE_VERSION=3.0.1

ADD entrypoint.sh /usr/bin

RUN sed -i 's#dl-cdn.alpinelinux.org#mirrors.aliyun.com#g' /etc/apk/repositories && \
    apk --update add wget gettext tar bash sqlite && \
    apk cache clean ; rm -rf /var/cache/apk/* && \
    mkdir /opt/kafka-eagle -p && cd /opt && \
    wget https://github.com/smartloli/kafka-eagle-bin/archive/v${EAGLE_VERSION}.tar.gz && \
    tar zxvf v${EAGLE_VERSION}.tar.gz -C kafka-eagle --strip-components 1 && rm -f v${EAGLE_VERSION}.tar.gz && \
    cd kafka-eagle;tar zxvf efak-web-${EAGLE_VERSION}-bin.tar.gz --strip-components 1 && rm -f efak-web-${EAGLE_VERSION}-bin.tar.gz  && \
    chmod +x /opt/kafka-eagle/bin/ke.sh && \
    mkdir -p /opt/kafka-eagle/db



EXPOSE 8048 8080

ENTRYPOINT ["entrypoint.sh"]

WORKDIR /opt/kafka-eagle
