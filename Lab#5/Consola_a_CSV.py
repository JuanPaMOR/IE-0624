import serial
import time
import csv


ser = serial.Serial(port='/dev/ttyACM0',baudrate=9600)

time.sleep(1)

archivo = "Movimiento Circulo"

titulo = ['X','Y','Z']

with open(archivo, mode='w', newline='') as datos:
    writer = csv.writer(datos)
    writer.writerow(titulo)


while True:
    XYZ = ser.readline().decode('ascii')
    XYZ = XYZ.split(',')
    with open(archivo, mode='a', newline='') as datos:
        writer = csv.writer(datos)
        writer.writerow(XYZ)
















