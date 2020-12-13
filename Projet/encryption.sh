#!/bin/bash


###### Vérification clé ##########

# Paramètre 1 : utilisateur
function existeCle() {
	if [ -d "/home/${1}/.gnupg" ] ; then
		if [ -z "$(ls -a /home/${1}/.gnupg/private-keys-v1.d)" ] ; then
			dialog --stdout --title "Erreur" --msgbox "Vous ne disposez pas de clé secrète ! Créez en une et revenez après." 0 0
			clear
			exit
		fi
	else
		dialog --stdout --title "Erreur" --msgbox "Vous ne disposez pas de clé secrète ! Créez en une et revenez après." 0 0
		clear
		exit
	fi
}

###### CRYPTAGE MESSAGE ######
# Paramètre 1 : fichier mail
# Paramètre 2 : utilisateur destinataire
function crypterMail() {
	gpg -r $2 --encrypt $1
}

###### DECHIFFREMENT MESSAGE ########
# Paramètre 1 : fichier crypté
function dechiffrerMail() {
	sudo gpg --decrypt ${1} > ${1}.txt
}

