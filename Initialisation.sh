#!/bin/bash


COUNT=0

while IFS=$'\n' read -r opt; do
    COUNT=$(( COUNT+1 ))
    options+=("$opt")
done </tmp/users

echo ${options[@]}

for choix in "${options[@]}"; do
	if [ -d "/home/${choix}/mails" ]; then
		echo "dossier mails déjà existant"
	else
		gpasswd -a $choix mails
		cd /home/$choix
		sudo mkdir mails 1>/dev/null
		echo "dossier mails créé chez ${choix}"
	fi
done

DIALOG=${DIALOG=dialog}

CHOIX=$(dialog --backtitle "Menu Principale" \
	--title "Mes choix" --clear \
        --stdout --radiolist "Est ce que vous voulez envoyer un message ou bien voir tes mails ? " 20 61 5 \
        	"Msg" "Envoyez un message" ON\
         "Mails" "Voir mes mails" off)

if [ $CHOIX == "Msg" ]; then

  bash Messagerie.sh

elif [ $CHOIX == "Mails" ]; then
 
  bash Mails.sh

fi
