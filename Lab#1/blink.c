#include <pic14/pic12f683.h>

void delay (unsigned inttiempo); 

unsigned int miRand(unsigned int *lfsr) {
    // XOR de bits específicos del LFSR para retroalimentación
    unsigned int feedback = ((*lfsr >> 0) ^ (*lfsr >> 2) ^ (*lfsr >> 3) ^ (*lfsr >> 5)) & 1;

    // Desplazar el LFSR y agregar el bit de retroalimentación
    *lfsr = (*lfsr >> 1) | (feedback << 15);

    return *lfsr % 100;  // Ajusta el resultado para que esté en el rango de 0 a 99
}

void main(void)
{	unsigned int semilla = 42;
	int numeroGenerado, i;
    int numerosUsados[10]; 
    TRISIO = 0b00001000; //Poner todos los pines como salidas
	GPIO = 0x00; //Poner pines en bajo
	int unidades = 9;
	int decenas = 9;
	int cont = 0;
	int cont2 = 0;
	int rep = 1;
	int rep2 = 0;

    //Loop forever
    while ( 1 )
    {
		if(GP3 == 1)  // Si el pin de entrada es alto (positivo)
        {
			do {
				numeroGenerado = miRand(&semilla);
 				for (i = 0; i < cont+1; i++) {
					if (numerosUsados[i] == numeroGenerado) {
						rep2++;
						} // Se encontró el valor, salimos del bucle
					}
				if(rep2==0) {
					rep = 0;
				}	
				else {
					rep2=0;
				}


				}while (rep==1);  

			numerosUsados[cont] = numeroGenerado;  
			int numeroAleatorio = numeroGenerado;

		    unidades = numeroAleatorio % 10;
    		decenas = numeroAleatorio / 10;
			cont++;
			delay(100);
			


        } 
		else
        {
			
		if (cont == 10 && cont2 == 0)
		{
			unsigned int i;
			unsigned int j;
			unidades = 9;
    		decenas = 9;

	  			for(j=0;j<100;j++){
					GP0 = 1;
					GP1 = unidades & 0x1;
					GP2 = (unidades >> 1) & 0x1;
					GP4 = (unidades >> 2) & 0x1;
					GP5 = (unidades >> 3) & 0x1;
					delay(1);

					GP0 = 0;
					GP1 = decenas & 0x1;
					GP2 = (decenas >> 1) & 0x1;
					GP4 = (decenas >> 2) & 0x1;
					GP5 = (decenas >> 3) & 0x1;
					delay(1);
				}	


			unidades = 0;
    		decenas = 0;

	  			for(j=0;j<50;j++){
					GP0 = 1;
					GP1 = unidades & 0x1;
					GP2 = (unidades >> 1) & 0x1;
					GP4 = (unidades >> 2) & 0x1;
					GP5 = (unidades >> 3) & 0x1;
					delay(1);

					GP0 = 0;
					GP1 = decenas & 0x1;
					GP2 = (decenas >> 1) & 0x1;
					GP4 = (decenas >> 2) & 0x1;
					GP5 = (decenas >> 3) & 0x1;
					delay(1);
				}	


			unidades = 9;
    		decenas = 9;

	  			for(j=0;j<100;j++){
					GP0 = 1;
					GP1 = unidades & 0x1;
					GP2 = (unidades >> 1) & 0x1;
					GP4 = (unidades >> 2) & 0x1;
					GP5 = (unidades >> 3) & 0x1;
					delay(1);

					GP0 = 0;
					GP1 = decenas & 0x1;
					GP2 = (decenas >> 1) & 0x1;
					GP4 = (decenas >> 2) & 0x1;
					GP5 = (decenas >> 3) & 0x1;
					delay(1);
				}	


			unidades = 0;
    		decenas = 0;

	  			for(j=0;j<50;j++){
					GP0 = 1;
					GP1 = unidades & 0x1;
					GP2 = (unidades >> 1) & 0x1;
					GP4 = (unidades >> 2) & 0x1;
					GP5 = (unidades >> 3) & 0x1;
					delay(1);

					GP0 = 0;
					GP1 = decenas & 0x1;
					GP2 = (decenas >> 1) & 0x1;
					GP4 = (decenas >> 2) & 0x1;
					GP5 = (decenas >> 3) & 0x1;
					delay(1);
				}	

			unidades = 9;
    		decenas = 9;
			cont2++;
		
		}


			GP0 = 1;
			GP1 = unidades & 0x1;
			GP2 = (unidades >> 1) & 0x1;
			GP4 = (unidades >> 2) & 0x1;
			GP5 = (unidades >> 3) & 0x1;
			delay(1);


			GP0 = 0;
			GP1 = decenas & 0x1;
			GP2 = (decenas >> 1) & 0x1;
			GP4 = (decenas >> 2) & 0x1;
			GP5 = (decenas >> 3) & 0x1;
			delay(1);


        }


    }
 
}

void delay(unsigned int tiempo)
{
	unsigned int i;
	unsigned int j;

	for(i=0;i<tiempo;i++)
	  for(j=0;j<1000;j++);
}
