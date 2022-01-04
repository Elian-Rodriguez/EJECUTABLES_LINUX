import os
import subprocess
from subprocess import check_output
from pathlib import Path
import os


#CONEXION A BASE DE DATOS
import pymysql
#acendente
miConexion = pymysql.connect( host='10.26.1.161', user= 'bart',port=3306, passwd='Linux-1234', db='TIENDAS' )
cur = miConexion.cursor()

#cur.execute( """  SELECT * FROM TIENDAS.Tienda where abierta =1 ORDER BY Cod_ncr ASC;""" )
cur.execute( """   SELECT * FROM TIENDAS.Tienda where abierta =1 and Cod_ncr=17 ORDER BY Cod_ncr ASC ;  """ )

datos = cur.fetchall()
#Recorrido  a todas las tiendas
for shop in datos:
    IP=shop[3]
    COD_POS= shop[0]
    Nombre_tienda=shop[1]
    Clave= "/home/despliegues-bogota/POSServerRest/NCR"
    Ruta_Resultado ="/home/despliegues-bogota/POSServerRest/Resultado/"
    file_name=str(Ruta_Resultado)+str(COD_POS)+".txt"
    Ejecucion = """  "ls -l /tmp/Auto_POSServerRest.sh; " """
    COMANDO ="sudo sshpass  -f "+Clave+" ssh -o StrictHostKeyChecking=no root@"+IP+Ejecucion+" > "+str(Ruta_Resultado)+str(COD_POS)+".txt; "
    print ( str(COMANDO))
    os.system(COMANDO)
    Existe = os.path.isfile(file_name)
    print (" INICIO IF")
    if Existe == True:
        archivo = open(file_name,'r')
        Estado_Pos_Server = archivo.read()
        archivo.close()
        Estado ="Existe la tarea :"+ str(Estado_Pos_Server)
        print(str(Estado))
        valor =Path(file_name).stat().st_size
        if valor == 0:
            Estado = "NO EXISTE Archivo  "
            print(Estado)
            Auto_POSServerRest = "/home/despliegues-bogota/POSServerRest/Auto_POSServerRest.sh"
            Ejecucion =  " sshpass -p 'linux'  scp  " + Auto_POSServerRest + " root@"+IP+":/tmp/"
            os.system(Ejecucion)
            Ejecucion = """  "chmod 755 /tmp/Auto_POSServerRest.sh; " """
            COMANDO ="sudo sshpass  -f "+Clave+" ssh -o StrictHostKeyChecking=no root@"+IP+Ejecucion+" > "+str(Ruta_Resultado)+str(COD_POS)+".txt; "
            os.system(COMANDO)
        else:
            print("EL ARCHIVO /tmp/Auto_POSServerRest.sh EXISTE")

    else:
        print ("LA CONSULTA PARA LA TIENDA NUMERO  "+str(COD_POS) +" NO FUE PSOBLE DEBIDO A QUE EL ARCHIVO NO EXISTE\n")
        Estado = "NO EXISTE Archivo  "
        Auto_POSServerRest = "/home/despliegues-bogota/POSServerRest/Auto_POSServerRest.sh"
        Ejecucion =  " sshpass -p 'linux'  scp  " + Auto_POSServerRest + " root@"+IP+":/tmp/"
        os.system(Ejecucion)
        Ejecucion = """  "chmod 755 /tmp/Auto_POSServerRest.sh; " """
        COMANDO ="sudo sshpass  -f "+Clave+" ssh -o StrictHostKeyChecking=no root@"+IP+Ejecucion+" > "+str(Ruta_Resultado)+str(COD_POS)+".txt; "
        os.system(COMANDO)




    #Validar si existe en el crontab
    os.system("cat /dev/null > /home/despliegues-bogota/POSServerRest/Resultado/*.txt")
    Ejecucion = """  "grep -i Auto_POSServerRest /var/spool/cron/tabs/root; " """
    COMANDO ="sudo sshpass  -f "+Clave+" ssh -o StrictHostKeyChecking=no root@"+IP+Ejecucion+" > "+str(Ruta_Resultado)+str(COD_POS)+".txt; "
    os.system(COMANDO)

    from pathlib import Path
    fileName = r"/home/despliegues-bogota/POSServerRest/Resultado/"+str(COD_POS)+".txt;"
    fileObj = Path(fileName)
    print(str(fileObj.is_file()))


    file_size = os.stat(r"/home/despliegues-bogota/POSServerRest/Resultado/"+str(COD_POS)+".txt")
    print(file_size.st_size)

    valor=file_size.st_size
    Existe = os.path.isfile(file_name)
    print ("INICIO VALIDACION DE AUTO_POS_ EN CRONTAB "+str(Existe))


    print (str(valor))
    if valor == 0:
        Estado = "NO EXISTE Archivo  "
        Auto_POSServerRest = "/home/despliegues-bogota/POSServerRest/Auto_POSServerRest.sh"
        Ejecucion ="""  "  echo  '*/5 5-9 * * * sudo sh /tmp/Auto_POSServerRest.sh' >> /var/spool/cron/tabs/root ;" """
        COMANDO ="sudo sshpass  -f "+Clave+" ssh -o StrictHostKeyChecking=no root@"+IP+Ejecucion+" > "+str(Ruta_Resultado)+str(COD_POS)+".txt; "
        os.system(COMANDO)

    else:
        Estado = " EXISTE Archivo  "

                               