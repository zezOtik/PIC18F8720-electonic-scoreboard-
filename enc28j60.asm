
_ENC28J60_init:

;enc28j60.c,50 :: 		void ENC28J60_init()
;enc28j60.c,53 :: 		SPI_Ethernet_Init(MAC_address, IP_address, 0x01);
	MOVLW       _MAC_address+0
	MOVWF       FARG_SPI_Ethernet_Init_mac+0 
	MOVLW       hi_addr(_MAC_address+0)
	MOVWF       FARG_SPI_Ethernet_Init_mac+1 
	MOVLW       _IP_address+0
	MOVWF       FARG_SPI_Ethernet_Init_ip+0 
	MOVLW       hi_addr(_IP_address+0)
	MOVWF       FARG_SPI_Ethernet_Init_ip+1 
	MOVLW       1
	MOVWF       FARG_SPI_Ethernet_Init_fullDuplex+0 
	CALL        _SPI_Ethernet_Init+0, 0
;enc28j60.c,54 :: 		}
L_end_ENC28J60_init:
	RETURN      0
; end of _ENC28J60_init

_ENC28J60_had_request:

;enc28j60.c,57 :: 		char ENC28J60_had_request()
;enc28j60.c,60 :: 		SPI_Ethernet_doPacket();
	CALL        _SPI_Ethernet_doPacket+0, 0
;enc28j60.c,62 :: 		return had_received_request;
	MOVF        _had_received_request+0, 0 
	MOVWF       R0 
;enc28j60.c,63 :: 		}
L_end_ENC28J60_had_request:
	RETURN      0
; end of _ENC28J60_had_request

_ENC28J60_get_request:

;enc28j60.c,66 :: 		void ENC28J60_get_request(Request* received_request)
;enc28j60.c,68 :: 		if (had_received_request)
	MOVF        _had_received_request+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_ENC28J60_get_request0
;enc28j60.c,71 :: 		received_request->eur_buy[0] = atoi(received_eur_buy_high);
	MOVF        FARG_ENC28J60_get_request_received_request+0, 0 
	MOVWF       FLOC__ENC28J60_get_request+0 
	MOVF        FARG_ENC28J60_get_request_received_request+1, 0 
	MOVWF       FLOC__ENC28J60_get_request+1 
	MOVLW       _received_eur_buy_high+0
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(_received_eur_buy_high+0)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVFF       FLOC__ENC28J60_get_request+0, FSR1
	MOVFF       FLOC__ENC28J60_get_request+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;enc28j60.c,72 :: 		received_request->eur_buy[1] = atoi(received_eur_buy_low);
	MOVLW       2
	ADDWF       FARG_ENC28J60_get_request_received_request+0, 0 
	MOVWF       FLOC__ENC28J60_get_request+0 
	MOVLW       0
	ADDWFC      FARG_ENC28J60_get_request_received_request+1, 0 
	MOVWF       FLOC__ENC28J60_get_request+1 
	MOVLW       _received_eur_buy_low+0
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(_received_eur_buy_low+0)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVFF       FLOC__ENC28J60_get_request+0, FSR1
	MOVFF       FLOC__ENC28J60_get_request+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;enc28j60.c,75 :: 		received_request->eur_sale[0] = atoi(received_eur_sale_high);
	MOVLW       4
	ADDWF       FARG_ENC28J60_get_request_received_request+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      FARG_ENC28J60_get_request_received_request+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       FLOC__ENC28J60_get_request+0 
	MOVF        R1, 0 
	MOVWF       FLOC__ENC28J60_get_request+1 
	MOVLW       _received_eur_sale_high+0
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(_received_eur_sale_high+0)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVFF       FLOC__ENC28J60_get_request+0, FSR1
	MOVFF       FLOC__ENC28J60_get_request+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;enc28j60.c,76 :: 		received_request->eur_sale[1] = atoi(received_eur_sale_low);
	MOVLW       4
	ADDWF       FARG_ENC28J60_get_request_received_request+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      FARG_ENC28J60_get_request_received_request+1, 0 
	MOVWF       R1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FLOC__ENC28J60_get_request+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FLOC__ENC28J60_get_request+1 
	MOVLW       _received_eur_sale_low+0
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(_received_eur_sale_low+0)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVFF       FLOC__ENC28J60_get_request+0, FSR1
	MOVFF       FLOC__ENC28J60_get_request+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;enc28j60.c,79 :: 		received_request->usd_buy[0] = atoi(received_usd_buy_high);
	MOVLW       8
	ADDWF       FARG_ENC28J60_get_request_received_request+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      FARG_ENC28J60_get_request_received_request+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       FLOC__ENC28J60_get_request+0 
	MOVF        R1, 0 
	MOVWF       FLOC__ENC28J60_get_request+1 
	MOVLW       _received_usd_buy_high+0
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(_received_usd_buy_high+0)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVFF       FLOC__ENC28J60_get_request+0, FSR1
	MOVFF       FLOC__ENC28J60_get_request+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;enc28j60.c,80 :: 		received_request->usd_buy[1] = atoi(received_usd_buy_low);
	MOVLW       8
	ADDWF       FARG_ENC28J60_get_request_received_request+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      FARG_ENC28J60_get_request_received_request+1, 0 
	MOVWF       R1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FLOC__ENC28J60_get_request+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FLOC__ENC28J60_get_request+1 
	MOVLW       _received_usd_buy_low+0
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(_received_usd_buy_low+0)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVFF       FLOC__ENC28J60_get_request+0, FSR1
	MOVFF       FLOC__ENC28J60_get_request+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;enc28j60.c,83 :: 		received_request->usd_sale[0] = atoi(received_usd_sale_high);
	MOVLW       12
	ADDWF       FARG_ENC28J60_get_request_received_request+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      FARG_ENC28J60_get_request_received_request+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       FLOC__ENC28J60_get_request+0 
	MOVF        R1, 0 
	MOVWF       FLOC__ENC28J60_get_request+1 
	MOVLW       _received_usd_sale_high+0
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(_received_usd_sale_high+0)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVFF       FLOC__ENC28J60_get_request+0, FSR1
	MOVFF       FLOC__ENC28J60_get_request+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;enc28j60.c,84 :: 		received_request->usd_sale[1] = atoi(received_usd_sale_low);
	MOVLW       12
	ADDWF       FARG_ENC28J60_get_request_received_request+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      FARG_ENC28J60_get_request_received_request+1, 0 
	MOVWF       R1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FLOC__ENC28J60_get_request+0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FLOC__ENC28J60_get_request+1 
	MOVLW       _received_usd_sale_low+0
	MOVWF       FARG_atoi_s+0 
	MOVLW       hi_addr(_received_usd_sale_low+0)
	MOVWF       FARG_atoi_s+1 
	CALL        _atoi+0, 0
	MOVFF       FLOC__ENC28J60_get_request+0, FSR1
	MOVFF       FLOC__ENC28J60_get_request+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;enc28j60.c,87 :: 		received_request->timestamp = atol(received_timestamp);
	MOVLW       16
	ADDWF       FARG_ENC28J60_get_request_received_request+0, 0 
	MOVWF       FLOC__ENC28J60_get_request+0 
	MOVLW       0
	ADDWFC      FARG_ENC28J60_get_request_received_request+1, 0 
	MOVWF       FLOC__ENC28J60_get_request+1 
	MOVLW       _received_timestamp+0
	MOVWF       FARG_atol_s+0 
	MOVLW       hi_addr(_received_timestamp+0)
	MOVWF       FARG_atol_s+1 
	CALL        _atol+0, 0
	MOVFF       FLOC__ENC28J60_get_request+0, FSR1
	MOVFF       FLOC__ENC28J60_get_request+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        R2, 0 
	MOVWF       POSTINC1+0 
	MOVF        R3, 0 
	MOVWF       POSTINC1+0 
;enc28j60.c,89 :: 		had_received_request = 0;
	CLRF        _had_received_request+0 
;enc28j60.c,90 :: 		}
L_ENC28J60_get_request0:
;enc28j60.c,91 :: 		}
L_end_ENC28J60_get_request:
	RETURN      0
; end of _ENC28J60_get_request

_SPI_Ethernet_UserTCP:

;enc28j60.c,98 :: 		TEthPktFlags* flags)
;enc28j60.c,102 :: 		unsigned int request_index = 0;
	CLRF        SPI_Ethernet_UserTCP_request_index_L0+0 
	CLRF        SPI_Ethernet_UserTCP_request_index_L0+1 
	CLRF        SPI_Ethernet_UserTCP_value_index_L0+0 
	CLRF        SPI_Ethernet_UserTCP_value_index_L0+1 
;enc28j60.c,105 :: 		if (local_port != 80)
	MOVLW       0
	XORWF       FARG_SPI_Ethernet_UserTCP_local_port+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP137
	MOVLW       80
	XORWF       FARG_SPI_Ethernet_UserTCP_local_port+0, 0 
L__SPI_Ethernet_UserTCP137:
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP1
;enc28j60.c,107 :: 		return(0);
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_SPI_Ethernet_UserTCP
;enc28j60.c,108 :: 		}
L_SPI_Ethernet_UserTCP1:
;enc28j60.c,111 :: 		for (request_index = 0; request_index < 178; ++request_index)
	CLRF        SPI_Ethernet_UserTCP_request_index_L0+0 
	CLRF        SPI_Ethernet_UserTCP_request_index_L0+1 
L_SPI_Ethernet_UserTCP2:
	MOVLW       0
	SUBWF       SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP138
	MOVLW       178
	SUBWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
L__SPI_Ethernet_UserTCP138:
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP3
;enc28j60.c,113 :: 		if (request_index == request_length)
	MOVF        SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	XORWF       FARG_SPI_Ethernet_UserTCP_request_length+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP139
	MOVF        FARG_SPI_Ethernet_UserTCP_request_length+0, 0 
	XORWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
L__SPI_Ethernet_UserTCP139:
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP5
;enc28j60.c,115 :: 		break;
	GOTO        L_SPI_Ethernet_UserTCP3
;enc28j60.c,116 :: 		}
L_SPI_Ethernet_UserTCP5:
;enc28j60.c,118 :: 		received_request[request_index] = SPI_Ethernet_getByte();
	MOVLW       _received_request+0
	ADDWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
	MOVWF       FLOC__SPI_Ethernet_UserTCP+0 
	MOVLW       hi_addr(_received_request+0)
	ADDWFC      SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	MOVWF       FLOC__SPI_Ethernet_UserTCP+1 
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVFF       FLOC__SPI_Ethernet_UserTCP+0, FSR1
	MOVFF       FLOC__SPI_Ethernet_UserTCP+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;enc28j60.c,111 :: 		for (request_index = 0; request_index < 178; ++request_index)
	INFSNZ      SPI_Ethernet_UserTCP_request_index_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_request_index_L0+1, 1 
;enc28j60.c,119 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP2
L_SPI_Ethernet_UserTCP3:
;enc28j60.c,122 :: 		if (!memcmp(received_request, "GET /?", 6))
	MOVLW       _received_request+0
	MOVWF       FARG_memcmp_s1+0 
	MOVLW       hi_addr(_received_request+0)
	MOVWF       FARG_memcmp_s1+1 
	MOVLW       ?lstr1_enc28j60+0
	MOVWF       FARG_memcmp_s2+0 
	MOVLW       hi_addr(?lstr1_enc28j60+0)
	MOVWF       FARG_memcmp_s2+1 
	MOVLW       6
	MOVWF       FARG_memcmp_n+0 
	MOVLW       0
	MOVWF       FARG_memcmp_n+1 
	CALL        _memcmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP6
;enc28j60.c,125 :: 		request_index = 6;
	MOVLW       6
	MOVWF       SPI_Ethernet_UserTCP_request_index_L0+0 
	MOVLW       0
	MOVWF       SPI_Ethernet_UserTCP_request_index_L0+1 
;enc28j60.c,128 :: 		if (!memcmp((received_request + request_index), "timestamp=", 10))
	MOVLW       _received_request+0
	ADDWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
	MOVWF       FARG_memcmp_s1+0 
	MOVLW       hi_addr(_received_request+0)
	ADDWFC      SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	MOVWF       FARG_memcmp_s1+1 
	MOVLW       ?lstr2_enc28j60+0
	MOVWF       FARG_memcmp_s2+0 
	MOVLW       hi_addr(?lstr2_enc28j60+0)
	MOVWF       FARG_memcmp_s2+1 
	MOVLW       10
	MOVWF       FARG_memcmp_n+0 
	MOVLW       0
	MOVWF       FARG_memcmp_n+1 
	CALL        _memcmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP7
;enc28j60.c,131 :: 		char symbol = 0;
	CLRF        SPI_Ethernet_UserTCP_symbol_L2+0 
;enc28j60.c,134 :: 		while (request_index < request_length)
L_SPI_Ethernet_UserTCP8:
	MOVF        FARG_SPI_Ethernet_UserTCP_request_length+1, 0 
	SUBWF       SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP140
	MOVF        FARG_SPI_Ethernet_UserTCP_request_length+0, 0 
	SUBWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
L__SPI_Ethernet_UserTCP140:
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP9
;enc28j60.c,136 :: 		symbol = received_request[request_index];
	MOVLW       _received_request+0
	ADDWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_received_request+0)
	ADDWFC      SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       SPI_Ethernet_UserTCP_symbol_L2+0 
;enc28j60.c,138 :: 		if (symbol == '=')
	MOVF        R1, 0 
	XORLW       61
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP10
;enc28j60.c,140 :: 		++request_index; break;
	INFSNZ      SPI_Ethernet_UserTCP_request_index_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_request_index_L0+1, 1 
	GOTO        L_SPI_Ethernet_UserTCP9
;enc28j60.c,141 :: 		}
L_SPI_Ethernet_UserTCP10:
;enc28j60.c,143 :: 		++request_index;
	INFSNZ      SPI_Ethernet_UserTCP_request_index_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_request_index_L0+1, 1 
;enc28j60.c,144 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP8
L_SPI_Ethernet_UserTCP9:
;enc28j60.c,146 :: 		value_index = 0;
	CLRF        SPI_Ethernet_UserTCP_value_index_L0+0 
	CLRF        SPI_Ethernet_UserTCP_value_index_L0+1 
;enc28j60.c,149 :: 		while ((value_index < 11) && (request_index < request_length))
L_SPI_Ethernet_UserTCP11:
	MOVLW       0
	SUBWF       SPI_Ethernet_UserTCP_value_index_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP141
	MOVLW       11
	SUBWF       SPI_Ethernet_UserTCP_value_index_L0+0, 0 
L__SPI_Ethernet_UserTCP141:
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP12
	MOVF        FARG_SPI_Ethernet_UserTCP_request_length+1, 0 
	SUBWF       SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP142
	MOVF        FARG_SPI_Ethernet_UserTCP_request_length+0, 0 
	SUBWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
L__SPI_Ethernet_UserTCP142:
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP12
L__SPI_Ethernet_UserTCP132:
;enc28j60.c,151 :: 		symbol = received_request[request_index];
	MOVLW       _received_request+0
	ADDWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_received_request+0)
	ADDWFC      SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       SPI_Ethernet_UserTCP_symbol_L2+0 
;enc28j60.c,153 :: 		if (symbol == '&')
	MOVF        R1, 0 
	XORLW       38
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP15
;enc28j60.c,155 :: 		++request_index; break;
	INFSNZ      SPI_Ethernet_UserTCP_request_index_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_request_index_L0+1, 1 
	GOTO        L_SPI_Ethernet_UserTCP12
;enc28j60.c,156 :: 		}
L_SPI_Ethernet_UserTCP15:
;enc28j60.c,159 :: 		if (isdigit(symbol))
	MOVF        SPI_Ethernet_UserTCP_symbol_L2+0, 0 
	MOVWF       FARG_isdigit_character+0 
	CALL        _isdigit+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP17
;enc28j60.c,161 :: 		received_timestamp[value_index] = symbol;
	MOVLW       _received_timestamp+0
	ADDWF       SPI_Ethernet_UserTCP_value_index_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_received_timestamp+0)
	ADDWFC      SPI_Ethernet_UserTCP_value_index_L0+1, 0 
	MOVWF       FSR1H 
	MOVF        SPI_Ethernet_UserTCP_symbol_L2+0, 0 
	MOVWF       POSTINC1+0 
;enc28j60.c,162 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP18
L_SPI_Ethernet_UserTCP17:
;enc28j60.c,165 :: 		received_timestamp[value_index] = '0';
	MOVLW       _received_timestamp+0
	ADDWF       SPI_Ethernet_UserTCP_value_index_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_received_timestamp+0)
	ADDWFC      SPI_Ethernet_UserTCP_value_index_L0+1, 0 
	MOVWF       FSR1H 
	MOVLW       48
	MOVWF       POSTINC1+0 
;enc28j60.c,166 :: 		}
L_SPI_Ethernet_UserTCP18:
;enc28j60.c,169 :: 		++request_index; ++value_index;
	INFSNZ      SPI_Ethernet_UserTCP_request_index_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_request_index_L0+1, 1 
	INFSNZ      SPI_Ethernet_UserTCP_value_index_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_value_index_L0+1, 1 
;enc28j60.c,170 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP11
L_SPI_Ethernet_UserTCP12:
;enc28j60.c,172 :: 		received_timestamp[value_index] = '\0';
	MOVLW       _received_timestamp+0
	ADDWF       SPI_Ethernet_UserTCP_value_index_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_received_timestamp+0)
	ADDWFC      SPI_Ethernet_UserTCP_value_index_L0+1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;enc28j60.c,173 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP19
L_SPI_Ethernet_UserTCP7:
;enc28j60.c,176 :: 		return(0);
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_SPI_Ethernet_UserTCP
;enc28j60.c,177 :: 		}
L_SPI_Ethernet_UserTCP19:
;enc28j60.c,180 :: 		if (!memcmp((received_request + request_index), "eur_buy_high=", 13))
	MOVLW       _received_request+0
	ADDWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
	MOVWF       FARG_memcmp_s1+0 
	MOVLW       hi_addr(_received_request+0)
	ADDWFC      SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	MOVWF       FARG_memcmp_s1+1 
	MOVLW       ?lstr3_enc28j60+0
	MOVWF       FARG_memcmp_s2+0 
	MOVLW       hi_addr(?lstr3_enc28j60+0)
	MOVWF       FARG_memcmp_s2+1 
	MOVLW       13
	MOVWF       FARG_memcmp_n+0 
	MOVLW       0
	MOVWF       FARG_memcmp_n+1 
	CALL        _memcmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP20
;enc28j60.c,183 :: 		char symbol = 0;
	CLRF        SPI_Ethernet_UserTCP_symbol_L2_L2+0 
;enc28j60.c,186 :: 		while (request_index < request_length)
L_SPI_Ethernet_UserTCP21:
	MOVF        FARG_SPI_Ethernet_UserTCP_request_length+1, 0 
	SUBWF       SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP143
	MOVF        FARG_SPI_Ethernet_UserTCP_request_length+0, 0 
	SUBWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
L__SPI_Ethernet_UserTCP143:
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP22
;enc28j60.c,188 :: 		symbol = received_request[request_index];
	MOVLW       _received_request+0
	ADDWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_received_request+0)
	ADDWFC      SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       SPI_Ethernet_UserTCP_symbol_L2_L2+0 
;enc28j60.c,190 :: 		if (symbol == '=')
	MOVF        R1, 0 
	XORLW       61
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP23
;enc28j60.c,192 :: 		++request_index; break;
	INFSNZ      SPI_Ethernet_UserTCP_request_index_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_request_index_L0+1, 1 
	GOTO        L_SPI_Ethernet_UserTCP22
;enc28j60.c,193 :: 		}
L_SPI_Ethernet_UserTCP23:
;enc28j60.c,195 :: 		++request_index;
	INFSNZ      SPI_Ethernet_UserTCP_request_index_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_request_index_L0+1, 1 
;enc28j60.c,196 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP21
L_SPI_Ethernet_UserTCP22:
;enc28j60.c,198 :: 		value_index = 0;
	CLRF        SPI_Ethernet_UserTCP_value_index_L0+0 
	CLRF        SPI_Ethernet_UserTCP_value_index_L0+1 
;enc28j60.c,201 :: 		while ((value_index < 6) && (request_index < request_length))
L_SPI_Ethernet_UserTCP24:
	MOVLW       0
	SUBWF       SPI_Ethernet_UserTCP_value_index_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP144
	MOVLW       6
	SUBWF       SPI_Ethernet_UserTCP_value_index_L0+0, 0 
L__SPI_Ethernet_UserTCP144:
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP25
	MOVF        FARG_SPI_Ethernet_UserTCP_request_length+1, 0 
	SUBWF       SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP145
	MOVF        FARG_SPI_Ethernet_UserTCP_request_length+0, 0 
	SUBWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
L__SPI_Ethernet_UserTCP145:
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP25
L__SPI_Ethernet_UserTCP131:
;enc28j60.c,203 :: 		symbol = received_request[request_index];
	MOVLW       _received_request+0
	ADDWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_received_request+0)
	ADDWFC      SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       SPI_Ethernet_UserTCP_symbol_L2_L2+0 
;enc28j60.c,205 :: 		if (symbol == '&')
	MOVF        R1, 0 
	XORLW       38
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP28
;enc28j60.c,207 :: 		++request_index; break;
	INFSNZ      SPI_Ethernet_UserTCP_request_index_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_request_index_L0+1, 1 
	GOTO        L_SPI_Ethernet_UserTCP25
;enc28j60.c,208 :: 		}
L_SPI_Ethernet_UserTCP28:
;enc28j60.c,211 :: 		if (isdigit(symbol))
	MOVF        SPI_Ethernet_UserTCP_symbol_L2_L2+0, 0 
	MOVWF       FARG_isdigit_character+0 
	CALL        _isdigit+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP30
;enc28j60.c,213 :: 		received_eur_buy_high[value_index] = symbol;
	MOVLW       _received_eur_buy_high+0
	ADDWF       SPI_Ethernet_UserTCP_value_index_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_received_eur_buy_high+0)
	ADDWFC      SPI_Ethernet_UserTCP_value_index_L0+1, 0 
	MOVWF       FSR1H 
	MOVF        SPI_Ethernet_UserTCP_symbol_L2_L2+0, 0 
	MOVWF       POSTINC1+0 
;enc28j60.c,214 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP31
L_SPI_Ethernet_UserTCP30:
;enc28j60.c,217 :: 		received_eur_buy_high[value_index] = '0';
	MOVLW       _received_eur_buy_high+0
	ADDWF       SPI_Ethernet_UserTCP_value_index_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_received_eur_buy_high+0)
	ADDWFC      SPI_Ethernet_UserTCP_value_index_L0+1, 0 
	MOVWF       FSR1H 
	MOVLW       48
	MOVWF       POSTINC1+0 
;enc28j60.c,218 :: 		}
L_SPI_Ethernet_UserTCP31:
;enc28j60.c,221 :: 		++request_index; ++value_index;
	INFSNZ      SPI_Ethernet_UserTCP_request_index_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_request_index_L0+1, 1 
	INFSNZ      SPI_Ethernet_UserTCP_value_index_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_value_index_L0+1, 1 
;enc28j60.c,222 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP24
L_SPI_Ethernet_UserTCP25:
;enc28j60.c,224 :: 		received_eur_buy_high[value_index] = '\0';
	MOVLW       _received_eur_buy_high+0
	ADDWF       SPI_Ethernet_UserTCP_value_index_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_received_eur_buy_high+0)
	ADDWFC      SPI_Ethernet_UserTCP_value_index_L0+1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;enc28j60.c,225 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP32
L_SPI_Ethernet_UserTCP20:
;enc28j60.c,228 :: 		return(0);
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_SPI_Ethernet_UserTCP
;enc28j60.c,229 :: 		}
L_SPI_Ethernet_UserTCP32:
;enc28j60.c,232 :: 		if (!memcmp((received_request + request_index), "eur_buy_low=", 12))
	MOVLW       _received_request+0
	ADDWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
	MOVWF       FARG_memcmp_s1+0 
	MOVLW       hi_addr(_received_request+0)
	ADDWFC      SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	MOVWF       FARG_memcmp_s1+1 
	MOVLW       ?lstr4_enc28j60+0
	MOVWF       FARG_memcmp_s2+0 
	MOVLW       hi_addr(?lstr4_enc28j60+0)
	MOVWF       FARG_memcmp_s2+1 
	MOVLW       12
	MOVWF       FARG_memcmp_n+0 
	MOVLW       0
	MOVWF       FARG_memcmp_n+1 
	CALL        _memcmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP33
;enc28j60.c,235 :: 		char symbol = 0;
	CLRF        SPI_Ethernet_UserTCP_symbol_L2_L2_L2+0 
;enc28j60.c,238 :: 		while (request_index < request_length)
L_SPI_Ethernet_UserTCP34:
	MOVF        FARG_SPI_Ethernet_UserTCP_request_length+1, 0 
	SUBWF       SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP146
	MOVF        FARG_SPI_Ethernet_UserTCP_request_length+0, 0 
	SUBWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
L__SPI_Ethernet_UserTCP146:
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP35
;enc28j60.c,240 :: 		symbol = received_request[request_index];
	MOVLW       _received_request+0
	ADDWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_received_request+0)
	ADDWFC      SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       SPI_Ethernet_UserTCP_symbol_L2_L2_L2+0 
;enc28j60.c,242 :: 		if (symbol == '=')
	MOVF        R1, 0 
	XORLW       61
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP36
;enc28j60.c,244 :: 		++request_index; break;
	INFSNZ      SPI_Ethernet_UserTCP_request_index_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_request_index_L0+1, 1 
	GOTO        L_SPI_Ethernet_UserTCP35
;enc28j60.c,245 :: 		}
L_SPI_Ethernet_UserTCP36:
;enc28j60.c,247 :: 		++request_index;
	INFSNZ      SPI_Ethernet_UserTCP_request_index_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_request_index_L0+1, 1 
;enc28j60.c,248 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP34
L_SPI_Ethernet_UserTCP35:
;enc28j60.c,250 :: 		value_index = 0;
	CLRF        SPI_Ethernet_UserTCP_value_index_L0+0 
	CLRF        SPI_Ethernet_UserTCP_value_index_L0+1 
;enc28j60.c,253 :: 		while ((value_index < 6) && (request_index < request_length))
L_SPI_Ethernet_UserTCP37:
	MOVLW       0
	SUBWF       SPI_Ethernet_UserTCP_value_index_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP147
	MOVLW       6
	SUBWF       SPI_Ethernet_UserTCP_value_index_L0+0, 0 
L__SPI_Ethernet_UserTCP147:
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP38
	MOVF        FARG_SPI_Ethernet_UserTCP_request_length+1, 0 
	SUBWF       SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP148
	MOVF        FARG_SPI_Ethernet_UserTCP_request_length+0, 0 
	SUBWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
L__SPI_Ethernet_UserTCP148:
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP38
L__SPI_Ethernet_UserTCP130:
;enc28j60.c,255 :: 		symbol = received_request[request_index];
	MOVLW       _received_request+0
	ADDWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_received_request+0)
	ADDWFC      SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       SPI_Ethernet_UserTCP_symbol_L2_L2_L2+0 
;enc28j60.c,257 :: 		if (symbol == '&')
	MOVF        R1, 0 
	XORLW       38
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP41
;enc28j60.c,259 :: 		++request_index; break;
	INFSNZ      SPI_Ethernet_UserTCP_request_index_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_request_index_L0+1, 1 
	GOTO        L_SPI_Ethernet_UserTCP38
;enc28j60.c,260 :: 		}
L_SPI_Ethernet_UserTCP41:
;enc28j60.c,263 :: 		if (isdigit(symbol))
	MOVF        SPI_Ethernet_UserTCP_symbol_L2_L2_L2+0, 0 
	MOVWF       FARG_isdigit_character+0 
	CALL        _isdigit+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP43
;enc28j60.c,265 :: 		received_eur_buy_low[value_index] = symbol;
	MOVLW       _received_eur_buy_low+0
	ADDWF       SPI_Ethernet_UserTCP_value_index_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_received_eur_buy_low+0)
	ADDWFC      SPI_Ethernet_UserTCP_value_index_L0+1, 0 
	MOVWF       FSR1H 
	MOVF        SPI_Ethernet_UserTCP_symbol_L2_L2_L2+0, 0 
	MOVWF       POSTINC1+0 
;enc28j60.c,266 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP44
L_SPI_Ethernet_UserTCP43:
;enc28j60.c,269 :: 		received_eur_buy_low[value_index] = '0';
	MOVLW       _received_eur_buy_low+0
	ADDWF       SPI_Ethernet_UserTCP_value_index_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_received_eur_buy_low+0)
	ADDWFC      SPI_Ethernet_UserTCP_value_index_L0+1, 0 
	MOVWF       FSR1H 
	MOVLW       48
	MOVWF       POSTINC1+0 
;enc28j60.c,270 :: 		}
L_SPI_Ethernet_UserTCP44:
;enc28j60.c,273 :: 		++request_index; ++value_index;
	INFSNZ      SPI_Ethernet_UserTCP_request_index_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_request_index_L0+1, 1 
	INFSNZ      SPI_Ethernet_UserTCP_value_index_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_value_index_L0+1, 1 
;enc28j60.c,274 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP37
L_SPI_Ethernet_UserTCP38:
;enc28j60.c,276 :: 		received_eur_buy_low[value_index] = '\0';
	MOVLW       _received_eur_buy_low+0
	ADDWF       SPI_Ethernet_UserTCP_value_index_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_received_eur_buy_low+0)
	ADDWFC      SPI_Ethernet_UserTCP_value_index_L0+1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;enc28j60.c,277 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP45
L_SPI_Ethernet_UserTCP33:
;enc28j60.c,280 :: 		return(0);
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_SPI_Ethernet_UserTCP
;enc28j60.c,281 :: 		}
L_SPI_Ethernet_UserTCP45:
;enc28j60.c,284 :: 		if (!memcmp((received_request + request_index), "eur_sale_high=", 14))
	MOVLW       _received_request+0
	ADDWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
	MOVWF       FARG_memcmp_s1+0 
	MOVLW       hi_addr(_received_request+0)
	ADDWFC      SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	MOVWF       FARG_memcmp_s1+1 
	MOVLW       ?lstr5_enc28j60+0
	MOVWF       FARG_memcmp_s2+0 
	MOVLW       hi_addr(?lstr5_enc28j60+0)
	MOVWF       FARG_memcmp_s2+1 
	MOVLW       14
	MOVWF       FARG_memcmp_n+0 
	MOVLW       0
	MOVWF       FARG_memcmp_n+1 
	CALL        _memcmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP46
;enc28j60.c,287 :: 		char symbol = 0;
	CLRF        SPI_Ethernet_UserTCP_symbol_L2_L2_L2_L2+0 
;enc28j60.c,290 :: 		while (request_index < request_length)
L_SPI_Ethernet_UserTCP47:
	MOVF        FARG_SPI_Ethernet_UserTCP_request_length+1, 0 
	SUBWF       SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP149
	MOVF        FARG_SPI_Ethernet_UserTCP_request_length+0, 0 
	SUBWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
L__SPI_Ethernet_UserTCP149:
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP48
;enc28j60.c,292 :: 		symbol = received_request[request_index];
	MOVLW       _received_request+0
	ADDWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_received_request+0)
	ADDWFC      SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       SPI_Ethernet_UserTCP_symbol_L2_L2_L2_L2+0 
;enc28j60.c,294 :: 		if (symbol == '=')
	MOVF        R1, 0 
	XORLW       61
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP49
;enc28j60.c,296 :: 		++request_index; break;
	INFSNZ      SPI_Ethernet_UserTCP_request_index_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_request_index_L0+1, 1 
	GOTO        L_SPI_Ethernet_UserTCP48
;enc28j60.c,297 :: 		}
L_SPI_Ethernet_UserTCP49:
;enc28j60.c,299 :: 		++request_index;
	INFSNZ      SPI_Ethernet_UserTCP_request_index_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_request_index_L0+1, 1 
;enc28j60.c,300 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP47
L_SPI_Ethernet_UserTCP48:
;enc28j60.c,302 :: 		value_index = 0;
	CLRF        SPI_Ethernet_UserTCP_value_index_L0+0 
	CLRF        SPI_Ethernet_UserTCP_value_index_L0+1 
;enc28j60.c,305 :: 		while ((value_index < 6) && (request_index < request_length))
L_SPI_Ethernet_UserTCP50:
	MOVLW       0
	SUBWF       SPI_Ethernet_UserTCP_value_index_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP150
	MOVLW       6
	SUBWF       SPI_Ethernet_UserTCP_value_index_L0+0, 0 
L__SPI_Ethernet_UserTCP150:
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP51
	MOVF        FARG_SPI_Ethernet_UserTCP_request_length+1, 0 
	SUBWF       SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP151
	MOVF        FARG_SPI_Ethernet_UserTCP_request_length+0, 0 
	SUBWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
L__SPI_Ethernet_UserTCP151:
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP51
L__SPI_Ethernet_UserTCP129:
;enc28j60.c,307 :: 		symbol = received_request[request_index];
	MOVLW       _received_request+0
	ADDWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_received_request+0)
	ADDWFC      SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       SPI_Ethernet_UserTCP_symbol_L2_L2_L2_L2+0 
;enc28j60.c,309 :: 		if (symbol == '&')
	MOVF        R1, 0 
	XORLW       38
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP54
;enc28j60.c,311 :: 		++request_index; break;
	INFSNZ      SPI_Ethernet_UserTCP_request_index_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_request_index_L0+1, 1 
	GOTO        L_SPI_Ethernet_UserTCP51
;enc28j60.c,312 :: 		}
L_SPI_Ethernet_UserTCP54:
;enc28j60.c,315 :: 		if (isdigit(symbol))
	MOVF        SPI_Ethernet_UserTCP_symbol_L2_L2_L2_L2+0, 0 
	MOVWF       FARG_isdigit_character+0 
	CALL        _isdigit+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP56
;enc28j60.c,317 :: 		received_eur_sale_high[value_index] = symbol;
	MOVLW       _received_eur_sale_high+0
	ADDWF       SPI_Ethernet_UserTCP_value_index_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_received_eur_sale_high+0)
	ADDWFC      SPI_Ethernet_UserTCP_value_index_L0+1, 0 
	MOVWF       FSR1H 
	MOVF        SPI_Ethernet_UserTCP_symbol_L2_L2_L2_L2+0, 0 
	MOVWF       POSTINC1+0 
;enc28j60.c,318 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP57
L_SPI_Ethernet_UserTCP56:
;enc28j60.c,321 :: 		received_eur_sale_high[value_index] = '0';
	MOVLW       _received_eur_sale_high+0
	ADDWF       SPI_Ethernet_UserTCP_value_index_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_received_eur_sale_high+0)
	ADDWFC      SPI_Ethernet_UserTCP_value_index_L0+1, 0 
	MOVWF       FSR1H 
	MOVLW       48
	MOVWF       POSTINC1+0 
;enc28j60.c,322 :: 		}
L_SPI_Ethernet_UserTCP57:
;enc28j60.c,325 :: 		++request_index; ++value_index;
	INFSNZ      SPI_Ethernet_UserTCP_request_index_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_request_index_L0+1, 1 
	INFSNZ      SPI_Ethernet_UserTCP_value_index_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_value_index_L0+1, 1 
;enc28j60.c,326 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP50
L_SPI_Ethernet_UserTCP51:
;enc28j60.c,328 :: 		received_eur_sale_high[value_index] = '\0';
	MOVLW       _received_eur_sale_high+0
	ADDWF       SPI_Ethernet_UserTCP_value_index_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_received_eur_sale_high+0)
	ADDWFC      SPI_Ethernet_UserTCP_value_index_L0+1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;enc28j60.c,329 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP58
L_SPI_Ethernet_UserTCP46:
;enc28j60.c,332 :: 		return(0);
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_SPI_Ethernet_UserTCP
;enc28j60.c,333 :: 		}
L_SPI_Ethernet_UserTCP58:
;enc28j60.c,336 :: 		if (!memcmp((received_request + request_index), "eur_sale_low=", 13))
	MOVLW       _received_request+0
	ADDWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
	MOVWF       FARG_memcmp_s1+0 
	MOVLW       hi_addr(_received_request+0)
	ADDWFC      SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	MOVWF       FARG_memcmp_s1+1 
	MOVLW       ?lstr6_enc28j60+0
	MOVWF       FARG_memcmp_s2+0 
	MOVLW       hi_addr(?lstr6_enc28j60+0)
	MOVWF       FARG_memcmp_s2+1 
	MOVLW       13
	MOVWF       FARG_memcmp_n+0 
	MOVLW       0
	MOVWF       FARG_memcmp_n+1 
	CALL        _memcmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP59
;enc28j60.c,339 :: 		char symbol = 0;
	CLRF        SPI_Ethernet_UserTCP_symbol_L2_L2_L2_L2_L2+0 
;enc28j60.c,342 :: 		while (request_index < request_length)
L_SPI_Ethernet_UserTCP60:
	MOVF        FARG_SPI_Ethernet_UserTCP_request_length+1, 0 
	SUBWF       SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP152
	MOVF        FARG_SPI_Ethernet_UserTCP_request_length+0, 0 
	SUBWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
L__SPI_Ethernet_UserTCP152:
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP61
;enc28j60.c,344 :: 		symbol = received_request[request_index];
	MOVLW       _received_request+0
	ADDWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_received_request+0)
	ADDWFC      SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       SPI_Ethernet_UserTCP_symbol_L2_L2_L2_L2_L2+0 
;enc28j60.c,346 :: 		if (symbol == '=')
	MOVF        R1, 0 
	XORLW       61
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP62
;enc28j60.c,348 :: 		++request_index; break;
	INFSNZ      SPI_Ethernet_UserTCP_request_index_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_request_index_L0+1, 1 
	GOTO        L_SPI_Ethernet_UserTCP61
;enc28j60.c,349 :: 		}
L_SPI_Ethernet_UserTCP62:
;enc28j60.c,351 :: 		++request_index;
	INFSNZ      SPI_Ethernet_UserTCP_request_index_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_request_index_L0+1, 1 
;enc28j60.c,352 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP60
L_SPI_Ethernet_UserTCP61:
;enc28j60.c,354 :: 		value_index = 0;
	CLRF        SPI_Ethernet_UserTCP_value_index_L0+0 
	CLRF        SPI_Ethernet_UserTCP_value_index_L0+1 
;enc28j60.c,357 :: 		while ((value_index < 6) && (request_index < request_length))
L_SPI_Ethernet_UserTCP63:
	MOVLW       0
	SUBWF       SPI_Ethernet_UserTCP_value_index_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP153
	MOVLW       6
	SUBWF       SPI_Ethernet_UserTCP_value_index_L0+0, 0 
L__SPI_Ethernet_UserTCP153:
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP64
	MOVF        FARG_SPI_Ethernet_UserTCP_request_length+1, 0 
	SUBWF       SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP154
	MOVF        FARG_SPI_Ethernet_UserTCP_request_length+0, 0 
	SUBWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
L__SPI_Ethernet_UserTCP154:
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP64
L__SPI_Ethernet_UserTCP128:
;enc28j60.c,359 :: 		symbol = received_request[request_index];
	MOVLW       _received_request+0
	ADDWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_received_request+0)
	ADDWFC      SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       SPI_Ethernet_UserTCP_symbol_L2_L2_L2_L2_L2+0 
;enc28j60.c,361 :: 		if (symbol == '&')
	MOVF        R1, 0 
	XORLW       38
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP67
;enc28j60.c,363 :: 		++request_index; break;
	INFSNZ      SPI_Ethernet_UserTCP_request_index_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_request_index_L0+1, 1 
	GOTO        L_SPI_Ethernet_UserTCP64
;enc28j60.c,364 :: 		}
L_SPI_Ethernet_UserTCP67:
;enc28j60.c,367 :: 		if (isdigit(symbol))
	MOVF        SPI_Ethernet_UserTCP_symbol_L2_L2_L2_L2_L2+0, 0 
	MOVWF       FARG_isdigit_character+0 
	CALL        _isdigit+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP69
;enc28j60.c,369 :: 		received_eur_sale_low[value_index] = symbol;
	MOVLW       _received_eur_sale_low+0
	ADDWF       SPI_Ethernet_UserTCP_value_index_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_received_eur_sale_low+0)
	ADDWFC      SPI_Ethernet_UserTCP_value_index_L0+1, 0 
	MOVWF       FSR1H 
	MOVF        SPI_Ethernet_UserTCP_symbol_L2_L2_L2_L2_L2+0, 0 
	MOVWF       POSTINC1+0 
;enc28j60.c,370 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP70
L_SPI_Ethernet_UserTCP69:
;enc28j60.c,373 :: 		received_eur_sale_low[value_index] = '0';
	MOVLW       _received_eur_sale_low+0
	ADDWF       SPI_Ethernet_UserTCP_value_index_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_received_eur_sale_low+0)
	ADDWFC      SPI_Ethernet_UserTCP_value_index_L0+1, 0 
	MOVWF       FSR1H 
	MOVLW       48
	MOVWF       POSTINC1+0 
;enc28j60.c,374 :: 		}
L_SPI_Ethernet_UserTCP70:
;enc28j60.c,377 :: 		++request_index; ++value_index;
	INFSNZ      SPI_Ethernet_UserTCP_request_index_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_request_index_L0+1, 1 
	INFSNZ      SPI_Ethernet_UserTCP_value_index_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_value_index_L0+1, 1 
;enc28j60.c,378 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP63
L_SPI_Ethernet_UserTCP64:
;enc28j60.c,380 :: 		received_eur_sale_low[value_index] = '\0';
	MOVLW       _received_eur_sale_low+0
	ADDWF       SPI_Ethernet_UserTCP_value_index_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_received_eur_sale_low+0)
	ADDWFC      SPI_Ethernet_UserTCP_value_index_L0+1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;enc28j60.c,381 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP71
L_SPI_Ethernet_UserTCP59:
;enc28j60.c,384 :: 		return(0);
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_SPI_Ethernet_UserTCP
;enc28j60.c,385 :: 		}
L_SPI_Ethernet_UserTCP71:
;enc28j60.c,388 :: 		if (!memcmp((received_request + request_index), "usd_buy_high=", 13))
	MOVLW       _received_request+0
	ADDWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
	MOVWF       FARG_memcmp_s1+0 
	MOVLW       hi_addr(_received_request+0)
	ADDWFC      SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	MOVWF       FARG_memcmp_s1+1 
	MOVLW       ?lstr7_enc28j60+0
	MOVWF       FARG_memcmp_s2+0 
	MOVLW       hi_addr(?lstr7_enc28j60+0)
	MOVWF       FARG_memcmp_s2+1 
	MOVLW       13
	MOVWF       FARG_memcmp_n+0 
	MOVLW       0
	MOVWF       FARG_memcmp_n+1 
	CALL        _memcmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP72
;enc28j60.c,391 :: 		char symbol = 0;
	CLRF        SPI_Ethernet_UserTCP_symbol_L2_L2_L2_L2_L2_L2+0 
;enc28j60.c,394 :: 		while (request_index < request_length)
L_SPI_Ethernet_UserTCP73:
	MOVF        FARG_SPI_Ethernet_UserTCP_request_length+1, 0 
	SUBWF       SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP155
	MOVF        FARG_SPI_Ethernet_UserTCP_request_length+0, 0 
	SUBWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
L__SPI_Ethernet_UserTCP155:
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP74
;enc28j60.c,396 :: 		symbol = received_request[request_index];
	MOVLW       _received_request+0
	ADDWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_received_request+0)
	ADDWFC      SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       SPI_Ethernet_UserTCP_symbol_L2_L2_L2_L2_L2_L2+0 
;enc28j60.c,398 :: 		if (symbol == '=')
	MOVF        R1, 0 
	XORLW       61
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP75
;enc28j60.c,400 :: 		++request_index; break;
	INFSNZ      SPI_Ethernet_UserTCP_request_index_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_request_index_L0+1, 1 
	GOTO        L_SPI_Ethernet_UserTCP74
;enc28j60.c,401 :: 		}
L_SPI_Ethernet_UserTCP75:
;enc28j60.c,403 :: 		++request_index;
	INFSNZ      SPI_Ethernet_UserTCP_request_index_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_request_index_L0+1, 1 
;enc28j60.c,404 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP73
L_SPI_Ethernet_UserTCP74:
;enc28j60.c,406 :: 		value_index = 0;
	CLRF        SPI_Ethernet_UserTCP_value_index_L0+0 
	CLRF        SPI_Ethernet_UserTCP_value_index_L0+1 
;enc28j60.c,409 :: 		while ((value_index < 6) && (request_index < request_length))
L_SPI_Ethernet_UserTCP76:
	MOVLW       0
	SUBWF       SPI_Ethernet_UserTCP_value_index_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP156
	MOVLW       6
	SUBWF       SPI_Ethernet_UserTCP_value_index_L0+0, 0 
L__SPI_Ethernet_UserTCP156:
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP77
	MOVF        FARG_SPI_Ethernet_UserTCP_request_length+1, 0 
	SUBWF       SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP157
	MOVF        FARG_SPI_Ethernet_UserTCP_request_length+0, 0 
	SUBWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
L__SPI_Ethernet_UserTCP157:
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP77
L__SPI_Ethernet_UserTCP127:
;enc28j60.c,411 :: 		symbol = received_request[request_index];
	MOVLW       _received_request+0
	ADDWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_received_request+0)
	ADDWFC      SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       SPI_Ethernet_UserTCP_symbol_L2_L2_L2_L2_L2_L2+0 
;enc28j60.c,413 :: 		if (symbol == '&')
	MOVF        R1, 0 
	XORLW       38
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP80
;enc28j60.c,415 :: 		++request_index; break;
	INFSNZ      SPI_Ethernet_UserTCP_request_index_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_request_index_L0+1, 1 
	GOTO        L_SPI_Ethernet_UserTCP77
;enc28j60.c,416 :: 		}
L_SPI_Ethernet_UserTCP80:
;enc28j60.c,419 :: 		if (isdigit(symbol))
	MOVF        SPI_Ethernet_UserTCP_symbol_L2_L2_L2_L2_L2_L2+0, 0 
	MOVWF       FARG_isdigit_character+0 
	CALL        _isdigit+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP82
;enc28j60.c,421 :: 		received_usd_buy_high[value_index] = symbol;
	MOVLW       _received_usd_buy_high+0
	ADDWF       SPI_Ethernet_UserTCP_value_index_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_received_usd_buy_high+0)
	ADDWFC      SPI_Ethernet_UserTCP_value_index_L0+1, 0 
	MOVWF       FSR1H 
	MOVF        SPI_Ethernet_UserTCP_symbol_L2_L2_L2_L2_L2_L2+0, 0 
	MOVWF       POSTINC1+0 
;enc28j60.c,422 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP83
L_SPI_Ethernet_UserTCP82:
;enc28j60.c,425 :: 		received_usd_buy_high[value_index] = '0';
	MOVLW       _received_usd_buy_high+0
	ADDWF       SPI_Ethernet_UserTCP_value_index_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_received_usd_buy_high+0)
	ADDWFC      SPI_Ethernet_UserTCP_value_index_L0+1, 0 
	MOVWF       FSR1H 
	MOVLW       48
	MOVWF       POSTINC1+0 
;enc28j60.c,426 :: 		}
L_SPI_Ethernet_UserTCP83:
;enc28j60.c,429 :: 		++request_index; ++value_index;
	INFSNZ      SPI_Ethernet_UserTCP_request_index_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_request_index_L0+1, 1 
	INFSNZ      SPI_Ethernet_UserTCP_value_index_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_value_index_L0+1, 1 
;enc28j60.c,430 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP76
L_SPI_Ethernet_UserTCP77:
;enc28j60.c,432 :: 		received_usd_buy_high[value_index] = '\0';
	MOVLW       _received_usd_buy_high+0
	ADDWF       SPI_Ethernet_UserTCP_value_index_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_received_usd_buy_high+0)
	ADDWFC      SPI_Ethernet_UserTCP_value_index_L0+1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;enc28j60.c,433 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP84
L_SPI_Ethernet_UserTCP72:
;enc28j60.c,436 :: 		return(0);
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_SPI_Ethernet_UserTCP
;enc28j60.c,437 :: 		}
L_SPI_Ethernet_UserTCP84:
;enc28j60.c,440 :: 		if (!memcmp((received_request + request_index), "usd_buy_low=", 12))
	MOVLW       _received_request+0
	ADDWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
	MOVWF       FARG_memcmp_s1+0 
	MOVLW       hi_addr(_received_request+0)
	ADDWFC      SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	MOVWF       FARG_memcmp_s1+1 
	MOVLW       ?lstr8_enc28j60+0
	MOVWF       FARG_memcmp_s2+0 
	MOVLW       hi_addr(?lstr8_enc28j60+0)
	MOVWF       FARG_memcmp_s2+1 
	MOVLW       12
	MOVWF       FARG_memcmp_n+0 
	MOVLW       0
	MOVWF       FARG_memcmp_n+1 
	CALL        _memcmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP85
;enc28j60.c,443 :: 		char symbol = 0;
	CLRF        SPI_Ethernet_UserTCP_symbol_L2_L2_L2_L2_L2_L2_L2+0 
;enc28j60.c,446 :: 		while (request_index < request_length)
L_SPI_Ethernet_UserTCP86:
	MOVF        FARG_SPI_Ethernet_UserTCP_request_length+1, 0 
	SUBWF       SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP158
	MOVF        FARG_SPI_Ethernet_UserTCP_request_length+0, 0 
	SUBWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
L__SPI_Ethernet_UserTCP158:
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP87
;enc28j60.c,448 :: 		symbol = received_request[request_index];
	MOVLW       _received_request+0
	ADDWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_received_request+0)
	ADDWFC      SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       SPI_Ethernet_UserTCP_symbol_L2_L2_L2_L2_L2_L2_L2+0 
;enc28j60.c,450 :: 		if (symbol == '=')
	MOVF        R1, 0 
	XORLW       61
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP88
;enc28j60.c,452 :: 		++request_index; break;
	INFSNZ      SPI_Ethernet_UserTCP_request_index_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_request_index_L0+1, 1 
	GOTO        L_SPI_Ethernet_UserTCP87
;enc28j60.c,453 :: 		}
L_SPI_Ethernet_UserTCP88:
;enc28j60.c,455 :: 		++request_index;
	INFSNZ      SPI_Ethernet_UserTCP_request_index_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_request_index_L0+1, 1 
;enc28j60.c,456 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP86
L_SPI_Ethernet_UserTCP87:
;enc28j60.c,458 :: 		value_index = 0;
	CLRF        SPI_Ethernet_UserTCP_value_index_L0+0 
	CLRF        SPI_Ethernet_UserTCP_value_index_L0+1 
;enc28j60.c,461 :: 		while ((value_index < 6) && (request_index < request_length))
L_SPI_Ethernet_UserTCP89:
	MOVLW       0
	SUBWF       SPI_Ethernet_UserTCP_value_index_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP159
	MOVLW       6
	SUBWF       SPI_Ethernet_UserTCP_value_index_L0+0, 0 
L__SPI_Ethernet_UserTCP159:
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP90
	MOVF        FARG_SPI_Ethernet_UserTCP_request_length+1, 0 
	SUBWF       SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP160
	MOVF        FARG_SPI_Ethernet_UserTCP_request_length+0, 0 
	SUBWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
L__SPI_Ethernet_UserTCP160:
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP90
L__SPI_Ethernet_UserTCP126:
;enc28j60.c,463 :: 		symbol = received_request[request_index];
	MOVLW       _received_request+0
	ADDWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_received_request+0)
	ADDWFC      SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       SPI_Ethernet_UserTCP_symbol_L2_L2_L2_L2_L2_L2_L2+0 
;enc28j60.c,465 :: 		if (symbol == '&')
	MOVF        R1, 0 
	XORLW       38
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP93
;enc28j60.c,467 :: 		++request_index; break;
	INFSNZ      SPI_Ethernet_UserTCP_request_index_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_request_index_L0+1, 1 
	GOTO        L_SPI_Ethernet_UserTCP90
;enc28j60.c,468 :: 		}
L_SPI_Ethernet_UserTCP93:
;enc28j60.c,471 :: 		if (isdigit(symbol))
	MOVF        SPI_Ethernet_UserTCP_symbol_L2_L2_L2_L2_L2_L2_L2+0, 0 
	MOVWF       FARG_isdigit_character+0 
	CALL        _isdigit+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP95
;enc28j60.c,473 :: 		received_usd_buy_low[value_index] = symbol;
	MOVLW       _received_usd_buy_low+0
	ADDWF       SPI_Ethernet_UserTCP_value_index_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_received_usd_buy_low+0)
	ADDWFC      SPI_Ethernet_UserTCP_value_index_L0+1, 0 
	MOVWF       FSR1H 
	MOVF        SPI_Ethernet_UserTCP_symbol_L2_L2_L2_L2_L2_L2_L2+0, 0 
	MOVWF       POSTINC1+0 
;enc28j60.c,474 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP96
L_SPI_Ethernet_UserTCP95:
;enc28j60.c,477 :: 		received_usd_buy_low[value_index] = '0';
	MOVLW       _received_usd_buy_low+0
	ADDWF       SPI_Ethernet_UserTCP_value_index_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_received_usd_buy_low+0)
	ADDWFC      SPI_Ethernet_UserTCP_value_index_L0+1, 0 
	MOVWF       FSR1H 
	MOVLW       48
	MOVWF       POSTINC1+0 
;enc28j60.c,478 :: 		}
L_SPI_Ethernet_UserTCP96:
;enc28j60.c,481 :: 		++request_index; ++value_index;
	INFSNZ      SPI_Ethernet_UserTCP_request_index_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_request_index_L0+1, 1 
	INFSNZ      SPI_Ethernet_UserTCP_value_index_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_value_index_L0+1, 1 
;enc28j60.c,482 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP89
L_SPI_Ethernet_UserTCP90:
;enc28j60.c,484 :: 		received_usd_buy_low[value_index] = '\0';
	MOVLW       _received_usd_buy_low+0
	ADDWF       SPI_Ethernet_UserTCP_value_index_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_received_usd_buy_low+0)
	ADDWFC      SPI_Ethernet_UserTCP_value_index_L0+1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;enc28j60.c,485 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP97
L_SPI_Ethernet_UserTCP85:
;enc28j60.c,488 :: 		return(0);
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_SPI_Ethernet_UserTCP
;enc28j60.c,489 :: 		}
L_SPI_Ethernet_UserTCP97:
;enc28j60.c,492 :: 		if (!memcmp((received_request + request_index), "usd_sale_high=", 14))
	MOVLW       _received_request+0
	ADDWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
	MOVWF       FARG_memcmp_s1+0 
	MOVLW       hi_addr(_received_request+0)
	ADDWFC      SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	MOVWF       FARG_memcmp_s1+1 
	MOVLW       ?lstr9_enc28j60+0
	MOVWF       FARG_memcmp_s2+0 
	MOVLW       hi_addr(?lstr9_enc28j60+0)
	MOVWF       FARG_memcmp_s2+1 
	MOVLW       14
	MOVWF       FARG_memcmp_n+0 
	MOVLW       0
	MOVWF       FARG_memcmp_n+1 
	CALL        _memcmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP98
;enc28j60.c,495 :: 		char symbol = 0;
	CLRF        SPI_Ethernet_UserTCP_symbol_L2_L2_L2_L2_L2_L2_L2_L2+0 
;enc28j60.c,498 :: 		while (request_index < request_length)
L_SPI_Ethernet_UserTCP99:
	MOVF        FARG_SPI_Ethernet_UserTCP_request_length+1, 0 
	SUBWF       SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP161
	MOVF        FARG_SPI_Ethernet_UserTCP_request_length+0, 0 
	SUBWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
L__SPI_Ethernet_UserTCP161:
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP100
;enc28j60.c,500 :: 		symbol = received_request[request_index];
	MOVLW       _received_request+0
	ADDWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_received_request+0)
	ADDWFC      SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       SPI_Ethernet_UserTCP_symbol_L2_L2_L2_L2_L2_L2_L2_L2+0 
;enc28j60.c,502 :: 		if (symbol == '=')
	MOVF        R1, 0 
	XORLW       61
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP101
;enc28j60.c,504 :: 		++request_index; break;
	INFSNZ      SPI_Ethernet_UserTCP_request_index_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_request_index_L0+1, 1 
	GOTO        L_SPI_Ethernet_UserTCP100
;enc28j60.c,505 :: 		}
L_SPI_Ethernet_UserTCP101:
;enc28j60.c,507 :: 		++request_index;
	INFSNZ      SPI_Ethernet_UserTCP_request_index_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_request_index_L0+1, 1 
;enc28j60.c,508 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP99
L_SPI_Ethernet_UserTCP100:
;enc28j60.c,510 :: 		value_index = 0;
	CLRF        SPI_Ethernet_UserTCP_value_index_L0+0 
	CLRF        SPI_Ethernet_UserTCP_value_index_L0+1 
;enc28j60.c,513 :: 		while ((value_index < 6) && (request_index < request_length))
L_SPI_Ethernet_UserTCP102:
	MOVLW       0
	SUBWF       SPI_Ethernet_UserTCP_value_index_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP162
	MOVLW       6
	SUBWF       SPI_Ethernet_UserTCP_value_index_L0+0, 0 
L__SPI_Ethernet_UserTCP162:
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP103
	MOVF        FARG_SPI_Ethernet_UserTCP_request_length+1, 0 
	SUBWF       SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP163
	MOVF        FARG_SPI_Ethernet_UserTCP_request_length+0, 0 
	SUBWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
L__SPI_Ethernet_UserTCP163:
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP103
L__SPI_Ethernet_UserTCP125:
;enc28j60.c,515 :: 		symbol = received_request[request_index];
	MOVLW       _received_request+0
	ADDWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_received_request+0)
	ADDWFC      SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       SPI_Ethernet_UserTCP_symbol_L2_L2_L2_L2_L2_L2_L2_L2+0 
;enc28j60.c,517 :: 		if (symbol == '&')
	MOVF        R1, 0 
	XORLW       38
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP106
;enc28j60.c,519 :: 		++request_index; break;
	INFSNZ      SPI_Ethernet_UserTCP_request_index_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_request_index_L0+1, 1 
	GOTO        L_SPI_Ethernet_UserTCP103
;enc28j60.c,520 :: 		}
L_SPI_Ethernet_UserTCP106:
;enc28j60.c,523 :: 		if (isdigit(symbol))
	MOVF        SPI_Ethernet_UserTCP_symbol_L2_L2_L2_L2_L2_L2_L2_L2+0, 0 
	MOVWF       FARG_isdigit_character+0 
	CALL        _isdigit+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP108
;enc28j60.c,525 :: 		received_usd_sale_high[value_index] = symbol;
	MOVLW       _received_usd_sale_high+0
	ADDWF       SPI_Ethernet_UserTCP_value_index_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_received_usd_sale_high+0)
	ADDWFC      SPI_Ethernet_UserTCP_value_index_L0+1, 0 
	MOVWF       FSR1H 
	MOVF        SPI_Ethernet_UserTCP_symbol_L2_L2_L2_L2_L2_L2_L2_L2+0, 0 
	MOVWF       POSTINC1+0 
;enc28j60.c,526 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP109
L_SPI_Ethernet_UserTCP108:
;enc28j60.c,529 :: 		received_usd_sale_high[value_index] = '0';
	MOVLW       _received_usd_sale_high+0
	ADDWF       SPI_Ethernet_UserTCP_value_index_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_received_usd_sale_high+0)
	ADDWFC      SPI_Ethernet_UserTCP_value_index_L0+1, 0 
	MOVWF       FSR1H 
	MOVLW       48
	MOVWF       POSTINC1+0 
;enc28j60.c,530 :: 		}
L_SPI_Ethernet_UserTCP109:
;enc28j60.c,533 :: 		++request_index; ++value_index;
	INFSNZ      SPI_Ethernet_UserTCP_request_index_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_request_index_L0+1, 1 
	INFSNZ      SPI_Ethernet_UserTCP_value_index_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_value_index_L0+1, 1 
;enc28j60.c,534 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP102
L_SPI_Ethernet_UserTCP103:
;enc28j60.c,536 :: 		received_usd_sale_high[value_index] = '\0';
	MOVLW       _received_usd_sale_high+0
	ADDWF       SPI_Ethernet_UserTCP_value_index_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_received_usd_sale_high+0)
	ADDWFC      SPI_Ethernet_UserTCP_value_index_L0+1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;enc28j60.c,537 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP110
L_SPI_Ethernet_UserTCP98:
;enc28j60.c,540 :: 		return(0);
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_SPI_Ethernet_UserTCP
;enc28j60.c,541 :: 		}
L_SPI_Ethernet_UserTCP110:
;enc28j60.c,544 :: 		if (!memcmp((received_request + request_index), "usd_sale_low=", 13))
	MOVLW       _received_request+0
	ADDWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
	MOVWF       FARG_memcmp_s1+0 
	MOVLW       hi_addr(_received_request+0)
	ADDWFC      SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	MOVWF       FARG_memcmp_s1+1 
	MOVLW       ?lstr10_enc28j60+0
	MOVWF       FARG_memcmp_s2+0 
	MOVLW       hi_addr(?lstr10_enc28j60+0)
	MOVWF       FARG_memcmp_s2+1 
	MOVLW       13
	MOVWF       FARG_memcmp_n+0 
	MOVLW       0
	MOVWF       FARG_memcmp_n+1 
	CALL        _memcmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP111
;enc28j60.c,547 :: 		char symbol = 0;
	CLRF        SPI_Ethernet_UserTCP_symbol_L2_L2_L2_L2_L2_L2_L2_L2_L2+0 
;enc28j60.c,550 :: 		while (request_index < request_length)
L_SPI_Ethernet_UserTCP112:
	MOVF        FARG_SPI_Ethernet_UserTCP_request_length+1, 0 
	SUBWF       SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP164
	MOVF        FARG_SPI_Ethernet_UserTCP_request_length+0, 0 
	SUBWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
L__SPI_Ethernet_UserTCP164:
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP113
;enc28j60.c,552 :: 		symbol = received_request[request_index];
	MOVLW       _received_request+0
	ADDWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_received_request+0)
	ADDWFC      SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       SPI_Ethernet_UserTCP_symbol_L2_L2_L2_L2_L2_L2_L2_L2_L2+0 
;enc28j60.c,554 :: 		if (symbol == '=')
	MOVF        R1, 0 
	XORLW       61
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP114
;enc28j60.c,556 :: 		++request_index; break;
	INFSNZ      SPI_Ethernet_UserTCP_request_index_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_request_index_L0+1, 1 
	GOTO        L_SPI_Ethernet_UserTCP113
;enc28j60.c,557 :: 		}
L_SPI_Ethernet_UserTCP114:
;enc28j60.c,559 :: 		++request_index;
	INFSNZ      SPI_Ethernet_UserTCP_request_index_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_request_index_L0+1, 1 
;enc28j60.c,560 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP112
L_SPI_Ethernet_UserTCP113:
;enc28j60.c,562 :: 		value_index = 0;
	CLRF        SPI_Ethernet_UserTCP_value_index_L0+0 
	CLRF        SPI_Ethernet_UserTCP_value_index_L0+1 
;enc28j60.c,565 :: 		while ((value_index < 6) && (request_index < request_length))
L_SPI_Ethernet_UserTCP115:
	MOVLW       0
	SUBWF       SPI_Ethernet_UserTCP_value_index_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP165
	MOVLW       6
	SUBWF       SPI_Ethernet_UserTCP_value_index_L0+0, 0 
L__SPI_Ethernet_UserTCP165:
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP116
	MOVF        FARG_SPI_Ethernet_UserTCP_request_length+1, 0 
	SUBWF       SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SPI_Ethernet_UserTCP166
	MOVF        FARG_SPI_Ethernet_UserTCP_request_length+0, 0 
	SUBWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
L__SPI_Ethernet_UserTCP166:
	BTFSC       STATUS+0, 0 
	GOTO        L_SPI_Ethernet_UserTCP116
L__SPI_Ethernet_UserTCP124:
;enc28j60.c,567 :: 		symbol = received_request[request_index];
	MOVLW       _received_request+0
	ADDWF       SPI_Ethernet_UserTCP_request_index_L0+0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(_received_request+0)
	ADDWFC      SPI_Ethernet_UserTCP_request_index_L0+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       SPI_Ethernet_UserTCP_symbol_L2_L2_L2_L2_L2_L2_L2_L2_L2+0 
;enc28j60.c,569 :: 		if (symbol == ' ')
	MOVF        R1, 0 
	XORLW       32
	BTFSS       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP119
;enc28j60.c,571 :: 		++request_index; break;
	INFSNZ      SPI_Ethernet_UserTCP_request_index_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_request_index_L0+1, 1 
	GOTO        L_SPI_Ethernet_UserTCP116
;enc28j60.c,572 :: 		}
L_SPI_Ethernet_UserTCP119:
;enc28j60.c,575 :: 		if (isdigit(symbol))
	MOVF        SPI_Ethernet_UserTCP_symbol_L2_L2_L2_L2_L2_L2_L2_L2_L2+0, 0 
	MOVWF       FARG_isdigit_character+0 
	CALL        _isdigit+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SPI_Ethernet_UserTCP121
;enc28j60.c,577 :: 		received_usd_sale_low[value_index] = symbol;
	MOVLW       _received_usd_sale_low+0
	ADDWF       SPI_Ethernet_UserTCP_value_index_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_received_usd_sale_low+0)
	ADDWFC      SPI_Ethernet_UserTCP_value_index_L0+1, 0 
	MOVWF       FSR1H 
	MOVF        SPI_Ethernet_UserTCP_symbol_L2_L2_L2_L2_L2_L2_L2_L2_L2+0, 0 
	MOVWF       POSTINC1+0 
;enc28j60.c,578 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP122
L_SPI_Ethernet_UserTCP121:
;enc28j60.c,581 :: 		received_usd_sale_low[value_index] = '0';
	MOVLW       _received_usd_sale_low+0
	ADDWF       SPI_Ethernet_UserTCP_value_index_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_received_usd_sale_low+0)
	ADDWFC      SPI_Ethernet_UserTCP_value_index_L0+1, 0 
	MOVWF       FSR1H 
	MOVLW       48
	MOVWF       POSTINC1+0 
;enc28j60.c,582 :: 		}
L_SPI_Ethernet_UserTCP122:
;enc28j60.c,585 :: 		++request_index; ++value_index;
	INFSNZ      SPI_Ethernet_UserTCP_request_index_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_request_index_L0+1, 1 
	INFSNZ      SPI_Ethernet_UserTCP_value_index_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_value_index_L0+1, 1 
;enc28j60.c,586 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP115
L_SPI_Ethernet_UserTCP116:
;enc28j60.c,588 :: 		received_usd_sale_low[value_index] = '\0';
	MOVLW       _received_usd_sale_low+0
	ADDWF       SPI_Ethernet_UserTCP_value_index_L0+0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_received_usd_sale_low+0)
	ADDWFC      SPI_Ethernet_UserTCP_value_index_L0+1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;enc28j60.c,589 :: 		}
	GOTO        L_SPI_Ethernet_UserTCP123
L_SPI_Ethernet_UserTCP111:
;enc28j60.c,592 :: 		return(0);
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_SPI_Ethernet_UserTCP
;enc28j60.c,593 :: 		}
L_SPI_Ethernet_UserTCP123:
;enc28j60.c,595 :: 		had_received_request = 1;
	MOVLW       1
	MOVWF       _had_received_request+0 
;enc28j60.c,596 :: 		}
L_SPI_Ethernet_UserTCP6:
;enc28j60.c,598 :: 		return(0);
	CLRF        R0 
	CLRF        R1 
;enc28j60.c,599 :: 		}
L_end_SPI_Ethernet_UserTCP:
	RETURN      0
; end of _SPI_Ethernet_UserTCP

_SPI_Ethernet_UserUDP:

;enc28j60.c,606 :: 		TEthPktFlags* flags)
;enc28j60.c,608 :: 		return(0);
	CLRF        R0 
	CLRF        R1 
;enc28j60.c,609 :: 		}
L_end_SPI_Ethernet_UserUDP:
	RETURN      0
; end of _SPI_Ethernet_UserUDP
