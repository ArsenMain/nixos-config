#!/bin/sh

CONFIG_PATH="$HOME""/.config/"
CONFIG_DIR="nixos-config"
FULL_PATH="$CONFIG_PATH""$CONFIG_DIR""/"

if [[ ! -d $FULL_PATH ]]; then
        mkdir -p "$FULL_PATH"
        sudo mv -v /etc/nixos/hardware-configuration.nix ./
        cp -rv ./* "$FULL_PATH"
        rm -rfv ./*
        sudo rm -v /etc/nixos/configuration.nix
        sudo ln -sv "$FULL_PATH""flake.nix" /etc/nixos/flake.nix
fi
