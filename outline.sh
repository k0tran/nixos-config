#!/usr/bin/env bash

KEY='<redacted>'
PORT=8388

# Ensure that config folder exists
mkdir -p ~/.config/shadowsocks-rust

# https -> ss -> config
ssurl -d $(wget $KEY -qO -) > ~/.config/shadowsocks-rust/config.json

# Use config to bootstrap local server
sslocal -c ~/.config/shadowsocks-rust/config.json -b 127.0.0.1:$PORT

