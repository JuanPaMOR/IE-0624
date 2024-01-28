import serial
import time

ser = serial.Serial(port='/tmp/ttyS1',baudrate=9600)

time.sleep(1)

while True:
    cad = ser.readline().decode('ascii')
    print(cad)
    print('******************')












