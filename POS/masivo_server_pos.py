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
cur.execute( """ SELECT Cod_ncr,IP_SERVER FROM TIENDAS.Tienda where abierta = 1 ; """ )
datos = cur.fetchall()
contadores = int(1)
for shop in datos:
    IP=shop[1]
    COD_POS= shop[0]
    Clave="/home/despliegues-bogota/ACCIONES_SERVIDOR/NCR"
    Resultado ="/home/despliegues-bogota/POS/"
    now = datetime.now()
    ip_pos =IP
    print(str(ip_pos)+" "+str(COD_POS))
    for i in range(1, 7):
        cadena=  """ "ssh p"""+str(i)+"""  grep 33 /home/reg/gd90/P_REGCONF.hierarchy.3900.FiscalNumber.XML | grep 43 | grep  -i ActionCode ; " """
        cadena = str(cadena)+ " > "+str(Resultado)+str(COD_POS)+"REG00"+str(i)+""".TXT"""
        comando = """sshpass  -f """+ str(Clave) +""" ssh -o StrictHostKeyChecking=no root@"""+str(ip_pos)+str(cadena)
        print (str(comando))
        print ("EJECUTAR ")
        system(comando)
        contadores = contadores +1
print(str(contadores)+" TOTAL DE POS VALIDADAS")

