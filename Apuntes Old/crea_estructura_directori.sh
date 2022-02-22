#!/bin/bash
# Filename:		crea_estructura_directori.sh
# Author:		jamoros
# Date:			11/03/2018
# Version:		0.1
# License:		This is free software, licensed under the GNU General Public License v3.
#				See http://www.gnu.org/licenses/gpl.html for more information.
# Usage:		crea_estructura_directori.sh
# Description:	Script que crea ( o tornar a crear) un directori base i fitxers dintre
# 				per fer proves amb backups.

NOM_DIRECTORI_BACKUP=directori_prova

# Elimina el directori de backup, i el seu contingut, si existeix
if [ -d "$NOM_DIRECTORI_BACKUP" ]
then
	rm -r "$NOM_DIRECTORI_BACKUP"
fi

# Creem l'estructura de directoris i subdirectoris
mkdir -p "$NOM_DIRECTORI_BACKUP"/{foo/baz,bar}

# Creem uns quants fitxers
echo 'contingut de a' > "$NOM_DIRECTORI_BACKUP"/a
echo 'contingut de b' > "$NOM_DIRECTORI_BACKUP"/foo/b
echo 'contingut de c' > "$NOM_DIRECTORI_BACKUP"/bar/c
echo 'contingut de d' > "$NOM_DIRECTORI_BACKUP"/foo/baz/d

# Mostrem el contingut
tree -C "$NOM_DIRECTORI_BACKUP"

# OBS1: També es podrien fer variables els subdirectoris, però ...
# OBS2: També es podria posar a l'ordre tree l'opció -D
