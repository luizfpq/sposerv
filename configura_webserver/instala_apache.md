## Instalar um servidor web (Apache) no Debian

### Passo 1: Atualizar o sistema
Abra o terminal e execute:

```bash
sudo apt update && sudo apt upgrade -y
```

---

### Passo 2: Instalar o Apache
```bash
sudo apt install apache2 -y
```

---

### Passo 3: Verificar se o servidor está rodando
Depois da instalação, o Apache já deve estar ativo. Verifique com:

```bash
sudo systemctl status apache2
```

Se aparecer algo como "active (running)", está funcionando!

---

### Passo 4: Testar no navegador
Abra o navegador e digite:

```
http://localhost
```
ou o IP da máquina, por exemplo:

```
http://192.168.0.100
```

Você verá a página padrão do Apache: **“Apache2 Debian Default Page”**.

---

### Passo 5 (opcional): Colocar seus arquivos no servidor
Os arquivos do site ficam em:

```
/var/www/html/
```

Você pode substituir o arquivo `index.html` por um novo:

```bash
sudo nano /var/www/html/index.html
```

Escreva algo como:

```html
<html><body><h1>Olá, mundo!</h1></body></html>
```

Salve e feche (`Ctrl+O`, `Enter`, depois `Ctrl+X`).

---

### Passo 6 (opcional): Abrir porta 80 no firewall (se estiver usando UFW)
```bash
sudo ufw allow 'Apache'
sudo ufw enable
```