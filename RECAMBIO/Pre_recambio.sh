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
                    else
                        echo -e  "Caja $i No responde ping, pulse <Eneter> para continuar"
                        sleep 2
                        fi
        done
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