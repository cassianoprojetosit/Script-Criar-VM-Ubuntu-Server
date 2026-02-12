#!/bin/bash

# ====================================================
# Script para criar a segunda VM Ubuntu Server
# Nome da VM: vm-ubuntu02
# ====================================================

# Variáveis configuráveis pelo usuário
VM_NAME="vm-ubuntu02"                                    # Nome da VM
ISO_PATH="/vms/isos/ubuntu-24.04.3-live-server-amd64.iso" # Caminho da ISO
DISK_PATH="/vms/disks/${VM_NAME}.vdi"                     # Disco da VM
DISK_SIZE_MB=40000                                        # Tamanho do disco (MB)
RAM_MB=3072                                               # Memória RAM (MB)
CPU_COUNT=2                                               # Número de CPUs
VRAM_MB=8                                                 # Memória de vídeo (MB)
NIC_TYPE="nat"                                            # Tipo de rede
VRDE_PORT=5002                                            # Porta VRDE (única por VM)
SATA_CTRL_NAME="SATA Controller"                          # Nome da controladora SATA

# ====================================================
# Criar diretórios da VM
mkdir -p /vms/isos /vms/disks /vms/${VM_NAME}

# ====================================================
# Criar a VM no VirtualBox
vboxmanage createvm --name "$VM_NAME" --ostype Ubuntu_64 --register

# ====================================================
# Configurar a VM
vboxmanage modifyvm "$VM_NAME" \
--memory $RAM_MB \
--cpus $CPU_COUNT \
--vram $VRAM_MB \
--boot1 dvd --boot2 disk \
--chipset piix3 \
--firmware bios \
--nic1 $NIC_TYPE \
--vrde on --vrdeport $VRDE_PORT \
--vrdeauthtype null \
--pae on --ioapic on --nestedpaging on --largepages on

# ====================================================
# Criar disco virtual
vboxmanage createhd --filename "$DISK_PATH" --size $DISK_SIZE_MB --format VDI

# ====================================================
# Criar controladora SATA e anexar disco + ISO
vboxmanage storagectl "$VM_NAME" --name "$SATA_CTRL_NAME" --add sata --controller IntelAhci --portcount 30
vboxmanage storageattach "$VM_NAME" --storagectl "$SATA_CTRL_NAME" --port 0 --device 0 --type hdd --medium "$DISK_PATH"
vboxmanage storageattach "$VM_NAME" --storagectl "$SATA_CTRL_NAME" --port 1 --device 0 --type dvddrive --medium "$ISO_PATH"

# ====================================================
# Iniciar a VM sem GUI
vboxmanage startvm "$VM_NAME" --type headless

echo "VM $VM_NAME criada e iniciada com sucesso! Acesse via VRDE na porta $VRDE_PORT."
