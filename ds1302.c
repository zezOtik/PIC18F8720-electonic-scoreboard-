#include "ds1302.h"

// ����������� �����.
sfr sbit DS1302_IO_DIRECTION at TRISB7_bit;
sfr sbit DS1302_IO_VALUE at RB7_bit;
sfr sbit DS1302_CLK at RB6_bit;
sfr sbit DS1302_RST at RB5_bit;

// ��������.
#define SECOND_WREG 0x80
#define SECOND_RREG 0x81
#define MINUTE_WREG 0x82
#define MINUTE_RREG 0x83
#define HOUR_WREG 0x84
#define HOUR_RREG 0x85
#define DAY_WREG 0x86
#define DAY_RREG 0x87
#define MONTH_WREG 0x88
#define MONTH_RREG 0x89
#define YEAR_WREG 0x8C
#define YEAR_RREG 0x8D
#define CONTROL_WREG 0x8E
#define CONTROL_RREG 0x8F
#define CHARGE_WREG 0x90
#define CHARGE_RREG 0x91

//----------------------------------------------------------------------------//
void DS1302_init()
{
    DS1302_RST = 0;
    DS1302_CLK = 0;

    Delay_ms(5);

    DS1302_write(CONTROL_WREG, 0x00);
    DS1302_write(CHARGE_WREG, 0xA9);
}

//----------------------------------------------------------------------------//
void DS1302_get_date(Date* current_date)
{
    // ������ ����.
    current_date->year = DS1302_read(YEAR_RREG);
    // ������� ���� �� 2-10 � 10.
    current_date->year = bcd_to_decimal((0xFF & current_date->year));

    // ������ ������.
    current_date->month = DS1302_read(MONTH_RREG);
    // ������� ������ �� 2-10 � 10.
    current_date->month = bcd_to_decimal((0x1F & current_date->month));

    // ������ ���.
    current_date->day = DS1302_read(DAY_RREG);
    // ������� ��� �� 2-10 � 10.
    current_date->day = bcd_to_decimal((0x3F & current_date->day));
}

//----------------------------------------------------------------------------//
void DS1302_set_date(Date* current_date)
{
    // ������ ����.
    DS1302_write(YEAR_WREG, decimal_to_bcd(current_date->year));

    // ������ ������.
    DS1302_write(MONTH_WREG, decimal_to_bcd(current_date->month));

    // ������ ���.
    DS1302_write(DAY_WREG, decimal_to_bcd(current_date->day));
}

//----------------------------------------------------------------------------//
void DS1302_get_time(Time* current_time)
{
    // ������ ����.
    current_time->hour = DS1302_read(HOUR_RREG);
    // ������� ���� �� 2-10 � 10.
    current_time->hour = bcd_to_decimal((0x3F & current_time->hour));

    // ������ �����.
    current_time->minute = DS1302_read(MINUTE_RREG);
    // ������� ����� �� 2-10 � 10.
    current_time->minute = bcd_to_decimal((0x7F & current_time->minute));

    // ������ ������.
    current_time->second = DS1302_read(SECOND_RREG);
    // ������� ������ �� 2-10 � 10.
    current_time->second = bcd_to_decimal((0x7F & current_time->second));
}

//----------------------------------------------------------------------------//
void DS1302_set_time(Time* current_time)
{
    // ������ ����.
    DS1302_write(HOUR_WREG, decimal_to_bcd(current_time->hour));

    // ������ �����.
    DS1302_write(MINUTE_WREG, decimal_to_bcd(current_time->minute));

    // ������ ������.
    DS1302_write(SECOND_WREG, decimal_to_bcd(current_time->second));
}

//----------------------------------------------------------------------------//
unsigned char DS1302_serial_read()
{
    unsigned char value = 0;

    unsigned char byte = 0;
    unsigned char mask = 1;

    // ���������, ��� � ����� IO ����� ����������� ������.
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

//----------------------------------------------------------------------------//
void DS1302_serial_write(unsigned char value)
{
    unsigned char byte = 0;
    unsigned char mask = 1;

    // ���������, ��� �� ���� IO ����� ����������� ������.
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

//----------------------------------------------------------------------------//
unsigned char DS1302_read(unsigned char address)
{
    unsigned char value = 0;

    DS1302_RST = 1;

    DS1302_serial_write(address); value = DS1302_serial_read();

    DS1302_RST = 0;

    return value;
}

//----------------------------------------------------------------------------//
void DS1302_write(unsigned char address, unsigned char value)
{
    DS1302_RST = 1;

    DS1302_serial_write(address); DS1302_serial_write(value);

    DS1302_RST = 0;
}

//----------------------------------------------------------------------------//
unsigned char bcd_to_decimal(unsigned char value)
{
    return ((value & 0x0F) + (((value & 0xF0) >> 4) * 10));
}

//----------------------------------------------------------------------------//
unsigned char decimal_to_bcd(unsigned char value)
{
    return ((((value / 10) << 4) & 0xF0) | ((value % 10) & 0x0F));
}