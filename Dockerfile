FROM debian:11-slim

LABEL maintainer="10763991+needs-coffee@users.noreply.github.com"
LABEL org.label-schema.schema-version="1.0" \
     org.label-schema.description="For use with the https://flic.io/ bluetooth buttons. A Docker container for the flicd binary found at https://github.com/50ButtonsEach/fliclib-linux-hci" \
     org.label-schema.docker.cmd="docker run -v ./data:/data --cap-add NET_ADMIN --net=host docker-flic"

## Optional architectures are aarch64, armv6l, i386, x86_64
ARG PLATFORM_ARCH=armv6l
ENV PLATFORM_ARCH=${PLATFORM_ARCH}

ENV FLIC_HCI_DEVICE=hci0
ENV FLIC_PORT=5551
ENV FLIC_DB_NAME=flicd.db

RUN mkdir /code /data /fliclib-temp \
    && \
    apt-get update && apt-get install -y \
    git \
    net-tools \
    && \
    git clone --depth 1 https://github.com/50ButtonsEach/fliclib-linux-hci /fliclib-temp && \
    cp /fliclib-temp/bin/${PLATFORM_ARCH}/flicd /code/flicd && \
    rm -rf /fliclib-temp \
    && \
    apt-get remove --purge -y git \
    && \
    apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* 

ADD ./*.sh /code/
RUN chmod +x /code/entrypoint.sh /code/healthcheck.sh /code/flicd

WORKDIR /data

HEALTHCHECK --interval=30s --timeout=15s --start-period=5s --retries=3 CMD /code/healthcheck.sh

VOLUME ["/data"]
ENTRYPOINT [ "/code/entrypoint.sh" ]