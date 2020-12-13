#!/bin/bash

export NCURSES_NO_UTF8_ACS=1
COUNT=0

sudo chmod 777 /tmp/users

#Création d'un fichier avec la liste des utilisateurs disponibles.
cat /etc/passwd | grep -v nologin | grep home | cut -d ":" -f1 > /tmp/users

sudo chmod 777 /tmp/users
#Récupère tous les utilisateurs sur la VM
while IFS=$'\n' read -r opt; do
    COUNT=$(( COUNT+1 ))
    options+=("$opt")
done</tmp/users


#echo ${options[@]}

#Créé le dossier mail sil inexistant
for choix in "${options[@]}"; do
	if [ -d "/home/${choix}/mails" ]; then
		echo "dossier mails déjà existant"
	else
		currentUser=$USER
		sudo mkdir /home/${currentUser}/mails 2>/dev/null
		sudo chmod 777 /home/${currentUser}/mails
		echo "dossier mails créé chez ${choix}"
	fi
done

#Première interface, on peut soit lire ses mails soit écrire un mail
CHOIX=$(dialog --backtitle "Menu Principal" \
	--title "Mes choix" --clear \
        --radiolist "Est-ce que vous voulez envoyer un message ou bien voir vos mails ? " 20 61 5 \
        	"Envoyer" "Envoyez un message" ON\
         "Mes_mails" "Voir mes mails" off 2>&1 >/dev/tty)
if [ $CHOIX == "Envoyer" ]; then
  bash main.sh
elif [ $CHOIX == "Mes_mails" ]; then
  bash InterfaceLecture.sh
fi
