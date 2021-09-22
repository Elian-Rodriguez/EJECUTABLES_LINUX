#!/bin/bash

NORMAL='\033[0;0m'
BLUE='\033[1;34m'
BOLD_GREEN='\033[1;32m'
RED='\033[0;31m'
BOLD_RED='\033[1;31m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
NC='\e[0m'

PATHSRV=/home/server


pause(){
    read -p "Press [Enter] key to continue..." fackEnterKey
}
one(){
    echo -e "INGRESEEL RANGO DE CAJAS A REALIZAR EL RESPALDO: 1-4"
        read RANG
        I=`echo $RANG|cut -c1`
        O=`echo $RANG|cut -c3`
        for (( i=$I; i<=$O; i++ ))
            do
                ping  -c5 -q p$i 1>/dev/null 2>&1
                if [ $? -eq 0 ];then
                    echo "              ->Creando carpeta /tmp/RECAMBIO"
                    mkdir /tmp/RECAMBIO
                    echo "              ->Creando carpeta /tmp/RECAMBIO/P$i"
                    mkdir /tmp/RECAMBIO/P$i
                    echo "              ->BAJANDO P_REGCONF.XM , *3900* , DE LA POS  $i"
                    scp root@p$i:/home/reg/gd90/P_REGCONF.XML /tmp/RECAMBIO/P$i/
                    scp root@p$i:/home/reg/gd90/*3900* /tmp/RECAMBIO/P$i/
                    scp root@p$i:/home/reg/gd90/J* /tmp/RECAMBIO/P$i/
                    echo "              ->Creando carpeta  /tmp/RECAMBIO/P$i/safe"
                    mkdir /tmp/RECAMBIO/P$i/safe
                    echo "              ->BAJANDO ARCHIVOS DE SAFE , DE LA POS  $i"
                    scp root@p$i:/home/reg/gd90/safe/J* /tmp/RECAMBIO/P$i/safe/
                    scp root@p$i:/home/reg/gd90/safe/S_IDC* /tmp/RECAMBIO/P$i/safe/
                    echo "              ->Creando carpeta/tmp/RECAMBIO/P$i/data"
                    mkdir /tmp/RECAMBIO/P$i/data
                    echo "              ->BAJANDO ARCHIVOS DE data , DE LA POS  $i"
                    scp root@p$i:/home/reg/gd90/data/* /tmp/RECAMBIO/P$i/data/
                    echo "              ->/tmp/RECAMBIO/P$i/safeinit"
                    mkdir /tmp/RECAMBIO/P$i/safeinit
                    echo "              ->BAJANDO ARCHIVOS DE safeinit , DE LA POS  $i"
                    scp root@p$i:/home/reg/gd90/safeinit/S_IDC* /tmp/RECAMBIO/P$i/safeinit/
                    scp root@p$i:/home/reg/gd90/safeinit/J* /tmp/RECAMBIO/P$i/safeinit/
                    echo "             ->BAJANDO ARCHIVOS DE GdCmos.POS , DE LA POS  $i"
                    scp root@p$i:/home/reg/gd90/GdCmos.POS /tmp/RECAMBIO/P$i/
                    echo""
                    echo""
                    echo""
                    
                    echo -e "            ${BOLD_GREEN} -> BACKUP POS $i TERMINADO CON EXITO ${NC}"
					echo""
                    echo""
                    echo""
                    else
                        echo -e  " ${RED} Caja $i No responde ping, pulse <Eneter> para continuar${NC}"
						echo""
						echo""
						echo""
                        sleep 2
                        fi
        done
        echo""
        echo""
        echo "___________________________________________________"
        echo -e "  ${BLUE}                 RESUMEN                         ${NC}"
        echo "____________________________________________________"
        echo""
        ls -l  /tmp/RECAMBIO/P*
        echo""
        echo""
        echo "-----> RECUERDE VERIFICAR LA INFORMACION EN DIRECTORIO /tmp/RECAMBIO <-----"
        echo""
    pause
}

# do something in two()
two(){
        echo -e "INGRESEEL RANGO DE CAJAS A ENVIAR EL RESPALDO 1-4"
        cat /dev/null > /root/.ssh/known_hosts
        read RANG
        I=`echo $RANG|cut -c1`
        O=`echo $RANG|cut -c3`
        for (( i=$I; i<=$O; i++ ))
            do
                ping  -c5 -q p$i 1>/dev/null 2>&1
                if [ $? -eq 0 ];then
                    ssh p$i  killall xterm
                    echo "              ->ENVIANDO P_REGCONF.XM , *3900* , DE LA POS  $i"
                    scp /tmp/RECAMBIO/P$i/P_REGCONF.XML root@p$i:/home/reg/gd90/
                    scp /tmp/RECAMBIO/P$i/P_REGCONF.hierarchy.3900.FiscalNumber.XML   root@p$i:/home/reg/gd90/
                    scp /tmp/RECAMBIO/P$i/J* root@p$i:/home/reg/gd90/
                    echo "              ->ENVIANDO ARCHIVOS DE SAFE , DE LA POS  $i"
                    scp -r /tmp/RECAMBIO/P$i/safe  root@p$i:/home/reg/gd90/
                    echo "              ->ENVIANDO ARCHIVOS DE data , DE LA POS  $i"
                    scp -r  /tmp/RECAMBIO/P$i/data/*.OLD root@p$i:/home/reg/gd90/data/
                    echo "              ->ENVIANDO ARCHIVOS DE safeinit DE LA POS  $i"
                    scp -r /tmp/RECAMBIO/P$i/safeinit  root@p$i:/home/reg/gd90/
                    echo "              ->BAJANDO ARCHIVOS DE GdCmos.POS , DE LA POS  $i"
                    scp  -r /tmp/RECAMBIO/P$i/GdCmos.POS  root@p$i:/home/reg/gd90/
                    echo""
                    echo""
                    echo""
		    k="KEY"
		    cp $PATHSRV/P_REGKEY.DAT-XR4 $PATHSRV/P_00$i$k.DAT
                    cp $PATHSRV/P_REGKEY.DAT-XR4 $PATHSRV/lan/P_00$i$k.DAT
                    cp $PATHSRV/P_REGKEY.DAT-XR4 $PATHSRV/lan4srv/P_00$i$k.DAT
                    scp  $PATHSRV/P_REGKEY.DAT-XR4 p$i:/home/reg/gd90/P_REGKEY.DAT

		    ssh p$i date
			ssh p$i killall xterm
                    ssh p$i mv /home/reg/gd90/AUTOPOS.CTL /home/reg/gd90/AUTOPOS.CTL-b 
		    echo "              ->SE CAMBIO EL TIPO DE TECLADO A NCR  , A LA POS  $i"
                     echo -e "            ${BOLD_GREEN} -> REVIDAR LA HORA DE LA  POS $i  ${NC}"
		    echo -e "            ${BOLD_GREEN} -> RESTAURACION BACKUP POS $i CON EXITO ${NC}"
					echo""
                    echo""
                    echo""
		    



            else
                  echo -e  " ${RED} Caja $i No responde ping, pulse <Eneter> para continuar${NC}"

                        sleep 2
                        fi
        done
    pause
}

# function to display menus
show_menus() {
    clear
    echo ""
    echo "              MENU-SOLUCIONES-REG-BOGOTA             "
    echo ""
    echo " 1.  ADQUIRIR ARCHIVOS DE RESPALDO TODAS LAS POS."
    echo " 2.  ENVIAR ARCHIVOS DE RESPALDO TODAS LAS POS."
    echo " 3.  Exit."
    echo ""
    echo ""

}

read_options(){
 local choice
 read -p "DIGITRE LA OPCION [ 1 - 3] " choice
 case $choice in
  1) one ;;
  2) two ;;
  3) exit 0;;
  *) echo -e "${RED}Error...${NC}" && sleep 2
 esac
}

# ----------------------------------------------
# Trap CTRL+C, CTRL+Z and quit singles
# ----------------------------------------------
trap '' SIGINT SIGQUIT SIGTSTP

# -----------------------------------
# Main logic - infinite loop
# ------------------------------------
while true
do

 show_menus
 read_options
done
