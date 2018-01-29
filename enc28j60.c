#include "enc28j60.h"

// Ножка для выбора.
sfr sbit SPI_Ethernet_CS at RC6_bit;
// Ножка для сброса.
sfr sbit SPI_Ethernet_RST at RC7_bit;
// Управление направлением ножки, выполняющей выбор.
sfr sbit SPI_Ethernet_CS_Direction at TRISC6_bit;
// Управление направлением ножки, выполняющей сброс.
sfr sbit SPI_Ethernet_RST_Direction at TRISC7_bit;

// Текущий IP-адрес.
unsigned char IP_address[4] = { 192, 168, 57, 57 };
// Текущий MAC-адрес.
unsigned char MAC_address[6] = { 0x4B, 0x06, 0x28, 0x0D, 0x6F, 0x7C };

// Тип запроса.
const unsigned char HTTP_METHOD[] = "GET /";
// Заголовок запроса №1.
const unsigned char HTTP_HEADER[] = "HTTP/1.1 200 OK\nContent-type:";
// Заголовок запроса №2.
const unsigned char HTTP_MIME_TYPE_HTML[] = "text/html\n\n";
// Заголовок запроса №3.
const unsigned char HTTP_MIME_TYPE_SCRIPT[] = "text/plain\n\n";

// Показывает, был ли запрос получен и считан.
char had_received_request = 0;
// Последний полученный запрос.
char received_request[178];
// Последний полученный курс покупки евро (Старший).
char received_eur_buy_high[6];
// Последний полученный курс покупки евро (Младший).
char received_eur_buy_low[6];
// Последний полученный курс продажи евро (Старший).
char received_eur_sale_high[6];
// Последний полученный курс продажи евро (Младший).
char received_eur_sale_low[6];
// Последний полученный курс покупки доллара (Старший).
char received_usd_buy_high[6];
// Последний полученный курс покупки доллара (Младший).
char received_usd_buy_low[6];
// Последний полученный курс продажи доллара (Старший).
char received_usd_sale_high[6];
// Последний полученный курс продажи доллара (Младший).
char received_usd_sale_low[6];
// Последняя полученная временная метка.
char received_timestamp[11];

//----------------------------------------------------------------------------//
void ENC28J60_init()
{
    // Инициализация платы.
    SPI_Ethernet_Init(MAC_address, IP_address, 0x01);
}

//----------------------------------------------------------------------------//
char ENC28J60_had_request()
{
    // Получаем пакет.
    SPI_Ethernet_doPacket();

    return had_received_request;
}

//----------------------------------------------------------------------------//
void ENC28J60_get_request(Request* received_request)
{
    if (had_received_request)
    {
        // Сохраняем полученный курс покупки евро.
        received_request->eur_buy[0] = atoi(received_eur_buy_high);
        received_request->eur_buy[1] = atoi(received_eur_buy_low);

        // Сохраняем полученный курс продажи евро.
        received_request->eur_sale[0] = atoi(received_eur_sale_high);
        received_request->eur_sale[1] = atoi(received_eur_sale_low);

        // Сохраняем полученный курс покупки доллара.
        received_request->usd_buy[0] = atoi(received_usd_buy_high);
        received_request->usd_buy[1] = atoi(received_usd_buy_low);

        // Сохраняем полученный курс продажи доллара.
        received_request->usd_sale[0] = atoi(received_usd_sale_high);
        received_request->usd_sale[1] = atoi(received_usd_sale_low);

        // Сохраняем полученную временную метку.
        received_request->timestamp = atol(received_timestamp);

        had_received_request = 0;
    }
}

//----------------------------------------------------------------------------//
unsigned int SPI_Ethernet_UserTCP(unsigned char* remote_host,
                                  unsigned int remote_port,
                                  unsigned int local_port,
                                  unsigned int request_length,
                                  TEthPktFlags* flags)
{
    // timestamp=**********&eur_buy_high=*****&eur_buy_low=*****&eur_sale_high=*****&eur_sale_low=*****&usd_buy_high=*****&usd_buy_low=*****&usd_sale_high=*****&usd_sale_low=*****

    unsigned int request_index = 0;
    unsigned int value_index = 0;

    if (local_port != 80)
    {
        return(0);
    }

    // Считываем запрос.
    for (request_index = 0; request_index < 178; ++request_index)
    {
        if (request_index == request_length)
        {
           break;
        }

        received_request[request_index] = SPI_Ethernet_getByte();
    }

    // Если запрос содержит какие-нибудь параметры.
    if (!memcmp(received_request, "GET /?", 6))
    {
        // Переходим к аргументам.
        request_index = 6;

        // Парсим временную метку.
        if (!memcmp((received_request + request_index), "timestamp=", 10))
        {
            // Текущий символ.
            char symbol = 0;

            // Пропускаем все символы до значения.
            while (request_index < request_length)
            {
                symbol = received_request[request_index];

                if (symbol == '=')
                {
                    ++request_index; break;
                }

                ++request_index;
            }

            value_index = 0;

            // Считываем значение.
            while ((value_index < 11) && (request_index < request_length))
            {
                symbol = received_request[request_index];

                if (symbol == '&')
                {
                    ++request_index; break;
                }
                else
                {
                    if (isdigit(symbol))
                    {
                        received_timestamp[value_index] = symbol;
                    }
                    else
                    {
                        received_timestamp[value_index] = '0';
                    }
                }

                ++request_index; ++value_index;
            }

            received_timestamp[value_index] = '\0';
        }
        else
        {
            return(0);
        }

        // Парсим курс покупки евро (Старший).
        if (!memcmp((received_request + request_index), "eur_buy_high=", 13))
        {
            // Текущий символ.
            char symbol = 0;

            // Пропускаем все символы до значения.
            while (request_index < request_length)
            {
                symbol = received_request[request_index];

                if (symbol == '=')
                {
                    ++request_index; break;
                }

                ++request_index;
            }

            value_index = 0;

            // Считываем значение.
            while ((value_index < 6) && (request_index < request_length))
            {
                symbol = received_request[request_index];

                if (symbol == '&')
                {
                    ++request_index; break;
                }
                else
                {
                    if (isdigit(symbol))
                    {
                        received_eur_buy_high[value_index] = symbol;
                    }
                    else
                    {
                        received_eur_buy_high[value_index] = '0';
                    }
                }

                ++request_index; ++value_index;
            }

            received_eur_buy_high[value_index] = '\0';
        }
        else
        {
            return(0);
        }

        // Парсим курс покупки евро (Младший).
        if (!memcmp((received_request + request_index), "eur_buy_low=", 12))
        {
            // Текущий символ.
            char symbol = 0;

            // Пропускаем все символы до значения.
            while (request_index < request_length)
            {
                symbol = received_request[request_index];

                if (symbol == '=')
                {
                    ++request_index; break;
                }

                ++request_index;
            }

            value_index = 0;

            // Считываем значение.
            while ((value_index < 6) && (request_index < request_length))
            {
                symbol = received_request[request_index];

                if (symbol == '&')
                {
                    ++request_index; break;
                }
                else
                {
                    if (isdigit(symbol))
                    {
                        received_eur_buy_low[value_index] = symbol;
                    }
                    else
                    {
                        received_eur_buy_low[value_index] = '0';
                    }
                }

                ++request_index; ++value_index;
            }

            received_eur_buy_low[value_index] = '\0';
        }
        else
        {
            return(0);
        }

        // Парсим курс продажи евро (Старший).
        if (!memcmp((received_request + request_index), "eur_sale_high=", 14))
        {
            // Текущий символ.
            char symbol = 0;

            // Пропускаем все символы до значения.
            while (request_index < request_length)
            {
                symbol = received_request[request_index];

                if (symbol == '=')
                {
                    ++request_index; break;
                }

                ++request_index;
            }

            value_index = 0;

            // Считываем значение.
            while ((value_index < 6) && (request_index < request_length))
            {
                symbol = received_request[request_index];

                if (symbol == '&')
                {
                    ++request_index; break;
                }
                else
                {
                    if (isdigit(symbol))
                    {
                        received_eur_sale_high[value_index] = symbol;
                    }
                    else
                    {
                        received_eur_sale_high[value_index] = '0';
                    }
                }

                ++request_index; ++value_index;
            }

            received_eur_sale_high[value_index] = '\0';
        }
        else
        {
            return(0);
        }

        // Парсим курс продажи евро (Младший).
        if (!memcmp((received_request + request_index), "eur_sale_low=", 13))
        {
            // Текущий символ.
            char symbol = 0;

            // Пропускаем все символы до значения.
            while (request_index < request_length)
            {
                symbol = received_request[request_index];

                if (symbol == '=')
                {
                    ++request_index; break;
                }

                ++request_index;
            }

            value_index = 0;

            // Считываем значение.
            while ((value_index < 6) && (request_index < request_length))
            {
                symbol = received_request[request_index];

                if (symbol == '&')
                {
                    ++request_index; break;
                }
                else
                {
                    if (isdigit(symbol))
                    {
                        received_eur_sale_low[value_index] = symbol;
                    }
                    else
                    {
                        received_eur_sale_low[value_index] = '0';
                    }
                }

                ++request_index; ++value_index;
            }

            received_eur_sale_low[value_index] = '\0';
        }
        else
        {
            return(0);
        }

        // Парсим курс покупки доллара (Старший).
        if (!memcmp((received_request + request_index), "usd_buy_high=", 13))
        {
            // Текущий символ.
            char symbol = 0;

            // Пропускаем все символы до значения.
            while (request_index < request_length)
            {
                symbol = received_request[request_index];

                if (symbol == '=')
                {
                    ++request_index; break;
                }

                ++request_index;
            }

            value_index = 0;

            // Считываем значение.
            while ((value_index < 6) && (request_index < request_length))
            {
                symbol = received_request[request_index];

                if (symbol == '&')
                {
                    ++request_index; break;
                }
                else
                {
                    if (isdigit(symbol))
                    {
                        received_usd_buy_high[value_index] = symbol;
                    }
                    else
                    {
                        received_usd_buy_high[value_index] = '0';
                    }
                }

                ++request_index; ++value_index;
            }

            received_usd_buy_high[value_index] = '\0';
        }
        else
        {
            return(0);
        }

        // Парсим курс покупки доллара (Младший).
        if (!memcmp((received_request + request_index), "usd_buy_low=", 12))
        {
            // Текущий символ.
            char symbol = 0;

            // Пропускаем все символы до значения.
            while (request_index < request_length)
            {
                symbol = received_request[request_index];

                if (symbol == '=')
                {
                    ++request_index; break;
                }

                ++request_index;
            }

            value_index = 0;

            // Считываем значение.
            while ((value_index < 6) && (request_index < request_length))
            {
                symbol = received_request[request_index];

                if (symbol == '&')
                {
                    ++request_index; break;
                }
                else
                {
                    if (isdigit(symbol))
                    {
                        received_usd_buy_low[value_index] = symbol;
                    }
                    else
                    {
                        received_usd_buy_low[value_index] = '0';
                    }
                }

                ++request_index; ++value_index;
            }

            received_usd_buy_low[value_index] = '\0';
        }
        else
        {
            return(0);
        }

        // Парсим курс продажи доллара (Старший).
        if (!memcmp((received_request + request_index), "usd_sale_high=", 14))
        {
            // Текущий символ.
            char symbol = 0;

            // Пропускаем все символы до значения.
            while (request_index < request_length)
            {
                symbol = received_request[request_index];

                if (symbol == '=')
                {
                    ++request_index; break;
                }

                ++request_index;
            }

            value_index = 0;

            // Считываем значение.
            while ((value_index < 6) && (request_index < request_length))
            {
                symbol = received_request[request_index];

                if (symbol == '&')
                {
                    ++request_index; break;
                }
                else
                {
                    if (isdigit(symbol))
                    {
                        received_usd_sale_high[value_index] = symbol;
                    }
                    else
                    {
                        received_usd_sale_high[value_index] = '0';
                    }
                }

                ++request_index; ++value_index;
            }

            received_usd_sale_high[value_index] = '\0';
        }
        else
        {
            return(0);
        }

        // Парсим курс продажи доллара (Младший).
        if (!memcmp((received_request + request_index), "usd_sale_low=", 13))
        {
            // Текущий символ.
            char symbol = 0;

            // Пропускаем все символы до значения.
            while (request_index < request_length)
            {
                symbol = received_request[request_index];

                if (symbol == '=')
                {
                    ++request_index; break;
                }

                ++request_index;
            }

            value_index = 0;

            // Считываем значение.
            while ((value_index < 6) && (request_index < request_length))
            {
                symbol = received_request[request_index];

                if (symbol == ' ')
                {
                    ++request_index; break;
                }
                else
                {
                    if (isdigit(symbol))
                    {
                        received_usd_sale_low[value_index] = symbol;
                    }
                    else
                    {
                        received_usd_sale_low[value_index] = '0';
                    }
                }

                ++request_index; ++value_index;
            }

            received_usd_sale_low[value_index] = '\0';
        }
        else
        {
            return(0);
        }

        had_received_request = 1;
    }

    return(0);
}

//----------------------------------------------------------------------------//
unsigned int SPI_Ethernet_UserUDP(unsigned char* remote_host,
                                  unsigned int remote_port,
                                  unsigned int local_port,
                                  unsigned int request_length,
                                  TEthPktFlags* flags)
{
    return(0);
}