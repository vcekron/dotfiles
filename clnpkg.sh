#!/bin/sh
echo "Clearing unaffiliated packages..."
sudo pacman -Rns $(pacman -Qtdq)
