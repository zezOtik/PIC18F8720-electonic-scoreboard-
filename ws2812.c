#include "ws2812.h"

// ����������� ���� ��� �����.
#define PANEL_CLOCK_PORT LATJ

// ����������� ���� ��� ����� ����� (��������).
#define PANEL_CURRENCY_NAME_PORT LATE
// ����������� ���� ��� ����� ����� (�������).
#define PANEL_CURRENCY_VALUE_BUY_PORT LATF
// ����������� ���� ��� ����� ����� (�������).
#define PANEL_CURRENCY_VALUE_SALE_PORT LATH

// ������ ���� ������ ��� �����.
#define PANEL_CLOCK_HEIGHT 7
// ������ ���� ������ ��� �����.
#define PANEL_CLOCK_WIDTH 30

// ������ ���� ������ ��� ����� ����� (��������).
#define PANEL_CURRENCY_NAME_HEIGHT 7
// ������ ���� ������ ��� ����� ����� (��������).
#define PANEL_CURRENCY_NAME_WIDTH 15
// ������ ���� ������ ��� ����� ����� (�������).
#define PANEL_CURRENCY_VALUE_BUY_HEIGHT 7
// ������ ���� ������ ��� ����� ����� (�������).
#define PANEL_CURRENCY_VALUE_BUY_WIDTH 20
// ������ ���� ������ ��� ����� ����� (�������).
#define PANEL_CURRENCY_VALUE_SALE_HEIGHT 7
// ������ ���� ������ ��� ����� ����� (�������).
#define PANEL_CURRENCY_VALUE_SALE_WIDTH 20

// ������ ����� ������������ �������.
#define MATRIX_HEIGHT 7
// ������ ����� ������������ �������.
#define MATRIX_WIDTH 5

// ������� �������� ����������� ������.
unsigned char current_panel_iteration = 0;

// ������� ���� ����.
unsigned char current_background_color[] = { 0xFF, 0xFF, 0xFF };
// ������� ���� ������.
unsigned char current_text_color[] = { 0x00, 0x00, 0x00 };

// ������� ������ ��� ����� �����.
Request currentRequest;
// ������� ������ ��� �����.
Time currentTime;

// ������� ���������� � ������������ ������ ��� �����.
PixelParameter panel_clock_pixels[PANEL_CLOCK_HEIGHT][PANEL_CLOCK_WIDTH];

// ������� ���������� � ������������ ������ ��� ����� ����� (��������).
PixelParameter panel_currency_name_pixels[PANEL_CURRENCY_NAME_HEIGHT][PANEL_CURRENCY_NAME_WIDTH];

// ������� ���������� � ������������ ������ ��� ����� ����� (�������).
PixelParameter panel_currency_value_buy_pixels[PANEL_CURRENCY_VALUE_BUY_HEIGHT][PANEL_CURRENCY_VALUE_BUY_WIDTH];

// ������� ���������� � ������������ ������ ��� ����� ����� (�������).
PixelParameter panel_currency_value_sale_pixels[PANEL_CURRENCY_VALUE_SALE_HEIGHT][PANEL_CURRENCY_VALUE_SALE_WIDTH];

// ������� (�����).
extern const unsigned char ALPHABET_NUMBERS[];
// ������� (�����).
extern const unsigned char ALPHABET_LETTERS[];

//----------------------------------------------------------------------------//
void WS2812_init()
{
    // ���������, ��������� �� � EEPROM �����-������ ��������.
    unsigned char status = EEPROM_Read(0x00); Delay_ms(20);

    // ���� EEPROM �� ����� �� �������������.
    if ((status != 0) && (status != 1))
    {
        EEPROM_Write(0x00, 0); Delay_ms(20);
    }
    else
    {
        // ���� EEPROM ����.
        if (status == 0)
        {
            return;
        }

        // ��������� ���������� ���������.
        WS2812_read_state();

        // ����������� ������ TMR0.
        T0CON = 0x87;
        // ������������� ��������� �������� ������� TMR0.
        TMR0L = 0x48;
        TMR0H = 0xE5;
        // �������� ���������� ����������.
        GIE_bit = 1;
        // �������� ���������� �� �������.
        TMR0IE_bit = 1;
    }
}

//----------------------------------------------------------------------------//
void WS2812_prepare_data()
{
    // �������� ������.
    ENC28J60_get_request(&currentRequest);

    // ��������� ���������� ������ � EEPROM.
    WS2812_save_state();

    // ����������� ������ TMR0.
    T0CON = 0x87;
    // ������������� ��������� �������� ������� TMR0.
    TMR0L = 0x48;
    TMR0H = 0xE5;
    // �������� ���������� ����������.
    GIE_bit = 1;
    // �������� ���������� �� �������.
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
    // ������� �����.
    unsigned int address_index = 0;
    // ������� ��������.
    unsigned int value_index = 0;

    // ������� ����.
    unsigned char* current_byte;

    // �������� ������� ����� � DS1302.
    DS1302_get_time(&currentTime);

    // �������� ���� ������� ����.
    for (value_index = 0; value_index < 2; ++value_index)
    {
        current_byte = &currentRequest.eur_buy[value_index];

        *current_byte++ = EEPROM_Read(++address_index); Delay_ms(20);
        *current_byte++ = EEPROM_Read(++address_index); Delay_ms(20);
    }

    // �������� ���� ������� ����.
    for (value_index = 0; value_index < 2; ++value_index)
    {
        current_byte = &currentRequest.eur_sale[value_index];

        *current_byte++ = EEPROM_Read(++address_index); Delay_ms(20);
        *current_byte++ = EEPROM_Read(++address_index); Delay_ms(20);
    }

    // �������� ���� ������� �������.
    for (value_index = 0; value_index < 2; ++value_index)
    {
        current_byte = &currentRequest.usd_buy[value_index];

        *current_byte++ = EEPROM_Read(++address_index); Delay_ms(20);
        *current_byte++ = EEPROM_Read(++address_index); Delay_ms(20);
    }

    // �������� ���� ������� �������.
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
    // ������� �����.
    unsigned int address_index = 0;
    // ������� ��������.
    unsigned int value_index = 0;

    // ������� ����.
    unsigned char* current_byte;

    // ���������, ��� EEPROM �� ����.
    EEPROM_Write(address_index++, 1); Delay_ms(20);

    // ���������� ���� ������� ����.
    for (value_index = 0; value_index < 2; ++value_index)
    {
        current_byte = &currentRequest.eur_buy[value_index];

        EEPROM_Write(address_index++, *current_byte++); Delay_ms(20);
        EEPROM_Write(address_index++, *current_byte++); Delay_ms(20);
    }

    // ���������� ���� ������� ����.
    for (value_index = 0; value_index < 2; ++value_index)
    {
        current_byte = &currentRequest.eur_sale[value_index];

        EEPROM_Write(address_index++, *current_byte++); Delay_ms(20);
        EEPROM_Write(address_index++, *current_byte++); Delay_ms(20);
    }

    // ���������� ���� ������� �������.
    for (value_index = 0; value_index < 2; ++value_index)
    {
        current_byte = &currentRequest.usd_buy[value_index];

        EEPROM_Write(address_index++, *current_byte++); Delay_ms(20);
        EEPROM_Write(address_index++, *current_byte++); Delay_ms(20);
    }

    // ���������� ���� ������� �������.
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
    // ������� ������� �� ������.
    unsigned int pixel_position = 0;

    // ������� ������� �������.
    unsigned int matrix_column = 0;
    // ������� ������ �������.
    unsigned int matrix_row = 0;
    // ������� ������� ������.
    unsigned int panel_column = 0;
    // ������� ������ ������.
    unsigned int panel_row = 0;

    // ������� ���.
    unsigned char current_bit;
    // ������� ����.
    unsigned char current_byte;

    // ��������� ������������� �����.
    char current_number[7];

    for (pixel_position = 0; pixel_position < PANEL_CLOCK_WIDTH; pixel_position += MATRIX_WIDTH)
    {
        for (matrix_row = 0; matrix_row < MATRIX_HEIGHT; ++matrix_row)
        {
            unsigned char matrix_element = 0x00;

            if ((pixel_position / MATRIX_WIDTH) == 0)
            {
                char symbol_code = 0; char* simplified_number;

                // �������� ��������� �������������.
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

                // �������� ��������� �������������.
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

                // �������� ��������� �������������.
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

                // �������� ��������� �������������.
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

                // �������� ��������� �������������.
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

                // �������� ��������� �������������.
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
        // ����� ��� ��������� �����.
        unsigned char mask_enable = PANEL_CLOCK_PORT | (0x01 << panel_row);
        // ����� ��� ���������� �����.
        unsigned char mask_disable = PANEL_CLOCK_PORT & ~(0x01 << panel_row);

        // ����� �������� ��� ������� ������.
        PixelParameter* pixels = panel_clock_pixels[panel_row];

        for (panel_column = 0; panel_column < PANEL_CLOCK_WIDTH; ++panel_column)
        {
            // ������ ����.
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

            // ������� ����.
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

            // ������� ����.
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

        // �������� ��� ������ ������.
        Delay_us(50);
    }
}

//----------------------------------------------------------------------------//
void WS2812_print_currency_name()
{
    // ������� ������� �� ������.
    unsigned int pixel_position = 0;

    // ������� ������� �������.
    unsigned int matrix_column = 0;
    // ������� ������ �������.
    unsigned int matrix_row = 0;
    // ������� ������� ������.
    unsigned int panel_column = 0;
    // ������� ������ ������.
    unsigned int panel_row = 0;

    // ������� ���.
    unsigned char current_bit;
    // ������� ����.
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
                    // ����� U.
                    matrix_element = ALPHABET_LETTERS[('U' - 65) * MATRIX_HEIGHT + matrix_row];
                }
                else
                {
                    // ����� E.
                    matrix_element = ALPHABET_LETTERS[('E' - 65) * MATRIX_HEIGHT + matrix_row];
                }
            }

            if ((pixel_position / MATRIX_WIDTH) == 1)
            {
                if ((current_panel_iteration % 2) == 0)
                {
                    // ����� S.
                    matrix_element = ALPHABET_LETTERS[('S' - 65) * MATRIX_HEIGHT + matrix_row];
                }
                else
                {
                    // ����� U.
                    matrix_element = ALPHABET_LETTERS[('U' - 65) * MATRIX_HEIGHT + matrix_row];
                }
            }

            if ((pixel_position / MATRIX_WIDTH) == 2)
            {
                if ((current_panel_iteration % 2) == 0)
                {
                    // ����� S.
                    matrix_element = ALPHABET_LETTERS[('D' - 65) * MATRIX_HEIGHT + matrix_row];
                }
                else
                {
                    // ����� U.
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
        // ����� ��� ��������� �����.
        unsigned char mask_enable = PANEL_CURRENCY_NAME_PORT | (0x01 << panel_row);
        // ����� ��� ���������� �����.
        unsigned char mask_disable = PANEL_CURRENCY_NAME_PORT & ~(0x01 << panel_row);

        // ����� �������� ��� ������� ������.
        PixelParameter* pixels = panel_currency_name_pixels[panel_row];

        for (panel_column = 0; panel_column < PANEL_CLOCK_WIDTH; ++panel_column)
        {
            // ������ ����.
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

            // ������� ����.
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

            // ������� ����.
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

        // �������� ��� ������ ������.
        Delay_us(50);
    }
}

//----------------------------------------------------------------------------//
void WS2812_print_currency_value_buy()
{
    // ������� ������� �� ������.
    unsigned int pixel_position = 0;

    // ������� ������� �������.
    unsigned int matrix_column = 0;
    // ������� ������ �������.
    unsigned int matrix_row = 0;
    // ������� ������� ������.
    unsigned int panel_column = 0;
    // ������� ������ ������.
    unsigned int panel_row = 0;

    // ������� ���.
    unsigned char current_bit;
    // ������� ����.
    unsigned char current_byte;

    // ��������� ������������� �����.
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
        // ����� ��� ��������� �����.
        unsigned char mask_enable = PANEL_CURRENCY_VALUE_BUY_PORT | (0x01 << panel_row);
        // ����� ��� ���������� �����.
        unsigned char mask_disable = PANEL_CURRENCY_VALUE_BUY_PORT & ~(0x01 << panel_row);

        // ����� �������� ��� ������� ������.
        PixelParameter* pixels = panel_currency_value_buy_pixels[panel_row];

        for (panel_column = 0; panel_column < PANEL_CURRENCY_VALUE_BUY_WIDTH; ++panel_column)
        {
            // ������ ����.
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

            // ������� ����.
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

            // ������� ����.
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

        // �������� ��� ������ ������.
        Delay_us(50);
    }
}

//----------------------------------------------------------------------------//
void WS2812_print_currency_value_sale()
{
    // ������� ������� �� ������.
    unsigned int pixel_position = 0;

    // ������� ������� �������.
    unsigned int matrix_column = 0;
    // ������� ������ �������.
    unsigned int matrix_row = 0;
    // ������� ������� ������.
    unsigned int panel_column = 0;
    // ������� ������ ������.
    unsigned int panel_row = 0;

    // ������� ���.
    unsigned char current_bit;
    // ������� ����.
    unsigned char current_byte;

    // ��������� ������������� �����.
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
        // ����� ��� ��������� �����.
        unsigned char mask_enable = PANEL_CURRENCY_VALUE_SALE_PORT | (0x01 << panel_row);
        // ����� ��� ���������� �����.
        unsigned char mask_disable = PANEL_CURRENCY_VALUE_SALE_PORT & ~(0x01 << panel_row);

        // ����� �������� ��� ������� ������.
        PixelParameter* pixels = panel_currency_value_sale_pixels[panel_row];

        for (panel_column = 0; panel_column < PANEL_CURRENCY_VALUE_SALE_WIDTH; ++panel_column)
        {
            // ������ ����.
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

            // ������� ����.
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

            // ������� ����.
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

        // �������� ��� ������ ������.
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
        // ���������� ���� �����.
        if ((current_panel_iteration % 15) == 0)
        {
            WS2812_print_currency_name();
            WS2812_print_currency_value_buy();
            WS2812_print_currency_value_sale();
        }

        // ���������� ����.
        if ((current_panel_iteration % 10) == 0)
        {
            WS2812_print_clock(); WS2812_increase_time();
        }

        ++current_panel_iteration;

        // �������� ���� ���������� �� �������.
        TMR0IF_bit = 0;
        // ����������� ������ TMR0.
        T0CON = 0x87;
        // ������������� ��������� �������� ������� TMR0.
        TMR0L = 0x48;
        TMR0H = 0xE5;
        // �������� ���������� ����������.
        GIE_bit = 1;
        // �������� ���������� �� �������.
        TMR0IE_bit = 1;
    }
}