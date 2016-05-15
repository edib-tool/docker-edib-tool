FROM edib/elixir-phoenix-dev:latest
MAINTAINER Christoph Grabo <edib@markentier.com>

WORKDIR /build
COPY . /build
RUN /build/tools/setup.sh

CMD ["make", "-f", "edib/Makefile"]
