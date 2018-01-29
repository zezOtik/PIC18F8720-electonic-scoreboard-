#line 1 "C:/Users/wzomzot/Desktop/Мой курсач/02/ds1302.c"
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
#line 4 "C:/Users/wzomzot/Desktop/Мой курсач/02/ds1302.c"
sfr sbit DS1302_IO_DIRECTION at TRISB7_bit;
sfr sbit DS1302_IO_VALUE at RB7_bit;
sfr sbit DS1302_CLK at RB6_bit;
sfr sbit DS1302_RST at RB5_bit;
#line 28 "C:/Users/wzomzot/Desktop/Мой курсач/02/ds1302.c"
void DS1302_init()
{
 DS1302_RST = 0;
 DS1302_CLK = 0;

 Delay_ms(5);

 DS1302_write( 0x8E , 0x00);
 DS1302_write( 0x90 , 0xA9);
}


void DS1302_get_date(Date* current_date)
{

 current_date->year = DS1302_read( 0x8D );

 current_date->year = bcd_to_decimal((0xFF & current_date->year));


 current_date->month = DS1302_read( 0x89 );

 current_date->month = bcd_to_decimal((0x1F & current_date->month));


 current_date->day = DS1302_read( 0x87 );

 current_date->day = bcd_to_decimal((0x3F & current_date->day));
}


void DS1302_set_date(Date* current_date)
{

 DS1302_write( 0x8C , decimal_to_bcd(current_date->year));


 DS1302_write( 0x88 , decimal_to_bcd(current_date->month));


 DS1302_write( 0x86 , decimal_to_bcd(current_date->day));
}


void DS1302_get_time(Time* current_time)
{

 current_time->hour = DS1302_read( 0x85 );

 current_time->hour = bcd_to_decimal((0x3F & current_time->hour));


 current_time->minute = DS1302_read( 0x83 );

 current_time->minute = bcd_to_decimal((0x7F & current_time->minute));


 current_time->second = DS1302_read( 0x81 );

 current_time->second = bcd_to_decimal((0x7F & current_time->second));
}


void DS1302_set_time(Time* current_time)
{

 DS1302_write( 0x84 , decimal_to_bcd(current_time->hour));


 DS1302_write( 0x82 , decimal_to_bcd(current_time->minute));


 DS1302_write( 0x80 , decimal_to_bcd(current_time->second));
}


unsigned char DS1302_serial_read()
{
 unsigned char value = 0;

 unsigned char byte = 0;
 unsigned char mask = 1;


 DS1302_IO_DIRECTION = 1;

 for (byte = 0; byte < 8; ++byte)
 {
 if (DS1302_IO_VALUE)
 {
 value |= mask;
 }

 DS1302_CLK = 1;
 DS1302_CLK = 0;

 mask <<= 1;
 }

 return value;
}


void DS1302_serial_write(unsigned char value)
{
 unsigned char byte = 0;
 unsigned char mask = 1;


 DS1302_IO_DIRECTION = 0;

 for (byte = 0; byte < 8; ++byte)
 {
 if (mask & value)
 {
 DS1302_IO_VALUE = 1;
 }
 else
 {
 DS1302_IO_VALUE = 0;
 }

 DS1302_CLK = 1;
 DS1302_CLK = 0;

 mask <<= 1;
 }
}


unsigned char DS1302_read(unsigned char address)
{
 unsigned char value = 0;

 DS1302_RST = 1;

 DS1302_serial_write(address); value = DS1302_serial_read();

 DS1302_RST = 0;

 return value;
}


void DS1302_write(unsigned char address, unsigned char value)
{
 DS1302_RST = 1;

 DS1302_serial_write(address); DS1302_serial_write(value);

 DS1302_RST = 0;
}


unsigned char bcd_to_decimal(unsigned char value)
{
 return ((value & 0x0F) + (((value & 0xF0) >> 4) * 10));
}


unsigned char decimal_to_bcd(unsigned char value)
{
 return ((((value / 10) << 4) & 0xF0) | ((value % 10) & 0x0F));
}
