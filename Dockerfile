FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -yy gcc g++ cmake

COPY . print/
WORKDIR print

RUN cmake -S . -B _build -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=_install -DBUILD_TESTS=OFF

RUN cmake --build _build
RUN cmake --build _build --target install

ENV LOG_PATH /home/logs/log.txt
ENV LD_LIBRARY_PATH=/print/_install/lib
RUN mkdir -p /home/logs 

WORKDIR _install/bin
ENTRYPOINT ["./demo"]
