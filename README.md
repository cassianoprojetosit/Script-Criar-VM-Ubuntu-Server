# ⚙️ Criação de Máquina Virtual Ubuntu Server com Script

<div align="center">
  <img src="https://img.shields.io/badge/VirtualBox-7.0+-blue?style=for-the-badge&logo=virtualbox" alt="VirtualBox 7.0+">
  <img src="https://img.shields.io/badge/Ubuntu_Server-24.04-orange?style=for-the-badge&logo=ubuntu" alt="Ubuntu Server 24.04">
  <img src="https://img.shields.io/badge/Script-Bash-4EAA25?style=for-the-badge&logo=gnu-bash" alt="Script Bash">
</div>

Este documento detalha o script `vm-ubuntu02.sh`, que automatiza a criação e configuração de uma **VM Ubuntu Server** no VirtualBox em um servidor Ubuntu.

## 📋 Índice

*   [🎯 Objetivo](#-objetivo)
*   [✅ Pré-requisitos](#-pré-requisitos)
*   [📁 Estrutura de Diretórios](#-estrutura-de-diretórios)
*   [📜 Passo a Passo do Script](#-passo-a-passo-do-script)
*   [💡 Dicas e Cuidados](#-dicas-e-cuidados)
*   [🏁 Conclusão](#-conclusão)

## 🎯 Objetivo

O script (`vm-ubuntu02.sh`) automatiza a criação de uma **VM Ubuntu Server** no VirtualBox, configurando:

*   ✅ Memória RAM, CPUs e VRAM
*   ✅ Disco virtual (HD)
*   ✅ Controladora SATA e anexação de ISO
*   ✅ Sequência de Boot
*   ✅ Rede NAT
*   ✅ VRDE (RDP) para acesso remoto
*   ✅ Recursos de virtualização (PAE, IOAPIC, Nested Paging, Large Pages)

## ✅ Pré-requisitos

*   Servidor físico rodando **Ubuntu Server**.
*   **VirtualBox** instalado e configurado.
*   **ISO do Ubuntu Server** disponível em `/vms/isos/`.
*   Acesso **root ou sudo** no servidor.
*   **Espaço em disco** suficiente para a VM (mínimo de 40GB).

## 📁 Estrutura de Diretórios

O script cria e utiliza a seguinte estrutura para organização:

```text
/vms/
├── isos/      # Local para armazenar as imagens ISO
├── disks/     # Local para os discos virtuais (VDI)
└── vm-ubuntu02/ # Diretório específico da VM
```

> **Nota:** Para alterar os caminhos, modifique as variáveis `ISO_PATH`, `DISK_PATH` e `VM_NAME` no topo do script.

## 📜 Passo a Passo do Script

### 1. Definição das Variáveis

O script começa com a definição de variáveis que permitem customizar a VM.

```bash
VM_NAME="vm-ubuntu02"          # Nome da VM
ISO_PATH="/vms/isos/ubuntu-24.04.3-live-server-amd64.iso" # Caminho da ISO
DISK_PATH="/vms/disks/${VM_NAME}.vdi"  # Caminho do disco virtual
DISK_SIZE_MB=40000             # Tamanho do disco em MB (40 GB)
RAM_MB=3072                    # Memória RAM em MB (3 GB)
CPU_COUNT=2                    # Número de CPUs
VRAM_MB=8                      # Memória de vídeo em MB
NIC_TYPE="nat"                 # Tipo de rede (nat, bridged, hostonly)
VRDE_PORT=5002                 # Porta RDP (deve ser única por VM)
```

### 2. Criação dos Diretórios

```bash
mkdir -p /vms/isos /vms/disks /vms/${VM_NAME}
```

### 3. Criação da VM

```bash
vboxmanage createvm --name "$VM_NAME" --ostype Ubuntu_64 --register
```

### 4. Configuração dos Recursos da VM

```bash
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
```

| Parâmetro          | Função                                    |
| :----------------- | :---------------------------------------- |
| `--memory`         | Define a memória RAM da VM                |
| `--cpus`           | Define o número de CPUs                   |
| `--boot1 dvd`      | Define o primeiro dispositivo de boot     |
| `--nic1`           | Configura a interface de rede             |
| `--vrde on`        | Habilita o acesso remoto via RDP          |
| `--vrdeport`       | Define a porta para o acesso RDP          |

### 5. Criação do Disco Virtual (VDI)

```bash
vboxmanage createhd --filename "$DISK_PATH" --size $DISK_SIZE_MB --format VDI
```

### 6. Anexação do Disco e ISO

```bash
# Cria a controladora SATA
vboxmanage storagectl "$VM_NAME" --name "SATA Controller" --add sata --controller IntelAhci

# Anexa o disco rígido (VDI) à porta 0
vboxmanage storageattach "$VM_NAME" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$DISK_PATH"

# Anexa a imagem ISO à porta 1
vboxmanage storageattach "$VM_NAME" --storagectl "SATA Controller" --port 1 --device 0 --type dvddrive --medium "$ISO_PATH"
```

### 7. Início da VM

```bash
vboxmanage startvm "$VM_NAME" --type headless
```

## 💡 Dicas e Cuidados

*   **Porta VRDE**: Cada VM deve ter uma porta VRDE única (ex: 5001, 5002, 5003).
*   **Múltiplas VMs**: Para criar outras VMs, altere no mínimo `VM_NAME`, `DISK_PATH` e `VRDE_PORT`.
*   **Remover ISO após instalação**:

    ```bash
    vboxmanage storageattach "$VM_NAME" --storagectl "SATA Controller" --port 1 --device 0 --medium none
    ```

*   **Gerenciamento de energia**:

    ```bash
    # Iniciar VM
    vboxmanage startvm "$VM_NAME" --type headless

    # Desligamento forçado (power off)
    vboxmanage controlvm "$VM_NAME" poweroff

    # Desligamento seguro (via ACPI)
    vboxmanage controlvm "$VM_NAME" acpipowerbutton
    ```

## 🏁 Conclusão

O script oferece um método robusto e personalizável para provisionar VMs Ubuntu Server. Alterando as variáveis iniciais, é possível adaptar a configuração para diferentes necessidades, garantindo um processo de criação rápido, organizado e livre de conflitos.

<div align="center">
  Documento mantido pela equipe de Infraestrutura
  <br>
  Última atualização: 12/02/2026
</div>
