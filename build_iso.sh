#!/bin/bash

# Définition des chemins
BUILD_DIR="/home/theaux/Citadel/build/$(date '+%Y-%m-%d')"
ISO_NAME="citadel-linux.iso"

# Création du dossier de build
mkdir -p "$BUILD_DIR"

# Construction de l'ISO
echo "[+] Génération de l'ISO dans $BUILD_DIR..."
sudo mkarchiso -v -w /tmp/archiso-tmp -o "$BUILD_DIR" "/home/theaux/Citadel/iso-profiles/releng"

