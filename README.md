# Trabalho_Sistemas_Operacionais

Script de Auditoria de Usuários Linux
Script em bash que gera um relatório sobre os usuários do sistema. Passa um diretório como argumento e ele salva o relatório lá com a data no nome.
O que ele faz: lista usuários comuns e do sistema separados por UID, mostra usuários sem senha, mostra quem nunca fez login, lista os grupos de cada usuário, verifica se o diretório existe e se tem permissão de escrita antes de salvar, funciona com sudo e doas e salva quem rodou o script e o horário no relatório.
Como usar:
bashchmod +x script.sh
./script.sh /caminho/do/diretorio
Precisa de Linux com bash, awk, lastlog e sudo ou doas.
