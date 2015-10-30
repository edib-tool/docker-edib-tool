FROM edib/elixir-phoenix-dev:1.0
MAINTAINER Christoph Grabo <edib@markentier.com>

WORKDIR /build
COPY . /build

CMD ["make", "-f", "edib/Makefile"]
