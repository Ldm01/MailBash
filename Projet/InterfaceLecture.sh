!/bin/bash
source encryption.sh
export NCURSES_NO_UTF8_ACS=1

W=()
# array contenant les valeurs à afficher
cd /home/$USER/mails
while read -r line; do
FORMATfile1=${line#*.}
if [ $FORMATfile1 == "txt.gpg" ] ; then
	exp="Nouveau Message !"
elif [ $FORMATfile1 == "txt.gpg.txt" ] ; then
	exp=$(head -n 1 ${line})
fi
#On affiche le nom du mail et l'expéditeur
W+=("$line" "$exp")
done < <(ls -1 /home/$USER/mails)
#On récupère le nom du mail sélectionné
FILE=$(dialog --title "List file of directory /home/$USER/mails" --menu "Chose one" 24 80 17 "${W[@]}" 2>&1 >/dev/tty)
clear

FORMATfile2=${FILE#*.}
if [ $FORMATfile2 == "txt.gpg" ] ; then
	dechiffrerMail /home/${USER}/mails/${FILE}
	pathMail="/home/${USER}/mails/${FILE}.txt"
	dialog --title "Message" --textbox $pathMail 0 0
	sudo rm -f /home/${USER}/mails/${FILE}
elif [ $FORMATfile2 == "txt.gpg.txt" ] ; then
	pathMail="/home/${USER}/mails/${FILE}"
	dialog --title "Message" --textbox $pathMail 0 0
fi
clear
