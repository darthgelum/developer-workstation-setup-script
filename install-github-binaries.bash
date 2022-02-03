#!/bin/bash
source functions.bash

PANDOC_VERSION=2.17.1.1
SHELLCHECK_VERSION=0.8.0
SHFMT_VERSION=3.4.2
RIPGREP_VERSION=13.0.0
BAT_VERSION=0.19.0
VALE_VERSION=2.14.0
STYLUA_VERSION=0.12.1
LTEXLS_VERSION=15.2.0
NVIM_VERSION=0.6.1

PANDOC_FILENAME=pandoc-${PANDOC_VERSION}-linux-amd64.tar.gz
SHELLCHECK_FILENAME=shellcheck-v${SHELLCHECK_VERSION}.linux.x86_64.tar.xz
SHFMT_FILENAME=shfmt_v${SHFMT_VERSION}_linux_amd64
RIPGREP_FILENAME=ripgrep-${RIPGREP_VERSION}-x86_64-unknown-linux-musl.tar.gz
BAT_FILENAME=bat-v${BAT_VERSION}-x86_64-unknown-linux-gnu.tar.gz
VALE_FILENAME=vale_${VALE_VERSION}_Linux_64-bit.tar.gz
STYLUA_FILENAME=stylua-${STYLUA_VERSION}-linux.zip
LTEXLS_FILENAME=ltex-ls-${LTEXLS_VERSION}.tar.gz
NVIM_FILENAME=nvim.appimage

install_github_binaries() {
    download $PANDOC_VERSION jgm/pandoc "*linux-amd64.tar.gz"
    download v$SHELLCHECK_VERSION koalaman/shellcheck "*linux.x86_64.tar.xz"
    download v$SHFMT_VERSION mvdan/sh "*linux_amd64"
    download $RIPGREP_VERSION BurntSushi/ripgrep "*x86_64-unknown-linux-musl.tar.gz"
    download v$BAT_VERSION sharkdp/bat "*x86_64-unknown-linux-gnu.tar.gz"
    download v${VALE_VERSION} errata-ai/vale "*Linux_64-bit.tar.gz"
    download v$STYLUA_VERSION JohnnyMorganz/StyLua "*linux.zip"
    download $LTEXLS_VERSION valentjn/ltex-ls "*ltex-ls-${LTEXLS_VERSION}.tar.gz"
    download v$NVIM_VERSION neovim/neovim "*.appimage"

    install "$PANDOC_FILENAME" "2" "pandoc"
    install "$SHELLCHECK_FILENAME" "1" "shellcheck"
    install "$RIPGREP_FILENAME" "1" "rg"
    install "$BAT_FILENAME" "1" "bat"
    install "$VALE_FILENAME" "0" "vale"

    # install stylua
    unzip -d $BIN_INSTALL_DIR $STYLUA_FILENAME
    chmod +x "$BIN_INSTALL_DIR/stylua"

    # install ltex-ls
    tar --no-same-owner -C $BIN_INSTALL_DIR/ -xf $LTEXLS_FILENAME --no-anchored 'bin' --strip=1
    tar --no-same-owner -C $BIN_INSTALL_DIR/ -xf $LTEXLS_FILENAME --no-anchored 'lib' --strip=1
    ln -s $BIN_INSTALL_DIR/bin/ltex-ls $BIN_INSTALL_DIR/ltex-ls

    # install neovim
    chmod +x $NVIM_FILENAME
    mv $NVIM_FILENAME $BIN_INSTALL_DIR/nvim

    # install shfmt
    chmod +x $SHFMT_FILENAME
    mv $SHFMT_FILENAME $BIN_INSTALL_DIR/shfmt

    # remove temp files
    rm $STYLUA_FILENAME $LTEXLS_FILENAME
}
