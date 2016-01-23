FROM edib/elixir-phoenix-dev:latest
MAINTAINER Christoph Grabo <edib@markentier.com>

WORKDIR /build
COPY . /build

CMD ["make", "-f", "edib/Makefile"]
