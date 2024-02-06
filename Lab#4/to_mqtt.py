import paho.mqtt.client as mqtt
from time import sleep
import serial

import random

#######################################################################################

broker    ="iot.eie.ucr.ac.cr"
topic_pub ='v1/devices/me/telemetry'
username  = "Labo4_JuanPablo_Douglas"
password  = "ankl0zcocz3629wj41ik"

nulo = "0"

client = mqtt.Client(username)
client.username_pw_set(password)
client.connect(broker, 1883, 1)

client.loop_start()

serialPort = serial.Serial(port = "/dev/ttyACM0", baudrate=115200)

while True:
    #if(serialPort.in_waiting > 0):
        datos = serialPort.readline().decode('ascii', errors='ignore')
        #print(datos)
        datosEnviar = datos.split()
        cantidadDatos = len(datosEnviar)
        print(datosEnviar)
        print("cantidad elementos" + str(cantidadDatos))

        if cantidadDatos==8:
            EjeX = '{"EjeX":"'+ datosEnviar[1] + '"}'
            EjeY = '{"EjeY":"'+ datosEnviar[3] + '"}'
            EjeZ = '{"EjeZ":"'+ datosEnviar[5] + '"}'
            bateria = '{"bateria":"'+ datosEnviar[6] + '"}'
            transmite = '{"transmite":"'+ datosEnviar[7] + '"}'
            client.publish(topic_pub, EjeX)
            client.publish(topic_pub, EjeY)
            client.publish(topic_pub, EjeZ)
            client.publish(topic_pub, bateria)
            client.publish(topic_pub, transmite)
            sleep(1)
        else:
            EjeX = '{"EjeX":"'+ nulo + '"}'
            EjeY = '{"EjeY":"'+ nulo + '"}'
            EjeZ = '{"EjeZ":"'+ nulo + '"}'
            bateria = '{"bateria":"'+ nulo + '"}'
            transmite = '{"transmite":"'+ "No" + '"}'
            client.publish(topic_pub, EjeX)
            client.publish(topic_pub, EjeY)
            client.publish(topic_pub, EjeZ)
            client.publish(topic_pub, bateria)
            client.publish(topic_pub, transmite)
            sleep(1)
