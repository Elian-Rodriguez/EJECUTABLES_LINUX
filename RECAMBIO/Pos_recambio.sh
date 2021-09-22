        echo -e "INGRESEEL RANGO DE CAJAS A ENVIAR EL RESPALDO 1-4"
        cat /dev/null > /root/.ssh/known_hosts
        read RANG
        I=`echo $RANG|cut -c1`
        O=`echo $RANG|cut -c3`
        for (( i=$I; i<=$O; i++ ))
            do
                ping  -c5 -q p$i 1>/dev/null 2>&1
                if [ $? -eq 0 ];then
                    echo "		->ENVIANDO P_REGCONF.XM , *3900* , DE LA POS  $i"
                    scp /tmp/RECAMBIO/P$i/P_REGCONF.XML root@p$i:/home/reg/gd90/
                    scp /tmp/RECAMBIO/P$i/P_REGCONF.hierarchy.3900.FiscalNumber.XML   root@p$i:/home/reg/gd90/
                    scp /tmp/RECAMBIO/P$i/J* root@p$i:/home/reg/gd90/
                    
                    echo "		->ENVIANDO ARCHIVOS DE SAFE , DE LA POS  $i"
                    scp -r /tmp/RECAMBIO/P$i/safescp -r
                    
                    echo "		->ENVIANDO ARCHIVOS DE data , DE LA POS  $i"
                    scp -r  /tmp/RECAMBIO/P$i/data root@p$i:/home/reg/gd90/
                    echo "		->ENVIANDO ARCHIVOS DE safeinit DE LA POS  $i"
                    scp -r /tmp/RECAMBIO/P$i/safeinit  root@p$i:/home/reg/gd90/

                     echo "		->BAJANDO ARCHIVOS DE GdCmos.POS , DE LA POS  $i"
                    scp  -r /tmp/RECAMBIO/P$i/GdCmos.POS  root@p$i:/home/reg/gd90/
                    else
                        echo -e  "Caja $i No responde ping, pulse <Eneter> para continuar"
                        sleep 2
                        fi
        done