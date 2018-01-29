#line 1 "C:/Users/wzomzot/Desktop/Мой курсач/02/enc28j60.c"
#line 1 "c:/users/wzomzot/desktop/Мой курсач/02/enc28j60.h"




typedef struct
{
 unsigned int eur_buy[2];
 unsigned int eur_sale[2];
 unsigned int usd_buy[2];
 unsigned int usd_sale[2];
 unsigned long timestamp;
} Request;


void ENC28J60_init();


char ENC28J60_had_request();


void ENC28J60_get_request(Request* received_request);


typedef struct
{
 unsigned canCloseTCP: 1;
 unsigned isBroadcast: 1;
} TEthPktFlags;


unsigned int SPI_Ethernet_UserTCP(unsigned char* remote_host,
 unsigned int remote_port,
 unsigned int local_port,
 unsigned int request_length,
 TEthPktFlags* flags);


unsigned int SPI_Ethernet_UserUDP(unsigned char* remote_host,
 unsigned int remote_port,
 unsigned int local_port,
 unsigned int request_length,
 TEthPktFlags* flags);
#line 4 "C:/Users/wzomzot/Desktop/Мой курсач/02/enc28j60.c"
sfr sbit SPI_Ethernet_CS at RC6_bit;

sfr sbit SPI_Ethernet_RST at RC7_bit;

sfr sbit SPI_Ethernet_CS_Direction at TRISC6_bit;

sfr sbit SPI_Ethernet_RST_Direction at TRISC7_bit;


unsigned char IP_address[4] = { 192, 168, 57, 57 };

unsigned char MAC_address[6] = { 0x4B, 0x06, 0x28, 0x0D, 0x6F, 0x7C };


const unsigned char HTTP_METHOD[] = "GET /";

const unsigned char HTTP_HEADER[] = "HTTP/1.1 200 OK\nContent-type:";

const unsigned char HTTP_MIME_TYPE_HTML[] = "text/html\n\n";

const unsigned char HTTP_MIME_TYPE_SCRIPT[] = "text/plain\n\n";


char had_received_request = 0;

char received_request[178];

char received_eur_buy_high[6];

char received_eur_buy_low[6];

char received_eur_sale_high[6];

char received_eur_sale_low[6];

char received_usd_buy_high[6];

char received_usd_buy_low[6];

char received_usd_sale_high[6];

char received_usd_sale_low[6];

char received_timestamp[11];


void ENC28J60_init()
{

 SPI_Ethernet_Init(MAC_address, IP_address, 0x01);
}


char ENC28J60_had_request()
{

 SPI_Ethernet_doPacket();

 return had_received_request;
}


void ENC28J60_get_request(Request* received_request)
{
 if (had_received_request)
 {

 received_request->eur_buy[0] = atoi(received_eur_buy_high);
 received_request->eur_buy[1] = atoi(received_eur_buy_low);


 received_request->eur_sale[0] = atoi(received_eur_sale_high);
 received_request->eur_sale[1] = atoi(received_eur_sale_low);


 received_request->usd_buy[0] = atoi(received_usd_buy_high);
 received_request->usd_buy[1] = atoi(received_usd_buy_low);


 received_request->usd_sale[0] = atoi(received_usd_sale_high);
 received_request->usd_sale[1] = atoi(received_usd_sale_low);


 received_request->timestamp = atol(received_timestamp);

 had_received_request = 0;
 }
}


unsigned int SPI_Ethernet_UserTCP(unsigned char* remote_host,
 unsigned int remote_port,
 unsigned int local_port,
 unsigned int request_length,
 TEthPktFlags* flags)
{


 unsigned int request_index = 0;
 unsigned int value_index = 0;

 if (local_port != 80)
 {
 return(0);
 }


 for (request_index = 0; request_index < 178; ++request_index)
 {
 if (request_index == request_length)
 {
 break;
 }

 received_request[request_index] = SPI_Ethernet_getByte();
 }


 if (!memcmp(received_request, "GET /?", 6))
 {

 request_index = 6;


 if (!memcmp((received_request + request_index), "timestamp=", 10))
 {

 char symbol = 0;


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


 if (!memcmp((received_request + request_index), "eur_buy_high=", 13))
 {

 char symbol = 0;


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


 if (!memcmp((received_request + request_index), "eur_buy_low=", 12))
 {

 char symbol = 0;


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


 if (!memcmp((received_request + request_index), "eur_sale_high=", 14))
 {

 char symbol = 0;


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


 if (!memcmp((received_request + request_index), "eur_sale_low=", 13))
 {

 char symbol = 0;


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


 if (!memcmp((received_request + request_index), "usd_buy_high=", 13))
 {

 char symbol = 0;


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


 if (!memcmp((received_request + request_index), "usd_buy_low=", 12))
 {

 char symbol = 0;


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


 if (!memcmp((received_request + request_index), "usd_sale_high=", 14))
 {

 char symbol = 0;


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


 if (!memcmp((received_request + request_index), "usd_sale_low=", 13))
 {

 char symbol = 0;


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


unsigned int SPI_Ethernet_UserUDP(unsigned char* remote_host,
 unsigned int remote_port,
 unsigned int local_port,
 unsigned int request_length,
 TEthPktFlags* flags)
{
 return(0);
}
