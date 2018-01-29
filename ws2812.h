#ifndef _WS2812_H_
#define _WS2812_H_

#include "ds1302.h"
#include "enc28j60.h"

// Структура данных для хранения информации о пикселе.
typedef struct
{
    unsigned char blue;
    unsigned char green;
    unsigned char red;
} PixelParameter;

// Инициализация.
void WS2812_init();

// Получение данных о времени и курсе валют.
void WS2812_prepare_data();

// Длинная задержка.
void WS2812_delay_long();

// Короткая задержка.
void WS2812_delay_short();

// Считывание последнего состояния.
void WS2812_read_state();

// Сохранение текущего состояния.
void WS2812_save_state();

// Отображение часов.
void WS2812_print_clock();

// Отображение курса валют (Название).
void WS2812_print_currency_name();

// Отображение курса валют (Покупка).
void WS2812_print_currency_value_buy();

// Отображение курса валют (Продажа).
void WS2812_print_currency_value_sale();

// Уменьшает сохранённое время на одну секунду.
void WS2812_decrease_time();

// Увеличивает сохранённое время на одну секунду.
void WS2812_increase_time();

#endif // _WS2812_H_