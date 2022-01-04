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
cur.execute( """ SELECT idConf_pos,IP_POS, TIPO_POS FROM Kardex_monitor.Conf_pos

            order by idConf_pos;  """ )
datos = cur.fetchall()

for shop in datos:
    IP=shop[1]
    COD_POS= shop[0]
    Clave="/home/despliegues-bogota/ACCIONES_SERVIDOR/"+str(shop[2])
    Resultado ="/home/despliegues-bogota/POS/"
    now = datetime.now()
    ip_pos =IP
    today = date.today()
    hora= now.time()

    print(str(ip_pos)+" "+str(COD_POS))
    comando = """sshpass  -f """+ str(Clave) +""" ssh -o StrictHostKeyChecking=no root@"""+str(ip_pos)+""" "  grep 33 /home/reg/gd90/P_REGCONF.hierarchy.3900.FiscalNumber.XML | grep 43 | grep ActionCode ; ">  """+ str(Resultado)+str(COD_POS)+""".TXT"""
    #print (str(comando))
    print("EL COMANDO ES")
    print (str(comando))
    print ("EJECUTAR ")
    system(comando)
