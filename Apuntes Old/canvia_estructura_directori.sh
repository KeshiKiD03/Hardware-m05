#!/bin/bash
# Filename:		canvia_estructura_directori.sh
# Author:		jamoros
# Date:			11/03/2018
# Version:		0.1
# License:		This is free software, licensed under the GNU General Public License v3.
#				See http://www.gnu.org/licenses/gpl.html for more information.
# Usage:		canvia_estructura_directori.sh
# Description:	Script que realitza canvis a l'estructura de directoris amb la qual 
# 				fem proves de backup (veure script crea_estructura_directori.sh)	

NOM_DIRECTORI_BACKUP=directori_prova

# Creem el directori de backup, i el seu contingut, si no existeix
if [ ! -d "$NOM_DIRECTORI_BACKUP" ]
then
	./crea_estructura_directori.sh
fi

# Fem alguns canvis a l'estructura de directoris

rm -r "$NOM_DIRECTORI_BACKUP"/foo/baz
mkdir "$NOM_DIRECTORI_BACKUP"/bar/new$$

# Fem alguns canvis amb fitxers
if [ ! -e "$NOM_DIRECTORI_BACKUP"/e ]
then 
	echo 'contingut del nou fitxer e' > "$NOM_DIRECTORI_BACKUP"/e
fi

echo 'afegit contingut al fitxer b' >> "$NOM_DIRECTORI_BACKUP"/foo/b 
echo "contingut del nou fitxer $$" > "$NOM_DIRECTORI_BACKUP"/bar/new$$/$$

# Mostrem el contingut
tree -C "$NOM_DIRECTORI_BACKUP"

# A la línia que elimina el directori baz podríem fer un test o enviar possibles missatges d'error a /dev/null
