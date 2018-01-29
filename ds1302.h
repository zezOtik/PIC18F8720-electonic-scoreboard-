#ifndef _DS1302_H_
#define _DS1302_H_

// Структура данных для хранения текущей даты.
typedef struct
{
    unsigned char day;
    unsigned char month;
    unsigned char year;
} Date;

// Структура данных для хранения текущего времени.
typedef struct
{
    unsigned char hour;
    unsigned char minute;
    unsigned char second;
} Time;

// Инициализация.
void DS1302_init();

// Получение текущей даты.
void DS1302_get_date(Date* current_date);

// Задание текущей даты.
void DS1302_set_date(Date* current_date);

// Получение текущего времени.
void DS1302_get_time(Time* current_time);

// Задание текущего времени.
void DS1302_set_time(Time* current_time);

// Чтение информации с управляющих портов;
unsigned char DS1302_serial_read();

// Запись информации на управляющие порты.
void DS1302_serial_write(unsigned char value);

// Чтение информации.
unsigned char DS1302_read(unsigned char address);

// Запись информации.
void DS1302_write(unsigned char address, unsigned char value);

// Перевод числа из 2-10 в 10.
unsigned char bcd_to_decimal(unsigned char value);

// Перевод числа из 10 в 2-10.
unsigned char decimal_to_bcd(unsigned char value);

#endif // _DS1302_H_