# ⚙️ Controle de VMs Ubuntu Server com Script

<div align="center">
  <img src="https://img.shields.io/badge/VirtualBox-7.0+-blue?style=for-the-badge&logo=virtualbox" alt="VirtualBox 7.0+">
  <img src="https://img.shields.io/badge/Ubuntu_Server-20.04+-orange?style=for-the-badge&logo=ubuntu" alt="Ubuntu Server 20.04+">
  <img src="https://img.shields.io/badge/Script-Bash-4EAA25?style=for-the-badge&logo=gnu-bash" alt="Script Bash">
</div>

Este documento descreve o script `vm_control.sh`, uma ferramenta para gerenciar de forma eficiente as Máquinas Virtuais (VMs) do Ubuntu Server criadas no VirtualBox.

## 📋 Índice

*   [🎯 Objetivo](#-objetivo)
*   [✅ Pré-requisitos](#-pré-requisitos)
*   [📝 Lista de VMs Gerenciadas](#-lista-de-vms-gerenciadas)
*   [📜 Passo a Passo do Script](#-passo-a-passo-do-script)
    *   [1. Uso Básico](#1-uso-básico)
    *   [2. Exemplo de Uso](#2-exemplo-de-uso)
    *   [3. Explicação das Ações](#3-explicação-das-ações)
    *   [4. Observações Importantes](#4-observações-importantes)
    *   [5. Exemplo de Adição de Novas VMs](#5-exemplo-de-adição-de-novas-vms)
*   [🏁 Conclusão](#-conclusão)

## 🎯 Objetivo

O script `vm_control.sh` foi desenvolvido para simplificar o gerenciamento de VMs Ubuntu Server no VirtualBox, oferecendo comandos para:

*   **Iniciar VMs** (`start`)
*   **Desligar VMs imediatamente** (`stop`)
*   **Desligar VMs de forma segura** (`acpi`)
*   **Verificar o status das VMs** (`status`)

Ele é projetado para funcionar com múltiplas VMs, permitindo aplicar comandos em todas de uma vez ou em uma VM específica.

## ✅ Pré-requisitos

Para utilizar o script, certifique-se de que os seguintes requisitos sejam atendidos:

*   **VirtualBox** instalado no servidor.
*   **VMs já criadas** e registradas no VirtualBox.
*   **Permissão de usuário** que pode executar `vboxmanage` (usuário `root` ou com `sudo`).

## 📝 Lista de VMs Gerenciadas

No script, as VMs a serem controladas são definidas em um array. Para adicionar ou remover VMs, basta editar esta linha:

```bash
VMS=("vm-ubuntu01" "vm-ubuntu02")
```

> **Exemplo:** Para incluir uma terceira VM, adicione o nome ao array:
> `VMS=("vm-ubuntu01" "vm-ubuntu02" "vm-ubuntu03")`

## 📜 Passo a Passo do Script

### 1. Uso Básico

O script é executado via linha de comando com a seguinte sintaxe:

```bash
./vm_control.sh {start|stop|acpi|status} [VM_NAME]
```

**Parâmetros:**

*   `start`: Inicia a VM.
*   `stop`: Desliga a VM imediatamente (poweroff).
*   `acpi`: Desliga a VM de forma segura (envia botão de energia virtual).
*   `status`: Mostra o status atual da VM.
*   `[VM_NAME]`: Nome opcional da VM. Se omitido, a ação será aplicada a todas as VMs definidas no array `VMS`.

### 2. Exemplo de Uso

```bash
# Iniciar todas as VMs
./vm_control.sh start

# Desligar uma VM específica
./vm_control.sh stop vm-ubuntu02

# Desligar todas as VMs de forma segura
./vm_control.sh acpi

# Verificar status de todas as VMs
./vm_control.sh status

# Verificar status de uma VM específica
./vm_control.sh status vm-ubuntu01
```

### 3. Explicação das Ações

| Ação     | Descrição                                                              |
| :------- | :--------------------------------------------------------------------- |
| `start`  | Inicia a VM em modo headless (sem interface gráfica).                  |
| `stop`   | Desliga a VM imediatamente (forçado, como desligar da tomada).        |
| `acpi`   | Desliga a VM de forma segura, equivalente a enviar o botão de energia. |
| `status` | Mostra informações resumidas da VM (nome e estado atual).              |

### 4. Observações Importantes

*   Se uma VM estiver ligada, não é possível alterar discos ou ISOs sem desligá-la primeiro.
*   Para adicionar novas VMs ao controle do script, inclua o nome no array `VMS`.
*   O script aplica a ação a todas as VMs se nenhum nome específico for passado como argumento.
*   É altamente recomendável usar a ação `acpi` para um desligamento seguro do Ubuntu Server, evitando perda de dados.

### 5. Exemplo de Adição de Novas VMs

Suponha que você crie uma nova VM chamada `vm-ubuntu03`. Para gerenciá-la com o script, primeiro adicione-a ao array `VMS`:

```bash
VMS=("vm-ubuntu01" "vm-ubuntu02" "vm-ubuntu03")
```

Em seguida, você pode iniciar apenas a nova VM:

```bash
./vm_control.sh start vm-ubuntu03
```

Isso iniciará apenas a nova VM sem afetar as anteriores que já estão em execução ou desligadas.

## 🏁 Conclusão

O script `vm_control.sh` oferece uma forma simples, dinâmica e segura de gerenciar múltiplas VMs no VirtualBox. Ele permite iniciar, desligar ou verificar o status de cada VM individualmente ou em lote, sendo totalmente configurável através da edição do array `VMS`. Isso proporciona um controle eficiente e centralizado sobre o ambiente de virtualização.

<div align="center">
  Documento mantido pela equipe de Infraestrutura
  <br>
  Última atualização: 12/02/2026
</div>
