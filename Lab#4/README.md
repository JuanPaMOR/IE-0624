Curso Laboratorio de Microcontroladores
Laboratorio 4

La carpeta Sismo contine el código necesario para compilar y ejecutar un sismografo, el cual detecta el movimiento
a traves del giroscopio de la tarjeta STM32F429.

Para compilar el programa se debe agregar la carpeta Sismo a la carpeta de ejemplos contenida en el repositorio
de libopencm3 examples, se puede clonar dicho repositorio desde
https://github.com/libopencm3/libopencm3-examples.git

Se debe generar un archivo .bin que debe ser cargado a la tarjeta STM32F429.
Dicho archivo .bin se puede crear a partir del comando

arm-none-eabi-objcopy -O binary firmware.elf firmware.bin

Para cargar el .bin a la tarjeta STM32F429 se debe ejecutar el comando

st-flash --reset write firmware.bin 0x8000000

El archivo to_mqtt.py es un script de python con instrucciones de MQTT que comunican
con un DashBoard en ThingsBoard. Envía el valor de los ejes y nivel de batería.

El código fue probado y diseñado en sistema operativo basado en linux.
