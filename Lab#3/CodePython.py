import serial
import time
import csv

ser = serial.Serial(port='/tmp/ttyS1',baudrate=9600)

time.sleep(1)

archivo = "datos.csv"

titulo = ['MODO','V1','V2','V3','V4']


with open(archivo, mode='w', newline='') as datos:
    writer = csv.writer(datos)
    writer.writerow(titulo)


while True:
    Voltajes = ser.readline().decode('ascii')
    Voltajes = Voltajes.split(',')
    with open(archivo, mode='a', newline='') as datos:
        writer = csv.writer(datos)
        writer.writerow(Voltajes)
        












