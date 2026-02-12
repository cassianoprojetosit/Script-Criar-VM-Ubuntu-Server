<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
    
</head>
<body>

<h1>Controle de VMs Ubuntu Server com Script</h1>

<h2>Objetivo</h2>
<p>O script <code>vm_control.sh</code> permite gerenciar de forma simples as VMs criadas no VirtualBox, com comandos para:</p>
<ul>
  <li>Iniciar VMs (start)</li>
  <li>Desligar VMs imediatamente (stop)</li>
  <li>Desligar VMs de forma segura (acpi)</li>
  <li>Verificar status das VMs (status)</li>
</ul>

<p>Ele foi projetado para funcionar com múltiplas VMs, aplicando comandos em todas de uma vez ou em uma VM específica.</p>

---

<h2>Pré-requisitos</h2>
<ul>
  <li>Ter o VirtualBox instalado no servidor.</li>
  <li>Ter as VMs já criadas e registradas no VirtualBox.</li>
  <li>Permissão de usuário que pode executar <code>vboxmanage</code> (root ou sudo).</li>
</ul>

---

<h2>Lista de VMs gerenciadas</h2>
<p>No script, você define um array com os nomes das VMs que deseja controlar:</p>
<pre>
VMS=("vm-ubuntu01" "vm-ubuntu02")
</pre>
<p>Para adicionar mais VMs, basta incluir o nome no array. Exemplo:</p>
<pre>
VMS=("vm-ubuntu01" "vm-ubuntu02" "vm-ubuntu03")
</pre>

---

<h2>Passo a Passo do Script</h2>

<h3>1. Uso básico</h3>
<pre>
./vm_control.sh {start|stop|acpi|status} [VM_NAME]
</pre>
<p><strong>Parâmetros:</strong></p>
<ul>
  <li><code>start</code> - Inicia a VM</li>
  <li><code>stop</code> - Desliga a VM imediatamente (poweroff)</li>
  <li><code>acpi</code> - Desliga a VM de forma segura (envia botão de energia virtual)</li>
  <li><code>status</code> - Mostra o status atual da VM</li>
  <li><code>VM_NAME</code> - Nome opcional da VM. Se omitido, a ação será aplicada a todas as VMs do array.</li>
</ul>

---

<h3>2. Exemplo de uso</h3>
<pre>
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
</pre>

---

<h3>3. Explicação das ações</h3>
<table>
  <tr><th>Ação</th><th>Descrição</th></tr>
  <tr><td>start</td><td>Inicia a VM em modo headless (sem GUI)</td></tr>
  <tr><td>stop</td><td>Desliga a VM imediatamente (forçado, como desligar na tomada)</td></tr>
  <tr><td>acpi</td><td>Desliga a VM de forma segura, equivalente a enviar botão de energia virtual</td></tr>
  <tr><td>status</td><td>Mostra informações resumidas da VM (nome e estado)</td></tr>
</table>

---

<h3>4. Observações importantes</h3>
<div class="note">
<ul>
  <li>Se uma VM estiver ligada, você não pode alterar discos ou ISO até desligá-la.</li>
  <li>Para adicionar novas VMs, inclua o nome no array <code>VMS</code>.</li>
  <li>O script aplica a ação a todas as VMs se nenhum nome específico for passado.</li>
  <li>É recomendável usar <code>acpi</code> para desligamento seguro do Ubuntu Server.</li>
</ul>
</div>

---

<h3>5. Exemplo de adição de novas VMs</h3>
<p>Suponha que você crie uma terceira VM chamada <code>vm-ubuntu03</code>:</p>
<pre>
VMS=("vm-ubuntu01" "vm-ubuntu02" "vm-ubuntu03")
./vm_control.sh start vm-ubuntu03
</pre>
<p>Isso iniciará apenas a nova VM sem afetar as anteriores.</p>

---

<h2>Conclusão</h2>
<p>O script <code>vm_control.sh</code> oferece uma forma simples, dinâmica e segura de gerenciar múltiplas VMs no VirtualBox, permitindo iniciar, desligar ou verificar status de cada VM individualmente ou em lote. Ele é totalmente configurável, bastando editar o array <code>VMS</code> e executar os comandos desejados.</p>

</body>
</html>
