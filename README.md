# Trabalho_Sistemas_Operacionais

Script em bash que gera um relatório de auditoria sobre os usuários do sistema Linux.

## O que ele faz

- Lista usuários comuns (UID >= 1000) e usuários do sistema (UID < 1000)
- Mostra usuários sem senha definida
- Mostra quem nunca fez login
- Lista os grupos de cada usuário
- Verifica se o diretório de destino existe e tem permissão de escrita
- Funciona com sudo e doas
- Registra quem rodou o script e o horário no relatório

## Como usar

```bash
chmod +x script.sh
./script.sh /caminho/do/diretorio
```

## Requisitos

Linux com bash, awk, lastlog e sudo ou doas.
