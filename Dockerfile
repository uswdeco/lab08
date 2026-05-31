FROM ubuntu:18.04

RUN apt update && apt install -yy gcc g++ cmake

COPY . print/
WORKDIR print

RUN sed -i '1s/^/set(BUILD_TESTS OFF CACHE BOOL "" FORCE)\n/' CMakeLists.txt

RUN mkdir _build && cd _build && cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=../_install
RUN cd _build && cmake --build .
RUN cd _build && cmake --build . --target install

ENV LOG_PATH /home/logs/log.txt
ENV LD_LIBRARY_PATH=/print/_install/lib:/print/_build

RUN mkdir -p /home/logs && touch /home/logs/log.txt && chmod -R 777 /home/logs

VOLUME /home/logs

WORKDIR _install/bin
ENTRYPOINT ["./demo"]
