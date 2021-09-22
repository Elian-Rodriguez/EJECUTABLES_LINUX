import os
import subprocess
from subprocess import check_output

#CONEXION A BASE DE DATOS
import pymysql
#acendente
miConexion = pymysql.connect( host='10.26.1.161', user= 'bart',port=3306, passwd='Linux-1234', db='TIENDAS' )
cur = miConexion.cursor()

cur.execute( """  SELECT * FROM TIENDAS.Tienda where abierta =1 ORDER BY Cod_ncr ASC;""" )

datos = cur.fetchall()

nombre = "Validar_pos_server_masivo.sh"
#print("El ARCHIVO SE VA ALMACENAR CON EL NOMBRE :"+nombre)
COMANDO =""" #! /bin/bash """
COMANDO=COMANDO+"""\ndate ;"""
COMANDO=COMANDO+"""\nrm /home/despliegues-bogota/Pos_Server/Resultado_Pos_Server/* ;"""
for shop in datos:
    IP=shop[3]
    COD_POS= shop[0]
    Clave= "/home/despliegues-bogota/Pos_Server/NCR"

    Ejecucion = """  "pgrep srvdemon; " """
    COMANDO =COMANDO + "\nsudo sshpass  -f "+Clave+" ssh -o StrictHostKeyChecking=no root@"+IP+Ejecucion+""" > /home/despliegues-bogota/Pos_Server/Resultado_Pos_Server/"""+str(COD_POS)+""".txt; """



print (COMANDO)
from os import system

COMANDO=COMANDO+"""\nsudo python3 /home/despliegues-bogota/Pos_Server/Subir_resultado_pos_server.py;"""
COMANDO=COMANDO+"""\ndate ;"""
COMANDO=COMANDO+"""\n sudo sh /home/despliegues-bogota/Pos_Server/Validar_pos_server_masivo.sh;"""
archivo = open(nombre,'w')
archivo.write(COMANDO)
archivo.close()

