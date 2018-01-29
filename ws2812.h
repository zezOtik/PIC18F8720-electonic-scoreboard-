#ifndef _WS2812_H_
#define _WS2812_H_

#include "ds1302.h"
#include "enc28j60.h"

// ��������� ������ ��� �������� ���������� � �������.
typedef struct
{
    unsigned char blue;
    unsigned char green;
    unsigned char red;
} PixelParameter;

// �������������.
void WS2812_init();

// ��������� ������ � ������� � ����� �����.
void WS2812_prepare_data();

// ������� ��������.
void WS2812_delay_long();

// �������� ��������.
void WS2812_delay_short();

// ���������� ���������� ���������.
void WS2812_read_state();

// ���������� �������� ���������.
void WS2812_save_state();

// ����������� �����.
void WS2812_print_clock();

// ����������� ����� ����� (��������).
void WS2812_print_currency_name();

// ����������� ����� ����� (�������).
void WS2812_print_currency_value_buy();

// ����������� ����� ����� (�������).
void WS2812_print_currency_value_sale();

// ��������� ���������� ����� �� ���� �������.
void WS2812_decrease_time();

// ����������� ���������� ����� �� ���� �������.
void WS2812_increase_time();

#endif // _WS2812_H_