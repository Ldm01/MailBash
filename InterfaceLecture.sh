#!/bin/bash
# define counting variable 
W=() 
# define working array 
cd /home/$USER/mails
while read -r line; do 
exp=$(head -n 1 ${line})
echo $exp
W+=("$line"  "$exp") 
done < <(ls -1 /home/$USER/mails)
FILE=$(dialog --stdout --title "List file of directory /home/$USER/mails" --menu "Chose one" 24 80 17 "${W[@]}")
clear 
#if [ $? -eq 0 ]; then 
# Exit with OK 
#cd 
#readlink -f $(ls -1 /home/$USER/mails | sed -n "/echo $FILE") 
#fi
cd /home/$USER/mails
cat $FILE

#dialog 
