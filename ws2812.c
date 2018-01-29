#include "ws2812.h"

// Управляющий порт для часов.
#define PANEL_CLOCK_PORT LATJ

// Управляющий порт для курса валют (Название).
#define PANEL_CURRENCY_NAME_PORT LATE
// Управляющий порт для курса валют (Покупка).
#define PANEL_CURRENCY_VALUE_BUY_PORT LATF
// Управляющий порт для курса валют (Продажа).
#define PANEL_CURRENCY_VALUE_SALE_PORT LATH

// Высота всей панели для часов.
#define PANEL_CLOCK_HEIGHT 7
// Ширина всей панели для часов.
#define PANEL_CLOCK_WIDTH 30

// Высота всей панели для курса валют (Название).
#define PANEL_CURRENCY_NAME_HEIGHT 7
// Ширина всей панели для курса валют (Название).
#define PANEL_CURRENCY_NAME_WIDTH 15
// Высота всей панели для курса валют (Покупка).
#define PANEL_CURRENCY_VALUE_BUY_HEIGHT 7
// Ширина всей панели для курса валют (Покупка).
#define PANEL_CURRENCY_VALUE_BUY_WIDTH 20
// Высота всей панели для курса валют (Продажа).
#define PANEL_CURRENCY_VALUE_SALE_HEIGHT 7
// Ширина всей панели для курса валют (Продажа).
#define PANEL_CURRENCY_VALUE_SALE_WIDTH 20

// Высота одной светодиодной матрицы.
#define MATRIX_HEIGHT 7
// Ширина одной светодиодной матрицы.
#define MATRIX_WIDTH 5

// Текущая итерация отображения данных.
unsigned char current_panel_iteration = 0;

// Текущий цвет фона.
unsigned char current_background_color[] = { 0xFF, 0xFF, 0xFF };
// Текущий цвет текста.
unsigned char current_text_color[] = { 0x00, 0x00, 0x00 };

// Текущие данные для курса валют.
Request currentRequest;
// Текущие данные для часов.
Time currentTime;

// Текущая информации о светодиодной панели для часов.
PixelParameter panel_clock_pixels[PANEL_CLOCK_HEIGHT][PANEL_CLOCK_WIDTH];

// Текущая информации о светодиодной панели для курса валют (Название).
PixelParameter panel_currency_name_pixels[PANEL_CURRENCY_NAME_HEIGHT][PANEL_CURRENCY_NAME_WIDTH];

// Текущая информации о светодиодной панели для курса валют (Покупка).
PixelParameter panel_currency_value_buy_pixels[PANEL_CURRENCY_VALUE_BUY_HEIGHT][PANEL_CURRENCY_VALUE_BUY_WIDTH];

// Текущая информации о светодиодной панели для курса валют (Продажа).
PixelParameter panel_currency_value_sale_pixels[PANEL_CURRENCY_VALUE_SALE_HEIGHT][PANEL_CURRENCY_VALUE_SALE_WIDTH];

// Алфавит (Цифры).
extern const unsigned char ALPHABET_NUMBERS[];
// Алфавит (Буквы).
extern const unsigned char ALPHABET_LETTERS[];

//----------------------------------------------------------------------------//
void WS2812_init()
{
    // Проверяем, находятся ли в EEPROM какие-нибудь значения.
    unsigned char status = EEPROM_Read(0x00); Delay_ms(20);

    // Если EEPROM до этого не использовался.
    if ((status != 0) && (status != 1))
    {
        EEPROM_Write(0x00, 0); Delay_ms(20);
    }
    else
    {
        // Если EEPROM пуст.
        if (status == 0)
        {
            return;
        }

        // Считываем сохранённое состояние.
        WS2812_read_state();

        // Настраиваем таймер TMR0.
        T0CON = 0x87;
        // Устанавливаем начальное значение таймера TMR0.
        TMR0L = 0x48;
        TMR0H = 0xE5;
        // Включаем глобальные прерывания.
        GIE_bit = 1;
        // Включаем прерывания по таймеру.
        TMR0IE_bit = 1;
    }
}

//----------------------------------------------------------------------------//
void WS2812_prepare_data()
{
    // Получаем запрос.
    ENC28J60_get_request(&currentRequest);

    // Сохраняем полученные данные в EEPROM.
    WS2812_save_state();

    // Настраиваем таймер TMR0.
    T0CON = 0x87;
    // Устанавливаем начальное значение таймера TMR0.
    TMR0L = 0x48;
    TMR0H = 0xE5;
    // Включаем глобальные прерывания.
    GIE_bit = 1;
    // Включаем прерывания по таймеру.
    TMR0IE_bit = 1;
}

//----------------------------------------------------------------------------//
void WS2812_delay_long()
{
    asm nop;
    asm nop;
    asm nop;
    asm nop;
}

//----------------------------------------------------------------------------//
void WS2812_delay_short()
{
    asm nop;
}

//----------------------------------------------------------------------------//
void WS2812_read_state()
{
    // Текущий адрес.
    unsigned int address_index = 0;
    // Текущее значение.
    unsigned int value_index = 0;

    // Текущий байт.
    unsigned char* current_byte;

    // Получаем текущее время с DS1302.
    DS1302_get_time(&currentTime);

    // Получаем курс покупки евро.
    for (value_index = 0; value_index < 2; ++value_index)
    {
        current_byte = &currentRequest.eur_buy[value_index];

        *current_byte++ = EEPROM_Read(++address_index); Delay_ms(20);
        *current_byte++ = EEPROM_Read(++address_index); Delay_ms(20);
    }

    // Получаем курс продажи евро.
    for (value_index = 0; value_index < 2; ++value_index)
    {
        current_byte = &currentRequest.eur_sale[value_index];

        *current_byte++ = EEPROM_Read(++address_index); Delay_ms(20);
        *current_byte++ = EEPROM_Read(++address_index); Delay_ms(20);
    }

    // Получаем курс покупки доллара.
    for (value_index = 0; value_index < 2; ++value_index)
    {
        current_byte = &currentRequest.usd_buy[value_index];

        *current_byte++ = EEPROM_Read(++address_index); Delay_ms(20);
        *current_byte++ = EEPROM_Read(++address_index); Delay_ms(20);
    }

    // Получаем курс продажи доллара.
    for (value_index = 0; value_index < 2; ++value_index)
    {
        current_byte = &currentRequest.usd_sale[value_index];

        *current_byte++ = EEPROM_Read(++address_index); Delay_ms(20);
        *current_byte++ = EEPROM_Read(++address_index); Delay_ms(20);
    }
}

//----------------------------------------------------------------------------//
void WS2812_save_state()
{
    // Текущий адрес.
    unsigned int address_index = 0;
    // Текущее значение.
    unsigned int value_index = 0;

    // Текущий байт.
    unsigned char* current_byte;

    // Указываем, что EEPROM не пуст.
    EEPROM_Write(address_index++, 1); Delay_ms(20);

    // Записываем курс покупки евро.
    for (value_index = 0; value_index < 2; ++value_index)
    {
        current_byte = &currentRequest.eur_buy[value_index];

        EEPROM_Write(address_index++, *current_byte++); Delay_ms(20);
        EEPROM_Write(address_index++, *current_byte++); Delay_ms(20);
    }

    // Записываем курс продажи евро.
    for (value_index = 0; value_index < 2; ++value_index)
    {
        current_byte = &currentRequest.eur_sale[value_index];

        EEPROM_Write(address_index++, *current_byte++); Delay_ms(20);
        EEPROM_Write(address_index++, *current_byte++); Delay_ms(20);
    }

    // Записываем курс покупки доллара.
    for (value_index = 0; value_index < 2; ++value_index)
    {
        current_byte = &currentRequest.usd_buy[value_index];

        EEPROM_Write(address_index++, *current_byte++); Delay_ms(20);
        EEPROM_Write(address_index++, *current_byte++); Delay_ms(20);
    }

    // Записываем курс продажи доллара.
    for (value_index = 0; value_index < 2; ++value_index)
    {
        current_byte = &currentRequest.usd_sale[value_index];

        EEPROM_Write(address_index++, *current_byte++); Delay_ms(20);
        EEPROM_Write(address_index++, *current_byte++); Delay_ms(20);
    }
}

//----------------------------------------------------------------------------//
void WS2812_print_clock()
{
    // Текущий пиксель на панели.
    unsigned int pixel_position = 0;

    // Текущий столбец матрицы.
    unsigned int matrix_column = 0;
    // Текущая строка матрицы.
    unsigned int matrix_row = 0;
    // Текущий столбец панели.
    unsigned int panel_column = 0;
    // Текущая строка панели.
    unsigned int panel_row = 0;

    // Текущий бит.
    unsigned char current_bit;
    // Текущий байт.
    unsigned char current_byte;

    // Строковое представление числа.
    char current_number[7];

    for (pixel_position = 0; pixel_position < PANEL_CLOCK_WIDTH; pixel_position += MATRIX_WIDTH)
    {
        for (matrix_row = 0; matrix_row < MATRIX_HEIGHT; ++matrix_row)
        {
            unsigned char matrix_element = 0x00;

            if ((pixel_position / MATRIX_WIDTH) == 0)
            {
                char symbol_code = 0; char* simplified_number;

                // Получаем строковое представление.
                IntToStr(currentTime.hour, current_number); simplified_number = Ltrim(current_number);

                if (strlen(simplified_number) > 1)
                {
                    symbol_code = simplified_number[0] - 48;
                }

                matrix_element = ALPHABET_NUMBERS[symbol_code * MATRIX_HEIGHT + matrix_row];
            }

            if ((pixel_position / MATRIX_WIDTH) == 1)
            {
                char symbol_code = 0; char* simplified_number;

                // Получаем строковое представление.
                IntToStr(currentTime.hour, current_number); simplified_number = Ltrim(current_number);

                if (strlen(simplified_number) == 1)
                {
                    symbol_code = simplified_number[0] - 48;
                }

                if (strlen(simplified_number) == 2)
                {
                    symbol_code = simplified_number[1] - 48;
                }

                matrix_element = ALPHABET_NUMBERS[symbol_code * MATRIX_HEIGHT + matrix_row];
            }

            if ((pixel_position / MATRIX_WIDTH) == 2)
            {
                char symbol_code = 0; char* simplified_number;

                // Получаем строковое представление.
                IntToStr(currentTime.minute, current_number); simplified_number = Ltrim(current_number);

                if (strlen(simplified_number) > 1)
                {
                    symbol_code = simplified_number[0] - 48;
                }

                matrix_element = ALPHABET_NUMBERS[symbol_code * MATRIX_HEIGHT + matrix_row];
            }

            if ((pixel_position / MATRIX_WIDTH) == 3)
            {
                char symbol_code = 0; char* simplified_number;

                // Получаем строковое представление.
                IntToStr(currentTime.minute, current_number); simplified_number = Ltrim(current_number);

                if (strlen(simplified_number) == 1)
                {
                    symbol_code = simplified_number[0] - 48;
                }

                if (strlen(simplified_number) == 2)
                {
                    symbol_code = simplified_number[1] - 48;
                }

                matrix_element = ALPHABET_NUMBERS[symbol_code * MATRIX_HEIGHT + matrix_row];
            }

            if ((pixel_position / MATRIX_WIDTH) == 4)
            {
                char symbol_code = 0; char* simplified_number;

                // Получаем строковое представление.
                IntToStr(currentTime.second, current_number); simplified_number = Ltrim(current_number);

                if (strlen(simplified_number) > 1)
                {
                    symbol_code = simplified_number[0] - 48;
                }

                matrix_element = ALPHABET_NUMBERS[symbol_code * MATRIX_HEIGHT + matrix_row];
            }

            if ((pixel_position / MATRIX_WIDTH) == 5)
            {
                char symbol_code = 0; char* simplified_number;

                // Получаем строковое представление.
                IntToStr(currentTime.second, current_number); simplified_number = Ltrim(current_number);

                if (strlen(simplified_number) == 1)
                {
                    symbol_code = simplified_number[0] - 48;
                }

                if (strlen(simplified_number) == 2)
                {
                    symbol_code = simplified_number[1] - 48;
                }

                matrix_element = ALPHABET_NUMBERS[symbol_code * MATRIX_HEIGHT + matrix_row];
            }

            for (matrix_column = 0; matrix_column < MATRIX_WIDTH; ++matrix_column)
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

    for (panel_row = 0; panel_row < PANEL_CLOCK_HEIGHT; ++panel_row)
    {
        // Маска для включения ножки.
        unsigned char mask_enable = PANEL_CLOCK_PORT | (0x01 << panel_row);
        // Маска для выключения ножки.
        unsigned char mask_disable = PANEL_CLOCK_PORT & ~(0x01 << panel_row);

        // Набор пикселей для текущей строки.
        PixelParameter* pixels = panel_clock_pixels[panel_row];

        for (panel_column = 0; panel_column < PANEL_CLOCK_WIDTH; ++panel_column)
        {
            // Зелёный цвет.
            current_byte = pixels[panel_column].green;

            for (current_bit = 0; current_bit < 8; ++current_bit)
            {
                if (current_byte & 0x80)
                {
                    PANEL_CLOCK_PORT = mask_enable;

                    WS2812_delay_long();

                    PANEL_CLOCK_PORT = mask_disable;
                }
                else
                {
                    PANEL_CLOCK_PORT = mask_enable;

                    PANEL_CLOCK_PORT = mask_disable;
                }

                current_byte = current_byte << 1;
            }

            // Красный цвет.
            current_byte = pixels[panel_column].red;

            for (current_bit = 0; current_bit < 8; ++current_bit)
            {
                if (current_byte & 0x80)
                {
                    PANEL_CLOCK_PORT = mask_enable;

                    WS2812_delay_long();

                    PANEL_CLOCK_PORT = mask_disable;
                }
                else
                {
                    PANEL_CLOCK_PORT = mask_enable;

                    PANEL_CLOCK_PORT = mask_disable;
                }

                current_byte = current_byte << 1;
            }

            // Голубой цвет.
            current_byte = pixels[panel_column].blue;

            for (current_bit = 0; current_bit < 8; ++current_bit)
            {
                if (current_byte & 0x80)
                {
                    PANEL_CLOCK_PORT = mask_enable;

                    WS2812_delay_long();

                    PANEL_CLOCK_PORT = mask_disable;
                }
                else
                {
                    PANEL_CLOCK_PORT = mask_enable;

                    PANEL_CLOCK_PORT = mask_disable;
                }

                current_byte = current_byte << 1;
            }
        }

        // Задержка для записи данных.
        Delay_us(50);
    }
}

//----------------------------------------------------------------------------//
void WS2812_print_currency_name()
{
    // Текущий пиксель на панели.
    unsigned int pixel_position = 0;

    // Текущий столбец матрицы.
    unsigned int matrix_column = 0;
    // Текущая строка матрицы.
    unsigned int matrix_row = 0;
    // Текущий столбец панели.
    unsigned int panel_column = 0;
    // Текущая строка панели.
    unsigned int panel_row = 0;

    // Текущий бит.
    unsigned char current_bit;
    // Текущий байт.
    unsigned char current_byte;

    for (pixel_position = 0; pixel_position < PANEL_CURRENCY_NAME_WIDTH; pixel_position += MATRIX_WIDTH)
    {
        for (matrix_row = 0; matrix_row < MATRIX_HEIGHT; ++matrix_row)
        {
            unsigned char matrix_element = 0x00;

            if ((pixel_position / MATRIX_WIDTH) == 0)
            {
                if ((current_panel_iteration % 2) == 0)
                {
                    // Буква U.
                    matrix_element = ALPHABET_LETTERS[('U' - 65) * MATRIX_HEIGHT + matrix_row];
                }
                else
                {
                    // Буква E.
                    matrix_element = ALPHABET_LETTERS[('E' - 65) * MATRIX_HEIGHT + matrix_row];
                }
            }

            if ((pixel_position / MATRIX_WIDTH) == 1)
            {
                if ((current_panel_iteration % 2) == 0)
                {
                    // Буква S.
                    matrix_element = ALPHABET_LETTERS[('S' - 65) * MATRIX_HEIGHT + matrix_row];
                }
                else
                {
                    // Буква U.
                    matrix_element = ALPHABET_LETTERS[('U' - 65) * MATRIX_HEIGHT + matrix_row];
                }
            }

            if ((pixel_position / MATRIX_WIDTH) == 2)
            {
                if ((current_panel_iteration % 2) == 0)
                {
                    // Буква S.
                    matrix_element = ALPHABET_LETTERS[('D' - 65) * MATRIX_HEIGHT + matrix_row];
                }
                else
                {
                    // Буква U.
                    matrix_element = ALPHABET_LETTERS[('R' - 65) * MATRIX_HEIGHT + matrix_row];
                }
            }

            for (matrix_column = 0; matrix_column < MATRIX_WIDTH; ++matrix_column)
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

    for (panel_row = 0; panel_row < PANEL_CURRENCY_NAME_HEIGHT; ++panel_row)
    {
        // Маска для включения ножки.
        unsigned char mask_enable = PANEL_CURRENCY_NAME_PORT | (0x01 << panel_row);
        // Маска для выключения ножки.
        unsigned char mask_disable = PANEL_CURRENCY_NAME_PORT & ~(0x01 << panel_row);

        // Набор пикселей для текущей строки.
        PixelParameter* pixels = panel_currency_name_pixels[panel_row];

        for (panel_column = 0; panel_column < PANEL_CLOCK_WIDTH; ++panel_column)
        {
            // Зелёный цвет.
            current_byte = pixels[panel_column].green;

            for (current_bit = 0; current_bit < 8; ++current_bit)
            {
                if (current_byte & 0x80)
                {
                    PANEL_CURRENCY_NAME_PORT = mask_enable;

                    WS2812_delay_long();

                    PANEL_CURRENCY_NAME_PORT = mask_disable;
                }
                else
                {
                    PANEL_CURRENCY_NAME_PORT = mask_enable;

                    PANEL_CURRENCY_NAME_PORT = mask_disable;
                }

                current_byte = current_byte << 1;
            }

            // Красный цвет.
            current_byte = pixels[panel_column].red;

            for (current_bit = 0; current_bit < 8; ++current_bit)
            {
                if (current_byte & 0x80)
                {
                    PANEL_CURRENCY_NAME_PORT = mask_enable;

                    WS2812_delay_long();

                    PANEL_CURRENCY_NAME_PORT = mask_disable;
                }
                else
                {
                    PANEL_CURRENCY_NAME_PORT = mask_enable;

                    PANEL_CURRENCY_NAME_PORT = mask_disable;
                }

                current_byte = current_byte << 1;
            }

            // Голубой цвет.
            current_byte = pixels[panel_column].blue;

            for (current_bit = 0; current_bit < 8; ++current_bit)
            {
                if (current_byte & 0x80)
                {
                    PANEL_CURRENCY_NAME_PORT = mask_enable;

                    WS2812_delay_long();

                    PANEL_CURRENCY_NAME_PORT = mask_disable;
                }
                else
                {
                    PANEL_CURRENCY_NAME_PORT = mask_enable;

                    PANEL_CURRENCY_NAME_PORT = mask_disable;
                }

                current_byte = current_byte << 1;
            }
        }

        // Задержка для записи данных.
        Delay_us(50);
    }
}

//----------------------------------------------------------------------------//
void WS2812_print_currency_value_buy()
{
    // Текущий пиксель на панели.
    unsigned int pixel_position = 0;

    // Текущий столбец матрицы.
    unsigned int matrix_column = 0;
    // Текущая строка матрицы.
    unsigned int matrix_row = 0;
    // Текущий столбец панели.
    unsigned int panel_column = 0;
    // Текущая строка панели.
    unsigned int panel_row = 0;

    // Текущий бит.
    unsigned char current_bit;
    // Текущий байт.
    unsigned char current_byte;

    // Строковое представление числа.
    char current_number[7];

    for (pixel_position = 0; pixel_position < PANEL_CURRENCY_VALUE_BUY_WIDTH; pixel_position += MATRIX_WIDTH)
    {
        for (matrix_row = 0; matrix_row < MATRIX_HEIGHT; ++matrix_row)
        {
            unsigned char matrix_element = 0x00;

            if ((pixel_position / MATRIX_WIDTH) == 0)
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

                matrix_element = ALPHABET_NUMBERS[symbol_code * MATRIX_HEIGHT + matrix_row];
            }

            if ((pixel_position / MATRIX_WIDTH) == 1)
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

                matrix_element = ALPHABET_NUMBERS[symbol_code * MATRIX_HEIGHT + matrix_row];
            }

            if ((pixel_position / MATRIX_WIDTH) == 2)
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

                matrix_element = ALPHABET_NUMBERS[symbol_code * MATRIX_HEIGHT + matrix_row];
            }

            if ((pixel_position / MATRIX_WIDTH) == 3)
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

                matrix_element = ALPHABET_NUMBERS[symbol_code * MATRIX_HEIGHT + matrix_row];
            }

            for (matrix_column = 0; matrix_column < MATRIX_WIDTH; ++matrix_column)
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

    for (panel_row = 0; panel_row < PANEL_CURRENCY_VALUE_BUY_HEIGHT; ++panel_row)
    {
        // Маска для включения ножки.
        unsigned char mask_enable = PANEL_CURRENCY_VALUE_BUY_PORT | (0x01 << panel_row);
        // Маска для выключения ножки.
        unsigned char mask_disable = PANEL_CURRENCY_VALUE_BUY_PORT & ~(0x01 << panel_row);

        // Набор пикселей для текущей строки.
        PixelParameter* pixels = panel_currency_value_buy_pixels[panel_row];

        for (panel_column = 0; panel_column < PANEL_CURRENCY_VALUE_BUY_WIDTH; ++panel_column)
        {
            // Зелёный цвет.
            current_byte = pixels[panel_column].green;

            for (current_bit = 0; current_bit < 8; ++current_bit)
            {
                if (current_byte & 0x80)
                {
                    PANEL_CURRENCY_VALUE_BUY_PORT = mask_enable;

                    WS2812_delay_long();

                    PANEL_CURRENCY_VALUE_BUY_PORT = mask_disable;
                }
                else
                {
                    PANEL_CURRENCY_VALUE_BUY_PORT = mask_enable;

                    PANEL_CURRENCY_VALUE_BUY_PORT = mask_disable;
                }

                current_byte = current_byte << 1;
            }

            // Красный цвет.
            current_byte = pixels[panel_column].red;

            for (current_bit = 0; current_bit < 8; ++current_bit)
            {
                if (current_byte & 0x80)
                {
                    PANEL_CURRENCY_VALUE_BUY_PORT = mask_enable;

                    WS2812_delay_long();

                    PANEL_CURRENCY_VALUE_BUY_PORT = mask_disable;
                }
                else
                {
                    PANEL_CURRENCY_VALUE_BUY_PORT = mask_enable;

                    PANEL_CURRENCY_VALUE_BUY_PORT = mask_disable;
                }

                current_byte = current_byte << 1;
            }

            // Голубой цвет.
            current_byte = pixels[panel_column].blue;

            for (current_bit = 0; current_bit < 8; ++current_bit)
            {
                if (current_byte & 0x80)
                {
                    PANEL_CURRENCY_VALUE_BUY_PORT = mask_enable;

                    WS2812_delay_long();

                    PANEL_CURRENCY_VALUE_BUY_PORT = mask_disable;
                }
                else
                {
                    PANEL_CURRENCY_VALUE_BUY_PORT = mask_enable;

                    PANEL_CURRENCY_VALUE_BUY_PORT = mask_disable;
                }

                current_byte = current_byte << 1;
            }
        }

        // Задержка для записи данных.
        Delay_us(50);
    }
}

//----------------------------------------------------------------------------//
void WS2812_print_currency_value_sale()
{
    // Текущий пиксель на панели.
    unsigned int pixel_position = 0;

    // Текущий столбец матрицы.
    unsigned int matrix_column = 0;
    // Текущая строка матрицы.
    unsigned int matrix_row = 0;
    // Текущий столбец панели.
    unsigned int panel_column = 0;
    // Текущая строка панели.
    unsigned int panel_row = 0;

    // Текущий бит.
    unsigned char current_bit;
    // Текущий байт.
    unsigned char current_byte;

    // Строковое представление числа.
    char current_number[7];

    for (pixel_position = 0; pixel_position < PANEL_CURRENCY_VALUE_SALE_WIDTH; pixel_position += MATRIX_WIDTH)
    {
        for (matrix_row = 0; matrix_row < MATRIX_HEIGHT; ++matrix_row)
        {
            unsigned char matrix_element = 0x00;

            if ((pixel_position / MATRIX_WIDTH) == 0)
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

                matrix_element = ALPHABET_NUMBERS[symbol_code * MATRIX_HEIGHT + matrix_row];
            }

            if ((pixel_position / MATRIX_WIDTH) == 1)
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

                matrix_element = ALPHABET_NUMBERS[symbol_code * MATRIX_HEIGHT + matrix_row];
            }

            if ((pixel_position / MATRIX_WIDTH) == 2)
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

                matrix_element = ALPHABET_NUMBERS[symbol_code * MATRIX_HEIGHT + matrix_row];
            }

            if ((pixel_position / MATRIX_WIDTH) == 3)
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

                matrix_element = ALPHABET_NUMBERS[symbol_code * MATRIX_HEIGHT + matrix_row];
            }

            for (matrix_column = 0; matrix_column < MATRIX_WIDTH; ++matrix_column)
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

    for (panel_row = 0; panel_row < PANEL_CURRENCY_VALUE_SALE_WIDTH; ++panel_row)
    {
        // Маска для включения ножки.
        unsigned char mask_enable = PANEL_CURRENCY_VALUE_SALE_PORT | (0x01 << panel_row);
        // Маска для выключения ножки.
        unsigned char mask_disable = PANEL_CURRENCY_VALUE_SALE_PORT & ~(0x01 << panel_row);

        // Набор пикселей для текущей строки.
        PixelParameter* pixels = panel_currency_value_sale_pixels[panel_row];

        for (panel_column = 0; panel_column < PANEL_CURRENCY_VALUE_SALE_WIDTH; ++panel_column)
        {
            // Зелёный цвет.
            current_byte = pixels[panel_column].green;

            for (current_bit = 0; current_bit < 8; ++current_bit)
            {
                if (current_byte & 0x80)
                {
                    PANEL_CURRENCY_VALUE_SALE_PORT = mask_enable;

                    WS2812_delay_long();

                    PANEL_CURRENCY_VALUE_SALE_PORT = mask_disable;
                }
                else
                {
                    PANEL_CURRENCY_VALUE_SALE_PORT = mask_enable;

                    PANEL_CURRENCY_VALUE_SALE_PORT = mask_disable;
                }

                current_byte = current_byte << 1;
            }

            // Красный цвет.
            current_byte = pixels[panel_column].red;

            for (current_bit = 0; current_bit < 8; ++current_bit)
            {
                if (current_byte & 0x80)
                {
                    PANEL_CURRENCY_VALUE_SALE_PORT = mask_enable;

                    WS2812_delay_long();

                    PANEL_CURRENCY_VALUE_SALE_PORT = mask_disable;
                }
                else
                {
                    PANEL_CURRENCY_VALUE_SALE_PORT = mask_enable;

                    PANEL_CURRENCY_VALUE_SALE_PORT = mask_disable;
                }

                current_byte = current_byte << 1;
            }

            // Голубой цвет.
            current_byte = pixels[panel_column].blue;

            for (current_bit = 0; current_bit < 8; ++current_bit)
            {
                if (current_byte & 0x80)
                {
                    PANEL_CURRENCY_VALUE_SALE_PORT = mask_enable;

                    WS2812_delay_long();

                    PANEL_CURRENCY_VALUE_SALE_PORT = mask_disable;
                }
                else
                {
                    PANEL_CURRENCY_VALUE_SALE_PORT = mask_enable;

                    PANEL_CURRENCY_VALUE_SALE_PORT = mask_disable;
                }

                current_byte = current_byte << 1;
            }
        }

        // Задержка для записи данных.
        Delay_us(50);
    }
}

//----------------------------------------------------------------------------//
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

//----------------------------------------------------------------------------//
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

//----------------------------------------------------------------------------//
void interrupt()
{
    if (TMR0IF_bit)
    {
        // Отображаем курс валют.
        if ((current_panel_iteration % 15) == 0)
        {
            WS2812_print_currency_name();
            WS2812_print_currency_value_buy();
            WS2812_print_currency_value_sale();
        }

        // Отображаем часы.
        if ((current_panel_iteration % 10) == 0)
        {
            WS2812_print_clock(); WS2812_increase_time();
        }

        ++current_panel_iteration;

        // Обнуляем флаг прерываний по таймеру.
        TMR0IF_bit = 0;
        // Настраиваем таймер TMR0.
        T0CON = 0x87;
        // Устанавливаем начальное значение таймера TMR0.
        TMR0L = 0x48;
        TMR0H = 0xE5;
        // Включаем глобальные прерывания.
        GIE_bit = 1;
        // Включаем прерывания по таймеру.
        TMR0IE_bit = 1;
    }
}