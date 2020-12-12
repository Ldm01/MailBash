#!/bin/bash
W=() 
# array contenant les valeurs à afficher
cd /home/$USER/mails
while read -r line; do 
exp=$(head -n 1 ${line})
echo $exp
#On affiche le nom du mail et l'expéditeur
W+=("$line"  "$exp") 
done < <(ls -1 /home/$USER/mails)
#On récupère le nom du mail sélectionné
FILE=$(dialog --stdout --title "List file of directory /home/$USER/mails" --menu "Chose one" 24 80 17 "${W[@]}")
clear 
#
cd /home/$USER/mails
cat $FILE
