#!/bin/bash

# ******************************************************************************
# Script para verificar configurações de rede de uma máquina Debian com DHCP
# Autor: Luiz Quirino <luiz.quirino@ifsp.edu.br>
# Since: versão 0.0.1
# Data: 04 de abril de 2025
#
# Descrição:
# Este script verifica e exibe as configurações de rede de uma máquina Debian
# que está usando DHCP, incluindo o IP atribuído, a máscara de rede (netmask),
# o gateway padrão e os servidores DNS configurados.
# ******************************************************************************

# 1. Verificando o IP da interface ativa
# O comando 'hostname -I' retorna todos os IPs atribuídos à máquina.
# Vamos pegar o primeiro IP da lista, que é o principal.
ip_address=$(hostname -I | awk '{print $1}')
echo "Endereço IP: $ip_address"

# 2. Verificando a máscara de rede (netmask)
# Usamos o comando 'ip addr show' para exibir as informações da interface.
# Filtramos a linha do IP e extraímos a máscara de rede.
netmask=$(ip addr show | grep -A 1 "$ip_address" | grep "inet" | awk '{print $2}' | cut -d'/' -f2)
echo "Máscara de Rede: $netmask"
echo "confira a tabela em: https://www.aelius.com/njh/subnet_sheet.html"

# 3. Verificando o Gateway Padrão
# O comando 'ip route' nos dá a rota padrão, que contém o gateway.
# Aqui, extraímos o valor do gateway a partir da saída.
gateway=$(ip route | grep default | awk '{print $3}')
echo "Gateway: $gateway"

# 4. Verificando os servidores DNS
# Os servidores DNS configurados são listados no arquivo '/etc/resolv.conf'.
# O comando 'grep' busca pelas linhas que contêm 'nameserver' e extrai o IP dos DNS.
dns_servers=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}')
echo "Servidores DNS: $dns_servers"
