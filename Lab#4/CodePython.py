import serial
import time

ser = serial.Serial(port='/dev/ttyACM0',baudrate=115200)

time.sleep(1)

while True:
    cad = ser.readline().decode('ascii')
    print(cad)
        












