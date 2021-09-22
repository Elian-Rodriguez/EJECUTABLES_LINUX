import os
import subprocess
from subprocess import check_output
from pathlib import Path

import pymysql

miConexion = pymysql.connect( host='10.26.1.161', user= 'lisa',port=3306, passwd='Linux-1234', db='Kardex_monitor' )
cur = miConexion.cursor()

#UPDATE `TIENDAS`.`Servicio` SET `Pos_Server` = '2' WHERE (`idServicio` = '17');

cur.execute( """  SELECT * FROM TIENDAS.Tienda where abierta =1 ORDER BY Cod_ncr ASC; """ )

datos = cur.fetchall()


for shop in datos:
    IP=shop[3]
    COD_NCR= shop[0]
    Nombre_tienda=shop[1]
    file_name="/home/despliegues-bogota/Pos_Server/Resultado_Pos_Server/"+str(COD_NCR)+".txt"
    
    Existe = os.path.isfile(file_name)
    if Existe == True:
        archivo = open(file_name,'r')
        Estado_Pos_Server = archivo.read()
        archivo.close()
        Estado ="ACTIVO PIP : "+ str(Estado_Pos_Server)

        valor =Path(file_name).stat().st_size
        if valor == 0:
            Estado = "NO ACTIVO"


        ACT ="""UPDATE `TIENDAS`.`Servicio` SET `Pos_Server` = '"""+Estado+"""' WHERE (`idServicio` = '"""+str(COD_NCR)+"""'); """

        print ("consulta realizada con exito "+str(COD_NCR)+"\n")
        cur.execute(ACT)
        miConexion.commit()
    else:
        print ("LA CONSULTA PARA LA TIENDA NUMERO  "+str(COD_NCR) +" NO FUE PSOBLE DEBIDO A QUE EL ARCHIVO NO EXISTE\n")

miConexion.close()