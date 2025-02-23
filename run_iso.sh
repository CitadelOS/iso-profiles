#!/bin/bash

# Vérification de l'argument
if [[ -z "$1" ]]; then
    echo "Usage: $0 <chemin de l'ISO>"
    exit 1
fi

ISO_PATH="$1"
VM_DISK="/tmp/temp_disk.qcow2"
EFI_BIOS="/usr/share/ovmf/x64/OVMF_CODE.4m.fd"

# Vérification de l'ISO
if [[ ! -f "$ISO_PATH" ]]; then
    echo "[!] L'ISO spécifié n'existe pas: $ISO_PATH"
    exit 1
fi

# Suppression de l'ancien disque s'il existe
if [[ -f "$VM_DISK" ]]; then
    echo "[+] Suppression de l'ancien disque VM..."
    rm -f "$VM_DISK"
fi

# Création d'un disque temporaire de 32GB
echo "[+] Création du disque VM temporaire dans /tmp/temp_disk.qcow2..."
qemu-img create -f qcow2 "$VM_DISK" 32G

# Démarrage de la VM avec QEMU
echo "[+] Lancement de la VM avec l'ISO: $ISO_PATH"
qemu-system-x86_64 \
    -enable-kvm \
    -cpu host \
    -smp 8 \
    -m 8G \
    -drive file="$EFI_BIOS",if=pflash,format=raw,readonly=on \
    -drive file="$VM_DISK",format=qcow2 \
    -cdrom "$ISO_PATH" \
    -boot menu=on \
    -vga virtio \
    -device virtio-net,netdev=net0 \
    -netdev user,id=net0,hostfwd=tcp::2222-:22 \
    -display gtk,gl=on

echo "[+] VM en cours d'exécution."
