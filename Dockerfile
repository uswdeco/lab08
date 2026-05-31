FROM ubuntu:18.04

RUN apt update && apt install -yy gcc g++ cmake

COPY . print/
WORKDIR print

# Принудительно отключаем тесты внутри кода, чтобы не качать Google Test
RUN sed -i '1s/^/set(BUILD_TESTS OFF CACHE BOOL "" FORCE)\n/' CMakeLists.txt

# Генерируем файлы сборки в папку _build (совместимый синтаксис)
RUN cmake -S . -B _build -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=_install

# Собираем и устанавливаем
RUN cmake --build _build
RUN cmake --build _build --target install

ENV LOG_PATH /home/logs/log.txt
VOLUME /home/logs

WORKDIR _install/bin
ENTRYPOINT ./demo
