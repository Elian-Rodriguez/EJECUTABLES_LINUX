#!/bin/bash
#-*-ENCODING: UTF-8 -*-

#cat /dev/null > /root/.ssh/known_hosts
echo""
echo "				<----EJECUTANDO RESPALDO---->"
echo ""
rm -R /tmp/RECAMBIO

echo "		->Creando carpeta /tmp/RECAMBIO"
echo""
mkdir /tmp/RECAMBIO
mkdir /tmp/RECAMBIO/P1
mkdir /tmp/RECAMBIO/P2
mkdir /tmp/RECAMBIO/P3
mkdir /tmp/RECAMBIO/P4
echo "		->Se crean las Carpetas POS"
echo""

#POS 1

echo "		->Copiando P1"
echo""
ping -c1 -w1 -q p1 2>/dev/null 1>&2
if [ $? -eq 0 ];then
echo "		------Copiando P_RECONF, *3900* Y ¨´J* de /gd90"
scp root@p1:/home/reg/gd90/P_REGCONF.XML /tmp/RECAMBIO/P1/
scp root@p1:/home/reg/gd90/*3900* /tmp/RECAMBIO/P1/
scp root@p1:/home/reg/gd90/J* /tmp/RECAMBIO/P1/
echo ""
echo "		------Creando directorio safe"
mkdir /tmp/RECAMBIO/P1/safe
echo""
echo "		------Copiando archivos J*, S_IDC*, de gd90/safe/"

scp root@p1:/home/reg/gd90/safe/J* /tmp/RECAMBIO/P1/safe/
scp root@p1:/home/reg/gd90/safe/S_IDC* /tmp/RECAMBIO/P1/safe/
echo""
echo "		------Creando directiro /data"
echo""
mkdir /tmp/RECAMBIO/P1/data

echo "		------Copiando archivo del directorio /data"
echo""
scp root@p1:/home/reg/gd90/data/* /tmp/RECAMBIO/P1/data/

echo "		------Creando directiro /safeinit"
echo""
mkdir /tmp/RECAMBIO/P1/safeinit

echo 		------"Copiando archivos S_IDC* y J* /safeinit"
scp root@p1:/home/reg/gd90/safeinit/S_IDC* /tmp/RECAMBIO/P1/safeinit/
scp root@p1:/home/reg/gd90/safeinit/J* /tmp/RECAMBIO/P1/safeinit/

echo "		-------Copiando GdCmos.POS"
echo""
scp root@p1:/home/reg/gd90/GdCmos.POS /tmp/RECAMBIO/P1/

echo "Terminado POS 1"
echo""
else
echo "   POS FUERA DE LINEA"
fi

#POS 2

echo""
echo "		->Copiando P2"

ping -c1 -w1 -q p2 2>/dev/null 1>&2
if [ $? -eq 0 ]; then

echo "		------Copiando P_RECONF, *3900* Y ¨´J* de /gd90"
scp root@p2:/home/reg/gd90/P_REGCONF.XML /tmp/RECAMBIO/P2/
scp root@p2:/home/reg/gd90/*3900* /tmp/RECAMBIO/P2/
scp root@p2:/home/reg/gd90/J* /tmp/RECAMBIO/P2/
echo ""
echo "		------Creando directorio safe"
mkdir /tmp/RECAMBIO/P2/safe
echo""
echo "		------Copiando archivos J*, S_IDC*, de gd90/safe/"

scp root@p2:/home/reg/gd90/safe/J* /tmp/RECAMBIO/P2/safe/
scp root@p2:/home/reg/gd90/safe/S_IDC* /tmp/RECAMBIO/P2/safe/
echo""
echo "		------Creando directiro /data"
echo""
mkdir /tmp/RECAMBIO/P2/data

echo "		------Copiando archivo del directorio /data"
echo""
scp root@p2:/home/reg/gd90/data/* /tmp/RECAMBIO/P2/data/

echo "		------Creando directiro /safeinit"
echo""
mkdir /tmp/RECAMBIO/P2/safeinit

echo 		------"Copiando archivos S_IDC* y J* /safeinit"
scp root@p2:/home/reg/gd90/safeinit/S_IDC* /tmp/RECAMBIO/P2/safeinit/
scp root@p2:/home/reg/gd90/safeinit/J* /tmp/RECAMBIO/P2/safeinit/

echo "		-------Copiando GdCmos.POS"
echo""
scp root@p2:/home/reg/gd90/GdCmos.POS /tmp/RECAMBIO/P2/

echo "Terminado POS 2"
echo""
else
echo "   POS FUERA DE LINEA"
fi


#POS 3

echo""
echo "		->Copiando P3"

ping -c1 -w1 -q p3 2>/dev/null 1>&2
if [ $? -eq 0 ]; then

echo "		------Copiando P_RECONF, *3900* Y ¨´J* de /gd90"
scp root@p3:/home/reg/gd90/P_REGCONF.XML /tmp/RECAMBIO/P3/
scp root@p3:/home/reg/gd90/*3900* /tmp/RECAMBIO/P3/
scp root@p3:/home/reg/gd90/J* /tmp/RECAMBIO/P3/
echo ""
echo "		------Creando directorio safe"
mkdir /tmp/RECAMBIO/P3/safe
echo""
echo "		------Copiando archivos J*, S_IDC*, de gd90/safe/"

scp root@p3:/home/reg/gd90/safe/J* /tmp/RECAMBIO/P3/safe/
scp root@p3:/home/reg/gd90/safe/S_IDC* /tmp/RECAMBIO/P3/safe/
echo""
echo "		------Creando directiro /data"
echo""
mkdir /tmp/RECAMBIO/P3/data

echo "		------Copiando archivo del directorio /data"
echo""
scp root@p3:/home/reg/gd90/data/* /tmp/RECAMBIO/P3/data/

echo "		------Creando directiro /safeinit"
echo""
mkdir /tmp/RECAMBIO/P3/safeinit

echo		" ------Copiando archivos S_IDC* y J* /safeinit"
scp root@p3:/home/reg/gd90/safeinit/S_IDC* /tmp/RECAMBIO/P3/safeinit/
scp root@p3:/home/reg/gd90/safeinit/J* /tmp/RECAMBIO/P3/safeinit/

echo "		-------Copiando GdCmos.POS"
echo""
scp root@p3:/home/reg/gd90/GdCmos.POS /tmp/RECAMBIO/P3/

echo "Terminado POS 3"
echo""
else
echo "   POS FUERA DE LINEA"
fi



#POS 4

echo""
echo "		->Copiando P4"

ping -c1 -w1 -q p4 2>/dev/null 1>&2
if [ $? -eq 0 ]; then

echo "		------Copiando P_RECONF, *3900* Y ¨´J* de /gd90"
scp root@p4:/home/reg/gd90/P_REGCONF.XML /tmp/RECAMBIO/P4/
scp root@p4:/home/reg/gd90/*3900* /tmp/RECAMBIO/P4/
scp root@p4:/home/reg/gd90/J* /tmp/RECAMBIO/P4/
echo ""
echo "		------Creando directorio safe"
mkdir /tmp/RECAMBIO/P4/safe
echo""
echo "		------Copiando archivos J*, S_IDC*, de gd90/safe/"

scp root@p4:/home/reg/gd90/safe/J* /tmp/RECAMBIO/P4/safe/
scp root@p4:/home/reg/gd90/safe/S_IDC* /tmp/RECAMBIO/P4/safe/
echo""
echo "		------Creando directiro /data"
echo""
mkdir /tmp/RECAMBIO/P4/data

echo "		------Copiando archivo del directorio /data"
echo""
scp root@p4:/home/reg/gd90/data/* /tmp/RECAMBIO/P4/data/

echo "		------Creando directiro /safeinit"
echo""
mkdir /tmp/RECAMBIO/P4/safeinit

echo "		------Copiando archivos S_IDC* y J* /safeinit"
scp root@p4:/home/reg/gd90/safeinit/S_IDC* /tmp/RECAMBIO/P4/safeinit/
scp root@p4:/home/reg/gd90/safeinit/J* /tmp/RECAMBIO/P4/safeinit/

echo "		-------Copiando GdCmos.POS"
echo""
scp root@p4:/home/reg/gd90/GdCmos.POS /tmp/RECAMBIO/P4/

echo "Terminado POS 4"
echo""
else
echo "   POS FUERA DE LINEA"
fi
echo""
echo""
echo "___________________________________________________"
echo "  			RESUMEN                         "
echo "___________________________________________________"
echo""
ls -l  /tmp/RECAMBIO/P*
echo""
echo""
echo "-----> RECUERDE VERIFICAR LA INFORMACION EN DIRECTORIO /tmp/RECAMBIO <-----"
echo""






exit
