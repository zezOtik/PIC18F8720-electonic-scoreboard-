#ifndef _DS1302_H_
#define _DS1302_H_

// ��������� ������ ��� �������� ������� ����.
typedef struct
{
    unsigned char day;
    unsigned char month;
    unsigned char year;
} Date;

// ��������� ������ ��� �������� �������� �������.
typedef struct
{
    unsigned char hour;
    unsigned char minute;
    unsigned char second;
} Time;

// �������������.
void DS1302_init();

// ��������� ������� ����.
void DS1302_get_date(Date* current_date);

// ������� ������� ����.
void DS1302_set_date(Date* current_date);

// ��������� �������� �������.
void DS1302_get_time(Time* current_time);

// ������� �������� �������.
void DS1302_set_time(Time* current_time);

// ������ ���������� � ����������� ������;
unsigned char DS1302_serial_read();

// ������ ���������� �� ����������� �����.
void DS1302_serial_write(unsigned char value);

// ������ ����������.
unsigned char DS1302_read(unsigned char address);

// ������ ����������.
void DS1302_write(unsigned char address, unsigned char value);

// ������� ����� �� 2-10 � 10.
unsigned char bcd_to_decimal(unsigned char value);

// ������� ����� �� 10 � 2-10.
unsigned char decimal_to_bcd(unsigned char value);

#endif // _DS1302_H_