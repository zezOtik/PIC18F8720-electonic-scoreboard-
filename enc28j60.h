#ifndef _ENC28J60_H_
#define _ENC28J60_H_

// Структура данных для хранения текущего курса валют.
typedef struct
{
    unsigned int eur_buy[2];
    unsigned int eur_sale[2];
    unsigned int usd_buy[2];
    unsigned int usd_sale[2];
    unsigned long timestamp;
} Request;

// Инициализация.
void ENC28J60_init();

// Определяет, был ли получен какой-либо запрос.
char ENC28J60_had_request();

// Получает текущий запрос.
void ENC28J60_get_request(Request* received_request);

// Структура данных для хранения информации о текущем соединении.
typedef struct
{
  unsigned canCloseTCP: 1;
  unsigned isBroadcast: 1;
} TEthPktFlags;

// Обработка TCP-соединения.
unsigned int SPI_Ethernet_UserTCP(unsigned char* remote_host,
                                  unsigned int remote_port,
                                  unsigned int local_port,
                                  unsigned int request_length,
                                  TEthPktFlags* flags);

// Обработка UDP-соединения.
unsigned int SPI_Ethernet_UserUDP(unsigned char* remote_host,
                                  unsigned int remote_port,
                                  unsigned int local_port,
                                  unsigned int request_length,
                                  TEthPktFlags* flags);

#endif // _ENC28J60_H_