FROM edib/elixir-phoenix-dev:1.3
MAINTAINER Christoph Grabo <edib@markentier.com>

WORKDIR /build
COPY . /build
RUN /build/tools/setup.sh

CMD ["make", "-f", "edib/Makefile"]
