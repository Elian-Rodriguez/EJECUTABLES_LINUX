import os
import subprocess
from subprocess import check_output

#CONEXION A BASE DE DATOS
import pymysql
#acendente
miConexion = pymysql.connect( host='10.26.1.161', user= 'bart',port=3306, passwd='Linux-1234', db='TIENDAS' )
cur = miConexion.cursor()

cur.execute( """ SELECT * FROM TIENDAS.Tienda WHERE abierta = 1 order by Cod_ncr asc;  """ )

datos = cur.fetchall()

nombre = "Despliegue_archivos_Servidor.sh"
#print("El ARCHIVO SE VA ALMACENAR CON EL NOMBRE :"+nombre)
COMANDO =""" #! /bin/bash """
COMANDO=COMANDO+"""\ndate ;"""
for shop in datos:
    IP=shop[3]
    COD_POS= shop[0]
    Clave= "NCR"
    #COMENTADO CODIGO EN CASO DE EJECUCION DE ACCIONES DENTRO DE CADA SERVIDOR
    #Ejecucion = """  "sh /home/NCRServices/InterfaceService/ConsultaCarguePrecios.sh" """
    #COMANDO =COMANDO + "\nsudo sshpass  -f "+Clave+" ssh -o StrictHostKeyChecking=no root@"+IP+Ejecucion+""" > """+str(COD_POS)+""".txt; """
    #COMANDO=COMANDO+"""\ndate ;"""
    COMANDO =COMANDO+ """ \nsshpass -p 'linux'  scp  Recambio_v1.sh root@"""+IP+"""/tmp/"""
print (COMANDO)
from os import system



archivo = open(nombre,'w')
archivo.write(COMANDO)
archivo.close()

