## Instalar o OpenSSH Server no Debian

### Passo 1: Atualizar o sistema
Abra um terminal e execute:

```bash
sudo apt update && sudo apt upgrade -y
```

---

### Passo 2: Instalar o servidor SSH

```bash
sudo apt install openssh-server -y
```

---

### Passo 3: Verificar o status do serviço SSH

```bash
sudo systemctl status ssh
```

Se estiver ativo, aparecerá algo como `active (running)`.

---

### Passo 4: Habilitar o serviço para iniciar com o sistema

```bash
sudo systemctl enable ssh
```

---

### Passo 5: Verificar o IP da máquina (para acessar remotamente)

```bash
ip a
```

Procure o endereço IP da sua interface de rede (geralmente algo como `192.168.x.x`).

---

### Passo 6: Testar a conexão SSH a partir de outra máquina

No terminal da outra máquina (Linux, macOS ou Windows com terminal SSH), use:

```bash
ssh usuario@ip_da_maquina
```

Exemplo:

```bash
ssh quirino@192.168.0.105
```

---

### Passo 7 (opcional): Configurar o SSH

O arquivo de configuração principal é:

```
/etc/ssh/sshd_config
```

Edite com:

```bash
sudo nano /etc/ssh/sshd_config
```

Depois de alterar, reinicie o serviço:

```bash
sudo systemctl restart ssh
```

---

### Passo 8 (opcional): Liberar a porta 22 no firewall (caso o UFW esteja ativo)

```bash
sudo ufw allow ssh
sudo ufw enable
```