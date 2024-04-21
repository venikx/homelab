#!/usr/bin/env sh

#scp -r [!.]* venikx@192.168.1.197:/home/venikx/homelab

echo "Rebuilding:" $CHAKRA_IP
nixos-rebuild switch --fast --flake .#chakra \
    --target-host $CHAKRA_IP \
    --build-host $CHAKRA_IP \
    --option eval-cache false
