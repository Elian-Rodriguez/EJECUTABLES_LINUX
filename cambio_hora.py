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
            where idConf_pos ='1642REG003'
or idConf_pos ='1639REG001'
or idConf_pos ='1641REG001'
or idConf_pos ='1915REG003'
or idConf_pos ='605REG001'
or idConf_pos ='1552REG003'
or idConf_pos ='1642REG001'
or idConf_pos ='1300REG003'
or idConf_pos ='832REG004'
or idConf_pos ='571REG002'
or idConf_pos ='1759REG002'
or idConf_pos ='599REG003'
or idConf_pos ='1225REG002'
or idConf_pos ='1868REG001'
or idConf_pos ='862REG002'
or idConf_pos ='1898REG002'
or idConf_pos ='605REG002'
or idConf_pos ='584REG003'
or idConf_pos ='1788REG003'
or idConf_pos ='841REG004'
or idConf_pos ='1895REG001'
or idConf_pos ='661REG004'

            order by idConf_pos;  """ )
datos = cur.fetchall()

for shop in datos:
    IP=shop[1]
    COD_POS= shop[0]
    Clave="/home/despliegues-bogota/ACCIONES_SERVIDOR/"+str(shop[2])

    now = datetime.now()
    ip_pos =IP
    today = date.today()
    hora= now.time()

    print(str(ip_pos)+" "+str(COD_POS))
    comando = """sshpass  -f """+ str(Clave) +""" ssh -o StrictHostKeyChecking=no root@"""+str(ip_pos)+""" "hwclock;date";"""

    comando = """sshpass  -f """+ str(Clave) +""" ssh -o StrictHostKeyChecking=no root@"""+str(ip_pos)+""" "hwclock --set --date='"""+str(today)+" "+str(hora)+"""' ; init 6";"""
    #print (str(comando))
    print("EL COMANDO ES")
    print (str(comando))
    print ("EJECUTAR ")
    system(comando)
