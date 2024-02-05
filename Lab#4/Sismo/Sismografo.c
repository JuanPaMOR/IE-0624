#include <stdint.h>
#include <libopencm3/stm32/rcc.h>
#include <libopencm3/stm32/gpio.h>
#include <libopencm3/stm32/spi.h>
#include <libopencm3/stm32/adc.h>
#include <libopencm3/stm32/usart.h>
#include <stdio.h>
#include "clock.h"
#include "console.h"
#include "sdram.h"
#include "lcd-spi.h"
#include "gfx.h"





uint16_t read_reg(int reg);
void write_reg(uint8_t reg, uint8_t value);
uint8_t read_xyz(int16_t vecs[3]);
void put_status(char *m);
int print_decimal(int num);


static void spi_setup(void)
{
	
	rcc_periph_clock_enable(RCC_SPI5);

	rcc_periph_clock_enable(RCC_GPIOC);
	/* For spi mode select on the l3gd20 */
	rcc_periph_clock_enable(RCC_GPIOF);

	/* Setup GPIOE3 pin for spi mode l3gd20 select. */
	gpio_mode_setup(GPIOC, GPIO_MODE_OUTPUT, GPIO_PUPD_NONE, GPIO1);
	/* Start with spi communication disabled */
	gpio_set(GPIOC, GPIO1);

	/* Setup GPIO pins for AF5 for SPI1 signals. */
	gpio_mode_setup(GPIOF, GPIO_MODE_AF, GPIO_PUPD_NONE,
			GPIO7 | GPIO8 | GPIO9);
	gpio_set_af(GPIOF, GPIO_AF5, GPIO7 | GPIO8 | GPIO9);
	
		
	//spi initialization;
	spi_set_master_mode(SPI5);
	spi_set_baudrate_prescaler(SPI5, SPI_CR1_BR_FPCLK_DIV_64);
	spi_set_clock_polarity_0(SPI5);
	spi_set_clock_phase_0(SPI5);
	spi_set_full_duplex_mode(SPI5);
	spi_set_unidirectional_mode(SPI5); /* bidirectional but in 3-wire */
	spi_enable_software_slave_management(SPI5);
	spi_send_msb_first(SPI5);
	spi_set_nss_high(SPI5);
	//spi_enable_ss_output(SPI1);

	SPI_I2SCFGR(SPI5) &= ~SPI_I2SCFGR_I2SMOD;
	spi_enable(SPI5);
}

static void usart_setup(void)
{
	/* Enable clocks for GPIO port A (for GPIO_USART2_TX) and USART2. */
	rcc_periph_clock_enable(RCC_USART1);
	rcc_periph_clock_enable(RCC_GPIOA);

	/* Setup GPIO pin GPIO_USART2_TX/GPIO9 on GPIO port A for transmit. */
	gpio_mode_setup(GPIOA, GPIO_MODE_AF, GPIO_PUPD_NONE, GPIO2 | GPIO3);
	gpio_set_af(GPIOA, GPIO_AF7, GPIO2| GPIO3);

	/* Setup UART parameters. */
	usart_set_baudrate(USART1, 115200);
	usart_set_databits(USART1, 8);
	usart_set_stopbits(USART1, USART_STOPBITS_1);
	usart_set_mode(USART1, USART_MODE_TX_RX);
	usart_set_parity(USART1, USART_PARITY_NONE);
	usart_set_flow_control(USART1, USART_FLOWCONTROL_NONE);

	/* Finally enable the USART. */
	usart_enable(USART1);
}

 /*=================================================================================*/




void put_status(char *m)
{
	uint16_t stmp;

	console_puts(m);
	console_puts(" Status: ");
	stmp = SPI_SR(SPI5);
	if (stmp & SPI_SR_TXE) {
		console_puts("TXE, ");
	}
	if (stmp & SPI_SR_RXNE) {
		console_puts("RXNE, ");
	}
	if (stmp & SPI_SR_BSY) {
		console_puts("BUSY, ");
	}
	if (stmp & SPI_SR_OVR) {
		console_puts("OVERRUN, ");
	}
	if (stmp & SPI_SR_MODF) {
		console_puts("MODE FAULT, ");
	}
	if (stmp & SPI_SR_CRCERR) {
		console_puts("CRC, ");
	}
	if (stmp & SPI_SR_UDR) {
		console_puts("UNDERRUN, ");
	}
	console_puts("\n");
}


uint8_t read_xyz(int16_t vecs[3])
{
	uint8_t	 buf[7];
	int		 i;

	gpio_clear(GPIOC, GPIO1); /* CS* select */
	spi_send(SPI5, 0xc0 | 0x28);
	(void) spi_read(SPI5);
	for (i = 0; i < 6; i++) {
		spi_send(SPI5, 0);
		buf[i] = spi_read(SPI5);
	}
	gpio_set(GPIOC, GPIO1); /* CS* deselect */
	vecs[0] = (buf[1] << 8 | buf[0]);
	vecs[1] = (buf[3] << 8 | buf[2]);
	vecs[2] = (buf[5] << 8 | buf[4]);
	return read_reg(0x27); /* Status register */
}


uint16_t read_reg(int reg)
{
	uint16_t d1, d2;

	d1 = 0x80 | (reg & 0x3f); /* Read operation */
	/* Nominallly a register read is a 16 bit operation */
	gpio_clear(GPIOC, GPIO1);
	spi_send(SPI5, d1);
	d2 = spi_read(SPI5);
	d2 <<= 8;
	/*
	 * You have to send as many bits as you want to read
	 * so we send another 8 bits to get the rest of the
	 * register.
	 */
	spi_send(SPI5, 0);
	d2 |= spi_read(SPI5);
	gpio_set(GPIOC, GPIO1);
	return d2;
}


void write_reg(uint8_t reg, uint8_t value)
{
	gpio_clear(GPIOC, GPIO1); /* CS* select */
	spi_send(SPI5, reg);
	(void) spi_read(SPI5);
	spi_send(SPI5, value);
	(void) spi_read(SPI5);
	gpio_set(GPIOC, GPIO1); /* CS* deselect */
	return;
}

int print_decimal(int num)
{
	int		ndx = 0;
	char	buf[10];
	int		len = 0;
	char	is_signed = 0;

	if (num < 0) {
		is_signed++;
		num = 0 - num;
	}
	buf[ndx++] = '\000';
	do {
		buf[ndx++] = (num % 10) + '0';
		num = num / 10;
	} while (num != 0);
	ndx--;
	if (is_signed != 0) {
		console_putc('-');
		len++;
	}
	while (buf[ndx] != '\000') {
		console_putc(buf[ndx--]);
		len++;
	}
	return len; /* number of characters printed */
}





static void lcd(char *x, char *y, char *z, char *v, char *u)
{
    gfx_init(lcd_draw_pixel, 240, 320);
	gfx_fillScreen(LCD_WHITE);
	gfx_setTextSize(2);
	gfx_setCursor(50, 20);
	gfx_puts("SENSOR");
	gfx_setTextSize(1);

	gfx_setTextSize(2);
	gfx_setCursor(15, 60);
	gfx_puts("X: ");
	gfx_puts(x);
	gfx_setTextSize(1);

	gfx_setTextSize(2);
	gfx_setCursor(15, 100);
	gfx_puts("Y: ");
	gfx_puts(y);
	gfx_setTextSize(1);

	gfx_setTextSize(2);
	gfx_setCursor(15, 140);
	gfx_puts("Z: ");
    gfx_puts(z);
	gfx_setTextSize(1);
	
	gfx_setTextSize(2);
	gfx_setCursor(15, 180);
	gfx_puts("V: ");
    gfx_puts(v);
	gfx_setTextSize(1);
	
	gfx_setTextSize(2);
	gfx_setCursor(15, 220);
	gfx_puts("T/R: ");
    gfx_puts(u);
	gfx_setTextSize(1);
	
	lcd_show_frame();
}

static void gpio_setup(void)
{
	rcc_periph_clock_enable(RCC_GPIOG);

	gpio_mode_setup(GPIOG, GPIO_MODE_OUTPUT,
			GPIO_PUPD_NONE, GPIO13);

	rcc_periph_clock_enable(RCC_GPIOC);
	gpio_mode_setup(GPIOC, GPIO_MODE_OUTPUT, GPIO_PUPD_NONE,
		GPIO8 | GPIO9 | GPIO10 | GPIO11 | GPIO12 | GPIO13 |
		GPIO14 | GPIO15);
}

static void button_setup(void)
{
	gpio_mode_setup(GPIOA, GPIO_MODE_INPUT, GPIO_PUPD_NONE, GPIO0);
}

char *axes[] = { "X: ", "Y: ", "Z: " };



#define GYR_RNW			(1 << 7) /* Write when zero */
#define GYR_MNS			(1 << 6) /* Multiple reads when 1 */
#define GYR_WHO_AM_I		0x0F
#define GYR_OUT_TEMP		0x26
#define GYR_STATUS_REG		0x27
#define GYR_CTRL_REG1		0x20
#define GYR_CTRL_REG1_PD	(1 << 3)
#define GYR_CTRL_REG1_XEN	(1 << 1)
#define GYR_CTRL_REG1_YEN	(1 << 0)
#define GYR_CTRL_REG1_ZEN	(1 << 2)
#define GYR_CTRL_REG1_BW_SHIFT	4
#define GYR_CTRL_REG4		0x23
#define GYR_CTRL_REG4_FS_SHIFT	4

#define GYR_OUT_X_L		0x28
#define GYR_OUT_X_H		0x29
 


int main(void)
{
	int estado = 0;
	int16_t vecs[3];
	int16_t baseline[3], XYZ[3];
	int tmp, i;
	int count;
	uint32_t cr_tmp;
	char *T="NO";
	char *Vol="HOLA";
	char X[10], Y[10], Z[10];

	gpio_setup();
	usart_setup();
	spi_setup();
    	gfx_init(lcd_draw_pixel, 240, 320);
	gfx_fillScreen(LCD_WHITE);
	clock_setup();
	button_setup();
	
	console_setup(115200);
	sdram_init();
	lcd_spi_init();	
	lcd("0", "0", "0", Vol, T);
	
	
	cr_tmp = SPI_CR1_BAUDRATE_FPCLK_DIV_8 |
		 SPI_CR1_MSTR |
		 SPI_CR1_SPE |
		 SPI_CR1_CPHA |
		 SPI_CR1_CPOL_CLK_TO_1_WHEN_IDLE;

	SPI_CR2(SPI5) |= SPI_CR2_SSOE;
	SPI_CR1(SPI5) = cr_tmp;

	XYZ[0] = 0;
	XYZ[1] = 0;
	XYZ[2] = 0;

	baseline[0] = 0;
	baseline[1] = 0;
	baseline[2] = 0;

	write_reg(0x20, 0xcf);  /* Normal mode */
	write_reg(0x21, 0x07);  /* standard filters */
	write_reg(0x23, 0xb0);  /* 250 dps */

	count = 0;

	while (1) {

		if (gpio_get(GPIOA, GPIO0)) {
			if(estado==0){
				estado = 1;
				gpio_toggle(GPIOG, GPIO13);
				T="SI";

			}
			else if (estado==1)
			{
				estado =0;
				gpio_toggle(GPIOG, GPIO13);
                		T="NO";
                		XYZ[0] = 0;
				XYZ[1] = 0;
				XYZ[2] = 0;
			}
			for (i = 0; i < 10000000; i++) {		/* Wait a bit. */
				__asm__("nop");
			}				
		}


		if(estado==1){

		    tmp = read_xyz(vecs);
		    for (i = 0; i < 3; i++) {
		        int pad;
		        console_puts(axes[i]);
		        tmp = vecs[i] - baseline[i];
		        XYZ[i]= tmp;
		        pad = print_decimal(tmp);
		        pad = 15 - pad;
		        while (pad--) {
		            console_puts(" ");
		        }
		    }
		    console_putc('\r');
		    if (count == 100) {
		        baseline[0] = vecs[0];
		        baseline[1] = vecs[1];
		        baseline[2] = vecs[2];
		    } else {
		        count++;
		    }
		    msleep(100);
		}
		
		sprintf(X, "%d", XYZ[0]);
		sprintf(Y, "%d", XYZ[1]);
  		sprintf(Z, "%d", XYZ[2]);

		lcd( X, Y, Z, Vol, T);
	}

}



























