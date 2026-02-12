#!/bin/bash

# ====================================================
# Script de Controle de VMs Ubuntu Server
# VMs configuradas: vm-ubuntu01, vm-ubuntu02
# Permite: start, stop, acpi (shutdown seguro), status
# ====================================================

# Lista de VMs gerenciadas
VMS=("vm-ubuntu01" "vm-ubuntu02")

# Função de uso
usage() {
    echo "Uso: $0 {start|stop|acpi|status} [VM_NAME]"
    echo "  start  - Iniciar a VM"
    echo "  stop   - Desligar a VM (poweroff)"
    echo "  acpi   - Desligar a VM com ACPI (shutdown seguro)"
    echo "  status - Mostrar status das VMs"
    echo "  VM_NAME opcional - nome da VM específica, se omitido aplica a todas"
    exit 1
}

# Checar argumentos
if [ $# -lt 1 ]; then
    usage
fi

ACTION=$1
TARGET_VM=$2

# Função para executar ação
run_action() {
    local VM=$1
    case $ACTION in
        start)
            echo "Iniciando VM $VM..."
            vboxmanage startvm "$VM" --type headless
            ;;
        stop)
            echo "Desligando VM $VM (forçado)..."
            vboxmanage controlvm "$VM" poweroff
            ;;
        acpi)
            echo "Desligando VM $VM (shutdown seguro)..."
            vboxmanage controlvm "$VM" acpipowerbutton
            ;;
        status)
            echo "Status da VM $VM:"
            vboxmanage showvminfo "$VM" | grep -E "Name:|State:"
            ;;
        *)
            echo "Ação inválida: $ACTION"
            usage
            ;;
    esac
}

# Se o usuário passou uma VM específica
if [ -n "$TARGET_VM" ]; then
    run_action "$TARGET_VM"
else
    # Aplica ação para todas as VMs listadas
    for VM in "${VMS[@]}"; do
        run_action "$VM"
    done
fi
