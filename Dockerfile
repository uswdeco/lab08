FROM ubuntu:18.04

RUN apt update && apt install -yy gcc g++ cmake

COPY . print/
WORKDIR print

# Принудительно отключаем тесты внутри CMakeLists.txt перед запуском
RUN sed -i '1s/^/set(BUILD_TESTS OFF CACHE BOOL "" FORCE)\n/' CMakeLists.txt

# Используем классический синтаксис сборки CMake без флагов -H и -B
RUN cmake . -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=_install
RUN cmake --build .
RUN cmake --build . --target install

ENV LOG_PATH /home/logs/log.txt
VOLUME /home/logs

WORKDIR _install/bin
ENTRYPOINT ./demo

