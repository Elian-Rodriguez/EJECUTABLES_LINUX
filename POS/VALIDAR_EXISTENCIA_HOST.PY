from os import system
from os import system
from datetime import date
from datetime import datetime
import os
import subprocess
from subprocess import check_output
import pymysql
from openpyxl import load_workbook
import time

#Conexion a la base de datos
miConexion = pymysql.connect( host='10.26.1.161', user= 'bart',port=3306, passwd='Linux-1234', db='TIENDAS')
cur = miConexion.cursor()
#Consulta a de la base de datos
cur.execute( """ SELECT Cod_ncr,IP_SERVER FROM TIENDAS.Tienda where abierta = 1 ; """ )

filesheet = "Archivo_prueba.xlsx"
wb = load_workbook(filesheet)
nombres = wb.get_sheet_by_name('TIENDAS')

wb.close()
for i in range(1,222):
    COD_TIENDA, NOMBRE_CORTO, TIENDA_NCR,DIRECCION_IP,IP_NETWORK,CAMARAS,IP_FIJA,IP_GATEWAY,NUMERO_DE_POS = nombres[f'A{i}:I{i}'][0]
    print ("LA TIENDA "+str(NOMBRE_CORTO.value)+" TIENE NCR " + str(COD_TIENDA.value)+ " TIENE "+ str(NUMERO_DE_POS.value)+ " POS")
    
