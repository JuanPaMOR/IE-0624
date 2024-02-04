#include <stdint.h>
#include <libopencm3/stm32/rcc.h>
#include <libopencm3/stm32/gpio.h>
#include <libopencm3/stm32/spi.h>
#include <libopencm3/stm32/adc.h>
#include "clock.h"
#include "console.h"
#include "sdram.h"
#include "lcd-spi.h"
#include "gfx.h"


static void adc_setup(void)
{
	gpio_mode_setup(GPIOA, GPIO_MODE_ANALOG, GPIO_PUPD_NONE, GPIO0);
	gpio_mode_setup(GPIOA, GPIO_MODE_ANALOG, GPIO_PUPD_NONE, GPIO1);

	adc_power_off(ADC1);
	adc_disable_scan_mode(ADC1);
	adc_set_sample_time_on_all_channels(ADC1, ADC_SMPR_SMP_3CYC);

	adc_power_on(ADC1);

}

static void dac_setup(void)
{
	gpio_mode_setup(GPIOA, GPIO_MODE_ANALOG, GPIO_PUPD_NONE, GPIO5);
	dac_disable(DAC1, DAC_CHANNEL2);
	dac_disable_waveform_generation(DAC1, DAC_CHANNEL2);
	dac_enable(DAC1, DAC_CHANNEL2);
	dac_set_trigger_source(DAC1, DAC_CR_TSEL2_SW);
}

static uint16_t read_adc_naiive(uint8_t channel)
{
	uint8_t channel_array[16];
	channel_array[0] = channel;
	adc_set_regular_sequence(ADC1, 1, channel_array);
	adc_start_conversion_regular(ADC1);
	while (!adc_eoc(ADC1));
	uint16_t reg16 = adc_read_regular(ADC1);
	return reg16;
}




static void lcd(char *x, char *y, char *z, char *v, char *u)
{
    
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
}

static void button_setup(void)
{
	gpio_mode_setup(GPIOA, GPIO_MODE_INPUT, GPIO_PUPD_NONE, GPIO0);
}

int main(void)
{
	int i;
	int estado = 0;
    char *Vol;
    gfx_init(lcd_draw_pixel, 240, 320);
	gfx_fillScreen(LCD_WHITE);
	clock_setup();
	button_setup();
	gpio_setup();
	console_setup(115200);
	sdram_init();
	lcd_spi_init();	
    adc_setup();
    Vol=adc_read();
	lcd("0", "0", "0", Vol, "NO");

	/* Blink the LED (PD13) on the board. */
	while (1) {

		if (gpio_get(GPIOA, GPIO0)) {
			if(estado==0){
				estado = 1;
				gpio_toggle(GPIOG, GPIO13);
				lcd( "0", "0", "0", "0", "Si");

			}
			else if (estado==1)
			{
				estado =0;
				gpio_toggle(GPIOG, GPIO13);
                lcd( "0", "0", "0", "0", "NO");
			}
			for (i = 0; i < 10000000; i++) {		/* Wait a bit. */
				__asm__("nop");
			}
						
		}
	

	}

}
