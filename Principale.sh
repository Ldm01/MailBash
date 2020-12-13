#!/bin/sh
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