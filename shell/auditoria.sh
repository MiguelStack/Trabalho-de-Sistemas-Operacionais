#!/bin/bash

DATA=$(date +"%d-%m-%y")
DIRETORIO=
RELATORIO=
USUARIO=$(whoami)


if [ -z "$1" ]; then
        echo "Este é um script que gera relatórios sobre os usuários do sistema"
        echo "Como usar - $0 <destino do relatório>"
        exit 0
else
        DIRETORIO=$1
        if [ ! -d $DIRETORIO ]; then
                echo "O destino especificado não existe"
                exit 1
        fi
        if [ ! -w $DIRETORIO ]; then
                echo "Você não possui permissão para escrever à esse destino"
                exit 1
        fi
fi

RELATORIO="$DIRETORIO/relatorio-$DATA.txt"

echo "RELATORIO DE AUDITORIA" > $RELATORIO
echo "Gerado às $(date +"%T") por $USUARIO" >> $RELATORIO
echo "=============================" >> $RELATORIO

echo "" >> $RELATORIO
echo "USUARIOS COMUNS:" >> $RELATORIO
awk -F: '$3 >= 1000 {print $1 " UID:" $3}' /etc/passwd >> $RELATORIO

echo "" >> $RELATORIO
echo "USUARIOS DO SISTEMA:" >> $RELATORIO
awk -F: '$3 < 1000 {print $1 " UID:" $3}' /etc/passwd >> $RELATORIO

echo "" >> $RELATORIO
echo "USUARIOS SEM SENHA:" >> $RELATORIO

if grep -qw $USUARIO /etc/doas.conf 2>/dev/null || grep -qw $USUARIO /usr/local/etc/doas.conf 2>/dev/null; then
        doas awk -F: '($2 == "" || $2 == "!" || $2 == "*") {print $1}' /etc/shadow >> $RELATORIO 2>/dev/null
else
        sudo awk -F: '($2 == "" || $2 == "!" || $2 == "*") {print $1}' /etc/shadow >> $RELATORIO
fi

echo "" >> $RELATORIO
echo "USUARIOS SEM LOGIN:" >> $RELATORIO
lastlog | awk 'NR>1 && ($4 == "**Never" || $5 == "logged") {print $1}' >> $RELATORIO

echo "" >> $RELATORIO
echo "GRUPOS DOS USUARIOS:" >> $RELATORIO
for usuario in $(awk -F: '$3 >= 1000 {print $1}' /etc/passwd)
do
    echo "$usuario:" >> $RELATORIO
    groups $usuario >> $RELATORIO
done

echo "" >> $RELATORIO
echo "RELATORIO FINALIZADO" >> $RELATORIO

echo "Arquivo criado: $RELATORIO"
