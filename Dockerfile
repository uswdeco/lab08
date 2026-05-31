FROM ubuntu:18.04

RUN apt update && apt install -yy gcc g++ cmake

COPY . print/
WORKDIR print

# Отключаем тесты внутри кода, чтобы не качать Google Test из сети
RUN sed -i '1s/^/set(BUILD_TESTS OFF CACHE BOOL "" FORCE)\n/' CMakeLists.txt

# Классический метод сборки, который поймет абсолютно любой CMake
RUN mkdir _build && cd _build && cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=../_install
RUN cd _build && cmake --build .
RUN cd _build && cmake --build . --target install

ENV LOG_PATH /home/logs/log.txt
VOLUME /home/logs

WORKDIR _install/bin
ENTRYPOINT ["./demo"]
