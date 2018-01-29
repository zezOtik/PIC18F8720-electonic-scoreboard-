#include "resources.h"
#include "ws2812.h"

// Инициализация PIC18F26K20.
void PIC18F26K20_init();

void main()
{
    // Инициализация PIC18F26K20.
    PIC18F26K20_init();
    // Инициализация ENC28J60.
    ENC28J60_init();
    // Инициализация DS1302.
    DS1302_init();
    // Инициализация WS2812.
    WS2812_init();

    while (1)
    {
        // Проверяем, был ли получен запрос.
        if (ENC28J60_had_request())
        {
            WS2812_prepare_data();
        }
    }
}

void PIC18F26K20_init()
{
    // Задание направлений портов.
    TRISB = 0x00;
    TRISE = 0x00;
    TRISF = 0x00;
    TRISH = 0x00;
    TRISJ = 0x00;
    // Задание значений портов.
    PORTB = 0x00;
    PORTE = 0x00;
    PORTF = 0x00;
    PORTH = 0x00;
    PORTJ = 0x00;

    // Инициализация протокола SPI.
    SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16,
                       _SPI_DATA_SAMPLE_MIDDLE,
                       _SPI_CLK_IDLE_LOW,
                       _SPI_HIGH_2_LOW);
}