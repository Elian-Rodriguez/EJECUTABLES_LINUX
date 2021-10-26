from os import system
from os import system
from datetime import date
from datetime import datetime
import os
import subprocess
from subprocess import check_output
import pymysql


#Conexion a la base de datos
miConexion = pymysql.connect( host='10.26.1.161', user= 'bart',port=3306, passwd='Linux-1234', db='TIENDAS')
cur = miConexion.cursor()
#Consulta a de la base de datos
cur.execute( """  SELECT Cod_Ncr,Ip_Server FROM Kardex_monitor.Tiendas where abierta = 1 and Cod_Ncr < 700; """ )
datos = cur.fetchall()

for shop in datos:
    IP=shop[1]
    COD_POS= shop[0]
    Clave="/home/despliegues-bogota/LISTA_DE_PRECIOS_SRV/NCR"

    now = datetime.now()
    ip_pos =IP
    today = date.today()
    hora= now.time()

    print(str(ip_pos)+" "+str(COD_POS))
    COMANTO="""  " sh /home/NCRServices/InterfaceService/ConsultaCarguePrecios.sh ;"  """
    comando = """sshpass  -f """+ str(Clave) +""" ssh -o StrictHostKeyChecking=no root@"""+str(ip_pos)+COMANTO+"""  >/home/despliegues-bogota/LISTA_DE_PRECIOS_SRV/RESULTADO/"""+ str(COD_POS)+""".TXT ;"""

    #print (str(comando))
    print("EL COMANDO ES")
    print (str(comando))
    print ("EJECUTAR ")
    system(comando)
