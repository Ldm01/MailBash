#!/bin/bash
cd mails
for fich in `ls`; do
	#Nombre de secondes passées depuis le 01/01/1970
	NBSEC=$(date +%s)
	#Nombre de secondes passées depuis la dernière modification
	LASTMODIF=$(stat -c %Z $fich)
	#On calcule l'age du fichier en secondes
	let "AGE=NBSEC-LASTMODIF"
	if [ $AGE -ge 86000 ]
	then
		gzip $fich 2> /dev/null
	fi
done
