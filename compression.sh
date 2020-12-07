#!/bin/bash
cd mails
for fich in `ls`; do
	NBSEC=$(date +%s)
	LASTMODIF=$(stat -c %Z $fich)
	let "AGE=NBSEC-LASTMODIF"
	if [ $AGE -ge 86000 ]
	then
		gzip $fich 2> /dev/null
	fi
done
