#!/bin/bash


COUNT=0

#Récupère tous les utilisateurs sur la VM
while IFS=$'\n' read -r opt; do
    COUNT=$(( COUNT+1 ))
    options+=("$opt")
done </tmp/users


#echo ${options[@]}

#Créé le dossier mail sil inexistant
for choix in "${options[@]}"; do
	if [ -d "/home/${choix}/mails" ]; then
		echo "dossier mails déjà existant"
	else
		gpasswd -a $choix mails
		cd /home/$choix
		sudo mkdir mails 1>/dev/null
		sudo chmod 777 /mails 
		echo "dossier mails créé chez ${choix}"
	fi
done


DIALOG=${DIALOG=dialog}

#Première interface, on peut soit lire ses mails soit écrire un mail
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
