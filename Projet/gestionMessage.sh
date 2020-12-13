#!/bin/bash

source encryption.sh

##### ENVOI MESSAGE #####
# Paramètre 1 : fichier message
# Paramètre 2 : destinataire

function envoiMessage() {
	currentUser=$USER
        crypterMail /home/${currentUser}/$1 $2
        sudo mv /home/${currentUser}/${1}.gpg /home/${2}/mails
}

##### CREATION MESSAGE #####
# Paramètre 1 : objet du message
# Paramètre 2 : contenu du message
# PAramètre 3 : destinataire
function creationMsg() {
	DATEmail=$(date +"%m-%d-%Y_%T")
	TITRE="${1}_${DATEmail}"
	cd /home/$USER
	touch ${TITRE}.txt
	echo "De : " $USER>/home/${USER}/${TITRE}.txt
	echo "Date : " $DATEmail>>/home/${USER}/${TITRE}.txt
	echo "Objet : " $1>>/home/${USER}/${TITRE}.txt
	echo $2>>/home/${USER}/${TITRE}.txt

	envoiMessage ${TITRE}.txt $3
	sudo rm ${TITRE}.txt
	clear
}

##### AFFICHAGE MESSAGE ######
# Paramètre 1 : fichier déchiffré
function affichageMessage() {
	dialog --textbox $1 0 0
}
