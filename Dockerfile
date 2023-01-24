FROM alpine AS compilers
RUN apk add --no-cache curl libarchive-tools \
    && mkdir compilers \
    && curl -L https://cdn.discordapp.com/attachments/727918646525165659/917185027656286218/GC_WII_COMPILERS.zip \
       | bsdtar -xvf- -C compilers

FROM ghcr.io/decompals/wibo:0.4.1
COPY --from=compilers /compilers /compilers
COPY --from=devkitpro/devkitppc:20230110 /opt/devkitpro /opt/devkitpro
ENV DEVKITPPC=/opt/devkitpro/devkitPPC
RUN apk add --no-cache ninja python3 py3-requests gcompat git
CMD [ "sh" ]

