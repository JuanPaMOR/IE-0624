#include <avr/io.h> 
#include <avr/interrupt.h> 
#include <util/delay.h>

#define LED PB0
#define LED2 PB1
#define LED3 PB2
#define LED4 PB7
#define SWITCH PINB3
#define SWITCH2 PINB4
#define SWITCH3 PINB5
#define SWITCH4 PINB6

int SUM_AGUA;
int LAVAR;
int ENJ;
int CENTRI;
int SELEC;
int CONT;
int unidades;
int decenas;
int INICIAR;
int estado;
int COUNTER;

ISR(PCINT0_vect) {
    if (PINB & _BV(SWITCH)){
        PORTB |= (1 << LED);
        PORTB &= ~(1 << LED2);
        PORTB &= ~(1 << LED3);
        SUM_AGUA = 1;
        LAVAR = 3;
        ENJ = 2;
        CENTRI = 3;
        SELEC = 1;
        PORTA |= (1 << PA0);

    }
    if (PINB & _BV(SWITCH2)){
        PORTB &= ~(1 << LED);
        PORTB |= (1 << LED2);
        PORTB &= ~(1 << LED3);
        SUM_AGUA = 2;
        LAVAR = 5;
        ENJ = 4;
        CENTRI = 5;
        SELEC = 1;
        PORTA |= (1 << PA0);
    }
    if (PINB & _BV(SWITCH3)){
        PORTB &= ~(1 << LED);
        PORTB &= ~(1 << LED2);
        PORTB |= (1 << LED3);
        SUM_AGUA = 3;
        LAVAR = 7;
        ENJ = 5;
        CENTRI = 6;
        SELEC = 1;
        PORTA |= (1 << PA0);
        
    }
    if (PINB & _BV(SWITCH4)){
        
        if(SELEC == 1){
          if(INICIAR == 1){
            INICIAR = 0;
            PORTA |= (1 << PA0);
            PORTA &= ~(1 << PA1);
            PORTA &= ~(1 << PA2);
            PORTD &= ~(1 << PD0);
            PORTD &= ~(1 << PD1);
            PORTB &= ~(1 << PB7);
            
          }
          else{
            CONT=0;
            estado = 1;
            INICIAR = 1;
          }
        }
    }
}

ISR(TIMER1_COMPA_vect) {  
    CONT++;
}

int main(void)
{
  CONT = 0;


  DDRB |= (_BV(LED) | _BV(LED2) | _BV(LED3) | _BV(LED4));  
  DDRD |= _BV(PD5);

	PCMSK |= (_BV(SWITCH) | _BV(SWITCH2) | _BV(SWITCH3) | _BV(SWITCH4)); 
	
	MCUCR = _BV(ISC01) | _BV(ISC00);    
	
	GIMSK |= _BV(PCIE0); 

  TCCR1B |= _BV(WGM12);
  TCCR1B |= _BV(CS12) | _BV(CS10);
  OCR1A = (F_CPU / (1024UL) - 1)*16.08;
  TIMSK |= _BV(OCIE1A);

  sei();  	            

  while (1){
    
    while (INICIAR==1)
    {
      switch (estado) {
        case 1:
            PORTA |= (1 << PA1);
            PORTA &= ~(1 << PA0);
            COUNTER=SUM_AGUA-CONT;
            if (COUNTER == 0){
              estado = 2;
            }
            break;
        case 2:
            PORTB |= (1 << PB7);
            PORTD |= (1 << PD1);
            PORTA &= ~(1 << PA1);
            COUNTER=SUM_AGUA+LAVAR-CONT;
            if (COUNTER == 0){
              estado = 3;
            }

            break;
        case 3:
            PORTD |= (1 << PD0);
            PORTD &= ~(1 << PD1);
            COUNTER=ENJ+SUM_AGUA+LAVAR-CONT;
            if (COUNTER == 0){
              estado = 4;
            }
            break;
        case 4:
            PORTA |= (1 << PA2);
            PORTD &= ~(1 << PD0);
            COUNTER=CENTRI+ENJ+SUM_AGUA+LAVAR-CONT;
            if (COUNTER == 0){
              INICIAR=0;
              PORTA &= ~(1 << PA2);
              PORTB &= ~(1 << PB7);
              PORTA |= (1 << PA0);
            }
            break;
        default:
            break;
      }
      unidades = COUNTER % 10;
		  decenas = COUNTER / 10;
      PORTD |= (1 << PD6);  
      PORTD &= ~((1 << PD5) | (1 << PD4) | (1 << PD3) | (1 << PD2));  
      PORTD |= ((unidades & 0x1) << PD2);
      PORTD |= (((unidades >> 1) & 0x1) << PD3);
      PORTD |= (((unidades >> 2) & 0x1) << PD4);
      PORTD |= (((unidades >> 3) & 0x1) << PD5);  
      _delay_ms(1);  

      
      PORTD &= ~(1 << PD6);  
      PORTD &= ~((1 << PD5) | (1 << PD4) | (1 << PD3) | (1 << PD2));  
      PORTD |= ((decenas & 0x1) << PD2); 
      PORTD |= (((decenas >> 1) & 0x1) << PD3);
      PORTD |= (((decenas >> 2) & 0x1) << PD4);
      PORTD |= (((decenas >> 3) & 0x1) << PD5);   
      _delay_ms(1);  

    }
    


    
    PORTD |= (1 << PD6);  
    PORTD &= ~((1 << PD5) | (1 << PD4) | (1 << PD3) | (1 << PD2));  
    _delay_ms(1);  

    
    PORTD &= ~(1 << PD6);  
    PORTD &= ~((1 << PD5) | (1 << PD4) | (1 << PD3) | (1 << PD2));  
    _delay_ms(1);  

  }
}
