#line 1 "C:/Users/wzomzot/Desktop/Мой курсач/02/ws2812.c"
#line 1 "c:/users/wzomzot/desktop/Мой курсач/02/ws2812.h"
#line 1 "c:/users/wzomzot/desktop/Мой курсач/02/ds1302.h"




typedef struct
{
 unsigned char day;
 unsigned char month;
 unsigned char year;
} Date;


typedef struct
{
 unsigned char hour;
 unsigned char minute;
 unsigned char second;
} Time;


void DS1302_init();


void DS1302_get_date(Date* current_date);


void DS1302_set_date(Date* current_date);


void DS1302_get_time(Time* current_time);


void DS1302_set_time(Time* current_time);


unsigned char DS1302_serial_read();


void DS1302_serial_write(unsigned char value);


unsigned char DS1302_read(unsigned char address);


void DS1302_write(unsigned char address, unsigned char value);


unsigned char bcd_to_decimal(unsigned char value);


unsigned char decimal_to_bcd(unsigned char value);
#line 1 "c:/users/wzomzot/desktop/Мой курсач/02/enc28j60.h"




typedef struct
{
 unsigned int eur_buy[2];
 unsigned int eur_sale[2];
 unsigned int usd_buy[2];
 unsigned int usd_sale[2];
 unsigned long timestamp;
} Request;


void ENC28J60_init();


char ENC28J60_had_request();


void ENC28J60_get_request(Request* received_request);


typedef struct
{
 unsigned canCloseTCP: 1;
 unsigned isBroadcast: 1;
} TEthPktFlags;


unsigned int SPI_Ethernet_UserTCP(unsigned char* remote_host,
 unsigned int remote_port,
 unsigned int local_port,
 unsigned int request_length,
 TEthPktFlags* flags);


unsigned int SPI_Ethernet_UserUDP(unsigned char* remote_host,
 unsigned int remote_port,
 unsigned int local_port,
 unsigned int request_length,
 TEthPktFlags* flags);
#line 8 "c:/users/wzomzot/desktop/Мой курсач/02/ws2812.h"
typedef struct
{
 unsigned char blue;
 unsigned char green;
 unsigned char red;
} PixelParameter;


void WS2812_init();


void WS2812_prepare_data();


void WS2812_delay_long();


void WS2812_delay_short();


void WS2812_read_state();


void WS2812_save_state();


void WS2812_print_clock();


void WS2812_print_currency_name();


void WS2812_print_currency_value_buy();


void WS2812_print_currency_value_sale();


void WS2812_decrease_time();


void WS2812_increase_time();
#line 37 "C:/Users/wzomzot/Desktop/Мой курсач/02/ws2812.c"
unsigned char current_panel_iteration = 0;


unsigned char current_background_color[] = { 0xFF, 0xFF, 0xFF };

unsigned char current_text_color[] = { 0x00, 0x00, 0x00 };


Request currentRequest;

Time currentTime;


PixelParameter panel_clock_pixels[ 7 ][ 30 ];


PixelParameter panel_currency_name_pixels[ 7 ][ 15 ];


PixelParameter panel_currency_value_buy_pixels[ 7 ][ 20 ];


PixelParameter panel_currency_value_sale_pixels[ 7 ][ 20 ];


extern const unsigned char ALPHABET_NUMBERS[];

extern const unsigned char ALPHABET_LETTERS[];


void WS2812_init()
{

 unsigned char status = EEPROM_Read(0x00); Delay_ms(20);


 if ((status != 0) && (status != 1))
 {
 EEPROM_Write(0x00, 0); Delay_ms(20);
 }
 else
 {

 if (status == 0)
 {
 return;
 }


 WS2812_read_state();


 T0CON = 0x87;

 TMR0L = 0x48;
 TMR0H = 0xE5;

 GIE_bit = 1;

 TMR0IE_bit = 1;
 }
}


void WS2812_prepare_data()
{

 ENC28J60_get_request(&currentRequest);


 WS2812_save_state();


 T0CON = 0x87;

 TMR0L = 0x48;
 TMR0H = 0xE5;

 GIE_bit = 1;

 TMR0IE_bit = 1;
}


void WS2812_delay_long()
{
 asm nop;
 asm nop;
 asm nop;
 asm nop;
}


void WS2812_delay_short()
{
 asm nop;
}


void WS2812_read_state()
{

 unsigned int address_index = 0;

 unsigned int value_index = 0;


 unsigned char* current_byte;


 DS1302_get_time(&currentTime);


 for (value_index = 0; value_index < 2; ++value_index)
 {
 current_byte = &currentRequest.eur_buy[value_index];

 *current_byte++ = EEPROM_Read(++address_index); Delay_ms(20);
 *current_byte++ = EEPROM_Read(++address_index); Delay_ms(20);
 }


 for (value_index = 0; value_index < 2; ++value_index)
 {
 current_byte = &currentRequest.eur_sale[value_index];

 *current_byte++ = EEPROM_Read(++address_index); Delay_ms(20);
 *current_byte++ = EEPROM_Read(++address_index); Delay_ms(20);
 }


 for (value_index = 0; value_index < 2; ++value_index)
 {
 current_byte = &currentRequest.usd_buy[value_index];

 *current_byte++ = EEPROM_Read(++address_index); Delay_ms(20);
 *current_byte++ = EEPROM_Read(++address_index); Delay_ms(20);
 }


 for (value_index = 0; value_index < 2; ++value_index)
 {
 current_byte = &currentRequest.usd_sale[value_index];

 *current_byte++ = EEPROM_Read(++address_index); Delay_ms(20);
 *current_byte++ = EEPROM_Read(++address_index); Delay_ms(20);
 }
}


void WS2812_save_state()
{

 unsigned int address_index = 0;

 unsigned int value_index = 0;


 unsigned char* current_byte;


 EEPROM_Write(address_index++, 1); Delay_ms(20);


 for (value_index = 0; value_index < 2; ++value_index)
 {
 current_byte = &currentRequest.eur_buy[value_index];

 EEPROM_Write(address_index++, *current_byte++); Delay_ms(20);
 EEPROM_Write(address_index++, *current_byte++); Delay_ms(20);
 }


 for (value_index = 0; value_index < 2; ++value_index)
 {
 current_byte = &currentRequest.eur_sale[value_index];

 EEPROM_Write(address_index++, *current_byte++); Delay_ms(20);
 EEPROM_Write(address_index++, *current_byte++); Delay_ms(20);
 }


 for (value_index = 0; value_index < 2; ++value_index)
 {
 current_byte = &currentRequest.usd_buy[value_index];

 EEPROM_Write(address_index++, *current_byte++); Delay_ms(20);
 EEPROM_Write(address_index++, *current_byte++); Delay_ms(20);
 }


 for (value_index = 0; value_index < 2; ++value_index)
 {
 current_byte = &currentRequest.usd_sale[value_index];

 EEPROM_Write(address_index++, *current_byte++); Delay_ms(20);
 EEPROM_Write(address_index++, *current_byte++); Delay_ms(20);
 }
}


void WS2812_print_clock()
{

 unsigned int pixel_position = 0;


 unsigned int matrix_column = 0;

 unsigned int matrix_row = 0;

 unsigned int panel_column = 0;

 unsigned int panel_row = 0;


 unsigned char current_bit;

 unsigned char current_byte;


 char current_number[7];

 for (pixel_position = 0; pixel_position <  30 ; pixel_position +=  5 )
 {
 for (matrix_row = 0; matrix_row <  7 ; ++matrix_row)
 {
 unsigned char matrix_element = 0x00;

 if ((pixel_position /  5 ) == 0)
 {
 char symbol_code = 0; char* simplified_number;


 IntToStr(currentTime.hour, current_number); simplified_number = Ltrim(current_number);

 if (strlen(simplified_number) > 1)
 {
 symbol_code = simplified_number[0] - 48;
 }

 matrix_element = ALPHABET_NUMBERS[symbol_code *  7  + matrix_row];
 }

 if ((pixel_position /  5 ) == 1)
 {
 char symbol_code = 0; char* simplified_number;


 IntToStr(currentTime.hour, current_number); simplified_number = Ltrim(current_number);

 if (strlen(simplified_number) == 1)
 {
 symbol_code = simplified_number[0] - 48;
 }

 if (strlen(simplified_number) == 2)
 {
 symbol_code = simplified_number[1] - 48;
 }

 matrix_element = ALPHABET_NUMBERS[symbol_code *  7  + matrix_row];
 }

 if ((pixel_position /  5 ) == 2)
 {
 char symbol_code = 0; char* simplified_number;


 IntToStr(currentTime.minute, current_number); simplified_number = Ltrim(current_number);

 if (strlen(simplified_number) > 1)
 {
 symbol_code = simplified_number[0] - 48;
 }

 matrix_element = ALPHABET_NUMBERS[symbol_code *  7  + matrix_row];
 }

 if ((pixel_position /  5 ) == 3)
 {
 char symbol_code = 0; char* simplified_number;


 IntToStr(currentTime.minute, current_number); simplified_number = Ltrim(current_number);

 if (strlen(simplified_number) == 1)
 {
 symbol_code = simplified_number[0] - 48;
 }

 if (strlen(simplified_number) == 2)
 {
 symbol_code = simplified_number[1] - 48;
 }

 matrix_element = ALPHABET_NUMBERS[symbol_code *  7  + matrix_row];
 }

 if ((pixel_position /  5 ) == 4)
 {
 char symbol_code = 0; char* simplified_number;


 IntToStr(currentTime.second, current_number); simplified_number = Ltrim(current_number);

 if (strlen(simplified_number) > 1)
 {
 symbol_code = simplified_number[0] - 48;
 }

 matrix_element = ALPHABET_NUMBERS[symbol_code *  7  + matrix_row];
 }

 if ((pixel_position /  5 ) == 5)
 {
 char symbol_code = 0; char* simplified_number;


 IntToStr(currentTime.second, current_number); simplified_number = Ltrim(current_number);

 if (strlen(simplified_number) == 1)
 {
 symbol_code = simplified_number[0] - 48;
 }

 if (strlen(simplified_number) == 2)
 {
 symbol_code = simplified_number[1] - 48;
 }

 matrix_element = ALPHABET_NUMBERS[symbol_code *  7  + matrix_row];
 }

 for (matrix_column = 0; matrix_column <  5 ; ++matrix_column)
 {
 if (matrix_element & 0x80)
 {
 panel_clock_pixels[matrix_row][pixel_position + matrix_column].red = current_text_color[0];
 panel_clock_pixels[matrix_row][pixel_position + matrix_column].green = current_text_color[1];
 panel_clock_pixels[matrix_row][pixel_position + matrix_column].blue = current_text_color[2];
 }
 else
 {
 panel_clock_pixels[matrix_row][pixel_position + matrix_column].red = current_background_color[0];
 panel_clock_pixels[matrix_row][pixel_position + matrix_column].green = current_background_color[1];
 panel_clock_pixels[matrix_row][pixel_position + matrix_column].blue = current_background_color[2];
 }

 matrix_element = matrix_element << 1;
 }
 }
 }

 for (panel_row = 0; panel_row <  7 ; ++panel_row)
 {

 unsigned char mask_enable =  LATJ  | (0x01 << panel_row);

 unsigned char mask_disable =  LATJ  & ~(0x01 << panel_row);


 PixelParameter* pixels = panel_clock_pixels[panel_row];

 for (panel_column = 0; panel_column <  30 ; ++panel_column)
 {

 current_byte = pixels[panel_column].green;

 for (current_bit = 0; current_bit < 8; ++current_bit)
 {
 if (current_byte & 0x80)
 {
  LATJ  = mask_enable;

 WS2812_delay_long();

  LATJ  = mask_disable;
 }
 else
 {
  LATJ  = mask_enable;

  LATJ  = mask_disable;
 }

 current_byte = current_byte << 1;
 }


 current_byte = pixels[panel_column].red;

 for (current_bit = 0; current_bit < 8; ++current_bit)
 {
 if (current_byte & 0x80)
 {
  LATJ  = mask_enable;

 WS2812_delay_long();

  LATJ  = mask_disable;
 }
 else
 {
  LATJ  = mask_enable;

  LATJ  = mask_disable;
 }

 current_byte = current_byte << 1;
 }


 current_byte = pixels[panel_column].blue;

 for (current_bit = 0; current_bit < 8; ++current_bit)
 {
 if (current_byte & 0x80)
 {
  LATJ  = mask_enable;

 WS2812_delay_long();

  LATJ  = mask_disable;
 }
 else
 {
  LATJ  = mask_enable;

  LATJ  = mask_disable;
 }

 current_byte = current_byte << 1;
 }
 }


 Delay_us(50);
 }
}


void WS2812_print_currency_name()
{

 unsigned int pixel_position = 0;


 unsigned int matrix_column = 0;

 unsigned int matrix_row = 0;

 unsigned int panel_column = 0;

 unsigned int panel_row = 0;


 unsigned char current_bit;

 unsigned char current_byte;

 for (pixel_position = 0; pixel_position <  15 ; pixel_position +=  5 )
 {
 for (matrix_row = 0; matrix_row <  7 ; ++matrix_row)
 {
 unsigned char matrix_element = 0x00;

 if ((pixel_position /  5 ) == 0)
 {
 if ((current_panel_iteration % 2) == 0)
 {

 matrix_element = ALPHABET_LETTERS[('U' - 65) *  7  + matrix_row];
 }
 else
 {

 matrix_element = ALPHABET_LETTERS[('E' - 65) *  7  + matrix_row];
 }
 }

 if ((pixel_position /  5 ) == 1)
 {
 if ((current_panel_iteration % 2) == 0)
 {

 matrix_element = ALPHABET_LETTERS[('S' - 65) *  7  + matrix_row];
 }
 else
 {

 matrix_element = ALPHABET_LETTERS[('U' - 65) *  7  + matrix_row];
 }
 }

 if ((pixel_position /  5 ) == 2)
 {
 if ((current_panel_iteration % 2) == 0)
 {

 matrix_element = ALPHABET_LETTERS[('D' - 65) *  7  + matrix_row];
 }
 else
 {

 matrix_element = ALPHABET_LETTERS[('R' - 65) *  7  + matrix_row];
 }
 }

 for (matrix_column = 0; matrix_column <  5 ; ++matrix_column)
 {
 if (matrix_element & 0x80)
 {
 panel_currency_name_pixels[matrix_row][pixel_position + matrix_column].red = current_text_color[0];
 panel_currency_name_pixels[matrix_row][pixel_position + matrix_column].green = current_text_color[1];
 panel_currency_name_pixels[matrix_row][pixel_position + matrix_column].blue = current_text_color[2];
 }
 else
 {
 panel_currency_name_pixels[matrix_row][pixel_position + matrix_column].red = current_background_color[0];
 panel_currency_name_pixels[matrix_row][pixel_position + matrix_column].green = current_background_color[1];
 panel_currency_name_pixels[matrix_row][pixel_position + matrix_column].blue = current_background_color[2];
 }

 matrix_element = matrix_element << 1;
 }
 }
 }

 for (panel_row = 0; panel_row <  7 ; ++panel_row)
 {

 unsigned char mask_enable =  LATE  | (0x01 << panel_row);

 unsigned char mask_disable =  LATE  & ~(0x01 << panel_row);


 PixelParameter* pixels = panel_currency_name_pixels[panel_row];

 for (panel_column = 0; panel_column <  30 ; ++panel_column)
 {

 current_byte = pixels[panel_column].green;

 for (current_bit = 0; current_bit < 8; ++current_bit)
 {
 if (current_byte & 0x80)
 {
  LATE  = mask_enable;

 WS2812_delay_long();

  LATE  = mask_disable;
 }
 else
 {
  LATE  = mask_enable;

  LATE  = mask_disable;
 }

 current_byte = current_byte << 1;
 }


 current_byte = pixels[panel_column].red;

 for (current_bit = 0; current_bit < 8; ++current_bit)
 {
 if (current_byte & 0x80)
 {
  LATE  = mask_enable;

 WS2812_delay_long();

  LATE  = mask_disable;
 }
 else
 {
  LATE  = mask_enable;

  LATE  = mask_disable;
 }

 current_byte = current_byte << 1;
 }


 current_byte = pixels[panel_column].blue;

 for (current_bit = 0; current_bit < 8; ++current_bit)
 {
 if (current_byte & 0x80)
 {
  LATE  = mask_enable;

 WS2812_delay_long();

  LATE  = mask_disable;
 }
 else
 {
  LATE  = mask_enable;

  LATE  = mask_disable;
 }

 current_byte = current_byte << 1;
 }
 }


 Delay_us(50);
 }
}


void WS2812_print_currency_value_buy()
{

 unsigned int pixel_position = 0;


 unsigned int matrix_column = 0;

 unsigned int matrix_row = 0;

 unsigned int panel_column = 0;

 unsigned int panel_row = 0;


 unsigned char current_bit;

 unsigned char current_byte;


 char current_number[7];

 for (pixel_position = 0; pixel_position <  20 ; pixel_position +=  5 )
 {
 for (matrix_row = 0; matrix_row <  7 ; ++matrix_row)
 {
 unsigned char matrix_element = 0x00;

 if ((pixel_position /  5 ) == 0)
 {
 char symbol_code = 0; char* simplified_number;

 if ((current_panel_iteration % 2) == 0)
 {
 IntToStr(currentRequest.usd_buy[0], current_number); simplified_number = Ltrim(current_number);
 }
 else
 {
 IntToStr(currentRequest.eur_buy[0], current_number); simplified_number = Ltrim(current_number);
 }

 if (strlen(simplified_number) > 1)
 {
 symbol_code = simplified_number[0] - 48;
 }

 matrix_element = ALPHABET_NUMBERS[symbol_code *  7  + matrix_row];
 }

 if ((pixel_position /  5 ) == 1)
 {
 char symbol_code = 0; char* simplified_number;

 if ((current_panel_iteration % 2) == 0)
 {
 IntToStr(currentRequest.usd_buy[0], current_number); simplified_number = Ltrim(current_number);
 }
 else
 {
 IntToStr(currentRequest.eur_buy[0], current_number); simplified_number = Ltrim(current_number);
 }

 if (strlen(simplified_number) == 2)
 {
 symbol_code = simplified_number[0] - 48;
 }

 if (strlen(simplified_number) == 2)
 {
 symbol_code = simplified_number[1] - 48;
 }

 matrix_element = ALPHABET_NUMBERS[symbol_code *  7  + matrix_row];
 }

 if ((pixel_position /  5 ) == 2)
 {
 char symbol_code = 0; char* simplified_number;

 if ((current_panel_iteration % 2) == 0)
 {
 IntToStr(currentRequest.usd_buy[1], current_number); simplified_number = Ltrim(current_number);
 }
 else
 {
 IntToStr(currentRequest.eur_buy[1], current_number); simplified_number = Ltrim(current_number);
 }

 if (strlen(simplified_number) > 1)
 {
 symbol_code = simplified_number[0] - 48;
 }

 matrix_element = ALPHABET_NUMBERS[symbol_code *  7  + matrix_row];
 }

 if ((pixel_position /  5 ) == 3)
 {
 char symbol_code = 0; char* simplified_number;

 if ((current_panel_iteration % 2) == 0)
 {
 IntToStr(currentRequest.usd_buy[1], current_number); simplified_number = Ltrim(current_number);
 }
 else
 {
 IntToStr(currentRequest.eur_buy[1], current_number); simplified_number = Ltrim(current_number);
 }

 if (strlen(simplified_number) == 1)
 {
 symbol_code = simplified_number[0] - 48;
 }

 if (strlen(simplified_number) == 2)
 {
 symbol_code = simplified_number[1] - 48;
 }

 matrix_element = ALPHABET_NUMBERS[symbol_code *  7  + matrix_row];
 }

 for (matrix_column = 0; matrix_column <  5 ; ++matrix_column)
 {
 if (matrix_element & 0x80)
 {
 panel_currency_value_buy_pixels[matrix_row][pixel_position + matrix_column].red = current_text_color[0];
 panel_currency_value_buy_pixels[matrix_row][pixel_position + matrix_column].green = current_text_color[1];
 panel_currency_value_buy_pixels[matrix_row][pixel_position + matrix_column].blue = current_text_color[2];
 }
 else
 {
 panel_currency_value_buy_pixels[matrix_row][pixel_position + matrix_column].red = current_background_color[0];
 panel_currency_value_buy_pixels[matrix_row][pixel_position + matrix_column].green = current_background_color[1];
 panel_currency_value_buy_pixels[matrix_row][pixel_position + matrix_column].blue = current_background_color[2];
 }

 matrix_element = matrix_element << 1;
 }
 }
 }

 for (panel_row = 0; panel_row <  7 ; ++panel_row)
 {

 unsigned char mask_enable =  LATF  | (0x01 << panel_row);

 unsigned char mask_disable =  LATF  & ~(0x01 << panel_row);


 PixelParameter* pixels = panel_currency_value_buy_pixels[panel_row];

 for (panel_column = 0; panel_column <  20 ; ++panel_column)
 {

 current_byte = pixels[panel_column].green;

 for (current_bit = 0; current_bit < 8; ++current_bit)
 {
 if (current_byte & 0x80)
 {
  LATF  = mask_enable;

 WS2812_delay_long();

  LATF  = mask_disable;
 }
 else
 {
  LATF  = mask_enable;

  LATF  = mask_disable;
 }

 current_byte = current_byte << 1;
 }


 current_byte = pixels[panel_column].red;

 for (current_bit = 0; current_bit < 8; ++current_bit)
 {
 if (current_byte & 0x80)
 {
  LATF  = mask_enable;

 WS2812_delay_long();

  LATF  = mask_disable;
 }
 else
 {
  LATF  = mask_enable;

  LATF  = mask_disable;
 }

 current_byte = current_byte << 1;
 }


 current_byte = pixels[panel_column].blue;

 for (current_bit = 0; current_bit < 8; ++current_bit)
 {
 if (current_byte & 0x80)
 {
  LATF  = mask_enable;

 WS2812_delay_long();

  LATF  = mask_disable;
 }
 else
 {
  LATF  = mask_enable;

  LATF  = mask_disable;
 }

 current_byte = current_byte << 1;
 }
 }


 Delay_us(50);
 }
}


void WS2812_print_currency_value_sale()
{

 unsigned int pixel_position = 0;


 unsigned int matrix_column = 0;

 unsigned int matrix_row = 0;

 unsigned int panel_column = 0;

 unsigned int panel_row = 0;


 unsigned char current_bit;

 unsigned char current_byte;


 char current_number[7];

 for (pixel_position = 0; pixel_position <  20 ; pixel_position +=  5 )
 {
 for (matrix_row = 0; matrix_row <  7 ; ++matrix_row)
 {
 unsigned char matrix_element = 0x00;

 if ((pixel_position /  5 ) == 0)
 {
 char symbol_code = 0; char* simplified_number;

 if ((current_panel_iteration % 2) == 0)
 {
 IntToStr(currentRequest.usd_sale[0], current_number); simplified_number = Ltrim(current_number);
 }
 else
 {
 IntToStr(currentRequest.eur_sale[0], current_number); simplified_number = Ltrim(current_number);
 }

 if (strlen(simplified_number) > 1)
 {
 symbol_code = simplified_number[0] - 48;
 }

 matrix_element = ALPHABET_NUMBERS[symbol_code *  7  + matrix_row];
 }

 if ((pixel_position /  5 ) == 1)
 {
 char symbol_code = 0; char* simplified_number;

 if ((current_panel_iteration % 2) == 0)
 {
 IntToStr(currentRequest.usd_sale[0], current_number); simplified_number = Ltrim(current_number);
 }
 else
 {
 IntToStr(currentRequest.eur_sale[0], current_number); simplified_number = Ltrim(current_number);
 }

 if (strlen(simplified_number) == 2)
 {
 symbol_code = simplified_number[0] - 48;
 }

 if (strlen(simplified_number) == 2)
 {
 symbol_code = simplified_number[1] - 48;
 }

 matrix_element = ALPHABET_NUMBERS[symbol_code *  7  + matrix_row];
 }

 if ((pixel_position /  5 ) == 2)
 {
 char symbol_code = 0; char* simplified_number;

 if ((current_panel_iteration % 2) == 0)
 {
 IntToStr(currentRequest.usd_sale[1], current_number); simplified_number = Ltrim(current_number);
 }
 else
 {
 IntToStr(currentRequest.eur_sale[1], current_number); simplified_number = Ltrim(current_number);
 }

 if (strlen(simplified_number) > 1)
 {
 symbol_code = simplified_number[0] - 48;
 }

 matrix_element = ALPHABET_NUMBERS[symbol_code *  7  + matrix_row];
 }

 if ((pixel_position /  5 ) == 3)
 {
 char symbol_code = 0; char* simplified_number;

 if ((current_panel_iteration % 2) == 0)
 {
 IntToStr(currentRequest.usd_sale[1], current_number); simplified_number = Ltrim(current_number);
 }
 else
 {
 IntToStr(currentRequest.eur_sale[1], current_number); simplified_number = Ltrim(current_number);
 }

 if (strlen(simplified_number) == 1)
 {
 symbol_code = simplified_number[0] - 48;
 }

 if (strlen(simplified_number) == 2)
 {
 symbol_code = simplified_number[1] - 48;
 }

 matrix_element = ALPHABET_NUMBERS[symbol_code *  7  + matrix_row];
 }

 for (matrix_column = 0; matrix_column <  5 ; ++matrix_column)
 {
 if (matrix_element & 0x80)
 {
 panel_currency_value_sale_pixels[matrix_row][pixel_position + matrix_column].red = current_text_color[0];
 panel_currency_value_sale_pixels[matrix_row][pixel_position + matrix_column].green = current_text_color[1];
 panel_currency_value_sale_pixels[matrix_row][pixel_position + matrix_column].blue = current_text_color[2];
 }
 else
 {
 panel_currency_value_sale_pixels[matrix_row][pixel_position + matrix_column].red = current_background_color[0];
 panel_currency_value_sale_pixels[matrix_row][pixel_position + matrix_column].green = current_background_color[1];
 panel_currency_value_sale_pixels[matrix_row][pixel_position + matrix_column].blue = current_background_color[2];
 }

 matrix_element = matrix_element << 1;
 }
 }
 }

 for (panel_row = 0; panel_row <  20 ; ++panel_row)
 {

 unsigned char mask_enable =  LATH  | (0x01 << panel_row);

 unsigned char mask_disable =  LATH  & ~(0x01 << panel_row);


 PixelParameter* pixels = panel_currency_value_sale_pixels[panel_row];

 for (panel_column = 0; panel_column <  20 ; ++panel_column)
 {

 current_byte = pixels[panel_column].green;

 for (current_bit = 0; current_bit < 8; ++current_bit)
 {
 if (current_byte & 0x80)
 {
  LATH  = mask_enable;

 WS2812_delay_long();

  LATH  = mask_disable;
 }
 else
 {
  LATH  = mask_enable;

  LATH  = mask_disable;
 }

 current_byte = current_byte << 1;
 }


 current_byte = pixels[panel_column].red;

 for (current_bit = 0; current_bit < 8; ++current_bit)
 {
 if (current_byte & 0x80)
 {
  LATH  = mask_enable;

 WS2812_delay_long();

  LATH  = mask_disable;
 }
 else
 {
  LATH  = mask_enable;

  LATH  = mask_disable;
 }

 current_byte = current_byte << 1;
 }


 current_byte = pixels[panel_column].blue;

 for (current_bit = 0; current_bit < 8; ++current_bit)
 {
 if (current_byte & 0x80)
 {
  LATH  = mask_enable;

 WS2812_delay_long();

  LATH  = mask_disable;
 }
 else
 {
  LATH  = mask_enable;

  LATH  = mask_disable;
 }

 current_byte = current_byte << 1;
 }
 }


 Delay_us(50);
 }
}


void WS2812_decrease_time()
{
 if (currentTime.second == 0)
 {
 currentTime.second = 59;
 currentTime.minute = currentTime.minute - 1;
 }
 else
 {
 currentTime.second = currentTime.second - 1;
 }

 if (currentTime.minute == 0)
 {
 currentTime.minute = 59;
 currentTime.hour = currentTime.hour - 1;
 }

 if (currentTime.hour == 0)
 {
 currentTime.hour = 23;
 currentTime.minute = 59;
 currentTime.second = 59;
 }
}


void WS2812_increase_time()
{
 currentTime.second = currentTime.second + 1;

 if (currentTime.second == 60)
 {
 currentTime.second = 0;
 currentTime.minute = currentTime.minute + 1;
 }

 if (currentTime.minute == 60)
 {
 currentTime.minute = 0;
 currentTime.hour = currentTime.hour + 1;
 }

 if (currentTime.hour == 24)
 {
 currentTime.hour = 0;
 currentTime.minute = 0;
 currentTime.second = 0;
 }
}


void interrupt()
{
 if (TMR0IF_bit)
 {

 if ((current_panel_iteration % 15) == 0)
 {
 WS2812_print_currency_name();
 WS2812_print_currency_value_buy();
 WS2812_print_currency_value_sale();
 }


 if ((current_panel_iteration % 10) == 0)
 {
 WS2812_print_clock(); WS2812_increase_time();
 }

 ++current_panel_iteration;


 TMR0IF_bit = 0;

 T0CON = 0x87;

 TMR0L = 0x48;
 TMR0H = 0xE5;

 GIE_bit = 1;

 TMR0IE_bit = 1;
 }
}
