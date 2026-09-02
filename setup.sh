#!/bin/sh

CONFIG_PATH="$HOME""/.config/"
CONFIG_DIR="nixos-config"
FULL_PATH="$CONFIG_PATH""$CONFIG_DIR""/"

if [[ ! -d $FULL_PATH ]]; then
        mkdir -p "$FULL_PATH"
        sudo mv /etc/nixos/hardware-configuration.nix ./
        cp -r ./* "$FULL_PATH"
        rm -rf ./*
        sudo rm /etc/nixos/configuration.nix
        sudo ln -s "$FULL_PATH""flake.nix" /etc/nixos/flake.nix 
fi
