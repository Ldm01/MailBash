#!/bin/bash
timestamp=`date "+%Y%m%d-%H%M%S"`
#Création d'un fichier avec la liste des utilisateurs disponibles.
cat /etc/passwd | grep -v nologin | grep home | cut -d ":" -f1 > /tmp/users

########## Dialog box : accueil ##########
DIALOG1=${DIALOG=dialog}

$DIALOG1 --title "Bienvenue à notre messagerie personnelle" --clear \
        --yesno "Salut,\n\nCet messagerie enverra des messages cryptés aux destinataires sélectionnés. \nVoulez-vous continuez?" 15 75
case $? in
  0)
    echo "Oui, on continue";;
  1)
    echo "Quitter"
    exit 1;;
  255)
    echo "Bouton ESC appuyé."
    exit 2;;
esac

############ Dialog box 2 : Choix destinataires #######
COUNT=0

while IFS=$'\n' read -r opt; do
    COUNT=$(( COUNT+1 ))
    options+=("$opt" "$COUNT" off)
done </tmp/users

#création d'une boîte de dialogue avec une liste de destinataires:
cmd=(dialog --backtitle "Bienvenue à notre messagerie personnelle"  --checklist "Choisissez un ou plusieurs destinataires" 22 30 16)
choixList=($("${cmd[@]}" "${options[@]}" 2>&1 1>/dev/tty))

case $? in
  0)
   ;; 
  1)
    echo "Quitter"
    exit 3;;
  255)
    echo "Bouton ESC appuyé."
    exit 4;;
esac

for choix in "${choixList[@]}"; do
   Destinataire+=("$choix")
done

#echo ${Destinataire[*]}

if [ ${#Destinataire[@]} -eq 0 ]; then
    echo "Aucun destinataire selectionné, Fin programme..."
    exit 5;
fi

########### Dialog box 3 : Rédaction message + envoie ###########

DIALOG3=${DIALOG=dialog}
tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
trap "rm -f $tempfile" 0 1 2 5 15

OBJET=$(dialog --title "Objet de message" --stdout  --inputbox "Objet:" 16 51)

$DIALOG3 --title "Bienvenue à notre messagerie personnelle" --textbox "$OBJET" --clear \
        --inputbox "Veuillez écire votre message:" 16 51 2> $tempfile

retval=$?

case $retval in
  0)
    Message=`cat $tempfile`;;
  1)
    echo "Annuler...";;
  255)
    if test -s $tempfile ; then
      cat $tempfile
    else
      echo "Bouton ESC appuyé."
    fi
    ;;
esac

if [ -z "$Message" ]; then
   echo "Le message n'a pas été écrit, Fin du programme..."
   exit 6;
fi

#Appel fonction send_message pour encrypter et envoyer le message.
#Décommentez la ligne en-dessous...
#send_message "$Message" "${Destinataire[@]}"
