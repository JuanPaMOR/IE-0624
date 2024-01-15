;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.0.0 #11528 (Linux)
;--------------------------------------------------------
; PIC port for the 14-bit core
;--------------------------------------------------------
;	.file	"blink.c"
	list	p=12f683
	radix dec
	include "p12f683.inc"
;--------------------------------------------------------
; external declarations
;--------------------------------------------------------
	extern	__divsint
	extern	__modsint
	extern	__moduint
	extern	_TRISIO
	extern	_GPIO
	extern	_GPIObits
	extern	__gptrget2
	extern	__gptrput2
	extern	__sdcc_gsinit_startup
;--------------------------------------------------------
; global declarations
;--------------------------------------------------------
	global	_main
	global	_miRand
	global	_delay

	global PSAVE
	global SSAVE
	global WSAVE
	global STK12
	global STK11
	global STK10
	global STK09
	global STK08
	global STK07
	global STK06
	global STK05
	global STK04
	global STK03
	global STK02
	global STK01
	global STK00

sharebank udata_ovr 0x0070
PSAVE	res 1
SSAVE	res 1
WSAVE	res 1
STK12	res 1
STK11	res 1
STK10	res 1
STK09	res 1
STK08	res 1
STK07	res 1
STK06	res 1
STK05	res 1
STK04	res 1
STK03	res 1
STK02	res 1
STK01	res 1
STK00	res 1

;--------------------------------------------------------
; global definitions
;--------------------------------------------------------
;--------------------------------------------------------
; absolute symbol definitions
;--------------------------------------------------------
;--------------------------------------------------------
; compiler-defined variables
;--------------------------------------------------------
UDL_blink_0	udata
r0x1020	res	1
r0x101F	res	1
r0x101E	res	1
r0x1022	res	1
r0x1021	res	1
r0x1023	res	1
r0x1024	res	1
r0x1026	res	1
r0x1025	res	1
r0x1027	res	1
r0x1028	res	1
r0x1029	res	1
r0x102A	res	1
r0x102B	res	1
r0x102C	res	1
r0x102D	res	1
r0x102E	res	1
r0x102F	res	1
r0x1030	res	1
r0x1031	res	1
r0x1032	res	1
r0x1033	res	1
r0x1034	res	1
r0x1035	res	1
r0x1036	res	1
r0x1038	res	1
r0x1037	res	1
r0x1039	res	1
r0x103A	res	1
r0x103B	res	1
r0x103C	res	1
r0x103D	res	1
r0x103E	res	1
r0x103F	res	1
r0x1040	res	1
r0x1041	res	1
r0x1042	res	1
r0x1017	res	1
r0x1016	res	1
r0x1018	res	1
r0x1019	res	1
r0x101A	res	1
r0x101B	res	1
r0x101C	res	1
r0x101D	res	1
_main_semilla_65536_5	res	2
_main_numerosUsados_65536_5	res	20
;--------------------------------------------------------
; initialized data
;--------------------------------------------------------
;--------------------------------------------------------
; initialized absolute data
;--------------------------------------------------------
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
;	udata_ovr
;--------------------------------------------------------
; reset vector 
;--------------------------------------------------------
STARTUP	code 0x0000
	nop
	pagesel __sdcc_gsinit_startup
	goto	__sdcc_gsinit_startup
;--------------------------------------------------------
; code
;--------------------------------------------------------
code_blink	code
;***
;  pBlock Stats: dbName = M
;***
;has an exit
;functions called:
;   _miRand
;   __modsint
;   __divsint
;   _delay
;   _delay
;   _delay
;   _delay
;   _delay
;   _delay
;   _delay
;   _delay
;   _delay
;   _delay
;   _delay
;   _miRand
;   __modsint
;   __divsint
;   _delay
;   _delay
;   _delay
;   _delay
;   _delay
;   _delay
;   _delay
;   _delay
;   _delay
;   _delay
;   _delay
;31 compiler assigned registers:
;   r0x1027
;   r0x1028
;   r0x1029
;   r0x102A
;   r0x102B
;   r0x102C
;   r0x102D
;   r0x102E
;   r0x102F
;   r0x1030
;   r0x1031
;   r0x1032
;   r0x1033
;   r0x1034
;   r0x1035
;   r0x1036
;   r0x1037
;   r0x1038
;   r0x1039
;   STK01
;   STK00
;   r0x103A
;   r0x103B
;   r0x103C
;   r0x103D
;   r0x103E
;   r0x103F
;   r0x1040
;   r0x1041
;   r0x1042
;   STK02
;; Starting pCode block
S_blink__main	code
_main:
; 2 exit points
;	.line	16; "blink.c"	{	unsigned int semilla = 42;
	MOVLW	0x2a
	BANKSEL	_main_semilla_65536_5
	MOVWF	_main_semilla_65536_5
	CLRF	(_main_semilla_65536_5 + 1)
;	.line	19; "blink.c"	TRISIO = 0b00001000; //Poner todos los pines como salidas
	MOVLW	0x08
	BANKSEL	_TRISIO
	MOVWF	_TRISIO
;	.line	20; "blink.c"	GPIO = 0x00; //Poner pines en bajo
	BANKSEL	_GPIO
	CLRF	_GPIO
;	.line	21; "blink.c"	int unidades = 9;
	MOVLW	0x09
	BANKSEL	r0x1027
	MOVWF	r0x1027
	CLRF	r0x1028
;	.line	22; "blink.c"	int decenas = 9;
	MOVLW	0x09
	MOVWF	r0x1029
	CLRF	r0x102A
;	.line	25; "blink.c"	int rep = 1;
	MOVLW	0x01
	MOVWF	r0x102B
	CLRF	r0x102C
;	.line	26; "blink.c"	int rep2 = 0;
	CLRF	r0x102D
	CLRF	r0x102E
;	.line	29; "blink.c"	while ( 1 )
	CLRF	r0x102F
	CLRF	r0x1030
	CLRF	r0x1031
	CLRF	r0x1032
	CLRF	r0x1033
	CLRF	r0x1034
_00129_DS_:
;	.line	31; "blink.c"	if(GP3 == 1)  // Si el pin de entrada es alto (positivo)
	BANKSEL	r0x1035
	CLRF	r0x1035
	BANKSEL	_GPIObits
	BTFSS	_GPIObits,3
	GOTO	_00001_DS_
	BANKSEL	r0x1035
	INCF	r0x1035,F
_00001_DS_:
	BANKSEL	r0x1035
	MOVF	r0x1035,W
	XORLW	0x01
	BTFSS	STATUS,2
	GOTO	_00126_DS_
;	.line	33; "blink.c"	do {
	MOVLW	0x01
	ADDWF	r0x102F,W
	MOVWF	r0x1035
	CLRF	r0x1036
	RLF	r0x1036,F
	MOVF	r0x1030,W
	ADDWF	r0x1036,F
_00115_DS_:
;	.line	34; "blink.c"	numeroGenerado = miRand(&semilla);
	MOVLW	high (_main_semilla_65536_5 + 0)
	BANKSEL	r0x1037
	MOVWF	r0x1037
	MOVLW	(_main_semilla_65536_5 + 0)
	MOVWF	r0x1038
	CLRF	r0x1039
	MOVF	r0x1038,W
	MOVWF	STK01
	MOVF	r0x1037,W
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_miRand
	CALL	_miRand
	PAGESEL	$
	BANKSEL	r0x1037
	MOVWF	r0x1037
	MOVF	STK00,W
	MOVWF	r0x1038
;	.line	35; "blink.c"	for (i = 0; i < cont+1; i++) {
	MOVF	r0x102D,W
	MOVWF	r0x1039
	MOVF	r0x102E,W
	MOVWF	r0x103A
	CLRF	r0x103B
	CLRF	r0x103C
	CLRF	r0x103D
	CLRF	r0x103E
_00132_DS_:
	BANKSEL	r0x103C
	MOVF	r0x103C,W
	ADDLW	0x80
	MOVWF	r0x103F
	MOVF	r0x1036,W
	ADDLW	0x80
	SUBWF	r0x103F,W
	BTFSS	STATUS,2
	GOTO	_00238_DS_
	MOVF	r0x1035,W
	SUBWF	r0x103B,W
_00238_DS_:
	BTFSC	STATUS,0
	GOTO	_00161_DS_
;;genSkipc:3307: created from rifx:0x7ffdbea73950
;	.line	36; "blink.c"	if (numerosUsados[i] == numeroGenerado) {
	BANKSEL	r0x103D
	MOVF	r0x103D,W
	ADDLW	(_main_numerosUsados_65536_5 + 0)
	MOVWF	r0x103F
	MOVLW	high (_main_numerosUsados_65536_5 + 0)
	MOVWF	r0x1040
	MOVF	r0x103E,W
	BTFSC	STATUS,0
	INCFSZ	r0x103E,W
	ADDWF	r0x1040,F
	MOVF	r0x103F,W
	BANKSEL	FSR
	MOVWF	FSR
	BCF	STATUS,7
	BANKSEL	r0x1040
	BTFSC	r0x1040,0
	BSF	STATUS,7
	BANKSEL	INDF
	MOVF	INDF,W
	BANKSEL	r0x1041
	MOVWF	r0x1041
	BANKSEL	FSR
	INCF	FSR,F
	MOVF	INDF,W
	BANKSEL	r0x1042
	MOVWF	r0x1042
	MOVF	r0x1038,W
	XORWF	r0x1041,W
	BTFSS	STATUS,2
	GOTO	_00133_DS_
	MOVF	r0x1037,W
	XORWF	r0x1042,W
	BTFSS	STATUS,2
	GOTO	_00133_DS_
;	.line	37; "blink.c"	rep2++;
	INCF	r0x1039,F
	BTFSC	STATUS,2
	INCF	r0x103A,F
_00133_DS_:
;	.line	35; "blink.c"	for (i = 0; i < cont+1; i++) {
	MOVLW	0x02
	BANKSEL	r0x103D
	ADDWF	r0x103D,F
	BTFSC	STATUS,0
	INCF	r0x103E,F
	INCF	r0x103B,F
	BTFSC	STATUS,2
	INCF	r0x103C,F
	GOTO	_00132_DS_
_00161_DS_:
	BANKSEL	r0x1039
	MOVF	r0x1039,W
	MOVWF	r0x102D
	MOVF	r0x103A,W
	MOVWF	r0x102E
;	.line	40; "blink.c"	if(rep2==0) {
	MOVF	r0x103A,W
	IORWF	r0x1039,W
	BTFSS	STATUS,2
	GOTO	_00113_DS_
;	.line	41; "blink.c"	rep = 0;
	CLRF	r0x102B
	CLRF	r0x102C
	GOTO	_00116_DS_
_00113_DS_:
;	.line	44; "blink.c"	rep2=0;
	BANKSEL	r0x102D
	CLRF	r0x102D
	CLRF	r0x102E
_00116_DS_:
;	.line	48; "blink.c"	}while (rep==1);  
	BANKSEL	r0x102B
	MOVF	r0x102B,W
	XORLW	0x01
	BTFSS	STATUS,2
	GOTO	_00239_DS_
	MOVF	r0x102C,W
;	.line	50; "blink.c"	numerosUsados[cont] = numeroGenerado;  
	XORLW	0x00
	BTFSC	STATUS,2
	GOTO	_00115_DS_
_00239_DS_:
	BANKSEL	r0x1033
	MOVF	r0x1033,W
	ADDLW	(_main_numerosUsados_65536_5 + 0)
	MOVWF	r0x1035
	MOVLW	high (_main_numerosUsados_65536_5 + 0)
	MOVWF	r0x1036
	MOVF	r0x1034,W
	BTFSC	STATUS,0
	INCFSZ	r0x1034,W
	ADDWF	r0x1036,F
	MOVF	r0x1035,W
	BANKSEL	FSR
	MOVWF	FSR
	BCF	STATUS,7
	BANKSEL	r0x1036
	BTFSC	r0x1036,0
	BSF	STATUS,7
	MOVF	r0x1038,W
	BANKSEL	INDF
	MOVWF	INDF
	INCF	FSR,F
	BANKSEL	r0x1037
	MOVF	r0x1037,W
	BANKSEL	INDF
	MOVWF	INDF
;	.line	53; "blink.c"	unidades = numeroAleatorio % 10;
	MOVLW	0x0a
	MOVWF	STK02
	MOVLW	0x00
	MOVWF	STK01
	BANKSEL	r0x1038
	MOVF	r0x1038,W
	MOVWF	STK00
	MOVF	r0x1037,W
	PAGESEL	__modsint
	CALL	__modsint
	PAGESEL	$
	BANKSEL	r0x1028
	MOVWF	r0x1028
	MOVF	STK00,W
	MOVWF	r0x1027
;	.line	54; "blink.c"	decenas = numeroAleatorio / 10;
	MOVLW	0x0a
	MOVWF	STK02
	MOVLW	0x00
	MOVWF	STK01
	MOVF	r0x1038,W
	MOVWF	STK00
	MOVF	r0x1037,W
	PAGESEL	__divsint
	CALL	__divsint
	PAGESEL	$
	BANKSEL	r0x102A
	MOVWF	r0x102A
	MOVF	STK00,W
	MOVWF	r0x1029
;	.line	55; "blink.c"	cont++;
	MOVLW	0x02
	ADDWF	r0x1033,F
	BTFSC	STATUS,0
	INCF	r0x1034,F
	INCF	r0x102F,F
	BTFSC	STATUS,2
	INCF	r0x1030,F
;	.line	56; "blink.c"	delay(100);
	MOVLW	0x64
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
	GOTO	_00129_DS_
_00126_DS_:
;	.line	64; "blink.c"	if (cont == 10 && cont2 == 0)
	BANKSEL	r0x102F
	MOVF	r0x102F,W
	XORLW	0x0a
	BTFSS	STATUS,2
	GOTO	_00123_DS_
	MOVF	r0x1030,W
	XORLW	0x00
	BTFSS	STATUS,2
	GOTO	_00123_DS_
	MOVF	r0x1032,W
	IORWF	r0x1031,W
	BTFSS	STATUS,2
	GOTO	_00123_DS_
;	.line	68; "blink.c"	unidades = 9;
	MOVLW	0x09
	MOVWF	r0x1027
	CLRF	r0x1028
;	.line	69; "blink.c"	decenas = 9;
	MOVLW	0x09
	MOVWF	r0x1035
	CLRF	r0x1036
;	.line	71; "blink.c"	for(j=0;j<100;j++){
	CLRF	r0x1038
	CLRF	r0x1037
_00134_DS_:
;	.line	72; "blink.c"	GP0 = 1;
	BANKSEL	_GPIObits
	BSF	_GPIObits,0
;	.line	73; "blink.c"	GP1 = unidades & 0x1;
	BANKSEL	r0x1027
	MOVF	r0x1027,W
	MOVWF	r0x1039
	RRF	r0x1039,W
	BTFSC	STATUS,0
	GOTO	_00002_DS_
	BANKSEL	_GPIObits
	BCF	_GPIObits,1
_00002_DS_:
	BTFSS	STATUS,0
	GOTO	_00003_DS_
	BANKSEL	_GPIObits
	BSF	_GPIObits,1
_00003_DS_:
;	.line	74; "blink.c"	GP2 = (unidades >> 1) & 0x1;
	BANKSEL	_GPIObits
	BCF	_GPIObits,2
;	.line	75; "blink.c"	GP4 = (unidades >> 2) & 0x1;
	BCF	_GPIObits,4
;	.line	76; "blink.c"	GP5 = (unidades >> 3) & 0x1;
	BSF	_GPIObits,5
;	.line	77; "blink.c"	delay(1);
	MOVLW	0x01
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
;	.line	79; "blink.c"	GP0 = 0;
	BANKSEL	_GPIObits
	BCF	_GPIObits,0
;	.line	80; "blink.c"	GP1 = decenas & 0x1;
	BANKSEL	r0x1035
	MOVF	r0x1035,W
	MOVWF	r0x1039
	RRF	r0x1039,W
	BTFSC	STATUS,0
	GOTO	_00004_DS_
	BANKSEL	_GPIObits
	BCF	_GPIObits,1
_00004_DS_:
	BTFSS	STATUS,0
	GOTO	_00005_DS_
	BANKSEL	_GPIObits
	BSF	_GPIObits,1
_00005_DS_:
;	.line	81; "blink.c"	GP2 = (decenas >> 1) & 0x1;
	BANKSEL	_GPIObits
	BCF	_GPIObits,2
;	.line	82; "blink.c"	GP4 = (decenas >> 2) & 0x1;
	BCF	_GPIObits,4
;	.line	83; "blink.c"	GP5 = (decenas >> 3) & 0x1;
	BSF	_GPIObits,5
;	.line	84; "blink.c"	delay(1);
	MOVLW	0x01
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
;	.line	71; "blink.c"	for(j=0;j<100;j++){
	BANKSEL	r0x1038
	INCF	r0x1038,F
	BTFSC	STATUS,2
	INCF	r0x1037,F
;;unsigned compare: left < lit(0x64=100), size=2
	MOVLW	0x00
	SUBWF	r0x1037,W
	BTFSS	STATUS,2
	GOTO	_00240_DS_
	MOVLW	0x64
	SUBWF	r0x1038,W
_00240_DS_:
	BTFSS	STATUS,0
	GOTO	_00134_DS_
;;genSkipc:3307: created from rifx:0x7ffdbea73950
;	.line	88; "blink.c"	unidades = 0;
	BANKSEL	r0x1027
	CLRF	r0x1027
	CLRF	r0x1028
;	.line	89; "blink.c"	decenas = 0;
	CLRF	r0x1035
	CLRF	r0x1036
;	.line	91; "blink.c"	for(j=0;j<50;j++){
	CLRF	r0x1038
	CLRF	r0x1037
_00136_DS_:
;	.line	92; "blink.c"	GP0 = 1;
	BANKSEL	_GPIObits
	BSF	_GPIObits,0
;	.line	93; "blink.c"	GP1 = unidades & 0x1;
	BANKSEL	r0x1027
	MOVF	r0x1027,W
	MOVWF	r0x1039
	RRF	r0x1039,W
	BTFSC	STATUS,0
	GOTO	_00006_DS_
	BANKSEL	_GPIObits
	BCF	_GPIObits,1
_00006_DS_:
	BTFSS	STATUS,0
	GOTO	_00007_DS_
	BANKSEL	_GPIObits
	BSF	_GPIObits,1
_00007_DS_:
;	.line	94; "blink.c"	GP2 = (unidades >> 1) & 0x1;
	BANKSEL	_GPIObits
	BCF	_GPIObits,2
;	.line	95; "blink.c"	GP4 = (unidades >> 2) & 0x1;
	BCF	_GPIObits,4
;	.line	96; "blink.c"	GP5 = (unidades >> 3) & 0x1;
	BCF	_GPIObits,5
;	.line	97; "blink.c"	delay(1);
	MOVLW	0x01
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
;	.line	99; "blink.c"	GP0 = 0;
	BANKSEL	_GPIObits
	BCF	_GPIObits,0
;	.line	100; "blink.c"	GP1 = decenas & 0x1;
	BANKSEL	r0x1035
	MOVF	r0x1035,W
	MOVWF	r0x1039
	RRF	r0x1039,W
	BTFSC	STATUS,0
	GOTO	_00008_DS_
	BANKSEL	_GPIObits
	BCF	_GPIObits,1
_00008_DS_:
	BTFSS	STATUS,0
	GOTO	_00009_DS_
	BANKSEL	_GPIObits
	BSF	_GPIObits,1
_00009_DS_:
;	.line	101; "blink.c"	GP2 = (decenas >> 1) & 0x1;
	BANKSEL	_GPIObits
	BCF	_GPIObits,2
;	.line	102; "blink.c"	GP4 = (decenas >> 2) & 0x1;
	BCF	_GPIObits,4
;	.line	103; "blink.c"	GP5 = (decenas >> 3) & 0x1;
	BCF	_GPIObits,5
;	.line	104; "blink.c"	delay(1);
	MOVLW	0x01
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
;	.line	91; "blink.c"	for(j=0;j<50;j++){
	BANKSEL	r0x1038
	INCF	r0x1038,F
	BTFSC	STATUS,2
	INCF	r0x1037,F
;;unsigned compare: left < lit(0x32=50), size=2
	MOVLW	0x00
	SUBWF	r0x1037,W
	BTFSS	STATUS,2
	GOTO	_00241_DS_
	MOVLW	0x32
	SUBWF	r0x1038,W
_00241_DS_:
	BTFSS	STATUS,0
	GOTO	_00136_DS_
;;genSkipc:3307: created from rifx:0x7ffdbea73950
;	.line	108; "blink.c"	unidades = 9;
	MOVLW	0x09
	BANKSEL	r0x1027
	MOVWF	r0x1027
	CLRF	r0x1028
;	.line	109; "blink.c"	decenas = 9;
	MOVLW	0x09
	MOVWF	r0x1035
	CLRF	r0x1036
;	.line	111; "blink.c"	for(j=0;j<100;j++){
	CLRF	r0x1038
	CLRF	r0x1037
_00138_DS_:
;	.line	112; "blink.c"	GP0 = 1;
	BANKSEL	_GPIObits
	BSF	_GPIObits,0
;	.line	113; "blink.c"	GP1 = unidades & 0x1;
	BANKSEL	r0x1027
	MOVF	r0x1027,W
	MOVWF	r0x1039
	RRF	r0x1039,W
	BTFSC	STATUS,0
	GOTO	_00010_DS_
	BANKSEL	_GPIObits
	BCF	_GPIObits,1
_00010_DS_:
	BTFSS	STATUS,0
	GOTO	_00011_DS_
	BANKSEL	_GPIObits
	BSF	_GPIObits,1
_00011_DS_:
;	.line	114; "blink.c"	GP2 = (unidades >> 1) & 0x1;
	BANKSEL	_GPIObits
	BCF	_GPIObits,2
;	.line	115; "blink.c"	GP4 = (unidades >> 2) & 0x1;
	BCF	_GPIObits,4
;	.line	116; "blink.c"	GP5 = (unidades >> 3) & 0x1;
	BSF	_GPIObits,5
;	.line	117; "blink.c"	delay(1);
	MOVLW	0x01
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
;	.line	119; "blink.c"	GP0 = 0;
	BANKSEL	_GPIObits
	BCF	_GPIObits,0
;	.line	120; "blink.c"	GP1 = decenas & 0x1;
	BANKSEL	r0x1035
	MOVF	r0x1035,W
	MOVWF	r0x1039
	RRF	r0x1039,W
	BTFSC	STATUS,0
	GOTO	_00012_DS_
	BANKSEL	_GPIObits
	BCF	_GPIObits,1
_00012_DS_:
	BTFSS	STATUS,0
	GOTO	_00013_DS_
	BANKSEL	_GPIObits
	BSF	_GPIObits,1
_00013_DS_:
;	.line	121; "blink.c"	GP2 = (decenas >> 1) & 0x1;
	BANKSEL	_GPIObits
	BCF	_GPIObits,2
;	.line	122; "blink.c"	GP4 = (decenas >> 2) & 0x1;
	BCF	_GPIObits,4
;	.line	123; "blink.c"	GP5 = (decenas >> 3) & 0x1;
	BSF	_GPIObits,5
;	.line	124; "blink.c"	delay(1);
	MOVLW	0x01
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
;	.line	111; "blink.c"	for(j=0;j<100;j++){
	BANKSEL	r0x1038
	INCF	r0x1038,F
	BTFSC	STATUS,2
	INCF	r0x1037,F
;;unsigned compare: left < lit(0x64=100), size=2
	MOVLW	0x00
	SUBWF	r0x1037,W
	BTFSS	STATUS,2
	GOTO	_00242_DS_
	MOVLW	0x64
	SUBWF	r0x1038,W
_00242_DS_:
	BTFSS	STATUS,0
	GOTO	_00138_DS_
;;genSkipc:3307: created from rifx:0x7ffdbea73950
;	.line	128; "blink.c"	unidades = 0;
	BANKSEL	r0x1027
	CLRF	r0x1027
	CLRF	r0x1028
;	.line	129; "blink.c"	decenas = 0;
	CLRF	r0x1035
	CLRF	r0x1036
;	.line	131; "blink.c"	for(j=0;j<50;j++){
	CLRF	r0x1038
	CLRF	r0x1037
_00140_DS_:
;	.line	132; "blink.c"	GP0 = 1;
	BANKSEL	_GPIObits
	BSF	_GPIObits,0
;	.line	133; "blink.c"	GP1 = unidades & 0x1;
	BANKSEL	r0x1027
	MOVF	r0x1027,W
	MOVWF	r0x1039
	RRF	r0x1039,W
	BTFSC	STATUS,0
	GOTO	_00014_DS_
	BANKSEL	_GPIObits
	BCF	_GPIObits,1
_00014_DS_:
	BTFSS	STATUS,0
	GOTO	_00015_DS_
	BANKSEL	_GPIObits
	BSF	_GPIObits,1
_00015_DS_:
;	.line	134; "blink.c"	GP2 = (unidades >> 1) & 0x1;
	BANKSEL	_GPIObits
	BCF	_GPIObits,2
;	.line	135; "blink.c"	GP4 = (unidades >> 2) & 0x1;
	BCF	_GPIObits,4
;	.line	136; "blink.c"	GP5 = (unidades >> 3) & 0x1;
	BCF	_GPIObits,5
;	.line	137; "blink.c"	delay(1);
	MOVLW	0x01
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
;	.line	139; "blink.c"	GP0 = 0;
	BANKSEL	_GPIObits
	BCF	_GPIObits,0
;	.line	140; "blink.c"	GP1 = decenas & 0x1;
	BANKSEL	r0x1035
	MOVF	r0x1035,W
	MOVWF	r0x1039
	RRF	r0x1039,W
	BTFSC	STATUS,0
	GOTO	_00016_DS_
	BANKSEL	_GPIObits
	BCF	_GPIObits,1
_00016_DS_:
	BTFSS	STATUS,0
	GOTO	_00017_DS_
	BANKSEL	_GPIObits
	BSF	_GPIObits,1
_00017_DS_:
;	.line	141; "blink.c"	GP2 = (decenas >> 1) & 0x1;
	BANKSEL	_GPIObits
	BCF	_GPIObits,2
;	.line	142; "blink.c"	GP4 = (decenas >> 2) & 0x1;
	BCF	_GPIObits,4
;	.line	143; "blink.c"	GP5 = (decenas >> 3) & 0x1;
	BCF	_GPIObits,5
;	.line	144; "blink.c"	delay(1);
	MOVLW	0x01
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
;	.line	131; "blink.c"	for(j=0;j<50;j++){
	BANKSEL	r0x1038
	INCF	r0x1038,F
	BTFSC	STATUS,2
	INCF	r0x1037,F
;;unsigned compare: left < lit(0x32=50), size=2
	MOVLW	0x00
	SUBWF	r0x1037,W
	BTFSS	STATUS,2
	GOTO	_00243_DS_
	MOVLW	0x32
	SUBWF	r0x1038,W
_00243_DS_:
	BTFSS	STATUS,0
	GOTO	_00140_DS_
;;genSkipc:3307: created from rifx:0x7ffdbea73950
;	.line	147; "blink.c"	unidades = 9;
	MOVLW	0x09
	BANKSEL	r0x1027
	MOVWF	r0x1027
	CLRF	r0x1028
;	.line	148; "blink.c"	decenas = 9;
	MOVLW	0x09
	MOVWF	r0x1029
	CLRF	r0x102A
;	.line	149; "blink.c"	cont2++;
	INCF	r0x1031,F
	BTFSC	STATUS,2
	INCF	r0x1032,F
_00123_DS_:
;	.line	154; "blink.c"	GP0 = 1;
	BANKSEL	_GPIObits
	BSF	_GPIObits,0
;	.line	155; "blink.c"	GP1 = unidades & 0x1;
	BANKSEL	r0x1027
	MOVF	r0x1027,W
	MOVWF	r0x1035
	RRF	r0x1035,W
	BTFSC	STATUS,0
	GOTO	_00018_DS_
	BANKSEL	_GPIObits
	BCF	_GPIObits,1
_00018_DS_:
	BTFSS	STATUS,0
	GOTO	_00019_DS_
	BANKSEL	_GPIObits
	BSF	_GPIObits,1
_00019_DS_:
;	.line	156; "blink.c"	GP2 = (unidades >> 1) & 0x1;
	BANKSEL	r0x1027
	MOVF	r0x1027,W
	ANDLW	0x02
	BTFSS	STATUS,2
	MOVLW	0x01
	MOVWF	r0x1035
	RRF	r0x1035,W
	BTFSC	STATUS,0
	GOTO	_00020_DS_
	BANKSEL	_GPIObits
	BCF	_GPIObits,2
_00020_DS_:
	BTFSS	STATUS,0
	GOTO	_00021_DS_
	BANKSEL	_GPIObits
	BSF	_GPIObits,2
_00021_DS_:
;	.line	157; "blink.c"	GP4 = (unidades >> 2) & 0x1;
	BANKSEL	r0x1027
	MOVF	r0x1027,W
	ANDLW	0x04
	BTFSS	STATUS,2
	MOVLW	0x01
	MOVWF	r0x1035
	RRF	r0x1035,W
	BTFSC	STATUS,0
	GOTO	_00022_DS_
	BANKSEL	_GPIObits
	BCF	_GPIObits,4
_00022_DS_:
	BTFSS	STATUS,0
	GOTO	_00023_DS_
	BANKSEL	_GPIObits
	BSF	_GPIObits,4
_00023_DS_:
;	.line	158; "blink.c"	GP5 = (unidades >> 3) & 0x1;
	BANKSEL	r0x1027
	MOVF	r0x1027,W
	ANDLW	0x08
	BTFSS	STATUS,2
	MOVLW	0x01
	MOVWF	r0x1035
	RRF	r0x1035,W
	BTFSC	STATUS,0
	GOTO	_00024_DS_
	BANKSEL	_GPIObits
	BCF	_GPIObits,5
_00024_DS_:
	BTFSS	STATUS,0
	GOTO	_00025_DS_
	BANKSEL	_GPIObits
	BSF	_GPIObits,5
_00025_DS_:
;	.line	159; "blink.c"	delay(1);
	MOVLW	0x01
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
;	.line	162; "blink.c"	GP0 = 0;
	BANKSEL	_GPIObits
	BCF	_GPIObits,0
;	.line	163; "blink.c"	GP1 = decenas & 0x1;
	BANKSEL	r0x1029
	MOVF	r0x1029,W
	MOVWF	r0x1035
	RRF	r0x1035,W
	BTFSC	STATUS,0
	GOTO	_00026_DS_
	BANKSEL	_GPIObits
	BCF	_GPIObits,1
_00026_DS_:
	BTFSS	STATUS,0
	GOTO	_00027_DS_
	BANKSEL	_GPIObits
	BSF	_GPIObits,1
_00027_DS_:
;	.line	164; "blink.c"	GP2 = (decenas >> 1) & 0x1;
	BANKSEL	r0x1029
	MOVF	r0x1029,W
	ANDLW	0x02
	BTFSS	STATUS,2
	MOVLW	0x01
	MOVWF	r0x1035
	RRF	r0x1035,W
	BTFSC	STATUS,0
	GOTO	_00028_DS_
	BANKSEL	_GPIObits
	BCF	_GPIObits,2
_00028_DS_:
	BTFSS	STATUS,0
	GOTO	_00029_DS_
	BANKSEL	_GPIObits
	BSF	_GPIObits,2
_00029_DS_:
;	.line	165; "blink.c"	GP4 = (decenas >> 2) & 0x1;
	BANKSEL	r0x1029
	MOVF	r0x1029,W
	ANDLW	0x04
	BTFSS	STATUS,2
	MOVLW	0x01
	MOVWF	r0x1035
	RRF	r0x1035,W
	BTFSC	STATUS,0
	GOTO	_00030_DS_
	BANKSEL	_GPIObits
	BCF	_GPIObits,4
_00030_DS_:
	BTFSS	STATUS,0
	GOTO	_00031_DS_
	BANKSEL	_GPIObits
	BSF	_GPIObits,4
_00031_DS_:
;	.line	166; "blink.c"	GP5 = (decenas >> 3) & 0x1;
	BANKSEL	r0x1029
	MOVF	r0x1029,W
	ANDLW	0x08
	BTFSS	STATUS,2
	MOVLW	0x01
	MOVWF	r0x1035
	RRF	r0x1035,W
	BTFSC	STATUS,0
	GOTO	_00032_DS_
	BANKSEL	_GPIObits
	BCF	_GPIObits,5
_00032_DS_:
	BTFSS	STATUS,0
	GOTO	_00033_DS_
	BANKSEL	_GPIObits
	BSF	_GPIObits,5
_00033_DS_:
;	.line	167; "blink.c"	delay(1);
	MOVLW	0x01
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay
	CALL	_delay
	PAGESEL	$
	GOTO	_00129_DS_
;	.line	175; "blink.c"	}
	RETURN	
; exit point of _main

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;9 compiler assigned registers:
;   r0x1016
;   STK00
;   r0x1017
;   r0x1018
;   r0x1019
;   r0x101A
;   r0x101B
;   r0x101C
;   r0x101D
;; Starting pCode block
S_blink__delay	code
_delay:
; 2 exit points
;	.line	177; "blink.c"	void delay(unsigned int tiempo)
	BANKSEL	r0x1016
	MOVWF	r0x1016
	MOVF	STK00,W
	MOVWF	r0x1017
;	.line	182; "blink.c"	for(i=0;i<tiempo;i++)
	CLRF	r0x1018
	CLRF	r0x1019
_00254_DS_:
	BANKSEL	r0x1016
	MOVF	r0x1016,W
	SUBWF	r0x1019,W
	BTFSS	STATUS,2
	GOTO	_00275_DS_
	MOVF	r0x1017,W
	SUBWF	r0x1018,W
_00275_DS_:
	BTFSC	STATUS,0
	GOTO	_00256_DS_
;;genSkipc:3307: created from rifx:0x7ffdbea73950
;	.line	183; "blink.c"	for(j=0;j<1000;j++);
	MOVLW	0xe8
	BANKSEL	r0x101A
	MOVWF	r0x101A
	MOVLW	0x03
	MOVWF	r0x101B
_00252_DS_:
	MOVLW	0xff
	BANKSEL	r0x101A
	ADDWF	r0x101A,W
	MOVWF	r0x101C
	MOVLW	0xff
	MOVWF	r0x101D
	MOVF	r0x101B,W
	BTFSC	STATUS,0
	INCFSZ	r0x101B,W
	ADDWF	r0x101D,F
	MOVF	r0x101C,W
	MOVWF	r0x101A
	MOVF	r0x101D,W
	MOVWF	r0x101B
	MOVF	r0x101D,W
	IORWF	r0x101C,W
	BTFSS	STATUS,2
	GOTO	_00252_DS_
;	.line	182; "blink.c"	for(i=0;i<tiempo;i++)
	INCF	r0x1018,F
	BTFSC	STATUS,2
	INCF	r0x1019,F
	GOTO	_00254_DS_
_00256_DS_:
;	.line	184; "blink.c"	}
	RETURN	
; exit point of _delay

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   __gptrget2
;   __gptrput2
;   __moduint
;   __gptrget2
;   __gptrput2
;   __moduint
;13 compiler assigned registers:
;   r0x101E
;   STK00
;   r0x101F
;   STK01
;   r0x1020
;   r0x1021
;   r0x1022
;   r0x1023
;   r0x1024
;   r0x1025
;   r0x1026
;   STK02
;   STK03
;; Starting pCode block
S_blink__miRand	code
_miRand:
; 2 exit points
;	.line	5; "blink.c"	unsigned int miRand(unsigned int *lfsr) {
	BANKSEL	r0x101E
	MOVWF	r0x101E
	MOVF	STK00,W
	MOVWF	r0x101F
	MOVF	STK01,W
;	.line	7; "blink.c"	unsigned int feedback = ((*lfsr >> 0) ^ (*lfsr >> 2) ^ (*lfsr >> 3) ^ (*lfsr >> 5)) & 1;
	MOVWF	r0x1020
	MOVWF	STK01
	MOVF	r0x101F,W
	MOVWF	STK00
	MOVF	r0x101E,W
	PAGESEL	__gptrget2
	CALL	__gptrget2
	PAGESEL	$
	BANKSEL	r0x1024
	MOVWF	r0x1024
	MOVWF	r0x1021
	MOVF	STK00,W
	MOVWF	r0x1022
	MOVWF	r0x1023
;;99	MOVF	r0x1021,W
;;shiftRight_Left2ResultLit:5474: shCount=1, size=2, sign=0, same=0, offr=0
	BCF	STATUS,0
	RRF	r0x1021,W
	MOVWF	r0x1025
	RRF	r0x1022,W
	MOVWF	r0x1026
;;shiftRight_Left2ResultLit:5474: shCount=1, size=2, sign=0, same=1, offr=0
	BCF	STATUS,0
	RRF	r0x1025,F
	RRF	r0x1026,F
	MOVF	r0x1026,W
	XORWF	r0x1023,F
	MOVF	r0x1025,W
	XORWF	r0x1024,F
;;shiftRight_Left2ResultLit:5474: shCount=1, size=2, sign=0, same=0, offr=0
	BCF	STATUS,0
	RRF	r0x1021,W
	MOVWF	r0x1025
	RRF	r0x1022,W
	MOVWF	r0x1026
;;shiftRight_Left2ResultLit:5474: shCount=1, size=2, sign=0, same=1, offr=0
	BCF	STATUS,0
	RRF	r0x1025,F
	RRF	r0x1026,F
;;shiftRight_Left2ResultLit:5474: shCount=1, size=2, sign=0, same=1, offr=0
	BCF	STATUS,0
	RRF	r0x1025,F
	RRF	r0x1026,F
	MOVF	r0x1026,W
	XORWF	r0x1023,F
	MOVF	r0x1025,W
	XORWF	r0x1024,F
	SWAPF	r0x1022,W
	ANDLW	0x0f
	MOVWF	r0x1026
	SWAPF	r0x1021,W
	MOVWF	r0x1025
	ANDLW	0xf0
	IORWF	r0x1026,F
	XORWF	r0x1025,F
;;shiftRight_Left2ResultLit:5474: shCount=1, size=2, sign=0, same=1, offr=0
	BCF	STATUS,0
	RRF	r0x1025,F
	RRF	r0x1026,F
	MOVF	r0x1026,W
	XORWF	r0x1023,F
	MOVF	r0x1025,W
	XORWF	r0x1024,F
	MOVLW	0x01
	ANDWF	r0x1023,F
	CLRF	r0x1024
;;shiftRight_Left2ResultLit:5474: shCount=1, size=2, sign=0, same=0, offr=0
;	.line	10; "blink.c"	*lfsr = (*lfsr >> 1) | (feedback << 15);
	BCF	STATUS,0
	RRF	r0x1021,W
	MOVWF	r0x1025
	RRF	r0x1022,W
	MOVWF	r0x1026
	RRF	r0x1023,W
	CLRF	r0x1021
	RRF	r0x1021,F
	CLRF	r0x1022
;;101	MOVF	r0x1026,W
	MOVF	r0x1021,W
	IORWF	r0x1025,W
	MOVWF	r0x1024
	MOVWF	STK02
;;100	MOVF	r0x1023,W
	MOVF	r0x1026,W
	MOVWF	r0x1023
	MOVWF	STK03
	MOVF	r0x1020,W
	MOVWF	STK01
	MOVF	r0x101F,W
	MOVWF	STK00
	MOVF	r0x101E,W
	PAGESEL	__gptrput2
	CALL	__gptrput2
	PAGESEL	$
;	.line	12; "blink.c"	return *lfsr % 100;  // Ajusta el resultado para que esté en el rango de 0 a 99
	MOVLW	0x64
	MOVWF	STK02
	MOVLW	0x00
	MOVWF	STK01
	BANKSEL	r0x1023
	MOVF	r0x1023,W
	MOVWF	STK00
	MOVF	r0x1024,W
	PAGESEL	__moduint
	CALL	__moduint
	PAGESEL	$
	BANKSEL	r0x101F
	MOVWF	r0x101F
	MOVF	STK00,W
	MOVWF	r0x1020
	MOVWF	STK00
	MOVF	r0x101F,W
;	.line	13; "blink.c"	}
	RETURN	
; exit point of _miRand


;	code size estimation:
;	  650+  148 =   798 instructions ( 1892 byte)

	end
