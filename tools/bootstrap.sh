#!/bin/sh
set -ex

# echo 'http://dl-cdn.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories
# echo 'http://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories

apk --no-cache upgrade

apk --no-cache add \
    bash binutils-gold ca-certificates cargo clang cmake curl \
    file gawk gcc g++ git gnutls libc-dev libgcc \
    llvm llvm-libs make ncurses-libs nodejs nodejs-npm \
    openssh openssl python rsync rust vim wget zsh yarn

update-ca-certificates --fresh
npm update -g npm

# erlang
apk --no-cache add \
    "erlang${ERLANG_VER_CONSTRAINT}" \
    "erlang-asn1${ERLANG_VER_CONSTRAINT}" \
    "erlang-common-test${ERLANG_VER_CONSTRAINT}" \
    "erlang-compiler${ERLANG_VER_CONSTRAINT}" \
    "erlang-cosevent${ERLANG_VER_CONSTRAINT}" \
    "erlang-coseventdomain${ERLANG_VER_CONSTRAINT}" \
    "erlang-cosfiletransfer${ERLANG_VER_CONSTRAINT}" \
    "erlang-cosnotification${ERLANG_VER_CONSTRAINT}" \
    "erlang-cosproperty${ERLANG_VER_CONSTRAINT}" \
    "erlang-costime${ERLANG_VER_CONSTRAINT}" \
    "erlang-costransaction${ERLANG_VER_CONSTRAINT}" \
    "erlang-crypto${ERLANG_VER_CONSTRAINT}" \
    "erlang-debugger${ERLANG_VER_CONSTRAINT}" \
    "erlang-dev${ERLANG_VER_CONSTRAINT}" \
    "erlang-dialyzer${ERLANG_VER_CONSTRAINT}" \
    "erlang-diameter${ERLANG_VER_CONSTRAINT}" \
    "erlang-edoc${ERLANG_VER_CONSTRAINT}" \
    "erlang-eldap${ERLANG_VER_CONSTRAINT}" \
    "erlang-erl-docgen${ERLANG_VER_CONSTRAINT}" \
    "erlang-erl-interface${ERLANG_VER_CONSTRAINT}" \
    "erlang-erts${ERLANG_VER_CONSTRAINT}" \
    "erlang-et${ERLANG_VER_CONSTRAINT}" \
    "erlang-eunit${ERLANG_VER_CONSTRAINT}" \
    "erlang-gs${ERLANG_VER_CONSTRAINT}" \
    "erlang-hipe${ERLANG_VER_CONSTRAINT}" \
    "erlang-ic${ERLANG_VER_CONSTRAINT}" \
    "erlang-inets${ERLANG_VER_CONSTRAINT}" \
    "erlang-jinterface${ERLANG_VER_CONSTRAINT}" \
    "erlang-kernel${ERLANG_VER_CONSTRAINT}" \
    "erlang-megaco${ERLANG_VER_CONSTRAINT}" \
    "erlang-mnesia${ERLANG_VER_CONSTRAINT}" \
    "erlang-observer${ERLANG_VER_CONSTRAINT}" \
    "erlang-odbc${ERLANG_VER_CONSTRAINT}" \
    "erlang-orber${ERLANG_VER_CONSTRAINT}" \
    "erlang-os-mon${ERLANG_VER_CONSTRAINT}" \
    "erlang-otp-mibs${ERLANG_VER_CONSTRAINT}" \
    "erlang-parsetools${ERLANG_VER_CONSTRAINT}" \
    "erlang-percept${ERLANG_VER_CONSTRAINT}" \
    "erlang-public-key${ERLANG_VER_CONSTRAINT}" \
    "erlang-reltool${ERLANG_VER_CONSTRAINT}" \
    "erlang-runtime-tools${ERLANG_VER_CONSTRAINT}" \
    "erlang-sasl${ERLANG_VER_CONSTRAINT}" \
    "erlang-snmp${ERLANG_VER_CONSTRAINT}" \
    "erlang-ssh${ERLANG_VER_CONSTRAINT}" \
    "erlang-ssl${ERLANG_VER_CONSTRAINT}" \
    "erlang-stdlib${ERLANG_VER_CONSTRAINT}" \
    "erlang-syntax-tools${ERLANG_VER_CONSTRAINT}" \
    "erlang-tools${ERLANG_VER_CONSTRAINT}" \
    "erlang-typer${ERLANG_VER_CONSTRAINT}" \
    "erlang-xmerl${ERLANG_VER_CONSTRAINT}"

curl -sSL https://github.com/erlang/rebar3/releases/download/${REBAR3_VERSION}/rebar3 -o /usr/local/bin/rebar3
chmod +x /usr/local/bin/rebar3
mkdir -p $HOME/.config/rebar3/
echo "{plugins, [rebar3_hex]}." > $HOME/.config/rebar3/rebar.config
rebar3 update && rebar3 plugins upgrade rebar3_hex

curl -sSL https://github.com/elixir-lang/elixir/releases/download/v${ELIXIR_VERSION}/Precompiled.zip -o elixir.zip
mkdir -p /opt/elixir-${ELIXIR_VERSION}/
unzip elixir.zip -d /opt/elixir-${ELIXIR_VERSION}/
rm elixir.zip

mix local.hex --force
mix local.rebar --force

TOOLS_DIR="/build/tools"
ESZ="ex_strip_zip"
ESZ_ZIP_BRANCH="master"
ESZ_HOME_ZIP="https://github.com/ntrepid8/$ESZ/archive/$ESZ_ZIP_BRANCH.zip"

echo "Fetching ExStripZip ($ESZ_HOME) ..."
ESZ_BUILD_DIR=$(mktemp -d)
cd $ESZ_BUILD_DIR
  curl -sSL $ESZ_HOME_ZIP -o $ESZ.zip
  unzip $ESZ.zip
  cd $ESZ-$ESZ_ZIP_BRANCH
    MIX_ENV=prod mix escript.build
    cp $ESZ $TOOLS_DIR/$ESZ
    chmod +x $TOOLS_DIR/$ESZ
cd ~
rm -rf $ESZ_BUILD_DIR

# info section

gcc --version
clang --version

rustc --version
cargo --version

node --version
npm --version
yarn --version

elixir --version
