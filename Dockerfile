FROM alpine:20230329 AS pico-sdk
LABEL org.opencontainers.image.title="Docker Pico SDK"
LABEL org.opencontainers.image.source="https://github.com/jisbert/docker-pico-sdk"
LABEL org.opencontainers.image.description="Dockerized environment for building C/C++ PICO SDK based applications. Targeted for GitHub Actions."
ENV PICO_SDK_PATH=/pico-sdk
ENV CMAKE_GENERATOR=Ninja
RUN apk add --no-cache \
  -X https://dl-cdn.alpinelinux.org/alpine/edge/testing \
  git=2.40.0-r1 \
  cmake=3.26.3-r1 \
  cpputest=4.0-r1 \
  g++=12.2.1_git20220924-r10 \
  g++-arm-none-eabi=12.2.0-r1 \
  lcov=1.16-r0 \
  python3=3.11.3-r3 \
  samurai=1.2-r3
RUN git clone -b master --depth=1 https://github.com/raspberrypi/pico-sdk.git ${PICO_SDK_PATH} \
  && git -C ${PICO_SDK_PATH}/lib submodule update --init --depth=1 \
  && git -C ${PICO_SDK_PATH}/lib/tinyusb submodule update --init --depth=1 hw/mcu/raspberry_pi
