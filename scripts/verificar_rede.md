Claro! Vou te guiar passo a passo para configurar manualmente o IP em uma máquina Debian, utilizando o script `verificar_rede.sh`, e depois gerar os arquivos de configuração `/etc/network/interfaces` e `/etc/resolv.conf`.

### Passo a Passo:


#### Passo 1: Obter as configurações de rede atuais
Antes de configurar o IP manualmente, você precisará verificar as configurações atuais da rede usando o script `verificar_rede.sh`.
Para isso, o arquivo precisa ser um executável, vamos permitir essa configuração com o comando:
```bash
chmod +x verificar_rede.sh
```


1. **Execute o script `verificar_rede.sh`**:
   Primeiro, execute o script para obter as informações de rede atuais da sua máquina, como o IP, a máscara de rede (netmask), o gateway e os servidores DNS.

   ```bash
   ./verificar_rede.sh
   ```

   Isso retornará algo parecido com o seguinte:

   ```
   Endereço IP: 192.168.1.100
   Máscara de Rede: 32
   Gateway: 192.168.1.1
   Servidores DNS: 8.8.8.8
   ```

   Esses valores são importantes para você configurar manualmente a rede.
   Para conferir a mascara de rede correta, verifique a tabela em:
    https://www.aelius.com/njh/subnet_sheet.html

#### Passo 2: Editar o arquivo `/etc/network/interfaces`
O arquivo `/etc/network/interfaces` controla a configuração de rede das interfaces no Debian. Vamos configurá-lo para que a máquina tenha um IP estático.

1. **Abra o arquivo `/etc/network/interfaces` para edição**:
   
   Você pode usar o editor de texto `nano` ou qualquer outro editor de sua preferência. Para editar o arquivo com o `nano`, execute:

   ```bash
   sudo nano /etc/network/interfaces
   ```

2. **Configurar a interface de rede para IP estático**:
   
   Adicione ou edite as linhas abaixo para configurar a interface de rede com um IP estático. Substitua os valores com base nas informações que você obteve com o script:

   ```
   # Configuração de rede estática para interface eth0
   auto eth0
   iface eth0 inet static
       address 192.168.1.100
       netmask 255.255.255.0
       gateway 192.168.1.1
       dns-nameservers 8.8.8.8
   ```

   **Observações**:
   - `eth0` é o nome da interface de rede. Se sua interface tiver outro nome (por exemplo, `enp0s3` ou `wlan0`), substitua `eth0` pelo nome correto da sua interface. Você pode descobrir o nome da interface com o comando `ip a`.
   - `address`, `netmask`, `gateway` e `dns-nameservers` devem ser preenchidos com os valores obtidos do script.
   - EVITE USAR O COPIAR E COLAR PARA NÃO INSERIR ESPAÇOES DESNECESSÁRIOS EM SEU ARQUIVO, QUE PODEM DANIFICAR A CONFIGURAÇÃO.

3. **Salvar e sair do editor**:
   
   No `nano`, pressione `CTRL + O` para salvar as alterações e depois `CTRL + X` para sair do editor.

#### Passo 3: Editar o arquivo `/etc/resolv.conf`
O arquivo `/etc/resolv.conf` contém as configurações de DNS para o sistema. Para configurar os servidores DNS manualmente, siga os passos abaixo:

1. **Abra o arquivo `/etc/resolv.conf` para edição**:
   
   ```bash
   sudo nano /etc/resolv.conf
   ```

2. **Adicionar servidores DNS**:

   Adicione as linhas abaixo, substituindo pelo(s) servidor(es) DNS que você obteve do script. Você pode adicionar múltiplos servidores DNS, um por linha.

   ```
   nameserver 8.8.8.8     # Substitua pelo DNS obtido
   nameserver 8.8.4.4     # Adicione outros DNS, se necessário
   ```

   **Observação**:
   - Você pode usar o Google DNS (8.8.8.8 e 8.8.4.4) ou outros servidores DNS que preferir.

3. **Salvar e sair do editor**:
   
   Novamente, no `nano`, pressione `CTRL + O` para salvar e depois `CTRL + X` para sair.

#### Passo 4: Reiniciar a interface de rede
Após fazer as alterações, você precisará reiniciar a interface de rede para aplicar as novas configurações. Para fazer isso, execute o comando abaixo:

```bash
sudo systemctl restart networking
```

Ou, se preferir, pode reiniciar a interface de rede diretamente:

```bash
sudo ifdown eth0 && sudo ifup eth0
```

Novamente, substitua `eth0` pelo nome correto da sua interface, caso seja diferente.

#### Passo 5: Verificar as novas configurações
Agora, você pode verificar se as configurações foram aplicadas corretamente. Execute novamente o comando `verificar_rede.sh` ou use os seguintes comandos para verificar o IP, gateway e DNS:

1. **Verificar o IP**:
   ```bash
   ip addr show eth0
   ```

2. **Verificar o Gateway**:
   ```bash
   ip route
   ```

3. **Verificar os DNS**:
   ```bash
   cat /etc/resolv.conf
   ```

Se tudo estiver configurado corretamente, seu IP, gateway e servidores DNS devem estar atualizados com os valores que você inseriu.

---

### Resumo:

1. Execute o script `verificar_rede.sh` para obter as configurações atuais.
2. Edite o arquivo `/etc/network/interfaces` para configurar a rede com IP estático.
3. Edite o arquivo `/etc/resolv.conf` para configurar os servidores DNS.
4. Reinicie a interface de rede ou o serviço de rede.
5. Verifique se as configurações foram aplicadas corretamente.
