FROM java:8-alpine

ENV KE_HOME=/opt/kafka-eagle
ENV EAGLE_VERSION=1.4.6

ADD entrypoint.sh /usr/bin

RUN sed -i 's#dl-cdn.alpinelinux.org#mirrors.aliyun.com#g' /etc/apk/repositories && \
    apk --update add wget gettext tar bash sqlite && \
    apk cache clean ; rm -rf /var/cache/apk/* && \
    cd /opt && ls -al && \
    wget https://github.com/smartloli/kafka-eagle-bin/archive/v${EAGLE_VERSION}.tar.gz && ls -alR && \
    tar zxvf v${EAGLE_VERSION}.tar.gz -C kafka-eagle --strip-components 1 && \
    cd kafka-eagle;tar zxvf kafka-eagle-web-${EAGLE_VERSION}-bin.tar.gz --strip-components 1 && \
    chmod +x /opt/kafka-eagle/bin/ke.sh && \
    mkdir -p /hadoop/kafka-eagle/db



EXPOSE 8048 8080

ENTRYPOINT ["./entrypoint.sh"]

WORKDIR /opt/kafka-eagle
