#ifndef _ENC28J60_H_
#define _ENC28J60_H_

// ��������� ������ ��� �������� �������� ����� �����.
typedef struct
{
    unsigned int eur_buy[2];
    unsigned int eur_sale[2];
    unsigned int usd_buy[2];
    unsigned int usd_sale[2];
    unsigned long timestamp;
} Request;

// �������������.
void ENC28J60_init();

// ����������, ��� �� ������� �����-���� ������.
char ENC28J60_had_request();

// �������� ������� ������.
void ENC28J60_get_request(Request* received_request);

// ��������� ������ ��� �������� ���������� � ������� ����������.
typedef struct
{
  unsigned canCloseTCP: 1;
  unsigned isBroadcast: 1;
} TEthPktFlags;

// ��������� TCP-����������.
unsigned int SPI_Ethernet_UserTCP(unsigned char* remote_host,
                                  unsigned int remote_port,
                                  unsigned int local_port,
                                  unsigned int request_length,
                                  TEthPktFlags* flags);

// ��������� UDP-����������.
unsigned int SPI_Ethernet_UserUDP(unsigned char* remote_host,
                                  unsigned int remote_port,
                                  unsigned int local_port,
                                  unsigned int request_length,
                                  TEthPktFlags* flags);

#endif // _ENC28J60_H_