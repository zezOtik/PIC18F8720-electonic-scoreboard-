
_WS2812_init:

;ws2812.c,67 :: 		void WS2812_init()
;ws2812.c,70 :: 		unsigned char status = EEPROM_Read(0x00); Delay_ms(20);
	CLRF        FARG_EEPROM_Read_address+0 
	CLRF        FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       WS2812_init_status_L0+0 
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       160
	MOVWF       R12, 0
	MOVLW       146
	MOVWF       R13, 0
L_WS2812_init0:
	DECFSZ      R13, 1, 1
	BRA         L_WS2812_init0
	DECFSZ      R12, 1, 1
	BRA         L_WS2812_init0
	DECFSZ      R11, 1, 1
	BRA         L_WS2812_init0
	NOP
;ws2812.c,73 :: 		if ((status != 0) && (status != 1))
	MOVF        WS2812_init_status_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_WS2812_init3
	MOVF        WS2812_init_status_L0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_WS2812_init3
L__WS2812_init250:
;ws2812.c,75 :: 		EEPROM_Write(0x00, 0); Delay_ms(20);
	CLRF        FARG_EEPROM_Write_address+0 
	CLRF        FARG_EEPROM_Write_address+1 
	CLRF        FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       160
	MOVWF       R12, 0
	MOVLW       146
	MOVWF       R13, 0
L_WS2812_init4:
	DECFSZ      R13, 1, 1
	BRA         L_WS2812_init4
	DECFSZ      R12, 1, 1
	BRA         L_WS2812_init4
	DECFSZ      R11, 1, 1
	BRA         L_WS2812_init4
	NOP
;ws2812.c,76 :: 		}
	GOTO        L_WS2812_init5
L_WS2812_init3:
;ws2812.c,80 :: 		if (status == 0)
	MOVF        WS2812_init_status_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_init6
;ws2812.c,82 :: 		return;
	GOTO        L_end_WS2812_init
;ws2812.c,83 :: 		}
L_WS2812_init6:
;ws2812.c,86 :: 		WS2812_read_state();
	CALL        _WS2812_read_state+0, 0
;ws2812.c,89 :: 		T0CON = 0x87;
	MOVLW       135
	MOVWF       T0CON+0 
;ws2812.c,91 :: 		TMR0L = 0x48;
	MOVLW       72
	MOVWF       TMR0L+0 
;ws2812.c,92 :: 		TMR0H = 0xE5;
	MOVLW       229
	MOVWF       TMR0H+0 
;ws2812.c,94 :: 		GIE_bit = 1;
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;ws2812.c,96 :: 		TMR0IE_bit = 1;
	BSF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;ws2812.c,97 :: 		}
L_WS2812_init5:
;ws2812.c,98 :: 		}
L_end_WS2812_init:
	RETURN      0
; end of _WS2812_init

_WS2812_prepare_data:

;ws2812.c,101 :: 		void WS2812_prepare_data()
;ws2812.c,104 :: 		ENC28J60_get_request(&currentRequest);
	MOVLW       _currentRequest+0
	MOVWF       FARG_ENC28J60_get_request_received_request+0 
	MOVLW       hi_addr(_currentRequest+0)
	MOVWF       FARG_ENC28J60_get_request_received_request+1 
	CALL        _ENC28J60_get_request+0, 0
;ws2812.c,107 :: 		WS2812_save_state();
	CALL        _WS2812_save_state+0, 0
;ws2812.c,110 :: 		T0CON = 0x87;
	MOVLW       135
	MOVWF       T0CON+0 
;ws2812.c,112 :: 		TMR0L = 0x48;
	MOVLW       72
	MOVWF       TMR0L+0 
;ws2812.c,113 :: 		TMR0H = 0xE5;
	MOVLW       229
	MOVWF       TMR0H+0 
;ws2812.c,115 :: 		GIE_bit = 1;
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;ws2812.c,117 :: 		TMR0IE_bit = 1;
	BSF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;ws2812.c,118 :: 		}
L_end_WS2812_prepare_data:
	RETURN      0
; end of _WS2812_prepare_data

_WS2812_delay_long:

;ws2812.c,121 :: 		void WS2812_delay_long()
;ws2812.c,123 :: 		asm nop;
	NOP
;ws2812.c,124 :: 		asm nop;
	NOP
;ws2812.c,125 :: 		asm nop;
	NOP
;ws2812.c,126 :: 		asm nop;
	NOP
;ws2812.c,127 :: 		}
L_end_WS2812_delay_long:
	RETURN      0
; end of _WS2812_delay_long

_WS2812_delay_short:

;ws2812.c,130 :: 		void WS2812_delay_short()
;ws2812.c,132 :: 		asm nop;
	NOP
;ws2812.c,133 :: 		}
L_end_WS2812_delay_short:
	RETURN      0
; end of _WS2812_delay_short

_WS2812_read_state:

;ws2812.c,136 :: 		void WS2812_read_state()
;ws2812.c,139 :: 		unsigned int address_index = 0;
	CLRF        WS2812_read_state_address_index_L0+0 
	CLRF        WS2812_read_state_address_index_L0+1 
	CLRF        WS2812_read_state_value_index_L0+0 
	CLRF        WS2812_read_state_value_index_L0+1 
;ws2812.c,147 :: 		DS1302_get_time(&currentTime);
	MOVLW       _currentTime+0
	MOVWF       FARG_DS1302_get_time_current_time+0 
	MOVLW       hi_addr(_currentTime+0)
	MOVWF       FARG_DS1302_get_time_current_time+1 
	CALL        _DS1302_get_time+0, 0
;ws2812.c,150 :: 		for (value_index = 0; value_index < 2; ++value_index)
	CLRF        WS2812_read_state_value_index_L0+0 
	CLRF        WS2812_read_state_value_index_L0+1 
L_WS2812_read_state7:
	MOVLW       0
	SUBWF       WS2812_read_state_value_index_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_read_state256
	MOVLW       2
	SUBWF       WS2812_read_state_value_index_L0+0, 0 
L__WS2812_read_state256:
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_read_state8
;ws2812.c,152 :: 		current_byte = &currentRequest.eur_buy[value_index];
	MOVF        WS2812_read_state_value_index_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_read_state_value_index_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _currentRequest+0
	ADDWF       R0, 0 
	MOVWF       WS2812_read_state_current_byte_L0+0 
	MOVLW       hi_addr(_currentRequest+0)
	ADDWFC      R1, 0 
	MOVWF       WS2812_read_state_current_byte_L0+1 
;ws2812.c,154 :: 		*current_byte++ = EEPROM_Read(++address_index); Delay_ms(20);
	INFSNZ      WS2812_read_state_address_index_L0+0, 1 
	INCF        WS2812_read_state_address_index_L0+1, 1 
	MOVF        WS2812_read_state_address_index_L0+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVF        WS2812_read_state_address_index_L0+1, 0 
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVFF       WS2812_read_state_current_byte_L0+0, FSR1
	MOVFF       WS2812_read_state_current_byte_L0+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      WS2812_read_state_current_byte_L0+0, 1 
	INCF        WS2812_read_state_current_byte_L0+1, 1 
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       160
	MOVWF       R12, 0
	MOVLW       146
	MOVWF       R13, 0
L_WS2812_read_state10:
	DECFSZ      R13, 1, 1
	BRA         L_WS2812_read_state10
	DECFSZ      R12, 1, 1
	BRA         L_WS2812_read_state10
	DECFSZ      R11, 1, 1
	BRA         L_WS2812_read_state10
	NOP
;ws2812.c,155 :: 		*current_byte++ = EEPROM_Read(++address_index); Delay_ms(20);
	INFSNZ      WS2812_read_state_address_index_L0+0, 1 
	INCF        WS2812_read_state_address_index_L0+1, 1 
	MOVF        WS2812_read_state_address_index_L0+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVF        WS2812_read_state_address_index_L0+1, 0 
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVFF       WS2812_read_state_current_byte_L0+0, FSR1
	MOVFF       WS2812_read_state_current_byte_L0+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      WS2812_read_state_current_byte_L0+0, 1 
	INCF        WS2812_read_state_current_byte_L0+1, 1 
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       160
	MOVWF       R12, 0
	MOVLW       146
	MOVWF       R13, 0
L_WS2812_read_state11:
	DECFSZ      R13, 1, 1
	BRA         L_WS2812_read_state11
	DECFSZ      R12, 1, 1
	BRA         L_WS2812_read_state11
	DECFSZ      R11, 1, 1
	BRA         L_WS2812_read_state11
	NOP
;ws2812.c,150 :: 		for (value_index = 0; value_index < 2; ++value_index)
	INFSNZ      WS2812_read_state_value_index_L0+0, 1 
	INCF        WS2812_read_state_value_index_L0+1, 1 
;ws2812.c,156 :: 		}
	GOTO        L_WS2812_read_state7
L_WS2812_read_state8:
;ws2812.c,159 :: 		for (value_index = 0; value_index < 2; ++value_index)
	CLRF        WS2812_read_state_value_index_L0+0 
	CLRF        WS2812_read_state_value_index_L0+1 
L_WS2812_read_state12:
	MOVLW       0
	SUBWF       WS2812_read_state_value_index_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_read_state257
	MOVLW       2
	SUBWF       WS2812_read_state_value_index_L0+0, 0 
L__WS2812_read_state257:
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_read_state13
;ws2812.c,161 :: 		current_byte = &currentRequest.eur_sale[value_index];
	MOVF        WS2812_read_state_value_index_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_read_state_value_index_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _currentRequest+4
	ADDWF       R0, 0 
	MOVWF       WS2812_read_state_current_byte_L0+0 
	MOVLW       hi_addr(_currentRequest+4)
	ADDWFC      R1, 0 
	MOVWF       WS2812_read_state_current_byte_L0+1 
;ws2812.c,163 :: 		*current_byte++ = EEPROM_Read(++address_index); Delay_ms(20);
	INFSNZ      WS2812_read_state_address_index_L0+0, 1 
	INCF        WS2812_read_state_address_index_L0+1, 1 
	MOVF        WS2812_read_state_address_index_L0+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVF        WS2812_read_state_address_index_L0+1, 0 
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVFF       WS2812_read_state_current_byte_L0+0, FSR1
	MOVFF       WS2812_read_state_current_byte_L0+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      WS2812_read_state_current_byte_L0+0, 1 
	INCF        WS2812_read_state_current_byte_L0+1, 1 
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       160
	MOVWF       R12, 0
	MOVLW       146
	MOVWF       R13, 0
L_WS2812_read_state15:
	DECFSZ      R13, 1, 1
	BRA         L_WS2812_read_state15
	DECFSZ      R12, 1, 1
	BRA         L_WS2812_read_state15
	DECFSZ      R11, 1, 1
	BRA         L_WS2812_read_state15
	NOP
;ws2812.c,164 :: 		*current_byte++ = EEPROM_Read(++address_index); Delay_ms(20);
	INFSNZ      WS2812_read_state_address_index_L0+0, 1 
	INCF        WS2812_read_state_address_index_L0+1, 1 
	MOVF        WS2812_read_state_address_index_L0+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVF        WS2812_read_state_address_index_L0+1, 0 
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVFF       WS2812_read_state_current_byte_L0+0, FSR1
	MOVFF       WS2812_read_state_current_byte_L0+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      WS2812_read_state_current_byte_L0+0, 1 
	INCF        WS2812_read_state_current_byte_L0+1, 1 
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       160
	MOVWF       R12, 0
	MOVLW       146
	MOVWF       R13, 0
L_WS2812_read_state16:
	DECFSZ      R13, 1, 1
	BRA         L_WS2812_read_state16
	DECFSZ      R12, 1, 1
	BRA         L_WS2812_read_state16
	DECFSZ      R11, 1, 1
	BRA         L_WS2812_read_state16
	NOP
;ws2812.c,159 :: 		for (value_index = 0; value_index < 2; ++value_index)
	INFSNZ      WS2812_read_state_value_index_L0+0, 1 
	INCF        WS2812_read_state_value_index_L0+1, 1 
;ws2812.c,165 :: 		}
	GOTO        L_WS2812_read_state12
L_WS2812_read_state13:
;ws2812.c,168 :: 		for (value_index = 0; value_index < 2; ++value_index)
	CLRF        WS2812_read_state_value_index_L0+0 
	CLRF        WS2812_read_state_value_index_L0+1 
L_WS2812_read_state17:
	MOVLW       0
	SUBWF       WS2812_read_state_value_index_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_read_state258
	MOVLW       2
	SUBWF       WS2812_read_state_value_index_L0+0, 0 
L__WS2812_read_state258:
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_read_state18
;ws2812.c,170 :: 		current_byte = &currentRequest.usd_buy[value_index];
	MOVF        WS2812_read_state_value_index_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_read_state_value_index_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _currentRequest+8
	ADDWF       R0, 0 
	MOVWF       WS2812_read_state_current_byte_L0+0 
	MOVLW       hi_addr(_currentRequest+8)
	ADDWFC      R1, 0 
	MOVWF       WS2812_read_state_current_byte_L0+1 
;ws2812.c,172 :: 		*current_byte++ = EEPROM_Read(++address_index); Delay_ms(20);
	INFSNZ      WS2812_read_state_address_index_L0+0, 1 
	INCF        WS2812_read_state_address_index_L0+1, 1 
	MOVF        WS2812_read_state_address_index_L0+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVF        WS2812_read_state_address_index_L0+1, 0 
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVFF       WS2812_read_state_current_byte_L0+0, FSR1
	MOVFF       WS2812_read_state_current_byte_L0+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      WS2812_read_state_current_byte_L0+0, 1 
	INCF        WS2812_read_state_current_byte_L0+1, 1 
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       160
	MOVWF       R12, 0
	MOVLW       146
	MOVWF       R13, 0
L_WS2812_read_state20:
	DECFSZ      R13, 1, 1
	BRA         L_WS2812_read_state20
	DECFSZ      R12, 1, 1
	BRA         L_WS2812_read_state20
	DECFSZ      R11, 1, 1
	BRA         L_WS2812_read_state20
	NOP
;ws2812.c,173 :: 		*current_byte++ = EEPROM_Read(++address_index); Delay_ms(20);
	INFSNZ      WS2812_read_state_address_index_L0+0, 1 
	INCF        WS2812_read_state_address_index_L0+1, 1 
	MOVF        WS2812_read_state_address_index_L0+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVF        WS2812_read_state_address_index_L0+1, 0 
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVFF       WS2812_read_state_current_byte_L0+0, FSR1
	MOVFF       WS2812_read_state_current_byte_L0+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      WS2812_read_state_current_byte_L0+0, 1 
	INCF        WS2812_read_state_current_byte_L0+1, 1 
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       160
	MOVWF       R12, 0
	MOVLW       146
	MOVWF       R13, 0
L_WS2812_read_state21:
	DECFSZ      R13, 1, 1
	BRA         L_WS2812_read_state21
	DECFSZ      R12, 1, 1
	BRA         L_WS2812_read_state21
	DECFSZ      R11, 1, 1
	BRA         L_WS2812_read_state21
	NOP
;ws2812.c,168 :: 		for (value_index = 0; value_index < 2; ++value_index)
	INFSNZ      WS2812_read_state_value_index_L0+0, 1 
	INCF        WS2812_read_state_value_index_L0+1, 1 
;ws2812.c,174 :: 		}
	GOTO        L_WS2812_read_state17
L_WS2812_read_state18:
;ws2812.c,177 :: 		for (value_index = 0; value_index < 2; ++value_index)
	CLRF        WS2812_read_state_value_index_L0+0 
	CLRF        WS2812_read_state_value_index_L0+1 
L_WS2812_read_state22:
	MOVLW       0
	SUBWF       WS2812_read_state_value_index_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_read_state259
	MOVLW       2
	SUBWF       WS2812_read_state_value_index_L0+0, 0 
L__WS2812_read_state259:
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_read_state23
;ws2812.c,179 :: 		current_byte = &currentRequest.usd_sale[value_index];
	MOVF        WS2812_read_state_value_index_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_read_state_value_index_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _currentRequest+12
	ADDWF       R0, 0 
	MOVWF       WS2812_read_state_current_byte_L0+0 
	MOVLW       hi_addr(_currentRequest+12)
	ADDWFC      R1, 0 
	MOVWF       WS2812_read_state_current_byte_L0+1 
;ws2812.c,181 :: 		*current_byte++ = EEPROM_Read(++address_index); Delay_ms(20);
	INFSNZ      WS2812_read_state_address_index_L0+0, 1 
	INCF        WS2812_read_state_address_index_L0+1, 1 
	MOVF        WS2812_read_state_address_index_L0+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVF        WS2812_read_state_address_index_L0+1, 0 
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVFF       WS2812_read_state_current_byte_L0+0, FSR1
	MOVFF       WS2812_read_state_current_byte_L0+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      WS2812_read_state_current_byte_L0+0, 1 
	INCF        WS2812_read_state_current_byte_L0+1, 1 
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       160
	MOVWF       R12, 0
	MOVLW       146
	MOVWF       R13, 0
L_WS2812_read_state25:
	DECFSZ      R13, 1, 1
	BRA         L_WS2812_read_state25
	DECFSZ      R12, 1, 1
	BRA         L_WS2812_read_state25
	DECFSZ      R11, 1, 1
	BRA         L_WS2812_read_state25
	NOP
;ws2812.c,182 :: 		*current_byte++ = EEPROM_Read(++address_index); Delay_ms(20);
	INFSNZ      WS2812_read_state_address_index_L0+0, 1 
	INCF        WS2812_read_state_address_index_L0+1, 1 
	MOVF        WS2812_read_state_address_index_L0+0, 0 
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVF        WS2812_read_state_address_index_L0+1, 0 
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVFF       WS2812_read_state_current_byte_L0+0, FSR1
	MOVFF       WS2812_read_state_current_byte_L0+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	INFSNZ      WS2812_read_state_current_byte_L0+0, 1 
	INCF        WS2812_read_state_current_byte_L0+1, 1 
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       160
	MOVWF       R12, 0
	MOVLW       146
	MOVWF       R13, 0
L_WS2812_read_state26:
	DECFSZ      R13, 1, 1
	BRA         L_WS2812_read_state26
	DECFSZ      R12, 1, 1
	BRA         L_WS2812_read_state26
	DECFSZ      R11, 1, 1
	BRA         L_WS2812_read_state26
	NOP
;ws2812.c,177 :: 		for (value_index = 0; value_index < 2; ++value_index)
	INFSNZ      WS2812_read_state_value_index_L0+0, 1 
	INCF        WS2812_read_state_value_index_L0+1, 1 
;ws2812.c,183 :: 		}
	GOTO        L_WS2812_read_state22
L_WS2812_read_state23:
;ws2812.c,184 :: 		}
L_end_WS2812_read_state:
	RETURN      0
; end of _WS2812_read_state

_WS2812_save_state:

;ws2812.c,187 :: 		void WS2812_save_state()
;ws2812.c,190 :: 		unsigned int address_index = 0;
	CLRF        WS2812_save_state_address_index_L0+0 
	CLRF        WS2812_save_state_address_index_L0+1 
	CLRF        WS2812_save_state_value_index_L0+0 
	CLRF        WS2812_save_state_value_index_L0+1 
;ws2812.c,198 :: 		EEPROM_Write(address_index++, 1); Delay_ms(20);
	MOVF        WS2812_save_state_address_index_L0+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        WS2812_save_state_address_index_L0+1, 0 
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
	INFSNZ      WS2812_save_state_address_index_L0+0, 1 
	INCF        WS2812_save_state_address_index_L0+1, 1 
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       160
	MOVWF       R12, 0
	MOVLW       146
	MOVWF       R13, 0
L_WS2812_save_state27:
	DECFSZ      R13, 1, 1
	BRA         L_WS2812_save_state27
	DECFSZ      R12, 1, 1
	BRA         L_WS2812_save_state27
	DECFSZ      R11, 1, 1
	BRA         L_WS2812_save_state27
	NOP
;ws2812.c,201 :: 		for (value_index = 0; value_index < 2; ++value_index)
	CLRF        WS2812_save_state_value_index_L0+0 
	CLRF        WS2812_save_state_value_index_L0+1 
L_WS2812_save_state28:
	MOVLW       0
	SUBWF       WS2812_save_state_value_index_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_save_state261
	MOVLW       2
	SUBWF       WS2812_save_state_value_index_L0+0, 0 
L__WS2812_save_state261:
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_save_state29
;ws2812.c,203 :: 		current_byte = &currentRequest.eur_buy[value_index];
	MOVF        WS2812_save_state_value_index_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_save_state_value_index_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _currentRequest+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_currentRequest+0)
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       WS2812_save_state_current_byte_L0+0 
	MOVF        R1, 0 
	MOVWF       WS2812_save_state_current_byte_L0+1 
;ws2812.c,205 :: 		EEPROM_Write(address_index++, *current_byte++); Delay_ms(20);
	MOVF        WS2812_save_state_address_index_L0+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        WS2812_save_state_address_index_L0+1, 0 
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVFF       R0, FSR0
	MOVFF       R1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
	INFSNZ      WS2812_save_state_address_index_L0+0, 1 
	INCF        WS2812_save_state_address_index_L0+1, 1 
	INFSNZ      WS2812_save_state_current_byte_L0+0, 1 
	INCF        WS2812_save_state_current_byte_L0+1, 1 
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       160
	MOVWF       R12, 0
	MOVLW       146
	MOVWF       R13, 0
L_WS2812_save_state31:
	DECFSZ      R13, 1, 1
	BRA         L_WS2812_save_state31
	DECFSZ      R12, 1, 1
	BRA         L_WS2812_save_state31
	DECFSZ      R11, 1, 1
	BRA         L_WS2812_save_state31
	NOP
;ws2812.c,206 :: 		EEPROM_Write(address_index++, *current_byte++); Delay_ms(20);
	MOVF        WS2812_save_state_address_index_L0+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        WS2812_save_state_address_index_L0+1, 0 
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVFF       WS2812_save_state_current_byte_L0+0, FSR0
	MOVFF       WS2812_save_state_current_byte_L0+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
	INFSNZ      WS2812_save_state_address_index_L0+0, 1 
	INCF        WS2812_save_state_address_index_L0+1, 1 
	INFSNZ      WS2812_save_state_current_byte_L0+0, 1 
	INCF        WS2812_save_state_current_byte_L0+1, 1 
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       160
	MOVWF       R12, 0
	MOVLW       146
	MOVWF       R13, 0
L_WS2812_save_state32:
	DECFSZ      R13, 1, 1
	BRA         L_WS2812_save_state32
	DECFSZ      R12, 1, 1
	BRA         L_WS2812_save_state32
	DECFSZ      R11, 1, 1
	BRA         L_WS2812_save_state32
	NOP
;ws2812.c,201 :: 		for (value_index = 0; value_index < 2; ++value_index)
	INFSNZ      WS2812_save_state_value_index_L0+0, 1 
	INCF        WS2812_save_state_value_index_L0+1, 1 
;ws2812.c,207 :: 		}
	GOTO        L_WS2812_save_state28
L_WS2812_save_state29:
;ws2812.c,210 :: 		for (value_index = 0; value_index < 2; ++value_index)
	CLRF        WS2812_save_state_value_index_L0+0 
	CLRF        WS2812_save_state_value_index_L0+1 
L_WS2812_save_state33:
	MOVLW       0
	SUBWF       WS2812_save_state_value_index_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_save_state262
	MOVLW       2
	SUBWF       WS2812_save_state_value_index_L0+0, 0 
L__WS2812_save_state262:
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_save_state34
;ws2812.c,212 :: 		current_byte = &currentRequest.eur_sale[value_index];
	MOVF        WS2812_save_state_value_index_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_save_state_value_index_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _currentRequest+4
	ADDWF       R0, 1 
	MOVLW       hi_addr(_currentRequest+4)
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       WS2812_save_state_current_byte_L0+0 
	MOVF        R1, 0 
	MOVWF       WS2812_save_state_current_byte_L0+1 
;ws2812.c,214 :: 		EEPROM_Write(address_index++, *current_byte++); Delay_ms(20);
	MOVF        WS2812_save_state_address_index_L0+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        WS2812_save_state_address_index_L0+1, 0 
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVFF       R0, FSR0
	MOVFF       R1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
	INFSNZ      WS2812_save_state_address_index_L0+0, 1 
	INCF        WS2812_save_state_address_index_L0+1, 1 
	INFSNZ      WS2812_save_state_current_byte_L0+0, 1 
	INCF        WS2812_save_state_current_byte_L0+1, 1 
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       160
	MOVWF       R12, 0
	MOVLW       146
	MOVWF       R13, 0
L_WS2812_save_state36:
	DECFSZ      R13, 1, 1
	BRA         L_WS2812_save_state36
	DECFSZ      R12, 1, 1
	BRA         L_WS2812_save_state36
	DECFSZ      R11, 1, 1
	BRA         L_WS2812_save_state36
	NOP
;ws2812.c,215 :: 		EEPROM_Write(address_index++, *current_byte++); Delay_ms(20);
	MOVF        WS2812_save_state_address_index_L0+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        WS2812_save_state_address_index_L0+1, 0 
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVFF       WS2812_save_state_current_byte_L0+0, FSR0
	MOVFF       WS2812_save_state_current_byte_L0+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
	INFSNZ      WS2812_save_state_address_index_L0+0, 1 
	INCF        WS2812_save_state_address_index_L0+1, 1 
	INFSNZ      WS2812_save_state_current_byte_L0+0, 1 
	INCF        WS2812_save_state_current_byte_L0+1, 1 
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       160
	MOVWF       R12, 0
	MOVLW       146
	MOVWF       R13, 0
L_WS2812_save_state37:
	DECFSZ      R13, 1, 1
	BRA         L_WS2812_save_state37
	DECFSZ      R12, 1, 1
	BRA         L_WS2812_save_state37
	DECFSZ      R11, 1, 1
	BRA         L_WS2812_save_state37
	NOP
;ws2812.c,210 :: 		for (value_index = 0; value_index < 2; ++value_index)
	INFSNZ      WS2812_save_state_value_index_L0+0, 1 
	INCF        WS2812_save_state_value_index_L0+1, 1 
;ws2812.c,216 :: 		}
	GOTO        L_WS2812_save_state33
L_WS2812_save_state34:
;ws2812.c,219 :: 		for (value_index = 0; value_index < 2; ++value_index)
	CLRF        WS2812_save_state_value_index_L0+0 
	CLRF        WS2812_save_state_value_index_L0+1 
L_WS2812_save_state38:
	MOVLW       0
	SUBWF       WS2812_save_state_value_index_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_save_state263
	MOVLW       2
	SUBWF       WS2812_save_state_value_index_L0+0, 0 
L__WS2812_save_state263:
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_save_state39
;ws2812.c,221 :: 		current_byte = &currentRequest.usd_buy[value_index];
	MOVF        WS2812_save_state_value_index_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_save_state_value_index_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _currentRequest+8
	ADDWF       R0, 1 
	MOVLW       hi_addr(_currentRequest+8)
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       WS2812_save_state_current_byte_L0+0 
	MOVF        R1, 0 
	MOVWF       WS2812_save_state_current_byte_L0+1 
;ws2812.c,223 :: 		EEPROM_Write(address_index++, *current_byte++); Delay_ms(20);
	MOVF        WS2812_save_state_address_index_L0+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        WS2812_save_state_address_index_L0+1, 0 
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVFF       R0, FSR0
	MOVFF       R1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
	INFSNZ      WS2812_save_state_address_index_L0+0, 1 
	INCF        WS2812_save_state_address_index_L0+1, 1 
	INFSNZ      WS2812_save_state_current_byte_L0+0, 1 
	INCF        WS2812_save_state_current_byte_L0+1, 1 
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       160
	MOVWF       R12, 0
	MOVLW       146
	MOVWF       R13, 0
L_WS2812_save_state41:
	DECFSZ      R13, 1, 1
	BRA         L_WS2812_save_state41
	DECFSZ      R12, 1, 1
	BRA         L_WS2812_save_state41
	DECFSZ      R11, 1, 1
	BRA         L_WS2812_save_state41
	NOP
;ws2812.c,224 :: 		EEPROM_Write(address_index++, *current_byte++); Delay_ms(20);
	MOVF        WS2812_save_state_address_index_L0+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        WS2812_save_state_address_index_L0+1, 0 
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVFF       WS2812_save_state_current_byte_L0+0, FSR0
	MOVFF       WS2812_save_state_current_byte_L0+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
	INFSNZ      WS2812_save_state_address_index_L0+0, 1 
	INCF        WS2812_save_state_address_index_L0+1, 1 
	INFSNZ      WS2812_save_state_current_byte_L0+0, 1 
	INCF        WS2812_save_state_current_byte_L0+1, 1 
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       160
	MOVWF       R12, 0
	MOVLW       146
	MOVWF       R13, 0
L_WS2812_save_state42:
	DECFSZ      R13, 1, 1
	BRA         L_WS2812_save_state42
	DECFSZ      R12, 1, 1
	BRA         L_WS2812_save_state42
	DECFSZ      R11, 1, 1
	BRA         L_WS2812_save_state42
	NOP
;ws2812.c,219 :: 		for (value_index = 0; value_index < 2; ++value_index)
	INFSNZ      WS2812_save_state_value_index_L0+0, 1 
	INCF        WS2812_save_state_value_index_L0+1, 1 
;ws2812.c,225 :: 		}
	GOTO        L_WS2812_save_state38
L_WS2812_save_state39:
;ws2812.c,228 :: 		for (value_index = 0; value_index < 2; ++value_index)
	CLRF        WS2812_save_state_value_index_L0+0 
	CLRF        WS2812_save_state_value_index_L0+1 
L_WS2812_save_state43:
	MOVLW       0
	SUBWF       WS2812_save_state_value_index_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_save_state264
	MOVLW       2
	SUBWF       WS2812_save_state_value_index_L0+0, 0 
L__WS2812_save_state264:
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_save_state44
;ws2812.c,230 :: 		current_byte = &currentRequest.usd_sale[value_index];
	MOVF        WS2812_save_state_value_index_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_save_state_value_index_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVLW       _currentRequest+12
	ADDWF       R0, 1 
	MOVLW       hi_addr(_currentRequest+12)
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       WS2812_save_state_current_byte_L0+0 
	MOVF        R1, 0 
	MOVWF       WS2812_save_state_current_byte_L0+1 
;ws2812.c,232 :: 		EEPROM_Write(address_index++, *current_byte++); Delay_ms(20);
	MOVF        WS2812_save_state_address_index_L0+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        WS2812_save_state_address_index_L0+1, 0 
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVFF       R0, FSR0
	MOVFF       R1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
	INFSNZ      WS2812_save_state_address_index_L0+0, 1 
	INCF        WS2812_save_state_address_index_L0+1, 1 
	INFSNZ      WS2812_save_state_current_byte_L0+0, 1 
	INCF        WS2812_save_state_current_byte_L0+1, 1 
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       160
	MOVWF       R12, 0
	MOVLW       146
	MOVWF       R13, 0
L_WS2812_save_state46:
	DECFSZ      R13, 1, 1
	BRA         L_WS2812_save_state46
	DECFSZ      R12, 1, 1
	BRA         L_WS2812_save_state46
	DECFSZ      R11, 1, 1
	BRA         L_WS2812_save_state46
	NOP
;ws2812.c,233 :: 		EEPROM_Write(address_index++, *current_byte++); Delay_ms(20);
	MOVF        WS2812_save_state_address_index_L0+0, 0 
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        WS2812_save_state_address_index_L0+1, 0 
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVFF       WS2812_save_state_current_byte_L0+0, FSR0
	MOVFF       WS2812_save_state_current_byte_L0+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
	INFSNZ      WS2812_save_state_address_index_L0+0, 1 
	INCF        WS2812_save_state_address_index_L0+1, 1 
	INFSNZ      WS2812_save_state_current_byte_L0+0, 1 
	INCF        WS2812_save_state_current_byte_L0+1, 1 
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       160
	MOVWF       R12, 0
	MOVLW       146
	MOVWF       R13, 0
L_WS2812_save_state47:
	DECFSZ      R13, 1, 1
	BRA         L_WS2812_save_state47
	DECFSZ      R12, 1, 1
	BRA         L_WS2812_save_state47
	DECFSZ      R11, 1, 1
	BRA         L_WS2812_save_state47
	NOP
;ws2812.c,228 :: 		for (value_index = 0; value_index < 2; ++value_index)
	INFSNZ      WS2812_save_state_value_index_L0+0, 1 
	INCF        WS2812_save_state_value_index_L0+1, 1 
;ws2812.c,234 :: 		}
	GOTO        L_WS2812_save_state43
L_WS2812_save_state44:
;ws2812.c,235 :: 		}
L_end_WS2812_save_state:
	RETURN      0
; end of _WS2812_save_state

_WS2812_print_clock:

;ws2812.c,238 :: 		void WS2812_print_clock()
;ws2812.c,241 :: 		unsigned int pixel_position = 0;
	CLRF        WS2812_print_clock_pixel_position_L0+0 
	CLRF        WS2812_print_clock_pixel_position_L0+1 
	CLRF        WS2812_print_clock_matrix_column_L0+0 
	CLRF        WS2812_print_clock_matrix_column_L0+1 
	CLRF        WS2812_print_clock_matrix_row_L0+0 
	CLRF        WS2812_print_clock_matrix_row_L0+1 
	CLRF        WS2812_print_clock_panel_column_L0+0 
	CLRF        WS2812_print_clock_panel_column_L0+1 
	CLRF        WS2812_print_clock_panel_row_L0+0 
	CLRF        WS2812_print_clock_panel_row_L0+1 
;ws2812.c,260 :: 		for (pixel_position = 0; pixel_position < PANEL_CLOCK_WIDTH; pixel_position += MATRIX_WIDTH)
	CLRF        WS2812_print_clock_pixel_position_L0+0 
	CLRF        WS2812_print_clock_pixel_position_L0+1 
L_WS2812_print_clock48:
	MOVLW       0
	SUBWF       WS2812_print_clock_pixel_position_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_clock266
	MOVLW       30
	SUBWF       WS2812_print_clock_pixel_position_L0+0, 0 
L__WS2812_print_clock266:
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_print_clock49
;ws2812.c,262 :: 		for (matrix_row = 0; matrix_row < MATRIX_HEIGHT; ++matrix_row)
	CLRF        WS2812_print_clock_matrix_row_L0+0 
	CLRF        WS2812_print_clock_matrix_row_L0+1 
L_WS2812_print_clock51:
	MOVLW       0
	SUBWF       WS2812_print_clock_matrix_row_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_clock267
	MOVLW       7
	SUBWF       WS2812_print_clock_matrix_row_L0+0, 0 
L__WS2812_print_clock267:
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_print_clock52
;ws2812.c,264 :: 		unsigned char matrix_element = 0x00;
	CLRF        WS2812_print_clock_matrix_element_L2+0 
;ws2812.c,266 :: 		if ((pixel_position / MATRIX_WIDTH) == 0)
	MOVLW       5
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        WS2812_print_clock_pixel_position_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_print_clock_pixel_position_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_clock268
	MOVLW       0
	XORWF       R0, 0 
L__WS2812_print_clock268:
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_print_clock54
;ws2812.c,268 :: 		char symbol_code = 0; char* simplified_number;
	CLRF        WS2812_print_clock_symbol_code_L3+0 
;ws2812.c,271 :: 		IntToStr(currentTime.hour, current_number); simplified_number = Ltrim(current_number);
	MOVF        _currentTime+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       WS2812_print_clock_current_number_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(WS2812_print_clock_current_number_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
	MOVLW       WS2812_print_clock_current_number_L0+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(WS2812_print_clock_current_number_L0+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
	MOVF        R0, 0 
	MOVWF       WS2812_print_clock_simplified_number_L3+0 
	MOVF        R1, 0 
	MOVWF       WS2812_print_clock_simplified_number_L3+1 
;ws2812.c,273 :: 		if (strlen(simplified_number) > 1)
	MOVF        R0, 0 
	MOVWF       FARG_strlen_s+0 
	MOVF        R1, 0 
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVLW       128
	MOVWF       R2 
	MOVLW       128
	XORWF       R1, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_clock269
	MOVF        R0, 0 
	SUBLW       1
L__WS2812_print_clock269:
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_print_clock55
;ws2812.c,275 :: 		symbol_code = simplified_number[0] - 48;
	MOVFF       WS2812_print_clock_simplified_number_L3+0, FSR0
	MOVFF       WS2812_print_clock_simplified_number_L3+1, FSR0H
	MOVLW       48
	SUBWF       POSTINC0+0, 0 
	MOVWF       WS2812_print_clock_symbol_code_L3+0 
;ws2812.c,276 :: 		}
L_WS2812_print_clock55:
;ws2812.c,278 :: 		matrix_element = ALPHABET_NUMBERS[symbol_code * MATRIX_HEIGHT + matrix_row];
	MOVLW       7
	MULWF       WS2812_print_clock_symbol_code_L3+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVF        WS2812_print_clock_matrix_row_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       R3 
	MOVF        WS2812_print_clock_matrix_row_L0+1, 0 
	ADDWFC      R1, 0 
	MOVWF       R4 
	MOVLW       _ALPHABET_NUMBERS+0
	MOVWF       R0 
	MOVLW       hi_addr(_ALPHABET_NUMBERS+0)
	MOVWF       R1 
	MOVLW       higher_addr(_ALPHABET_NUMBERS+0)
	MOVWF       R2 
	MOVF        R3, 0 
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVF        R4, 0 
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, WS2812_print_clock_matrix_element_L2+0
;ws2812.c,279 :: 		}
L_WS2812_print_clock54:
;ws2812.c,281 :: 		if ((pixel_position / MATRIX_WIDTH) == 1)
	MOVLW       5
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        WS2812_print_clock_pixel_position_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_print_clock_pixel_position_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_clock270
	MOVLW       1
	XORWF       R0, 0 
L__WS2812_print_clock270:
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_print_clock56
;ws2812.c,283 :: 		char symbol_code = 0; char* simplified_number;
	CLRF        WS2812_print_clock_symbol_code_L3_L3+0 
;ws2812.c,286 :: 		IntToStr(currentTime.hour, current_number); simplified_number = Ltrim(current_number);
	MOVF        _currentTime+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       WS2812_print_clock_current_number_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(WS2812_print_clock_current_number_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
	MOVLW       WS2812_print_clock_current_number_L0+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(WS2812_print_clock_current_number_L0+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
	MOVF        R0, 0 
	MOVWF       WS2812_print_clock_simplified_number_L3_L3+0 
	MOVF        R1, 0 
	MOVWF       WS2812_print_clock_simplified_number_L3_L3+1 
;ws2812.c,288 :: 		if (strlen(simplified_number) == 1)
	MOVF        R0, 0 
	MOVWF       FARG_strlen_s+0 
	MOVF        R1, 0 
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_clock271
	MOVLW       1
	XORWF       R0, 0 
L__WS2812_print_clock271:
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_print_clock57
;ws2812.c,290 :: 		symbol_code = simplified_number[0] - 48;
	MOVFF       WS2812_print_clock_simplified_number_L3_L3+0, FSR0
	MOVFF       WS2812_print_clock_simplified_number_L3_L3+1, FSR0H
	MOVLW       48
	SUBWF       POSTINC0+0, 0 
	MOVWF       WS2812_print_clock_symbol_code_L3_L3+0 
;ws2812.c,291 :: 		}
L_WS2812_print_clock57:
;ws2812.c,293 :: 		if (strlen(simplified_number) == 2)
	MOVF        WS2812_print_clock_simplified_number_L3_L3+0, 0 
	MOVWF       FARG_strlen_s+0 
	MOVF        WS2812_print_clock_simplified_number_L3_L3+1, 0 
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_clock272
	MOVLW       2
	XORWF       R0, 0 
L__WS2812_print_clock272:
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_print_clock58
;ws2812.c,295 :: 		symbol_code = simplified_number[1] - 48;
	MOVLW       1
	ADDWF       WS2812_print_clock_simplified_number_L3_L3+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      WS2812_print_clock_simplified_number_L3_L3+1, 0 
	MOVWF       FSR0H 
	MOVLW       48
	SUBWF       POSTINC0+0, 0 
	MOVWF       WS2812_print_clock_symbol_code_L3_L3+0 
;ws2812.c,296 :: 		}
L_WS2812_print_clock58:
;ws2812.c,298 :: 		matrix_element = ALPHABET_NUMBERS[symbol_code * MATRIX_HEIGHT + matrix_row];
	MOVLW       7
	MULWF       WS2812_print_clock_symbol_code_L3_L3+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVF        WS2812_print_clock_matrix_row_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       R3 
	MOVF        WS2812_print_clock_matrix_row_L0+1, 0 
	ADDWFC      R1, 0 
	MOVWF       R4 
	MOVLW       _ALPHABET_NUMBERS+0
	MOVWF       R0 
	MOVLW       hi_addr(_ALPHABET_NUMBERS+0)
	MOVWF       R1 
	MOVLW       higher_addr(_ALPHABET_NUMBERS+0)
	MOVWF       R2 
	MOVF        R3, 0 
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVF        R4, 0 
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, WS2812_print_clock_matrix_element_L2+0
;ws2812.c,299 :: 		}
L_WS2812_print_clock56:
;ws2812.c,301 :: 		if ((pixel_position / MATRIX_WIDTH) == 2)
	MOVLW       5
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        WS2812_print_clock_pixel_position_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_print_clock_pixel_position_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_clock273
	MOVLW       2
	XORWF       R0, 0 
L__WS2812_print_clock273:
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_print_clock59
;ws2812.c,303 :: 		char symbol_code = 0; char* simplified_number;
	CLRF        WS2812_print_clock_symbol_code_L3_L3_L3+0 
;ws2812.c,306 :: 		IntToStr(currentTime.minute, current_number); simplified_number = Ltrim(current_number);
	MOVF        _currentTime+1, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       WS2812_print_clock_current_number_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(WS2812_print_clock_current_number_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
	MOVLW       WS2812_print_clock_current_number_L0+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(WS2812_print_clock_current_number_L0+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
	MOVF        R0, 0 
	MOVWF       WS2812_print_clock_simplified_number_L3_L3_L3+0 
	MOVF        R1, 0 
	MOVWF       WS2812_print_clock_simplified_number_L3_L3_L3+1 
;ws2812.c,308 :: 		if (strlen(simplified_number) > 1)
	MOVF        R0, 0 
	MOVWF       FARG_strlen_s+0 
	MOVF        R1, 0 
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVLW       128
	MOVWF       R2 
	MOVLW       128
	XORWF       R1, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_clock274
	MOVF        R0, 0 
	SUBLW       1
L__WS2812_print_clock274:
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_print_clock60
;ws2812.c,310 :: 		symbol_code = simplified_number[0] - 48;
	MOVFF       WS2812_print_clock_simplified_number_L3_L3_L3+0, FSR0
	MOVFF       WS2812_print_clock_simplified_number_L3_L3_L3+1, FSR0H
	MOVLW       48
	SUBWF       POSTINC0+0, 0 
	MOVWF       WS2812_print_clock_symbol_code_L3_L3_L3+0 
;ws2812.c,311 :: 		}
L_WS2812_print_clock60:
;ws2812.c,313 :: 		matrix_element = ALPHABET_NUMBERS[symbol_code * MATRIX_HEIGHT + matrix_row];
	MOVLW       7
	MULWF       WS2812_print_clock_symbol_code_L3_L3_L3+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVF        WS2812_print_clock_matrix_row_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       R3 
	MOVF        WS2812_print_clock_matrix_row_L0+1, 0 
	ADDWFC      R1, 0 
	MOVWF       R4 
	MOVLW       _ALPHABET_NUMBERS+0
	MOVWF       R0 
	MOVLW       hi_addr(_ALPHABET_NUMBERS+0)
	MOVWF       R1 
	MOVLW       higher_addr(_ALPHABET_NUMBERS+0)
	MOVWF       R2 
	MOVF        R3, 0 
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVF        R4, 0 
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, WS2812_print_clock_matrix_element_L2+0
;ws2812.c,314 :: 		}
L_WS2812_print_clock59:
;ws2812.c,316 :: 		if ((pixel_position / MATRIX_WIDTH) == 3)
	MOVLW       5
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        WS2812_print_clock_pixel_position_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_print_clock_pixel_position_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_clock275
	MOVLW       3
	XORWF       R0, 0 
L__WS2812_print_clock275:
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_print_clock61
;ws2812.c,318 :: 		char symbol_code = 0; char* simplified_number;
	CLRF        WS2812_print_clock_symbol_code_L3_L3_L3_L3+0 
;ws2812.c,321 :: 		IntToStr(currentTime.minute, current_number); simplified_number = Ltrim(current_number);
	MOVF        _currentTime+1, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       WS2812_print_clock_current_number_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(WS2812_print_clock_current_number_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
	MOVLW       WS2812_print_clock_current_number_L0+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(WS2812_print_clock_current_number_L0+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
	MOVF        R0, 0 
	MOVWF       WS2812_print_clock_simplified_number_L3_L3_L3_L3+0 
	MOVF        R1, 0 
	MOVWF       WS2812_print_clock_simplified_number_L3_L3_L3_L3+1 
;ws2812.c,323 :: 		if (strlen(simplified_number) == 1)
	MOVF        R0, 0 
	MOVWF       FARG_strlen_s+0 
	MOVF        R1, 0 
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_clock276
	MOVLW       1
	XORWF       R0, 0 
L__WS2812_print_clock276:
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_print_clock62
;ws2812.c,325 :: 		symbol_code = simplified_number[0] - 48;
	MOVFF       WS2812_print_clock_simplified_number_L3_L3_L3_L3+0, FSR0
	MOVFF       WS2812_print_clock_simplified_number_L3_L3_L3_L3+1, FSR0H
	MOVLW       48
	SUBWF       POSTINC0+0, 0 
	MOVWF       WS2812_print_clock_symbol_code_L3_L3_L3_L3+0 
;ws2812.c,326 :: 		}
L_WS2812_print_clock62:
;ws2812.c,328 :: 		if (strlen(simplified_number) == 2)
	MOVF        WS2812_print_clock_simplified_number_L3_L3_L3_L3+0, 0 
	MOVWF       FARG_strlen_s+0 
	MOVF        WS2812_print_clock_simplified_number_L3_L3_L3_L3+1, 0 
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_clock277
	MOVLW       2
	XORWF       R0, 0 
L__WS2812_print_clock277:
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_print_clock63
;ws2812.c,330 :: 		symbol_code = simplified_number[1] - 48;
	MOVLW       1
	ADDWF       WS2812_print_clock_simplified_number_L3_L3_L3_L3+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      WS2812_print_clock_simplified_number_L3_L3_L3_L3+1, 0 
	MOVWF       FSR0H 
	MOVLW       48
	SUBWF       POSTINC0+0, 0 
	MOVWF       WS2812_print_clock_symbol_code_L3_L3_L3_L3+0 
;ws2812.c,331 :: 		}
L_WS2812_print_clock63:
;ws2812.c,333 :: 		matrix_element = ALPHABET_NUMBERS[symbol_code * MATRIX_HEIGHT + matrix_row];
	MOVLW       7
	MULWF       WS2812_print_clock_symbol_code_L3_L3_L3_L3+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVF        WS2812_print_clock_matrix_row_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       R3 
	MOVF        WS2812_print_clock_matrix_row_L0+1, 0 
	ADDWFC      R1, 0 
	MOVWF       R4 
	MOVLW       _ALPHABET_NUMBERS+0
	MOVWF       R0 
	MOVLW       hi_addr(_ALPHABET_NUMBERS+0)
	MOVWF       R1 
	MOVLW       higher_addr(_ALPHABET_NUMBERS+0)
	MOVWF       R2 
	MOVF        R3, 0 
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVF        R4, 0 
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, WS2812_print_clock_matrix_element_L2+0
;ws2812.c,334 :: 		}
L_WS2812_print_clock61:
;ws2812.c,336 :: 		if ((pixel_position / MATRIX_WIDTH) == 4)
	MOVLW       5
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        WS2812_print_clock_pixel_position_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_print_clock_pixel_position_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_clock278
	MOVLW       4
	XORWF       R0, 0 
L__WS2812_print_clock278:
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_print_clock64
;ws2812.c,338 :: 		char symbol_code = 0; char* simplified_number;
	CLRF        WS2812_print_clock_symbol_code_L3_L3_L3_L3_L3+0 
;ws2812.c,341 :: 		IntToStr(currentTime.second, current_number); simplified_number = Ltrim(current_number);
	MOVF        _currentTime+2, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       WS2812_print_clock_current_number_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(WS2812_print_clock_current_number_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
	MOVLW       WS2812_print_clock_current_number_L0+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(WS2812_print_clock_current_number_L0+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
	MOVF        R0, 0 
	MOVWF       WS2812_print_clock_simplified_number_L3_L3_L3_L3_L3+0 
	MOVF        R1, 0 
	MOVWF       WS2812_print_clock_simplified_number_L3_L3_L3_L3_L3+1 
;ws2812.c,343 :: 		if (strlen(simplified_number) > 1)
	MOVF        R0, 0 
	MOVWF       FARG_strlen_s+0 
	MOVF        R1, 0 
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVLW       128
	MOVWF       R2 
	MOVLW       128
	XORWF       R1, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_clock279
	MOVF        R0, 0 
	SUBLW       1
L__WS2812_print_clock279:
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_print_clock65
;ws2812.c,345 :: 		symbol_code = simplified_number[0] - 48;
	MOVFF       WS2812_print_clock_simplified_number_L3_L3_L3_L3_L3+0, FSR0
	MOVFF       WS2812_print_clock_simplified_number_L3_L3_L3_L3_L3+1, FSR0H
	MOVLW       48
	SUBWF       POSTINC0+0, 0 
	MOVWF       WS2812_print_clock_symbol_code_L3_L3_L3_L3_L3+0 
;ws2812.c,346 :: 		}
L_WS2812_print_clock65:
;ws2812.c,348 :: 		matrix_element = ALPHABET_NUMBERS[symbol_code * MATRIX_HEIGHT + matrix_row];
	MOVLW       7
	MULWF       WS2812_print_clock_symbol_code_L3_L3_L3_L3_L3+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVF        WS2812_print_clock_matrix_row_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       R3 
	MOVF        WS2812_print_clock_matrix_row_L0+1, 0 
	ADDWFC      R1, 0 
	MOVWF       R4 
	MOVLW       _ALPHABET_NUMBERS+0
	MOVWF       R0 
	MOVLW       hi_addr(_ALPHABET_NUMBERS+0)
	MOVWF       R1 
	MOVLW       higher_addr(_ALPHABET_NUMBERS+0)
	MOVWF       R2 
	MOVF        R3, 0 
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVF        R4, 0 
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, WS2812_print_clock_matrix_element_L2+0
;ws2812.c,349 :: 		}
L_WS2812_print_clock64:
;ws2812.c,351 :: 		if ((pixel_position / MATRIX_WIDTH) == 5)
	MOVLW       5
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        WS2812_print_clock_pixel_position_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_print_clock_pixel_position_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_clock280
	MOVLW       5
	XORWF       R0, 0 
L__WS2812_print_clock280:
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_print_clock66
;ws2812.c,353 :: 		char symbol_code = 0; char* simplified_number;
	CLRF        WS2812_print_clock_symbol_code_L3_L3_L3_L3_L3_L3+0 
;ws2812.c,356 :: 		IntToStr(currentTime.second, current_number); simplified_number = Ltrim(current_number);
	MOVF        _currentTime+2, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVLW       0
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       WS2812_print_clock_current_number_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(WS2812_print_clock_current_number_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
	MOVLW       WS2812_print_clock_current_number_L0+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(WS2812_print_clock_current_number_L0+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
	MOVF        R0, 0 
	MOVWF       WS2812_print_clock_simplified_number_L3_L3_L3_L3_L3_L3+0 
	MOVF        R1, 0 
	MOVWF       WS2812_print_clock_simplified_number_L3_L3_L3_L3_L3_L3+1 
;ws2812.c,358 :: 		if (strlen(simplified_number) == 1)
	MOVF        R0, 0 
	MOVWF       FARG_strlen_s+0 
	MOVF        R1, 0 
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_clock281
	MOVLW       1
	XORWF       R0, 0 
L__WS2812_print_clock281:
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_print_clock67
;ws2812.c,360 :: 		symbol_code = simplified_number[0] - 48;
	MOVFF       WS2812_print_clock_simplified_number_L3_L3_L3_L3_L3_L3+0, FSR0
	MOVFF       WS2812_print_clock_simplified_number_L3_L3_L3_L3_L3_L3+1, FSR0H
	MOVLW       48
	SUBWF       POSTINC0+0, 0 
	MOVWF       WS2812_print_clock_symbol_code_L3_L3_L3_L3_L3_L3+0 
;ws2812.c,361 :: 		}
L_WS2812_print_clock67:
;ws2812.c,363 :: 		if (strlen(simplified_number) == 2)
	MOVF        WS2812_print_clock_simplified_number_L3_L3_L3_L3_L3_L3+0, 0 
	MOVWF       FARG_strlen_s+0 
	MOVF        WS2812_print_clock_simplified_number_L3_L3_L3_L3_L3_L3+1, 0 
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_clock282
	MOVLW       2
	XORWF       R0, 0 
L__WS2812_print_clock282:
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_print_clock68
;ws2812.c,365 :: 		symbol_code = simplified_number[1] - 48;
	MOVLW       1
	ADDWF       WS2812_print_clock_simplified_number_L3_L3_L3_L3_L3_L3+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      WS2812_print_clock_simplified_number_L3_L3_L3_L3_L3_L3+1, 0 
	MOVWF       FSR0H 
	MOVLW       48
	SUBWF       POSTINC0+0, 0 
	MOVWF       WS2812_print_clock_symbol_code_L3_L3_L3_L3_L3_L3+0 
;ws2812.c,366 :: 		}
L_WS2812_print_clock68:
;ws2812.c,368 :: 		matrix_element = ALPHABET_NUMBERS[symbol_code * MATRIX_HEIGHT + matrix_row];
	MOVLW       7
	MULWF       WS2812_print_clock_symbol_code_L3_L3_L3_L3_L3_L3+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVF        WS2812_print_clock_matrix_row_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       R3 
	MOVF        WS2812_print_clock_matrix_row_L0+1, 0 
	ADDWFC      R1, 0 
	MOVWF       R4 
	MOVLW       _ALPHABET_NUMBERS+0
	MOVWF       R0 
	MOVLW       hi_addr(_ALPHABET_NUMBERS+0)
	MOVWF       R1 
	MOVLW       higher_addr(_ALPHABET_NUMBERS+0)
	MOVWF       R2 
	MOVF        R3, 0 
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVF        R4, 0 
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, WS2812_print_clock_matrix_element_L2+0
;ws2812.c,369 :: 		}
L_WS2812_print_clock66:
;ws2812.c,371 :: 		for (matrix_column = 0; matrix_column < MATRIX_WIDTH; ++matrix_column)
	CLRF        WS2812_print_clock_matrix_column_L0+0 
	CLRF        WS2812_print_clock_matrix_column_L0+1 
L_WS2812_print_clock69:
	MOVLW       0
	SUBWF       WS2812_print_clock_matrix_column_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_clock283
	MOVLW       5
	SUBWF       WS2812_print_clock_matrix_column_L0+0, 0 
L__WS2812_print_clock283:
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_print_clock70
;ws2812.c,373 :: 		if (matrix_element & 0x80)
	BTFSS       WS2812_print_clock_matrix_element_L2+0, 7 
	GOTO        L_WS2812_print_clock72
;ws2812.c,375 :: 		panel_clock_pixels[matrix_row][pixel_position + matrix_column].red = current_text_color[0];
	MOVLW       90
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        WS2812_print_clock_matrix_row_L0+0, 0 
	MOVWF       R4 
	MOVF        WS2812_print_clock_matrix_row_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _panel_clock_pixels+0
	ADDWF       R0, 0 
	MOVWF       FLOC__WS2812_print_clock+0 
	MOVLW       hi_addr(_panel_clock_pixels+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__WS2812_print_clock+1 
	MOVF        WS2812_print_clock_matrix_column_L0+0, 0 
	ADDWF       WS2812_print_clock_pixel_position_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_print_clock_matrix_column_L0+1, 0 
	ADDWFC      WS2812_print_clock_pixel_position_L0+1, 0 
	MOVWF       R1 
	MOVLW       3
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        FLOC__WS2812_print_clock+0, 0 
	ADDWF       R0, 1 
	MOVF        FLOC__WS2812_print_clock+1, 0 
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        _current_text_color+0, 0 
	MOVWF       POSTINC1+0 
;ws2812.c,376 :: 		panel_clock_pixels[matrix_row][pixel_position + matrix_column].green = current_text_color[1];
	MOVLW       90
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        WS2812_print_clock_matrix_row_L0+0, 0 
	MOVWF       R4 
	MOVF        WS2812_print_clock_matrix_row_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _panel_clock_pixels+0
	ADDWF       R0, 0 
	MOVWF       FLOC__WS2812_print_clock+0 
	MOVLW       hi_addr(_panel_clock_pixels+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__WS2812_print_clock+1 
	MOVF        WS2812_print_clock_matrix_column_L0+0, 0 
	ADDWF       WS2812_print_clock_pixel_position_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_print_clock_matrix_column_L0+1, 0 
	ADDWFC      WS2812_print_clock_pixel_position_L0+1, 0 
	MOVWF       R1 
	MOVLW       3
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        FLOC__WS2812_print_clock+0, 0 
	ADDWF       R0, 1 
	MOVF        FLOC__WS2812_print_clock+1, 0 
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        _current_text_color+1, 0 
	MOVWF       POSTINC1+0 
;ws2812.c,377 :: 		panel_clock_pixels[matrix_row][pixel_position + matrix_column].blue = current_text_color[2];
	MOVLW       90
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        WS2812_print_clock_matrix_row_L0+0, 0 
	MOVWF       R4 
	MOVF        WS2812_print_clock_matrix_row_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _panel_clock_pixels+0
	ADDWF       R0, 0 
	MOVWF       FLOC__WS2812_print_clock+0 
	MOVLW       hi_addr(_panel_clock_pixels+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__WS2812_print_clock+1 
	MOVF        WS2812_print_clock_matrix_column_L0+0, 0 
	ADDWF       WS2812_print_clock_pixel_position_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_print_clock_matrix_column_L0+1, 0 
	ADDWFC      WS2812_print_clock_pixel_position_L0+1, 0 
	MOVWF       R1 
	MOVLW       3
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__WS2812_print_clock+0, 0 
	MOVWF       FSR1 
	MOVF        R1, 0 
	ADDWFC      FLOC__WS2812_print_clock+1, 0 
	MOVWF       FSR1H 
	MOVF        _current_text_color+2, 0 
	MOVWF       POSTINC1+0 
;ws2812.c,378 :: 		}
	GOTO        L_WS2812_print_clock73
L_WS2812_print_clock72:
;ws2812.c,381 :: 		panel_clock_pixels[matrix_row][pixel_position + matrix_column].red = current_background_color[0];
	MOVLW       90
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        WS2812_print_clock_matrix_row_L0+0, 0 
	MOVWF       R4 
	MOVF        WS2812_print_clock_matrix_row_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _panel_clock_pixels+0
	ADDWF       R0, 0 
	MOVWF       FLOC__WS2812_print_clock+0 
	MOVLW       hi_addr(_panel_clock_pixels+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__WS2812_print_clock+1 
	MOVF        WS2812_print_clock_matrix_column_L0+0, 0 
	ADDWF       WS2812_print_clock_pixel_position_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_print_clock_matrix_column_L0+1, 0 
	ADDWFC      WS2812_print_clock_pixel_position_L0+1, 0 
	MOVWF       R1 
	MOVLW       3
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        FLOC__WS2812_print_clock+0, 0 
	ADDWF       R0, 1 
	MOVF        FLOC__WS2812_print_clock+1, 0 
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        _current_background_color+0, 0 
	MOVWF       POSTINC1+0 
;ws2812.c,382 :: 		panel_clock_pixels[matrix_row][pixel_position + matrix_column].green = current_background_color[1];
	MOVLW       90
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        WS2812_print_clock_matrix_row_L0+0, 0 
	MOVWF       R4 
	MOVF        WS2812_print_clock_matrix_row_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _panel_clock_pixels+0
	ADDWF       R0, 0 
	MOVWF       FLOC__WS2812_print_clock+0 
	MOVLW       hi_addr(_panel_clock_pixels+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__WS2812_print_clock+1 
	MOVF        WS2812_print_clock_matrix_column_L0+0, 0 
	ADDWF       WS2812_print_clock_pixel_position_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_print_clock_matrix_column_L0+1, 0 
	ADDWFC      WS2812_print_clock_pixel_position_L0+1, 0 
	MOVWF       R1 
	MOVLW       3
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        FLOC__WS2812_print_clock+0, 0 
	ADDWF       R0, 1 
	MOVF        FLOC__WS2812_print_clock+1, 0 
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        _current_background_color+1, 0 
	MOVWF       POSTINC1+0 
;ws2812.c,383 :: 		panel_clock_pixels[matrix_row][pixel_position + matrix_column].blue = current_background_color[2];
	MOVLW       90
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        WS2812_print_clock_matrix_row_L0+0, 0 
	MOVWF       R4 
	MOVF        WS2812_print_clock_matrix_row_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _panel_clock_pixels+0
	ADDWF       R0, 0 
	MOVWF       FLOC__WS2812_print_clock+0 
	MOVLW       hi_addr(_panel_clock_pixels+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__WS2812_print_clock+1 
	MOVF        WS2812_print_clock_matrix_column_L0+0, 0 
	ADDWF       WS2812_print_clock_pixel_position_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_print_clock_matrix_column_L0+1, 0 
	ADDWFC      WS2812_print_clock_pixel_position_L0+1, 0 
	MOVWF       R1 
	MOVLW       3
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__WS2812_print_clock+0, 0 
	MOVWF       FSR1 
	MOVF        R1, 0 
	ADDWFC      FLOC__WS2812_print_clock+1, 0 
	MOVWF       FSR1H 
	MOVF        _current_background_color+2, 0 
	MOVWF       POSTINC1+0 
;ws2812.c,384 :: 		}
L_WS2812_print_clock73:
;ws2812.c,386 :: 		matrix_element = matrix_element << 1;
	RLCF        WS2812_print_clock_matrix_element_L2+0, 1 
	BCF         WS2812_print_clock_matrix_element_L2+0, 0 
;ws2812.c,371 :: 		for (matrix_column = 0; matrix_column < MATRIX_WIDTH; ++matrix_column)
	INFSNZ      WS2812_print_clock_matrix_column_L0+0, 1 
	INCF        WS2812_print_clock_matrix_column_L0+1, 1 
;ws2812.c,387 :: 		}
	GOTO        L_WS2812_print_clock69
L_WS2812_print_clock70:
;ws2812.c,262 :: 		for (matrix_row = 0; matrix_row < MATRIX_HEIGHT; ++matrix_row)
	INFSNZ      WS2812_print_clock_matrix_row_L0+0, 1 
	INCF        WS2812_print_clock_matrix_row_L0+1, 1 
;ws2812.c,388 :: 		}
	GOTO        L_WS2812_print_clock51
L_WS2812_print_clock52:
;ws2812.c,260 :: 		for (pixel_position = 0; pixel_position < PANEL_CLOCK_WIDTH; pixel_position += MATRIX_WIDTH)
	MOVLW       5
	ADDWF       WS2812_print_clock_pixel_position_L0+0, 1 
	MOVLW       0
	ADDWFC      WS2812_print_clock_pixel_position_L0+1, 1 
;ws2812.c,389 :: 		}
	GOTO        L_WS2812_print_clock48
L_WS2812_print_clock49:
;ws2812.c,391 :: 		for (panel_row = 0; panel_row < PANEL_CLOCK_HEIGHT; ++panel_row)
	CLRF        WS2812_print_clock_panel_row_L0+0 
	CLRF        WS2812_print_clock_panel_row_L0+1 
L_WS2812_print_clock74:
	MOVLW       0
	SUBWF       WS2812_print_clock_panel_row_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_clock284
	MOVLW       7
	SUBWF       WS2812_print_clock_panel_row_L0+0, 0 
L__WS2812_print_clock284:
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_print_clock75
;ws2812.c,394 :: 		unsigned char mask_enable = PANEL_CLOCK_PORT | (0x01 << panel_row);
	MOVF        WS2812_print_clock_panel_row_L0+0, 0 
	MOVWF       R0 
	MOVLW       1
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R0, 0 
L__WS2812_print_clock285:
	BZ          L__WS2812_print_clock286
	RLCF        R2, 1 
	BCF         R2, 0 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__WS2812_print_clock285
L__WS2812_print_clock286:
	MOVF        R2, 0 
	IORWF       LATJ+0, 0 
	MOVWF       R0 
	MOVLW       0
	IORWF       R3, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       WS2812_print_clock_mask_enable_L1+0 
;ws2812.c,396 :: 		unsigned char mask_disable = PANEL_CLOCK_PORT & ~(0x01 << panel_row);
	COMF        R2, 0 
	MOVWF       R0 
	COMF        R3, 0 
	MOVWF       R1 
	MOVF        LATJ+0, 0 
	ANDWF       R0, 1 
	MOVLW       0
	ANDWF       R1, 1 
	MOVF        R0, 0 
	MOVWF       WS2812_print_clock_mask_disable_L1+0 
;ws2812.c,399 :: 		PixelParameter* pixels = panel_clock_pixels[panel_row];
	MOVLW       90
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        WS2812_print_clock_panel_row_L0+0, 0 
	MOVWF       R4 
	MOVF        WS2812_print_clock_panel_row_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _panel_clock_pixels+0
	ADDWF       R0, 0 
	MOVWF       WS2812_print_clock_pixels_L1+0 
	MOVLW       hi_addr(_panel_clock_pixels+0)
	ADDWFC      R1, 0 
	MOVWF       WS2812_print_clock_pixels_L1+1 
;ws2812.c,401 :: 		for (panel_column = 0; panel_column < PANEL_CLOCK_WIDTH; ++panel_column)
	CLRF        WS2812_print_clock_panel_column_L0+0 
	CLRF        WS2812_print_clock_panel_column_L0+1 
L_WS2812_print_clock77:
	MOVLW       0
	SUBWF       WS2812_print_clock_panel_column_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_clock287
	MOVLW       30
	SUBWF       WS2812_print_clock_panel_column_L0+0, 0 
L__WS2812_print_clock287:
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_print_clock78
;ws2812.c,404 :: 		current_byte = pixels[panel_column].green;
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        WS2812_print_clock_panel_column_L0+0, 0 
	MOVWF       R4 
	MOVF        WS2812_print_clock_panel_column_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        WS2812_print_clock_pixels_L1+0, 0 
	ADDWF       R0, 1 
	MOVF        WS2812_print_clock_pixels_L1+1, 0 
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       WS2812_print_clock_current_byte_L0+0 
;ws2812.c,406 :: 		for (current_bit = 0; current_bit < 8; ++current_bit)
	CLRF        WS2812_print_clock_current_bit_L0+0 
L_WS2812_print_clock80:
	MOVLW       8
	SUBWF       WS2812_print_clock_current_bit_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_print_clock81
;ws2812.c,408 :: 		if (current_byte & 0x80)
	BTFSS       WS2812_print_clock_current_byte_L0+0, 7 
	GOTO        L_WS2812_print_clock83
;ws2812.c,410 :: 		PANEL_CLOCK_PORT = mask_enable;
	MOVF        WS2812_print_clock_mask_enable_L1+0, 0 
	MOVWF       LATJ+0 
;ws2812.c,412 :: 		WS2812_delay_long();
	CALL        _WS2812_delay_long+0, 0
;ws2812.c,414 :: 		PANEL_CLOCK_PORT = mask_disable;
	MOVF        WS2812_print_clock_mask_disable_L1+0, 0 
	MOVWF       LATJ+0 
;ws2812.c,415 :: 		}
	GOTO        L_WS2812_print_clock84
L_WS2812_print_clock83:
;ws2812.c,418 :: 		PANEL_CLOCK_PORT = mask_enable;
	MOVF        WS2812_print_clock_mask_enable_L1+0, 0 
	MOVWF       LATJ+0 
;ws2812.c,420 :: 		PANEL_CLOCK_PORT = mask_disable;
	MOVF        WS2812_print_clock_mask_disable_L1+0, 0 
	MOVWF       LATJ+0 
;ws2812.c,421 :: 		}
L_WS2812_print_clock84:
;ws2812.c,423 :: 		current_byte = current_byte << 1;
	RLCF        WS2812_print_clock_current_byte_L0+0, 1 
	BCF         WS2812_print_clock_current_byte_L0+0, 0 
;ws2812.c,406 :: 		for (current_bit = 0; current_bit < 8; ++current_bit)
	INCF        WS2812_print_clock_current_bit_L0+0, 1 
;ws2812.c,424 :: 		}
	GOTO        L_WS2812_print_clock80
L_WS2812_print_clock81:
;ws2812.c,427 :: 		current_byte = pixels[panel_column].red;
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        WS2812_print_clock_panel_column_L0+0, 0 
	MOVWF       R4 
	MOVF        WS2812_print_clock_panel_column_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        WS2812_print_clock_pixels_L1+0, 0 
	ADDWF       R0, 1 
	MOVF        WS2812_print_clock_pixels_L1+1, 0 
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       WS2812_print_clock_current_byte_L0+0 
;ws2812.c,429 :: 		for (current_bit = 0; current_bit < 8; ++current_bit)
	CLRF        WS2812_print_clock_current_bit_L0+0 
L_WS2812_print_clock85:
	MOVLW       8
	SUBWF       WS2812_print_clock_current_bit_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_print_clock86
;ws2812.c,431 :: 		if (current_byte & 0x80)
	BTFSS       WS2812_print_clock_current_byte_L0+0, 7 
	GOTO        L_WS2812_print_clock88
;ws2812.c,433 :: 		PANEL_CLOCK_PORT = mask_enable;
	MOVF        WS2812_print_clock_mask_enable_L1+0, 0 
	MOVWF       LATJ+0 
;ws2812.c,435 :: 		WS2812_delay_long();
	CALL        _WS2812_delay_long+0, 0
;ws2812.c,437 :: 		PANEL_CLOCK_PORT = mask_disable;
	MOVF        WS2812_print_clock_mask_disable_L1+0, 0 
	MOVWF       LATJ+0 
;ws2812.c,438 :: 		}
	GOTO        L_WS2812_print_clock89
L_WS2812_print_clock88:
;ws2812.c,441 :: 		PANEL_CLOCK_PORT = mask_enable;
	MOVF        WS2812_print_clock_mask_enable_L1+0, 0 
	MOVWF       LATJ+0 
;ws2812.c,443 :: 		PANEL_CLOCK_PORT = mask_disable;
	MOVF        WS2812_print_clock_mask_disable_L1+0, 0 
	MOVWF       LATJ+0 
;ws2812.c,444 :: 		}
L_WS2812_print_clock89:
;ws2812.c,446 :: 		current_byte = current_byte << 1;
	RLCF        WS2812_print_clock_current_byte_L0+0, 1 
	BCF         WS2812_print_clock_current_byte_L0+0, 0 
;ws2812.c,429 :: 		for (current_bit = 0; current_bit < 8; ++current_bit)
	INCF        WS2812_print_clock_current_bit_L0+0, 1 
;ws2812.c,447 :: 		}
	GOTO        L_WS2812_print_clock85
L_WS2812_print_clock86:
;ws2812.c,450 :: 		current_byte = pixels[panel_column].blue;
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        WS2812_print_clock_panel_column_L0+0, 0 
	MOVWF       R4 
	MOVF        WS2812_print_clock_panel_column_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       WS2812_print_clock_pixels_L1+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      WS2812_print_clock_pixels_L1+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       WS2812_print_clock_current_byte_L0+0 
;ws2812.c,452 :: 		for (current_bit = 0; current_bit < 8; ++current_bit)
	CLRF        WS2812_print_clock_current_bit_L0+0 
L_WS2812_print_clock90:
	MOVLW       8
	SUBWF       WS2812_print_clock_current_bit_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_print_clock91
;ws2812.c,454 :: 		if (current_byte & 0x80)
	BTFSS       WS2812_print_clock_current_byte_L0+0, 7 
	GOTO        L_WS2812_print_clock93
;ws2812.c,456 :: 		PANEL_CLOCK_PORT = mask_enable;
	MOVF        WS2812_print_clock_mask_enable_L1+0, 0 
	MOVWF       LATJ+0 
;ws2812.c,458 :: 		WS2812_delay_long();
	CALL        _WS2812_delay_long+0, 0
;ws2812.c,460 :: 		PANEL_CLOCK_PORT = mask_disable;
	MOVF        WS2812_print_clock_mask_disable_L1+0, 0 
	MOVWF       LATJ+0 
;ws2812.c,461 :: 		}
	GOTO        L_WS2812_print_clock94
L_WS2812_print_clock93:
;ws2812.c,464 :: 		PANEL_CLOCK_PORT = mask_enable;
	MOVF        WS2812_print_clock_mask_enable_L1+0, 0 
	MOVWF       LATJ+0 
;ws2812.c,466 :: 		PANEL_CLOCK_PORT = mask_disable;
	MOVF        WS2812_print_clock_mask_disable_L1+0, 0 
	MOVWF       LATJ+0 
;ws2812.c,467 :: 		}
L_WS2812_print_clock94:
;ws2812.c,469 :: 		current_byte = current_byte << 1;
	RLCF        WS2812_print_clock_current_byte_L0+0, 1 
	BCF         WS2812_print_clock_current_byte_L0+0, 0 
;ws2812.c,452 :: 		for (current_bit = 0; current_bit < 8; ++current_bit)
	INCF        WS2812_print_clock_current_bit_L0+0, 1 
;ws2812.c,470 :: 		}
	GOTO        L_WS2812_print_clock90
L_WS2812_print_clock91:
;ws2812.c,401 :: 		for (panel_column = 0; panel_column < PANEL_CLOCK_WIDTH; ++panel_column)
	INFSNZ      WS2812_print_clock_panel_column_L0+0, 1 
	INCF        WS2812_print_clock_panel_column_L0+1, 1 
;ws2812.c,471 :: 		}
	GOTO        L_WS2812_print_clock77
L_WS2812_print_clock78:
;ws2812.c,474 :: 		Delay_us(50);
	MOVLW       2
	MOVWF       R12, 0
	MOVLW       8
	MOVWF       R13, 0
L_WS2812_print_clock95:
	DECFSZ      R13, 1, 1
	BRA         L_WS2812_print_clock95
	DECFSZ      R12, 1, 1
	BRA         L_WS2812_print_clock95
	NOP
;ws2812.c,391 :: 		for (panel_row = 0; panel_row < PANEL_CLOCK_HEIGHT; ++panel_row)
	INFSNZ      WS2812_print_clock_panel_row_L0+0, 1 
	INCF        WS2812_print_clock_panel_row_L0+1, 1 
;ws2812.c,475 :: 		}
	GOTO        L_WS2812_print_clock74
L_WS2812_print_clock75:
;ws2812.c,476 :: 		}
L_end_WS2812_print_clock:
	RETURN      0
; end of _WS2812_print_clock

_WS2812_print_currency_name:

;ws2812.c,479 :: 		void WS2812_print_currency_name()
;ws2812.c,482 :: 		unsigned int pixel_position = 0;
	CLRF        WS2812_print_currency_name_pixel_position_L0+0 
	CLRF        WS2812_print_currency_name_pixel_position_L0+1 
	CLRF        WS2812_print_currency_name_matrix_column_L0+0 
	CLRF        WS2812_print_currency_name_matrix_column_L0+1 
	CLRF        WS2812_print_currency_name_matrix_row_L0+0 
	CLRF        WS2812_print_currency_name_matrix_row_L0+1 
	CLRF        WS2812_print_currency_name_panel_column_L0+0 
	CLRF        WS2812_print_currency_name_panel_column_L0+1 
	CLRF        WS2812_print_currency_name_panel_row_L0+0 
	CLRF        WS2812_print_currency_name_panel_row_L0+1 
;ws2812.c,498 :: 		for (pixel_position = 0; pixel_position < PANEL_CURRENCY_NAME_WIDTH; pixel_position += MATRIX_WIDTH)
	CLRF        WS2812_print_currency_name_pixel_position_L0+0 
	CLRF        WS2812_print_currency_name_pixel_position_L0+1 
L_WS2812_print_currency_name96:
	MOVLW       0
	SUBWF       WS2812_print_currency_name_pixel_position_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_currency_name289
	MOVLW       15
	SUBWF       WS2812_print_currency_name_pixel_position_L0+0, 0 
L__WS2812_print_currency_name289:
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_print_currency_name97
;ws2812.c,500 :: 		for (matrix_row = 0; matrix_row < MATRIX_HEIGHT; ++matrix_row)
	CLRF        WS2812_print_currency_name_matrix_row_L0+0 
	CLRF        WS2812_print_currency_name_matrix_row_L0+1 
L_WS2812_print_currency_name99:
	MOVLW       0
	SUBWF       WS2812_print_currency_name_matrix_row_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_currency_name290
	MOVLW       7
	SUBWF       WS2812_print_currency_name_matrix_row_L0+0, 0 
L__WS2812_print_currency_name290:
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_print_currency_name100
;ws2812.c,502 :: 		unsigned char matrix_element = 0x00;
	CLRF        WS2812_print_currency_name_matrix_element_L2+0 
;ws2812.c,504 :: 		if ((pixel_position / MATRIX_WIDTH) == 0)
	MOVLW       5
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        WS2812_print_currency_name_pixel_position_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_print_currency_name_pixel_position_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_currency_name291
	MOVLW       0
	XORWF       R0, 0 
L__WS2812_print_currency_name291:
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_print_currency_name102
;ws2812.c,506 :: 		if ((current_panel_iteration % 2) == 0)
	MOVLW       1
	ANDWF       _current_panel_iteration+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_print_currency_name103
;ws2812.c,509 :: 		matrix_element = ALPHABET_LETTERS[('U' - 65) * MATRIX_HEIGHT + matrix_row];
	MOVLW       140
	ADDWF       WS2812_print_currency_name_matrix_row_L0+0, 0 
	MOVWF       R3 
	MOVLW       0
	ADDWFC      WS2812_print_currency_name_matrix_row_L0+1, 0 
	MOVWF       R4 
	MOVLW       _ALPHABET_LETTERS+0
	MOVWF       R0 
	MOVLW       hi_addr(_ALPHABET_LETTERS+0)
	MOVWF       R1 
	MOVLW       higher_addr(_ALPHABET_LETTERS+0)
	MOVWF       R2 
	MOVF        R3, 0 
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVF        R4, 0 
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, WS2812_print_currency_name_matrix_element_L2+0
;ws2812.c,510 :: 		}
	GOTO        L_WS2812_print_currency_name104
L_WS2812_print_currency_name103:
;ws2812.c,514 :: 		matrix_element = ALPHABET_LETTERS[('E' - 65) * MATRIX_HEIGHT + matrix_row];
	MOVLW       28
	ADDWF       WS2812_print_currency_name_matrix_row_L0+0, 0 
	MOVWF       R3 
	MOVLW       0
	ADDWFC      WS2812_print_currency_name_matrix_row_L0+1, 0 
	MOVWF       R4 
	MOVLW       _ALPHABET_LETTERS+0
	MOVWF       R0 
	MOVLW       hi_addr(_ALPHABET_LETTERS+0)
	MOVWF       R1 
	MOVLW       higher_addr(_ALPHABET_LETTERS+0)
	MOVWF       R2 
	MOVF        R3, 0 
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVF        R4, 0 
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, WS2812_print_currency_name_matrix_element_L2+0
;ws2812.c,515 :: 		}
L_WS2812_print_currency_name104:
;ws2812.c,516 :: 		}
L_WS2812_print_currency_name102:
;ws2812.c,518 :: 		if ((pixel_position / MATRIX_WIDTH) == 1)
	MOVLW       5
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        WS2812_print_currency_name_pixel_position_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_print_currency_name_pixel_position_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_currency_name292
	MOVLW       1
	XORWF       R0, 0 
L__WS2812_print_currency_name292:
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_print_currency_name105
;ws2812.c,520 :: 		if ((current_panel_iteration % 2) == 0)
	MOVLW       1
	ANDWF       _current_panel_iteration+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_print_currency_name106
;ws2812.c,523 :: 		matrix_element = ALPHABET_LETTERS[('S' - 65) * MATRIX_HEIGHT + matrix_row];
	MOVLW       126
	ADDWF       WS2812_print_currency_name_matrix_row_L0+0, 0 
	MOVWF       R3 
	MOVLW       0
	ADDWFC      WS2812_print_currency_name_matrix_row_L0+1, 0 
	MOVWF       R4 
	MOVLW       _ALPHABET_LETTERS+0
	MOVWF       R0 
	MOVLW       hi_addr(_ALPHABET_LETTERS+0)
	MOVWF       R1 
	MOVLW       higher_addr(_ALPHABET_LETTERS+0)
	MOVWF       R2 
	MOVF        R3, 0 
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVF        R4, 0 
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, WS2812_print_currency_name_matrix_element_L2+0
;ws2812.c,524 :: 		}
	GOTO        L_WS2812_print_currency_name107
L_WS2812_print_currency_name106:
;ws2812.c,528 :: 		matrix_element = ALPHABET_LETTERS[('U' - 65) * MATRIX_HEIGHT + matrix_row];
	MOVLW       140
	ADDWF       WS2812_print_currency_name_matrix_row_L0+0, 0 
	MOVWF       R3 
	MOVLW       0
	ADDWFC      WS2812_print_currency_name_matrix_row_L0+1, 0 
	MOVWF       R4 
	MOVLW       _ALPHABET_LETTERS+0
	MOVWF       R0 
	MOVLW       hi_addr(_ALPHABET_LETTERS+0)
	MOVWF       R1 
	MOVLW       higher_addr(_ALPHABET_LETTERS+0)
	MOVWF       R2 
	MOVF        R3, 0 
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVF        R4, 0 
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, WS2812_print_currency_name_matrix_element_L2+0
;ws2812.c,529 :: 		}
L_WS2812_print_currency_name107:
;ws2812.c,530 :: 		}
L_WS2812_print_currency_name105:
;ws2812.c,532 :: 		if ((pixel_position / MATRIX_WIDTH) == 2)
	MOVLW       5
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        WS2812_print_currency_name_pixel_position_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_print_currency_name_pixel_position_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_currency_name293
	MOVLW       2
	XORWF       R0, 0 
L__WS2812_print_currency_name293:
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_print_currency_name108
;ws2812.c,534 :: 		if ((current_panel_iteration % 2) == 0)
	MOVLW       1
	ANDWF       _current_panel_iteration+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_print_currency_name109
;ws2812.c,537 :: 		matrix_element = ALPHABET_LETTERS[('D' - 65) * MATRIX_HEIGHT + matrix_row];
	MOVLW       21
	ADDWF       WS2812_print_currency_name_matrix_row_L0+0, 0 
	MOVWF       R3 
	MOVLW       0
	ADDWFC      WS2812_print_currency_name_matrix_row_L0+1, 0 
	MOVWF       R4 
	MOVLW       _ALPHABET_LETTERS+0
	MOVWF       R0 
	MOVLW       hi_addr(_ALPHABET_LETTERS+0)
	MOVWF       R1 
	MOVLW       higher_addr(_ALPHABET_LETTERS+0)
	MOVWF       R2 
	MOVF        R3, 0 
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVF        R4, 0 
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, WS2812_print_currency_name_matrix_element_L2+0
;ws2812.c,538 :: 		}
	GOTO        L_WS2812_print_currency_name110
L_WS2812_print_currency_name109:
;ws2812.c,542 :: 		matrix_element = ALPHABET_LETTERS[('R' - 65) * MATRIX_HEIGHT + matrix_row];
	MOVLW       119
	ADDWF       WS2812_print_currency_name_matrix_row_L0+0, 0 
	MOVWF       R3 
	MOVLW       0
	ADDWFC      WS2812_print_currency_name_matrix_row_L0+1, 0 
	MOVWF       R4 
	MOVLW       _ALPHABET_LETTERS+0
	MOVWF       R0 
	MOVLW       hi_addr(_ALPHABET_LETTERS+0)
	MOVWF       R1 
	MOVLW       higher_addr(_ALPHABET_LETTERS+0)
	MOVWF       R2 
	MOVF        R3, 0 
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVF        R4, 0 
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, WS2812_print_currency_name_matrix_element_L2+0
;ws2812.c,543 :: 		}
L_WS2812_print_currency_name110:
;ws2812.c,544 :: 		}
L_WS2812_print_currency_name108:
;ws2812.c,546 :: 		for (matrix_column = 0; matrix_column < MATRIX_WIDTH; ++matrix_column)
	CLRF        WS2812_print_currency_name_matrix_column_L0+0 
	CLRF        WS2812_print_currency_name_matrix_column_L0+1 
L_WS2812_print_currency_name111:
	MOVLW       0
	SUBWF       WS2812_print_currency_name_matrix_column_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_currency_name294
	MOVLW       5
	SUBWF       WS2812_print_currency_name_matrix_column_L0+0, 0 
L__WS2812_print_currency_name294:
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_print_currency_name112
;ws2812.c,548 :: 		if (matrix_element & 0x80)
	BTFSS       WS2812_print_currency_name_matrix_element_L2+0, 7 
	GOTO        L_WS2812_print_currency_name114
;ws2812.c,550 :: 		panel_currency_name_pixels[matrix_row][pixel_position + matrix_column].red = current_text_color[0];
	MOVLW       45
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        WS2812_print_currency_name_matrix_row_L0+0, 0 
	MOVWF       R4 
	MOVF        WS2812_print_currency_name_matrix_row_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _panel_currency_name_pixels+0
	ADDWF       R0, 0 
	MOVWF       FLOC__WS2812_print_currency_name+0 
	MOVLW       hi_addr(_panel_currency_name_pixels+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__WS2812_print_currency_name+1 
	MOVF        WS2812_print_currency_name_matrix_column_L0+0, 0 
	ADDWF       WS2812_print_currency_name_pixel_position_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_print_currency_name_matrix_column_L0+1, 0 
	ADDWFC      WS2812_print_currency_name_pixel_position_L0+1, 0 
	MOVWF       R1 
	MOVLW       3
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        FLOC__WS2812_print_currency_name+0, 0 
	ADDWF       R0, 1 
	MOVF        FLOC__WS2812_print_currency_name+1, 0 
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        _current_text_color+0, 0 
	MOVWF       POSTINC1+0 
;ws2812.c,551 :: 		panel_currency_name_pixels[matrix_row][pixel_position + matrix_column].green = current_text_color[1];
	MOVLW       45
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        WS2812_print_currency_name_matrix_row_L0+0, 0 
	MOVWF       R4 
	MOVF        WS2812_print_currency_name_matrix_row_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _panel_currency_name_pixels+0
	ADDWF       R0, 0 
	MOVWF       FLOC__WS2812_print_currency_name+0 
	MOVLW       hi_addr(_panel_currency_name_pixels+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__WS2812_print_currency_name+1 
	MOVF        WS2812_print_currency_name_matrix_column_L0+0, 0 
	ADDWF       WS2812_print_currency_name_pixel_position_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_print_currency_name_matrix_column_L0+1, 0 
	ADDWFC      WS2812_print_currency_name_pixel_position_L0+1, 0 
	MOVWF       R1 
	MOVLW       3
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        FLOC__WS2812_print_currency_name+0, 0 
	ADDWF       R0, 1 
	MOVF        FLOC__WS2812_print_currency_name+1, 0 
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        _current_text_color+1, 0 
	MOVWF       POSTINC1+0 
;ws2812.c,552 :: 		panel_currency_name_pixels[matrix_row][pixel_position + matrix_column].blue = current_text_color[2];
	MOVLW       45
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        WS2812_print_currency_name_matrix_row_L0+0, 0 
	MOVWF       R4 
	MOVF        WS2812_print_currency_name_matrix_row_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _panel_currency_name_pixels+0
	ADDWF       R0, 0 
	MOVWF       FLOC__WS2812_print_currency_name+0 
	MOVLW       hi_addr(_panel_currency_name_pixels+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__WS2812_print_currency_name+1 
	MOVF        WS2812_print_currency_name_matrix_column_L0+0, 0 
	ADDWF       WS2812_print_currency_name_pixel_position_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_print_currency_name_matrix_column_L0+1, 0 
	ADDWFC      WS2812_print_currency_name_pixel_position_L0+1, 0 
	MOVWF       R1 
	MOVLW       3
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__WS2812_print_currency_name+0, 0 
	MOVWF       FSR1 
	MOVF        R1, 0 
	ADDWFC      FLOC__WS2812_print_currency_name+1, 0 
	MOVWF       FSR1H 
	MOVF        _current_text_color+2, 0 
	MOVWF       POSTINC1+0 
;ws2812.c,553 :: 		}
	GOTO        L_WS2812_print_currency_name115
L_WS2812_print_currency_name114:
;ws2812.c,556 :: 		panel_currency_name_pixels[matrix_row][pixel_position + matrix_column].red = current_background_color[0];
	MOVLW       45
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        WS2812_print_currency_name_matrix_row_L0+0, 0 
	MOVWF       R4 
	MOVF        WS2812_print_currency_name_matrix_row_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _panel_currency_name_pixels+0
	ADDWF       R0, 0 
	MOVWF       FLOC__WS2812_print_currency_name+0 
	MOVLW       hi_addr(_panel_currency_name_pixels+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__WS2812_print_currency_name+1 
	MOVF        WS2812_print_currency_name_matrix_column_L0+0, 0 
	ADDWF       WS2812_print_currency_name_pixel_position_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_print_currency_name_matrix_column_L0+1, 0 
	ADDWFC      WS2812_print_currency_name_pixel_position_L0+1, 0 
	MOVWF       R1 
	MOVLW       3
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        FLOC__WS2812_print_currency_name+0, 0 
	ADDWF       R0, 1 
	MOVF        FLOC__WS2812_print_currency_name+1, 0 
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        _current_background_color+0, 0 
	MOVWF       POSTINC1+0 
;ws2812.c,557 :: 		panel_currency_name_pixels[matrix_row][pixel_position + matrix_column].green = current_background_color[1];
	MOVLW       45
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        WS2812_print_currency_name_matrix_row_L0+0, 0 
	MOVWF       R4 
	MOVF        WS2812_print_currency_name_matrix_row_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _panel_currency_name_pixels+0
	ADDWF       R0, 0 
	MOVWF       FLOC__WS2812_print_currency_name+0 
	MOVLW       hi_addr(_panel_currency_name_pixels+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__WS2812_print_currency_name+1 
	MOVF        WS2812_print_currency_name_matrix_column_L0+0, 0 
	ADDWF       WS2812_print_currency_name_pixel_position_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_print_currency_name_matrix_column_L0+1, 0 
	ADDWFC      WS2812_print_currency_name_pixel_position_L0+1, 0 
	MOVWF       R1 
	MOVLW       3
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        FLOC__WS2812_print_currency_name+0, 0 
	ADDWF       R0, 1 
	MOVF        FLOC__WS2812_print_currency_name+1, 0 
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        _current_background_color+1, 0 
	MOVWF       POSTINC1+0 
;ws2812.c,558 :: 		panel_currency_name_pixels[matrix_row][pixel_position + matrix_column].blue = current_background_color[2];
	MOVLW       45
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        WS2812_print_currency_name_matrix_row_L0+0, 0 
	MOVWF       R4 
	MOVF        WS2812_print_currency_name_matrix_row_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _panel_currency_name_pixels+0
	ADDWF       R0, 0 
	MOVWF       FLOC__WS2812_print_currency_name+0 
	MOVLW       hi_addr(_panel_currency_name_pixels+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__WS2812_print_currency_name+1 
	MOVF        WS2812_print_currency_name_matrix_column_L0+0, 0 
	ADDWF       WS2812_print_currency_name_pixel_position_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_print_currency_name_matrix_column_L0+1, 0 
	ADDWFC      WS2812_print_currency_name_pixel_position_L0+1, 0 
	MOVWF       R1 
	MOVLW       3
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__WS2812_print_currency_name+0, 0 
	MOVWF       FSR1 
	MOVF        R1, 0 
	ADDWFC      FLOC__WS2812_print_currency_name+1, 0 
	MOVWF       FSR1H 
	MOVF        _current_background_color+2, 0 
	MOVWF       POSTINC1+0 
;ws2812.c,559 :: 		}
L_WS2812_print_currency_name115:
;ws2812.c,561 :: 		matrix_element = matrix_element << 1;
	RLCF        WS2812_print_currency_name_matrix_element_L2+0, 1 
	BCF         WS2812_print_currency_name_matrix_element_L2+0, 0 
;ws2812.c,546 :: 		for (matrix_column = 0; matrix_column < MATRIX_WIDTH; ++matrix_column)
	INFSNZ      WS2812_print_currency_name_matrix_column_L0+0, 1 
	INCF        WS2812_print_currency_name_matrix_column_L0+1, 1 
;ws2812.c,562 :: 		}
	GOTO        L_WS2812_print_currency_name111
L_WS2812_print_currency_name112:
;ws2812.c,500 :: 		for (matrix_row = 0; matrix_row < MATRIX_HEIGHT; ++matrix_row)
	INFSNZ      WS2812_print_currency_name_matrix_row_L0+0, 1 
	INCF        WS2812_print_currency_name_matrix_row_L0+1, 1 
;ws2812.c,563 :: 		}
	GOTO        L_WS2812_print_currency_name99
L_WS2812_print_currency_name100:
;ws2812.c,498 :: 		for (pixel_position = 0; pixel_position < PANEL_CURRENCY_NAME_WIDTH; pixel_position += MATRIX_WIDTH)
	MOVLW       5
	ADDWF       WS2812_print_currency_name_pixel_position_L0+0, 1 
	MOVLW       0
	ADDWFC      WS2812_print_currency_name_pixel_position_L0+1, 1 
;ws2812.c,564 :: 		}
	GOTO        L_WS2812_print_currency_name96
L_WS2812_print_currency_name97:
;ws2812.c,566 :: 		for (panel_row = 0; panel_row < PANEL_CURRENCY_NAME_HEIGHT; ++panel_row)
	CLRF        WS2812_print_currency_name_panel_row_L0+0 
	CLRF        WS2812_print_currency_name_panel_row_L0+1 
L_WS2812_print_currency_name116:
	MOVLW       0
	SUBWF       WS2812_print_currency_name_panel_row_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_currency_name295
	MOVLW       7
	SUBWF       WS2812_print_currency_name_panel_row_L0+0, 0 
L__WS2812_print_currency_name295:
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_print_currency_name117
;ws2812.c,569 :: 		unsigned char mask_enable = PANEL_CURRENCY_NAME_PORT | (0x01 << panel_row);
	MOVF        WS2812_print_currency_name_panel_row_L0+0, 0 
	MOVWF       R0 
	MOVLW       1
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R0, 0 
L__WS2812_print_currency_name296:
	BZ          L__WS2812_print_currency_name297
	RLCF        R2, 1 
	BCF         R2, 0 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__WS2812_print_currency_name296
L__WS2812_print_currency_name297:
	MOVF        R2, 0 
	IORWF       LATE+0, 0 
	MOVWF       R0 
	MOVLW       0
	IORWF       R3, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       WS2812_print_currency_name_mask_enable_L1+0 
;ws2812.c,571 :: 		unsigned char mask_disable = PANEL_CURRENCY_NAME_PORT & ~(0x01 << panel_row);
	COMF        R2, 0 
	MOVWF       R0 
	COMF        R3, 0 
	MOVWF       R1 
	MOVF        LATE+0, 0 
	ANDWF       R0, 1 
	MOVLW       0
	ANDWF       R1, 1 
	MOVF        R0, 0 
	MOVWF       WS2812_print_currency_name_mask_disable_L1+0 
;ws2812.c,574 :: 		PixelParameter* pixels = panel_currency_name_pixels[panel_row];
	MOVLW       45
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        WS2812_print_currency_name_panel_row_L0+0, 0 
	MOVWF       R4 
	MOVF        WS2812_print_currency_name_panel_row_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _panel_currency_name_pixels+0
	ADDWF       R0, 0 
	MOVWF       WS2812_print_currency_name_pixels_L1+0 
	MOVLW       hi_addr(_panel_currency_name_pixels+0)
	ADDWFC      R1, 0 
	MOVWF       WS2812_print_currency_name_pixels_L1+1 
;ws2812.c,576 :: 		for (panel_column = 0; panel_column < PANEL_CLOCK_WIDTH; ++panel_column)
	CLRF        WS2812_print_currency_name_panel_column_L0+0 
	CLRF        WS2812_print_currency_name_panel_column_L0+1 
L_WS2812_print_currency_name119:
	MOVLW       0
	SUBWF       WS2812_print_currency_name_panel_column_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_currency_name298
	MOVLW       30
	SUBWF       WS2812_print_currency_name_panel_column_L0+0, 0 
L__WS2812_print_currency_name298:
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_print_currency_name120
;ws2812.c,579 :: 		current_byte = pixels[panel_column].green;
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        WS2812_print_currency_name_panel_column_L0+0, 0 
	MOVWF       R4 
	MOVF        WS2812_print_currency_name_panel_column_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        WS2812_print_currency_name_pixels_L1+0, 0 
	ADDWF       R0, 1 
	MOVF        WS2812_print_currency_name_pixels_L1+1, 0 
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       WS2812_print_currency_name_current_byte_L0+0 
;ws2812.c,581 :: 		for (current_bit = 0; current_bit < 8; ++current_bit)
	CLRF        WS2812_print_currency_name_current_bit_L0+0 
L_WS2812_print_currency_name122:
	MOVLW       8
	SUBWF       WS2812_print_currency_name_current_bit_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_print_currency_name123
;ws2812.c,583 :: 		if (current_byte & 0x80)
	BTFSS       WS2812_print_currency_name_current_byte_L0+0, 7 
	GOTO        L_WS2812_print_currency_name125
;ws2812.c,585 :: 		PANEL_CURRENCY_NAME_PORT = mask_enable;
	MOVF        WS2812_print_currency_name_mask_enable_L1+0, 0 
	MOVWF       LATE+0 
;ws2812.c,587 :: 		WS2812_delay_long();
	CALL        _WS2812_delay_long+0, 0
;ws2812.c,589 :: 		PANEL_CURRENCY_NAME_PORT = mask_disable;
	MOVF        WS2812_print_currency_name_mask_disable_L1+0, 0 
	MOVWF       LATE+0 
;ws2812.c,590 :: 		}
	GOTO        L_WS2812_print_currency_name126
L_WS2812_print_currency_name125:
;ws2812.c,593 :: 		PANEL_CURRENCY_NAME_PORT = mask_enable;
	MOVF        WS2812_print_currency_name_mask_enable_L1+0, 0 
	MOVWF       LATE+0 
;ws2812.c,595 :: 		PANEL_CURRENCY_NAME_PORT = mask_disable;
	MOVF        WS2812_print_currency_name_mask_disable_L1+0, 0 
	MOVWF       LATE+0 
;ws2812.c,596 :: 		}
L_WS2812_print_currency_name126:
;ws2812.c,598 :: 		current_byte = current_byte << 1;
	RLCF        WS2812_print_currency_name_current_byte_L0+0, 1 
	BCF         WS2812_print_currency_name_current_byte_L0+0, 0 
;ws2812.c,581 :: 		for (current_bit = 0; current_bit < 8; ++current_bit)
	INCF        WS2812_print_currency_name_current_bit_L0+0, 1 
;ws2812.c,599 :: 		}
	GOTO        L_WS2812_print_currency_name122
L_WS2812_print_currency_name123:
;ws2812.c,602 :: 		current_byte = pixels[panel_column].red;
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        WS2812_print_currency_name_panel_column_L0+0, 0 
	MOVWF       R4 
	MOVF        WS2812_print_currency_name_panel_column_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        WS2812_print_currency_name_pixels_L1+0, 0 
	ADDWF       R0, 1 
	MOVF        WS2812_print_currency_name_pixels_L1+1, 0 
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       WS2812_print_currency_name_current_byte_L0+0 
;ws2812.c,604 :: 		for (current_bit = 0; current_bit < 8; ++current_bit)
	CLRF        WS2812_print_currency_name_current_bit_L0+0 
L_WS2812_print_currency_name127:
	MOVLW       8
	SUBWF       WS2812_print_currency_name_current_bit_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_print_currency_name128
;ws2812.c,606 :: 		if (current_byte & 0x80)
	BTFSS       WS2812_print_currency_name_current_byte_L0+0, 7 
	GOTO        L_WS2812_print_currency_name130
;ws2812.c,608 :: 		PANEL_CURRENCY_NAME_PORT = mask_enable;
	MOVF        WS2812_print_currency_name_mask_enable_L1+0, 0 
	MOVWF       LATE+0 
;ws2812.c,610 :: 		WS2812_delay_long();
	CALL        _WS2812_delay_long+0, 0
;ws2812.c,612 :: 		PANEL_CURRENCY_NAME_PORT = mask_disable;
	MOVF        WS2812_print_currency_name_mask_disable_L1+0, 0 
	MOVWF       LATE+0 
;ws2812.c,613 :: 		}
	GOTO        L_WS2812_print_currency_name131
L_WS2812_print_currency_name130:
;ws2812.c,616 :: 		PANEL_CURRENCY_NAME_PORT = mask_enable;
	MOVF        WS2812_print_currency_name_mask_enable_L1+0, 0 
	MOVWF       LATE+0 
;ws2812.c,618 :: 		PANEL_CURRENCY_NAME_PORT = mask_disable;
	MOVF        WS2812_print_currency_name_mask_disable_L1+0, 0 
	MOVWF       LATE+0 
;ws2812.c,619 :: 		}
L_WS2812_print_currency_name131:
;ws2812.c,621 :: 		current_byte = current_byte << 1;
	RLCF        WS2812_print_currency_name_current_byte_L0+0, 1 
	BCF         WS2812_print_currency_name_current_byte_L0+0, 0 
;ws2812.c,604 :: 		for (current_bit = 0; current_bit < 8; ++current_bit)
	INCF        WS2812_print_currency_name_current_bit_L0+0, 1 
;ws2812.c,622 :: 		}
	GOTO        L_WS2812_print_currency_name127
L_WS2812_print_currency_name128:
;ws2812.c,625 :: 		current_byte = pixels[panel_column].blue;
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        WS2812_print_currency_name_panel_column_L0+0, 0 
	MOVWF       R4 
	MOVF        WS2812_print_currency_name_panel_column_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       WS2812_print_currency_name_pixels_L1+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      WS2812_print_currency_name_pixels_L1+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       WS2812_print_currency_name_current_byte_L0+0 
;ws2812.c,627 :: 		for (current_bit = 0; current_bit < 8; ++current_bit)
	CLRF        WS2812_print_currency_name_current_bit_L0+0 
L_WS2812_print_currency_name132:
	MOVLW       8
	SUBWF       WS2812_print_currency_name_current_bit_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_print_currency_name133
;ws2812.c,629 :: 		if (current_byte & 0x80)
	BTFSS       WS2812_print_currency_name_current_byte_L0+0, 7 
	GOTO        L_WS2812_print_currency_name135
;ws2812.c,631 :: 		PANEL_CURRENCY_NAME_PORT = mask_enable;
	MOVF        WS2812_print_currency_name_mask_enable_L1+0, 0 
	MOVWF       LATE+0 
;ws2812.c,633 :: 		WS2812_delay_long();
	CALL        _WS2812_delay_long+0, 0
;ws2812.c,635 :: 		PANEL_CURRENCY_NAME_PORT = mask_disable;
	MOVF        WS2812_print_currency_name_mask_disable_L1+0, 0 
	MOVWF       LATE+0 
;ws2812.c,636 :: 		}
	GOTO        L_WS2812_print_currency_name136
L_WS2812_print_currency_name135:
;ws2812.c,639 :: 		PANEL_CURRENCY_NAME_PORT = mask_enable;
	MOVF        WS2812_print_currency_name_mask_enable_L1+0, 0 
	MOVWF       LATE+0 
;ws2812.c,641 :: 		PANEL_CURRENCY_NAME_PORT = mask_disable;
	MOVF        WS2812_print_currency_name_mask_disable_L1+0, 0 
	MOVWF       LATE+0 
;ws2812.c,642 :: 		}
L_WS2812_print_currency_name136:
;ws2812.c,644 :: 		current_byte = current_byte << 1;
	RLCF        WS2812_print_currency_name_current_byte_L0+0, 1 
	BCF         WS2812_print_currency_name_current_byte_L0+0, 0 
;ws2812.c,627 :: 		for (current_bit = 0; current_bit < 8; ++current_bit)
	INCF        WS2812_print_currency_name_current_bit_L0+0, 1 
;ws2812.c,645 :: 		}
	GOTO        L_WS2812_print_currency_name132
L_WS2812_print_currency_name133:
;ws2812.c,576 :: 		for (panel_column = 0; panel_column < PANEL_CLOCK_WIDTH; ++panel_column)
	INFSNZ      WS2812_print_currency_name_panel_column_L0+0, 1 
	INCF        WS2812_print_currency_name_panel_column_L0+1, 1 
;ws2812.c,646 :: 		}
	GOTO        L_WS2812_print_currency_name119
L_WS2812_print_currency_name120:
;ws2812.c,649 :: 		Delay_us(50);
	MOVLW       2
	MOVWF       R12, 0
	MOVLW       8
	MOVWF       R13, 0
L_WS2812_print_currency_name137:
	DECFSZ      R13, 1, 1
	BRA         L_WS2812_print_currency_name137
	DECFSZ      R12, 1, 1
	BRA         L_WS2812_print_currency_name137
	NOP
;ws2812.c,566 :: 		for (panel_row = 0; panel_row < PANEL_CURRENCY_NAME_HEIGHT; ++panel_row)
	INFSNZ      WS2812_print_currency_name_panel_row_L0+0, 1 
	INCF        WS2812_print_currency_name_panel_row_L0+1, 1 
;ws2812.c,650 :: 		}
	GOTO        L_WS2812_print_currency_name116
L_WS2812_print_currency_name117:
;ws2812.c,651 :: 		}
L_end_WS2812_print_currency_name:
	RETURN      0
; end of _WS2812_print_currency_name

_WS2812_print_currency_value_buy:

;ws2812.c,654 :: 		void WS2812_print_currency_value_buy()
;ws2812.c,657 :: 		unsigned int pixel_position = 0;
	CLRF        WS2812_print_currency_value_buy_pixel_position_L0+0 
	CLRF        WS2812_print_currency_value_buy_pixel_position_L0+1 
	CLRF        WS2812_print_currency_value_buy_matrix_column_L0+0 
	CLRF        WS2812_print_currency_value_buy_matrix_column_L0+1 
	CLRF        WS2812_print_currency_value_buy_matrix_row_L0+0 
	CLRF        WS2812_print_currency_value_buy_matrix_row_L0+1 
	CLRF        WS2812_print_currency_value_buy_panel_column_L0+0 
	CLRF        WS2812_print_currency_value_buy_panel_column_L0+1 
	CLRF        WS2812_print_currency_value_buy_panel_row_L0+0 
	CLRF        WS2812_print_currency_value_buy_panel_row_L0+1 
;ws2812.c,676 :: 		for (pixel_position = 0; pixel_position < PANEL_CURRENCY_VALUE_BUY_WIDTH; pixel_position += MATRIX_WIDTH)
	CLRF        WS2812_print_currency_value_buy_pixel_position_L0+0 
	CLRF        WS2812_print_currency_value_buy_pixel_position_L0+1 
L_WS2812_print_currency_value_buy138:
	MOVLW       0
	SUBWF       WS2812_print_currency_value_buy_pixel_position_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_currency_value_buy300
	MOVLW       20
	SUBWF       WS2812_print_currency_value_buy_pixel_position_L0+0, 0 
L__WS2812_print_currency_value_buy300:
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_print_currency_value_buy139
;ws2812.c,678 :: 		for (matrix_row = 0; matrix_row < MATRIX_HEIGHT; ++matrix_row)
	CLRF        WS2812_print_currency_value_buy_matrix_row_L0+0 
	CLRF        WS2812_print_currency_value_buy_matrix_row_L0+1 
L_WS2812_print_currency_value_buy141:
	MOVLW       0
	SUBWF       WS2812_print_currency_value_buy_matrix_row_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_currency_value_buy301
	MOVLW       7
	SUBWF       WS2812_print_currency_value_buy_matrix_row_L0+0, 0 
L__WS2812_print_currency_value_buy301:
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_print_currency_value_buy142
;ws2812.c,680 :: 		unsigned char matrix_element = 0x00;
	CLRF        WS2812_print_currency_value_buy_matrix_element_L2+0 
;ws2812.c,682 :: 		if ((pixel_position / MATRIX_WIDTH) == 0)
	MOVLW       5
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        WS2812_print_currency_value_buy_pixel_position_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_print_currency_value_buy_pixel_position_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_currency_value_buy302
	MOVLW       0
	XORWF       R0, 0 
L__WS2812_print_currency_value_buy302:
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_print_currency_value_buy144
;ws2812.c,684 :: 		char symbol_code = 0; char* simplified_number;
	CLRF        WS2812_print_currency_value_buy_symbol_code_L3+0 
;ws2812.c,686 :: 		if ((current_panel_iteration % 2) == 0)
	MOVLW       1
	ANDWF       _current_panel_iteration+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_print_currency_value_buy145
;ws2812.c,688 :: 		IntToStr(currentRequest.usd_buy[0], current_number); simplified_number = Ltrim(current_number);
	MOVF        _currentRequest+8, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _currentRequest+9, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       WS2812_print_currency_value_buy_current_number_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(WS2812_print_currency_value_buy_current_number_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
	MOVLW       WS2812_print_currency_value_buy_current_number_L0+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(WS2812_print_currency_value_buy_current_number_L0+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
	MOVF        R0, 0 
	MOVWF       WS2812_print_currency_value_buy_simplified_number_L3+0 
	MOVF        R1, 0 
	MOVWF       WS2812_print_currency_value_buy_simplified_number_L3+1 
;ws2812.c,689 :: 		}
	GOTO        L_WS2812_print_currency_value_buy146
L_WS2812_print_currency_value_buy145:
;ws2812.c,692 :: 		IntToStr(currentRequest.eur_buy[0], current_number); simplified_number = Ltrim(current_number);
	MOVF        _currentRequest+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _currentRequest+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       WS2812_print_currency_value_buy_current_number_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(WS2812_print_currency_value_buy_current_number_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
	MOVLW       WS2812_print_currency_value_buy_current_number_L0+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(WS2812_print_currency_value_buy_current_number_L0+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
	MOVF        R0, 0 
	MOVWF       WS2812_print_currency_value_buy_simplified_number_L3+0 
	MOVF        R1, 0 
	MOVWF       WS2812_print_currency_value_buy_simplified_number_L3+1 
;ws2812.c,693 :: 		}
L_WS2812_print_currency_value_buy146:
;ws2812.c,695 :: 		if (strlen(simplified_number) > 1)
	MOVF        WS2812_print_currency_value_buy_simplified_number_L3+0, 0 
	MOVWF       FARG_strlen_s+0 
	MOVF        WS2812_print_currency_value_buy_simplified_number_L3+1, 0 
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVLW       128
	MOVWF       R2 
	MOVLW       128
	XORWF       R1, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_currency_value_buy303
	MOVF        R0, 0 
	SUBLW       1
L__WS2812_print_currency_value_buy303:
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_print_currency_value_buy147
;ws2812.c,697 :: 		symbol_code = simplified_number[0] - 48;
	MOVFF       WS2812_print_currency_value_buy_simplified_number_L3+0, FSR0
	MOVFF       WS2812_print_currency_value_buy_simplified_number_L3+1, FSR0H
	MOVLW       48
	SUBWF       POSTINC0+0, 0 
	MOVWF       WS2812_print_currency_value_buy_symbol_code_L3+0 
;ws2812.c,698 :: 		}
L_WS2812_print_currency_value_buy147:
;ws2812.c,700 :: 		matrix_element = ALPHABET_NUMBERS[symbol_code * MATRIX_HEIGHT + matrix_row];
	MOVLW       7
	MULWF       WS2812_print_currency_value_buy_symbol_code_L3+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVF        WS2812_print_currency_value_buy_matrix_row_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       R3 
	MOVF        WS2812_print_currency_value_buy_matrix_row_L0+1, 0 
	ADDWFC      R1, 0 
	MOVWF       R4 
	MOVLW       _ALPHABET_NUMBERS+0
	MOVWF       R0 
	MOVLW       hi_addr(_ALPHABET_NUMBERS+0)
	MOVWF       R1 
	MOVLW       higher_addr(_ALPHABET_NUMBERS+0)
	MOVWF       R2 
	MOVF        R3, 0 
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVF        R4, 0 
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, WS2812_print_currency_value_buy_matrix_element_L2+0
;ws2812.c,701 :: 		}
L_WS2812_print_currency_value_buy144:
;ws2812.c,703 :: 		if ((pixel_position / MATRIX_WIDTH) == 1)
	MOVLW       5
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        WS2812_print_currency_value_buy_pixel_position_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_print_currency_value_buy_pixel_position_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_currency_value_buy304
	MOVLW       1
	XORWF       R0, 0 
L__WS2812_print_currency_value_buy304:
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_print_currency_value_buy148
;ws2812.c,705 :: 		char symbol_code = 0; char* simplified_number;
	CLRF        WS2812_print_currency_value_buy_symbol_code_L3_L3+0 
;ws2812.c,707 :: 		if ((current_panel_iteration % 2) == 0)
	MOVLW       1
	ANDWF       _current_panel_iteration+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_print_currency_value_buy149
;ws2812.c,709 :: 		IntToStr(currentRequest.usd_buy[0], current_number); simplified_number = Ltrim(current_number);
	MOVF        _currentRequest+8, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _currentRequest+9, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       WS2812_print_currency_value_buy_current_number_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(WS2812_print_currency_value_buy_current_number_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
	MOVLW       WS2812_print_currency_value_buy_current_number_L0+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(WS2812_print_currency_value_buy_current_number_L0+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
	MOVF        R0, 0 
	MOVWF       WS2812_print_currency_value_buy_simplified_number_L3_L3+0 
	MOVF        R1, 0 
	MOVWF       WS2812_print_currency_value_buy_simplified_number_L3_L3+1 
;ws2812.c,710 :: 		}
	GOTO        L_WS2812_print_currency_value_buy150
L_WS2812_print_currency_value_buy149:
;ws2812.c,713 :: 		IntToStr(currentRequest.eur_buy[0], current_number); simplified_number = Ltrim(current_number);
	MOVF        _currentRequest+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _currentRequest+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       WS2812_print_currency_value_buy_current_number_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(WS2812_print_currency_value_buy_current_number_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
	MOVLW       WS2812_print_currency_value_buy_current_number_L0+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(WS2812_print_currency_value_buy_current_number_L0+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
	MOVF        R0, 0 
	MOVWF       WS2812_print_currency_value_buy_simplified_number_L3_L3+0 
	MOVF        R1, 0 
	MOVWF       WS2812_print_currency_value_buy_simplified_number_L3_L3+1 
;ws2812.c,714 :: 		}
L_WS2812_print_currency_value_buy150:
;ws2812.c,716 :: 		if (strlen(simplified_number) == 2)
	MOVF        WS2812_print_currency_value_buy_simplified_number_L3_L3+0, 0 
	MOVWF       FARG_strlen_s+0 
	MOVF        WS2812_print_currency_value_buy_simplified_number_L3_L3+1, 0 
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_currency_value_buy305
	MOVLW       2
	XORWF       R0, 0 
L__WS2812_print_currency_value_buy305:
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_print_currency_value_buy151
;ws2812.c,718 :: 		symbol_code = simplified_number[0] - 48;
	MOVFF       WS2812_print_currency_value_buy_simplified_number_L3_L3+0, FSR0
	MOVFF       WS2812_print_currency_value_buy_simplified_number_L3_L3+1, FSR0H
	MOVLW       48
	SUBWF       POSTINC0+0, 0 
	MOVWF       WS2812_print_currency_value_buy_symbol_code_L3_L3+0 
;ws2812.c,719 :: 		}
L_WS2812_print_currency_value_buy151:
;ws2812.c,721 :: 		if (strlen(simplified_number) == 2)
	MOVF        WS2812_print_currency_value_buy_simplified_number_L3_L3+0, 0 
	MOVWF       FARG_strlen_s+0 
	MOVF        WS2812_print_currency_value_buy_simplified_number_L3_L3+1, 0 
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_currency_value_buy306
	MOVLW       2
	XORWF       R0, 0 
L__WS2812_print_currency_value_buy306:
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_print_currency_value_buy152
;ws2812.c,723 :: 		symbol_code = simplified_number[1] - 48;
	MOVLW       1
	ADDWF       WS2812_print_currency_value_buy_simplified_number_L3_L3+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      WS2812_print_currency_value_buy_simplified_number_L3_L3+1, 0 
	MOVWF       FSR0H 
	MOVLW       48
	SUBWF       POSTINC0+0, 0 
	MOVWF       WS2812_print_currency_value_buy_symbol_code_L3_L3+0 
;ws2812.c,724 :: 		}
L_WS2812_print_currency_value_buy152:
;ws2812.c,726 :: 		matrix_element = ALPHABET_NUMBERS[symbol_code * MATRIX_HEIGHT + matrix_row];
	MOVLW       7
	MULWF       WS2812_print_currency_value_buy_symbol_code_L3_L3+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVF        WS2812_print_currency_value_buy_matrix_row_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       R3 
	MOVF        WS2812_print_currency_value_buy_matrix_row_L0+1, 0 
	ADDWFC      R1, 0 
	MOVWF       R4 
	MOVLW       _ALPHABET_NUMBERS+0
	MOVWF       R0 
	MOVLW       hi_addr(_ALPHABET_NUMBERS+0)
	MOVWF       R1 
	MOVLW       higher_addr(_ALPHABET_NUMBERS+0)
	MOVWF       R2 
	MOVF        R3, 0 
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVF        R4, 0 
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, WS2812_print_currency_value_buy_matrix_element_L2+0
;ws2812.c,727 :: 		}
L_WS2812_print_currency_value_buy148:
;ws2812.c,729 :: 		if ((pixel_position / MATRIX_WIDTH) == 2)
	MOVLW       5
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        WS2812_print_currency_value_buy_pixel_position_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_print_currency_value_buy_pixel_position_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_currency_value_buy307
	MOVLW       2
	XORWF       R0, 0 
L__WS2812_print_currency_value_buy307:
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_print_currency_value_buy153
;ws2812.c,731 :: 		char symbol_code = 0; char* simplified_number;
	CLRF        WS2812_print_currency_value_buy_symbol_code_L3_L3_L3+0 
;ws2812.c,733 :: 		if ((current_panel_iteration % 2) == 0)
	MOVLW       1
	ANDWF       _current_panel_iteration+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_print_currency_value_buy154
;ws2812.c,735 :: 		IntToStr(currentRequest.usd_buy[1], current_number); simplified_number = Ltrim(current_number);
	MOVF        _currentRequest+10, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _currentRequest+11, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       WS2812_print_currency_value_buy_current_number_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(WS2812_print_currency_value_buy_current_number_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
	MOVLW       WS2812_print_currency_value_buy_current_number_L0+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(WS2812_print_currency_value_buy_current_number_L0+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
	MOVF        R0, 0 
	MOVWF       WS2812_print_currency_value_buy_simplified_number_L3_L3_L3+0 
	MOVF        R1, 0 
	MOVWF       WS2812_print_currency_value_buy_simplified_number_L3_L3_L3+1 
;ws2812.c,736 :: 		}
	GOTO        L_WS2812_print_currency_value_buy155
L_WS2812_print_currency_value_buy154:
;ws2812.c,739 :: 		IntToStr(currentRequest.eur_buy[1], current_number); simplified_number = Ltrim(current_number);
	MOVF        _currentRequest+2, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _currentRequest+3, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       WS2812_print_currency_value_buy_current_number_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(WS2812_print_currency_value_buy_current_number_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
	MOVLW       WS2812_print_currency_value_buy_current_number_L0+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(WS2812_print_currency_value_buy_current_number_L0+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
	MOVF        R0, 0 
	MOVWF       WS2812_print_currency_value_buy_simplified_number_L3_L3_L3+0 
	MOVF        R1, 0 
	MOVWF       WS2812_print_currency_value_buy_simplified_number_L3_L3_L3+1 
;ws2812.c,740 :: 		}
L_WS2812_print_currency_value_buy155:
;ws2812.c,742 :: 		if (strlen(simplified_number) > 1)
	MOVF        WS2812_print_currency_value_buy_simplified_number_L3_L3_L3+0, 0 
	MOVWF       FARG_strlen_s+0 
	MOVF        WS2812_print_currency_value_buy_simplified_number_L3_L3_L3+1, 0 
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVLW       128
	MOVWF       R2 
	MOVLW       128
	XORWF       R1, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_currency_value_buy308
	MOVF        R0, 0 
	SUBLW       1
L__WS2812_print_currency_value_buy308:
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_print_currency_value_buy156
;ws2812.c,744 :: 		symbol_code = simplified_number[0] - 48;
	MOVFF       WS2812_print_currency_value_buy_simplified_number_L3_L3_L3+0, FSR0
	MOVFF       WS2812_print_currency_value_buy_simplified_number_L3_L3_L3+1, FSR0H
	MOVLW       48
	SUBWF       POSTINC0+0, 0 
	MOVWF       WS2812_print_currency_value_buy_symbol_code_L3_L3_L3+0 
;ws2812.c,745 :: 		}
L_WS2812_print_currency_value_buy156:
;ws2812.c,747 :: 		matrix_element = ALPHABET_NUMBERS[symbol_code * MATRIX_HEIGHT + matrix_row];
	MOVLW       7
	MULWF       WS2812_print_currency_value_buy_symbol_code_L3_L3_L3+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVF        WS2812_print_currency_value_buy_matrix_row_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       R3 
	MOVF        WS2812_print_currency_value_buy_matrix_row_L0+1, 0 
	ADDWFC      R1, 0 
	MOVWF       R4 
	MOVLW       _ALPHABET_NUMBERS+0
	MOVWF       R0 
	MOVLW       hi_addr(_ALPHABET_NUMBERS+0)
	MOVWF       R1 
	MOVLW       higher_addr(_ALPHABET_NUMBERS+0)
	MOVWF       R2 
	MOVF        R3, 0 
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVF        R4, 0 
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, WS2812_print_currency_value_buy_matrix_element_L2+0
;ws2812.c,748 :: 		}
L_WS2812_print_currency_value_buy153:
;ws2812.c,750 :: 		if ((pixel_position / MATRIX_WIDTH) == 3)
	MOVLW       5
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        WS2812_print_currency_value_buy_pixel_position_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_print_currency_value_buy_pixel_position_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_currency_value_buy309
	MOVLW       3
	XORWF       R0, 0 
L__WS2812_print_currency_value_buy309:
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_print_currency_value_buy157
;ws2812.c,752 :: 		char symbol_code = 0; char* simplified_number;
	CLRF        WS2812_print_currency_value_buy_symbol_code_L3_L3_L3_L3+0 
;ws2812.c,754 :: 		if ((current_panel_iteration % 2) == 0)
	MOVLW       1
	ANDWF       _current_panel_iteration+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_print_currency_value_buy158
;ws2812.c,756 :: 		IntToStr(currentRequest.usd_buy[1], current_number); simplified_number = Ltrim(current_number);
	MOVF        _currentRequest+10, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _currentRequest+11, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       WS2812_print_currency_value_buy_current_number_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(WS2812_print_currency_value_buy_current_number_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
	MOVLW       WS2812_print_currency_value_buy_current_number_L0+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(WS2812_print_currency_value_buy_current_number_L0+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
	MOVF        R0, 0 
	MOVWF       WS2812_print_currency_value_buy_simplified_number_L3_L3_L3_L3+0 
	MOVF        R1, 0 
	MOVWF       WS2812_print_currency_value_buy_simplified_number_L3_L3_L3_L3+1 
;ws2812.c,757 :: 		}
	GOTO        L_WS2812_print_currency_value_buy159
L_WS2812_print_currency_value_buy158:
;ws2812.c,760 :: 		IntToStr(currentRequest.eur_buy[1], current_number); simplified_number = Ltrim(current_number);
	MOVF        _currentRequest+2, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _currentRequest+3, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       WS2812_print_currency_value_buy_current_number_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(WS2812_print_currency_value_buy_current_number_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
	MOVLW       WS2812_print_currency_value_buy_current_number_L0+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(WS2812_print_currency_value_buy_current_number_L0+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
	MOVF        R0, 0 
	MOVWF       WS2812_print_currency_value_buy_simplified_number_L3_L3_L3_L3+0 
	MOVF        R1, 0 
	MOVWF       WS2812_print_currency_value_buy_simplified_number_L3_L3_L3_L3+1 
;ws2812.c,761 :: 		}
L_WS2812_print_currency_value_buy159:
;ws2812.c,763 :: 		if (strlen(simplified_number) == 1)
	MOVF        WS2812_print_currency_value_buy_simplified_number_L3_L3_L3_L3+0, 0 
	MOVWF       FARG_strlen_s+0 
	MOVF        WS2812_print_currency_value_buy_simplified_number_L3_L3_L3_L3+1, 0 
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_currency_value_buy310
	MOVLW       1
	XORWF       R0, 0 
L__WS2812_print_currency_value_buy310:
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_print_currency_value_buy160
;ws2812.c,765 :: 		symbol_code = simplified_number[0] - 48;
	MOVFF       WS2812_print_currency_value_buy_simplified_number_L3_L3_L3_L3+0, FSR0
	MOVFF       WS2812_print_currency_value_buy_simplified_number_L3_L3_L3_L3+1, FSR0H
	MOVLW       48
	SUBWF       POSTINC0+0, 0 
	MOVWF       WS2812_print_currency_value_buy_symbol_code_L3_L3_L3_L3+0 
;ws2812.c,766 :: 		}
L_WS2812_print_currency_value_buy160:
;ws2812.c,768 :: 		if (strlen(simplified_number) == 2)
	MOVF        WS2812_print_currency_value_buy_simplified_number_L3_L3_L3_L3+0, 0 
	MOVWF       FARG_strlen_s+0 
	MOVF        WS2812_print_currency_value_buy_simplified_number_L3_L3_L3_L3+1, 0 
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_currency_value_buy311
	MOVLW       2
	XORWF       R0, 0 
L__WS2812_print_currency_value_buy311:
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_print_currency_value_buy161
;ws2812.c,770 :: 		symbol_code = simplified_number[1] - 48;
	MOVLW       1
	ADDWF       WS2812_print_currency_value_buy_simplified_number_L3_L3_L3_L3+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      WS2812_print_currency_value_buy_simplified_number_L3_L3_L3_L3+1, 0 
	MOVWF       FSR0H 
	MOVLW       48
	SUBWF       POSTINC0+0, 0 
	MOVWF       WS2812_print_currency_value_buy_symbol_code_L3_L3_L3_L3+0 
;ws2812.c,771 :: 		}
L_WS2812_print_currency_value_buy161:
;ws2812.c,773 :: 		matrix_element = ALPHABET_NUMBERS[symbol_code * MATRIX_HEIGHT + matrix_row];
	MOVLW       7
	MULWF       WS2812_print_currency_value_buy_symbol_code_L3_L3_L3_L3+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVF        WS2812_print_currency_value_buy_matrix_row_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       R3 
	MOVF        WS2812_print_currency_value_buy_matrix_row_L0+1, 0 
	ADDWFC      R1, 0 
	MOVWF       R4 
	MOVLW       _ALPHABET_NUMBERS+0
	MOVWF       R0 
	MOVLW       hi_addr(_ALPHABET_NUMBERS+0)
	MOVWF       R1 
	MOVLW       higher_addr(_ALPHABET_NUMBERS+0)
	MOVWF       R2 
	MOVF        R3, 0 
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVF        R4, 0 
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, WS2812_print_currency_value_buy_matrix_element_L2+0
;ws2812.c,774 :: 		}
L_WS2812_print_currency_value_buy157:
;ws2812.c,776 :: 		for (matrix_column = 0; matrix_column < MATRIX_WIDTH; ++matrix_column)
	CLRF        WS2812_print_currency_value_buy_matrix_column_L0+0 
	CLRF        WS2812_print_currency_value_buy_matrix_column_L0+1 
L_WS2812_print_currency_value_buy162:
	MOVLW       0
	SUBWF       WS2812_print_currency_value_buy_matrix_column_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_currency_value_buy312
	MOVLW       5
	SUBWF       WS2812_print_currency_value_buy_matrix_column_L0+0, 0 
L__WS2812_print_currency_value_buy312:
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_print_currency_value_buy163
;ws2812.c,778 :: 		if (matrix_element & 0x80)
	BTFSS       WS2812_print_currency_value_buy_matrix_element_L2+0, 7 
	GOTO        L_WS2812_print_currency_value_buy165
;ws2812.c,780 :: 		panel_currency_value_buy_pixels[matrix_row][pixel_position + matrix_column].red = current_text_color[0];
	MOVLW       60
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        WS2812_print_currency_value_buy_matrix_row_L0+0, 0 
	MOVWF       R4 
	MOVF        WS2812_print_currency_value_buy_matrix_row_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _panel_currency_value_buy_pixels+0
	ADDWF       R0, 0 
	MOVWF       FLOC__WS2812_print_currency_value_buy+0 
	MOVLW       hi_addr(_panel_currency_value_buy_pixels+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__WS2812_print_currency_value_buy+1 
	MOVF        WS2812_print_currency_value_buy_matrix_column_L0+0, 0 
	ADDWF       WS2812_print_currency_value_buy_pixel_position_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_print_currency_value_buy_matrix_column_L0+1, 0 
	ADDWFC      WS2812_print_currency_value_buy_pixel_position_L0+1, 0 
	MOVWF       R1 
	MOVLW       3
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        FLOC__WS2812_print_currency_value_buy+0, 0 
	ADDWF       R0, 1 
	MOVF        FLOC__WS2812_print_currency_value_buy+1, 0 
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        _current_text_color+0, 0 
	MOVWF       POSTINC1+0 
;ws2812.c,781 :: 		panel_currency_value_buy_pixels[matrix_row][pixel_position + matrix_column].green = current_text_color[1];
	MOVLW       60
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        WS2812_print_currency_value_buy_matrix_row_L0+0, 0 
	MOVWF       R4 
	MOVF        WS2812_print_currency_value_buy_matrix_row_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _panel_currency_value_buy_pixels+0
	ADDWF       R0, 0 
	MOVWF       FLOC__WS2812_print_currency_value_buy+0 
	MOVLW       hi_addr(_panel_currency_value_buy_pixels+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__WS2812_print_currency_value_buy+1 
	MOVF        WS2812_print_currency_value_buy_matrix_column_L0+0, 0 
	ADDWF       WS2812_print_currency_value_buy_pixel_position_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_print_currency_value_buy_matrix_column_L0+1, 0 
	ADDWFC      WS2812_print_currency_value_buy_pixel_position_L0+1, 0 
	MOVWF       R1 
	MOVLW       3
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        FLOC__WS2812_print_currency_value_buy+0, 0 
	ADDWF       R0, 1 
	MOVF        FLOC__WS2812_print_currency_value_buy+1, 0 
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        _current_text_color+1, 0 
	MOVWF       POSTINC1+0 
;ws2812.c,782 :: 		panel_currency_value_buy_pixels[matrix_row][pixel_position + matrix_column].blue = current_text_color[2];
	MOVLW       60
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        WS2812_print_currency_value_buy_matrix_row_L0+0, 0 
	MOVWF       R4 
	MOVF        WS2812_print_currency_value_buy_matrix_row_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _panel_currency_value_buy_pixels+0
	ADDWF       R0, 0 
	MOVWF       FLOC__WS2812_print_currency_value_buy+0 
	MOVLW       hi_addr(_panel_currency_value_buy_pixels+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__WS2812_print_currency_value_buy+1 
	MOVF        WS2812_print_currency_value_buy_matrix_column_L0+0, 0 
	ADDWF       WS2812_print_currency_value_buy_pixel_position_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_print_currency_value_buy_matrix_column_L0+1, 0 
	ADDWFC      WS2812_print_currency_value_buy_pixel_position_L0+1, 0 
	MOVWF       R1 
	MOVLW       3
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__WS2812_print_currency_value_buy+0, 0 
	MOVWF       FSR1 
	MOVF        R1, 0 
	ADDWFC      FLOC__WS2812_print_currency_value_buy+1, 0 
	MOVWF       FSR1H 
	MOVF        _current_text_color+2, 0 
	MOVWF       POSTINC1+0 
;ws2812.c,783 :: 		}
	GOTO        L_WS2812_print_currency_value_buy166
L_WS2812_print_currency_value_buy165:
;ws2812.c,786 :: 		panel_currency_value_buy_pixels[matrix_row][pixel_position + matrix_column].red = current_background_color[0];
	MOVLW       60
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        WS2812_print_currency_value_buy_matrix_row_L0+0, 0 
	MOVWF       R4 
	MOVF        WS2812_print_currency_value_buy_matrix_row_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _panel_currency_value_buy_pixels+0
	ADDWF       R0, 0 
	MOVWF       FLOC__WS2812_print_currency_value_buy+0 
	MOVLW       hi_addr(_panel_currency_value_buy_pixels+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__WS2812_print_currency_value_buy+1 
	MOVF        WS2812_print_currency_value_buy_matrix_column_L0+0, 0 
	ADDWF       WS2812_print_currency_value_buy_pixel_position_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_print_currency_value_buy_matrix_column_L0+1, 0 
	ADDWFC      WS2812_print_currency_value_buy_pixel_position_L0+1, 0 
	MOVWF       R1 
	MOVLW       3
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        FLOC__WS2812_print_currency_value_buy+0, 0 
	ADDWF       R0, 1 
	MOVF        FLOC__WS2812_print_currency_value_buy+1, 0 
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        _current_background_color+0, 0 
	MOVWF       POSTINC1+0 
;ws2812.c,787 :: 		panel_currency_value_buy_pixels[matrix_row][pixel_position + matrix_column].green = current_background_color[1];
	MOVLW       60
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        WS2812_print_currency_value_buy_matrix_row_L0+0, 0 
	MOVWF       R4 
	MOVF        WS2812_print_currency_value_buy_matrix_row_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _panel_currency_value_buy_pixels+0
	ADDWF       R0, 0 
	MOVWF       FLOC__WS2812_print_currency_value_buy+0 
	MOVLW       hi_addr(_panel_currency_value_buy_pixels+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__WS2812_print_currency_value_buy+1 
	MOVF        WS2812_print_currency_value_buy_matrix_column_L0+0, 0 
	ADDWF       WS2812_print_currency_value_buy_pixel_position_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_print_currency_value_buy_matrix_column_L0+1, 0 
	ADDWFC      WS2812_print_currency_value_buy_pixel_position_L0+1, 0 
	MOVWF       R1 
	MOVLW       3
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        FLOC__WS2812_print_currency_value_buy+0, 0 
	ADDWF       R0, 1 
	MOVF        FLOC__WS2812_print_currency_value_buy+1, 0 
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        _current_background_color+1, 0 
	MOVWF       POSTINC1+0 
;ws2812.c,788 :: 		panel_currency_value_buy_pixels[matrix_row][pixel_position + matrix_column].blue = current_background_color[2];
	MOVLW       60
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        WS2812_print_currency_value_buy_matrix_row_L0+0, 0 
	MOVWF       R4 
	MOVF        WS2812_print_currency_value_buy_matrix_row_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _panel_currency_value_buy_pixels+0
	ADDWF       R0, 0 
	MOVWF       FLOC__WS2812_print_currency_value_buy+0 
	MOVLW       hi_addr(_panel_currency_value_buy_pixels+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__WS2812_print_currency_value_buy+1 
	MOVF        WS2812_print_currency_value_buy_matrix_column_L0+0, 0 
	ADDWF       WS2812_print_currency_value_buy_pixel_position_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_print_currency_value_buy_matrix_column_L0+1, 0 
	ADDWFC      WS2812_print_currency_value_buy_pixel_position_L0+1, 0 
	MOVWF       R1 
	MOVLW       3
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__WS2812_print_currency_value_buy+0, 0 
	MOVWF       FSR1 
	MOVF        R1, 0 
	ADDWFC      FLOC__WS2812_print_currency_value_buy+1, 0 
	MOVWF       FSR1H 
	MOVF        _current_background_color+2, 0 
	MOVWF       POSTINC1+0 
;ws2812.c,789 :: 		}
L_WS2812_print_currency_value_buy166:
;ws2812.c,791 :: 		matrix_element = matrix_element << 1;
	RLCF        WS2812_print_currency_value_buy_matrix_element_L2+0, 1 
	BCF         WS2812_print_currency_value_buy_matrix_element_L2+0, 0 
;ws2812.c,776 :: 		for (matrix_column = 0; matrix_column < MATRIX_WIDTH; ++matrix_column)
	INFSNZ      WS2812_print_currency_value_buy_matrix_column_L0+0, 1 
	INCF        WS2812_print_currency_value_buy_matrix_column_L0+1, 1 
;ws2812.c,792 :: 		}
	GOTO        L_WS2812_print_currency_value_buy162
L_WS2812_print_currency_value_buy163:
;ws2812.c,678 :: 		for (matrix_row = 0; matrix_row < MATRIX_HEIGHT; ++matrix_row)
	INFSNZ      WS2812_print_currency_value_buy_matrix_row_L0+0, 1 
	INCF        WS2812_print_currency_value_buy_matrix_row_L0+1, 1 
;ws2812.c,793 :: 		}
	GOTO        L_WS2812_print_currency_value_buy141
L_WS2812_print_currency_value_buy142:
;ws2812.c,676 :: 		for (pixel_position = 0; pixel_position < PANEL_CURRENCY_VALUE_BUY_WIDTH; pixel_position += MATRIX_WIDTH)
	MOVLW       5
	ADDWF       WS2812_print_currency_value_buy_pixel_position_L0+0, 1 
	MOVLW       0
	ADDWFC      WS2812_print_currency_value_buy_pixel_position_L0+1, 1 
;ws2812.c,794 :: 		}
	GOTO        L_WS2812_print_currency_value_buy138
L_WS2812_print_currency_value_buy139:
;ws2812.c,796 :: 		for (panel_row = 0; panel_row < PANEL_CURRENCY_VALUE_BUY_HEIGHT; ++panel_row)
	CLRF        WS2812_print_currency_value_buy_panel_row_L0+0 
	CLRF        WS2812_print_currency_value_buy_panel_row_L0+1 
L_WS2812_print_currency_value_buy167:
	MOVLW       0
	SUBWF       WS2812_print_currency_value_buy_panel_row_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_currency_value_buy313
	MOVLW       7
	SUBWF       WS2812_print_currency_value_buy_panel_row_L0+0, 0 
L__WS2812_print_currency_value_buy313:
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_print_currency_value_buy168
;ws2812.c,799 :: 		unsigned char mask_enable = PANEL_CURRENCY_VALUE_BUY_PORT | (0x01 << panel_row);
	MOVF        WS2812_print_currency_value_buy_panel_row_L0+0, 0 
	MOVWF       R0 
	MOVLW       1
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R0, 0 
L__WS2812_print_currency_value_buy314:
	BZ          L__WS2812_print_currency_value_buy315
	RLCF        R2, 1 
	BCF         R2, 0 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__WS2812_print_currency_value_buy314
L__WS2812_print_currency_value_buy315:
	MOVF        R2, 0 
	IORWF       LATF+0, 0 
	MOVWF       R0 
	MOVLW       0
	IORWF       R3, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       WS2812_print_currency_value_buy_mask_enable_L1+0 
;ws2812.c,801 :: 		unsigned char mask_disable = PANEL_CURRENCY_VALUE_BUY_PORT & ~(0x01 << panel_row);
	COMF        R2, 0 
	MOVWF       R0 
	COMF        R3, 0 
	MOVWF       R1 
	MOVF        LATF+0, 0 
	ANDWF       R0, 1 
	MOVLW       0
	ANDWF       R1, 1 
	MOVF        R0, 0 
	MOVWF       WS2812_print_currency_value_buy_mask_disable_L1+0 
;ws2812.c,804 :: 		PixelParameter* pixels = panel_currency_value_buy_pixels[panel_row];
	MOVLW       60
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        WS2812_print_currency_value_buy_panel_row_L0+0, 0 
	MOVWF       R4 
	MOVF        WS2812_print_currency_value_buy_panel_row_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _panel_currency_value_buy_pixels+0
	ADDWF       R0, 0 
	MOVWF       WS2812_print_currency_value_buy_pixels_L1+0 
	MOVLW       hi_addr(_panel_currency_value_buy_pixels+0)
	ADDWFC      R1, 0 
	MOVWF       WS2812_print_currency_value_buy_pixels_L1+1 
;ws2812.c,806 :: 		for (panel_column = 0; panel_column < PANEL_CURRENCY_VALUE_BUY_WIDTH; ++panel_column)
	CLRF        WS2812_print_currency_value_buy_panel_column_L0+0 
	CLRF        WS2812_print_currency_value_buy_panel_column_L0+1 
L_WS2812_print_currency_value_buy170:
	MOVLW       0
	SUBWF       WS2812_print_currency_value_buy_panel_column_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_currency_value_buy316
	MOVLW       20
	SUBWF       WS2812_print_currency_value_buy_panel_column_L0+0, 0 
L__WS2812_print_currency_value_buy316:
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_print_currency_value_buy171
;ws2812.c,809 :: 		current_byte = pixels[panel_column].green;
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        WS2812_print_currency_value_buy_panel_column_L0+0, 0 
	MOVWF       R4 
	MOVF        WS2812_print_currency_value_buy_panel_column_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        WS2812_print_currency_value_buy_pixels_L1+0, 0 
	ADDWF       R0, 1 
	MOVF        WS2812_print_currency_value_buy_pixels_L1+1, 0 
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       WS2812_print_currency_value_buy_current_byte_L0+0 
;ws2812.c,811 :: 		for (current_bit = 0; current_bit < 8; ++current_bit)
	CLRF        WS2812_print_currency_value_buy_current_bit_L0+0 
L_WS2812_print_currency_value_buy173:
	MOVLW       8
	SUBWF       WS2812_print_currency_value_buy_current_bit_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_print_currency_value_buy174
;ws2812.c,813 :: 		if (current_byte & 0x80)
	BTFSS       WS2812_print_currency_value_buy_current_byte_L0+0, 7 
	GOTO        L_WS2812_print_currency_value_buy176
;ws2812.c,815 :: 		PANEL_CURRENCY_VALUE_BUY_PORT = mask_enable;
	MOVF        WS2812_print_currency_value_buy_mask_enable_L1+0, 0 
	MOVWF       LATF+0 
;ws2812.c,817 :: 		WS2812_delay_long();
	CALL        _WS2812_delay_long+0, 0
;ws2812.c,819 :: 		PANEL_CURRENCY_VALUE_BUY_PORT = mask_disable;
	MOVF        WS2812_print_currency_value_buy_mask_disable_L1+0, 0 
	MOVWF       LATF+0 
;ws2812.c,820 :: 		}
	GOTO        L_WS2812_print_currency_value_buy177
L_WS2812_print_currency_value_buy176:
;ws2812.c,823 :: 		PANEL_CURRENCY_VALUE_BUY_PORT = mask_enable;
	MOVF        WS2812_print_currency_value_buy_mask_enable_L1+0, 0 
	MOVWF       LATF+0 
;ws2812.c,825 :: 		PANEL_CURRENCY_VALUE_BUY_PORT = mask_disable;
	MOVF        WS2812_print_currency_value_buy_mask_disable_L1+0, 0 
	MOVWF       LATF+0 
;ws2812.c,826 :: 		}
L_WS2812_print_currency_value_buy177:
;ws2812.c,828 :: 		current_byte = current_byte << 1;
	RLCF        WS2812_print_currency_value_buy_current_byte_L0+0, 1 
	BCF         WS2812_print_currency_value_buy_current_byte_L0+0, 0 
;ws2812.c,811 :: 		for (current_bit = 0; current_bit < 8; ++current_bit)
	INCF        WS2812_print_currency_value_buy_current_bit_L0+0, 1 
;ws2812.c,829 :: 		}
	GOTO        L_WS2812_print_currency_value_buy173
L_WS2812_print_currency_value_buy174:
;ws2812.c,832 :: 		current_byte = pixels[panel_column].red;
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        WS2812_print_currency_value_buy_panel_column_L0+0, 0 
	MOVWF       R4 
	MOVF        WS2812_print_currency_value_buy_panel_column_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        WS2812_print_currency_value_buy_pixels_L1+0, 0 
	ADDWF       R0, 1 
	MOVF        WS2812_print_currency_value_buy_pixels_L1+1, 0 
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       WS2812_print_currency_value_buy_current_byte_L0+0 
;ws2812.c,834 :: 		for (current_bit = 0; current_bit < 8; ++current_bit)
	CLRF        WS2812_print_currency_value_buy_current_bit_L0+0 
L_WS2812_print_currency_value_buy178:
	MOVLW       8
	SUBWF       WS2812_print_currency_value_buy_current_bit_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_print_currency_value_buy179
;ws2812.c,836 :: 		if (current_byte & 0x80)
	BTFSS       WS2812_print_currency_value_buy_current_byte_L0+0, 7 
	GOTO        L_WS2812_print_currency_value_buy181
;ws2812.c,838 :: 		PANEL_CURRENCY_VALUE_BUY_PORT = mask_enable;
	MOVF        WS2812_print_currency_value_buy_mask_enable_L1+0, 0 
	MOVWF       LATF+0 
;ws2812.c,840 :: 		WS2812_delay_long();
	CALL        _WS2812_delay_long+0, 0
;ws2812.c,842 :: 		PANEL_CURRENCY_VALUE_BUY_PORT = mask_disable;
	MOVF        WS2812_print_currency_value_buy_mask_disable_L1+0, 0 
	MOVWF       LATF+0 
;ws2812.c,843 :: 		}
	GOTO        L_WS2812_print_currency_value_buy182
L_WS2812_print_currency_value_buy181:
;ws2812.c,846 :: 		PANEL_CURRENCY_VALUE_BUY_PORT = mask_enable;
	MOVF        WS2812_print_currency_value_buy_mask_enable_L1+0, 0 
	MOVWF       LATF+0 
;ws2812.c,848 :: 		PANEL_CURRENCY_VALUE_BUY_PORT = mask_disable;
	MOVF        WS2812_print_currency_value_buy_mask_disable_L1+0, 0 
	MOVWF       LATF+0 
;ws2812.c,849 :: 		}
L_WS2812_print_currency_value_buy182:
;ws2812.c,851 :: 		current_byte = current_byte << 1;
	RLCF        WS2812_print_currency_value_buy_current_byte_L0+0, 1 
	BCF         WS2812_print_currency_value_buy_current_byte_L0+0, 0 
;ws2812.c,834 :: 		for (current_bit = 0; current_bit < 8; ++current_bit)
	INCF        WS2812_print_currency_value_buy_current_bit_L0+0, 1 
;ws2812.c,852 :: 		}
	GOTO        L_WS2812_print_currency_value_buy178
L_WS2812_print_currency_value_buy179:
;ws2812.c,855 :: 		current_byte = pixels[panel_column].blue;
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        WS2812_print_currency_value_buy_panel_column_L0+0, 0 
	MOVWF       R4 
	MOVF        WS2812_print_currency_value_buy_panel_column_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       WS2812_print_currency_value_buy_pixels_L1+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      WS2812_print_currency_value_buy_pixels_L1+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       WS2812_print_currency_value_buy_current_byte_L0+0 
;ws2812.c,857 :: 		for (current_bit = 0; current_bit < 8; ++current_bit)
	CLRF        WS2812_print_currency_value_buy_current_bit_L0+0 
L_WS2812_print_currency_value_buy183:
	MOVLW       8
	SUBWF       WS2812_print_currency_value_buy_current_bit_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_print_currency_value_buy184
;ws2812.c,859 :: 		if (current_byte & 0x80)
	BTFSS       WS2812_print_currency_value_buy_current_byte_L0+0, 7 
	GOTO        L_WS2812_print_currency_value_buy186
;ws2812.c,861 :: 		PANEL_CURRENCY_VALUE_BUY_PORT = mask_enable;
	MOVF        WS2812_print_currency_value_buy_mask_enable_L1+0, 0 
	MOVWF       LATF+0 
;ws2812.c,863 :: 		WS2812_delay_long();
	CALL        _WS2812_delay_long+0, 0
;ws2812.c,865 :: 		PANEL_CURRENCY_VALUE_BUY_PORT = mask_disable;
	MOVF        WS2812_print_currency_value_buy_mask_disable_L1+0, 0 
	MOVWF       LATF+0 
;ws2812.c,866 :: 		}
	GOTO        L_WS2812_print_currency_value_buy187
L_WS2812_print_currency_value_buy186:
;ws2812.c,869 :: 		PANEL_CURRENCY_VALUE_BUY_PORT = mask_enable;
	MOVF        WS2812_print_currency_value_buy_mask_enable_L1+0, 0 
	MOVWF       LATF+0 
;ws2812.c,871 :: 		PANEL_CURRENCY_VALUE_BUY_PORT = mask_disable;
	MOVF        WS2812_print_currency_value_buy_mask_disable_L1+0, 0 
	MOVWF       LATF+0 
;ws2812.c,872 :: 		}
L_WS2812_print_currency_value_buy187:
;ws2812.c,874 :: 		current_byte = current_byte << 1;
	RLCF        WS2812_print_currency_value_buy_current_byte_L0+0, 1 
	BCF         WS2812_print_currency_value_buy_current_byte_L0+0, 0 
;ws2812.c,857 :: 		for (current_bit = 0; current_bit < 8; ++current_bit)
	INCF        WS2812_print_currency_value_buy_current_bit_L0+0, 1 
;ws2812.c,875 :: 		}
	GOTO        L_WS2812_print_currency_value_buy183
L_WS2812_print_currency_value_buy184:
;ws2812.c,806 :: 		for (panel_column = 0; panel_column < PANEL_CURRENCY_VALUE_BUY_WIDTH; ++panel_column)
	INFSNZ      WS2812_print_currency_value_buy_panel_column_L0+0, 1 
	INCF        WS2812_print_currency_value_buy_panel_column_L0+1, 1 
;ws2812.c,876 :: 		}
	GOTO        L_WS2812_print_currency_value_buy170
L_WS2812_print_currency_value_buy171:
;ws2812.c,879 :: 		Delay_us(50);
	MOVLW       2
	MOVWF       R12, 0
	MOVLW       8
	MOVWF       R13, 0
L_WS2812_print_currency_value_buy188:
	DECFSZ      R13, 1, 1
	BRA         L_WS2812_print_currency_value_buy188
	DECFSZ      R12, 1, 1
	BRA         L_WS2812_print_currency_value_buy188
	NOP
;ws2812.c,796 :: 		for (panel_row = 0; panel_row < PANEL_CURRENCY_VALUE_BUY_HEIGHT; ++panel_row)
	INFSNZ      WS2812_print_currency_value_buy_panel_row_L0+0, 1 
	INCF        WS2812_print_currency_value_buy_panel_row_L0+1, 1 
;ws2812.c,880 :: 		}
	GOTO        L_WS2812_print_currency_value_buy167
L_WS2812_print_currency_value_buy168:
;ws2812.c,881 :: 		}
L_end_WS2812_print_currency_value_buy:
	RETURN      0
; end of _WS2812_print_currency_value_buy

_WS2812_print_currency_value_sale:

;ws2812.c,884 :: 		void WS2812_print_currency_value_sale()
;ws2812.c,887 :: 		unsigned int pixel_position = 0;
	CLRF        WS2812_print_currency_value_sale_pixel_position_L0+0 
	CLRF        WS2812_print_currency_value_sale_pixel_position_L0+1 
	CLRF        WS2812_print_currency_value_sale_matrix_column_L0+0 
	CLRF        WS2812_print_currency_value_sale_matrix_column_L0+1 
	CLRF        WS2812_print_currency_value_sale_matrix_row_L0+0 
	CLRF        WS2812_print_currency_value_sale_matrix_row_L0+1 
	CLRF        WS2812_print_currency_value_sale_panel_column_L0+0 
	CLRF        WS2812_print_currency_value_sale_panel_column_L0+1 
	CLRF        WS2812_print_currency_value_sale_panel_row_L0+0 
	CLRF        WS2812_print_currency_value_sale_panel_row_L0+1 
;ws2812.c,906 :: 		for (pixel_position = 0; pixel_position < PANEL_CURRENCY_VALUE_SALE_WIDTH; pixel_position += MATRIX_WIDTH)
	CLRF        WS2812_print_currency_value_sale_pixel_position_L0+0 
	CLRF        WS2812_print_currency_value_sale_pixel_position_L0+1 
L_WS2812_print_currency_value_sale189:
	MOVLW       0
	SUBWF       WS2812_print_currency_value_sale_pixel_position_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_currency_value_sale318
	MOVLW       20
	SUBWF       WS2812_print_currency_value_sale_pixel_position_L0+0, 0 
L__WS2812_print_currency_value_sale318:
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_print_currency_value_sale190
;ws2812.c,908 :: 		for (matrix_row = 0; matrix_row < MATRIX_HEIGHT; ++matrix_row)
	CLRF        WS2812_print_currency_value_sale_matrix_row_L0+0 
	CLRF        WS2812_print_currency_value_sale_matrix_row_L0+1 
L_WS2812_print_currency_value_sale192:
	MOVLW       0
	SUBWF       WS2812_print_currency_value_sale_matrix_row_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_currency_value_sale319
	MOVLW       7
	SUBWF       WS2812_print_currency_value_sale_matrix_row_L0+0, 0 
L__WS2812_print_currency_value_sale319:
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_print_currency_value_sale193
;ws2812.c,910 :: 		unsigned char matrix_element = 0x00;
	CLRF        WS2812_print_currency_value_sale_matrix_element_L2+0 
;ws2812.c,912 :: 		if ((pixel_position / MATRIX_WIDTH) == 0)
	MOVLW       5
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        WS2812_print_currency_value_sale_pixel_position_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_print_currency_value_sale_pixel_position_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_currency_value_sale320
	MOVLW       0
	XORWF       R0, 0 
L__WS2812_print_currency_value_sale320:
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_print_currency_value_sale195
;ws2812.c,914 :: 		char symbol_code = 0; char* simplified_number;
	CLRF        WS2812_print_currency_value_sale_symbol_code_L3+0 
;ws2812.c,916 :: 		if ((current_panel_iteration % 2) == 0)
	MOVLW       1
	ANDWF       _current_panel_iteration+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_print_currency_value_sale196
;ws2812.c,918 :: 		IntToStr(currentRequest.usd_sale[0], current_number); simplified_number = Ltrim(current_number);
	MOVF        _currentRequest+12, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _currentRequest+13, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       WS2812_print_currency_value_sale_current_number_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(WS2812_print_currency_value_sale_current_number_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
	MOVLW       WS2812_print_currency_value_sale_current_number_L0+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(WS2812_print_currency_value_sale_current_number_L0+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
	MOVF        R0, 0 
	MOVWF       WS2812_print_currency_value_sale_simplified_number_L3+0 
	MOVF        R1, 0 
	MOVWF       WS2812_print_currency_value_sale_simplified_number_L3+1 
;ws2812.c,919 :: 		}
	GOTO        L_WS2812_print_currency_value_sale197
L_WS2812_print_currency_value_sale196:
;ws2812.c,922 :: 		IntToStr(currentRequest.eur_sale[0], current_number); simplified_number = Ltrim(current_number);
	MOVF        _currentRequest+4, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _currentRequest+5, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       WS2812_print_currency_value_sale_current_number_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(WS2812_print_currency_value_sale_current_number_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
	MOVLW       WS2812_print_currency_value_sale_current_number_L0+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(WS2812_print_currency_value_sale_current_number_L0+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
	MOVF        R0, 0 
	MOVWF       WS2812_print_currency_value_sale_simplified_number_L3+0 
	MOVF        R1, 0 
	MOVWF       WS2812_print_currency_value_sale_simplified_number_L3+1 
;ws2812.c,923 :: 		}
L_WS2812_print_currency_value_sale197:
;ws2812.c,925 :: 		if (strlen(simplified_number) > 1)
	MOVF        WS2812_print_currency_value_sale_simplified_number_L3+0, 0 
	MOVWF       FARG_strlen_s+0 
	MOVF        WS2812_print_currency_value_sale_simplified_number_L3+1, 0 
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVLW       128
	MOVWF       R2 
	MOVLW       128
	XORWF       R1, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_currency_value_sale321
	MOVF        R0, 0 
	SUBLW       1
L__WS2812_print_currency_value_sale321:
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_print_currency_value_sale198
;ws2812.c,927 :: 		symbol_code = simplified_number[0] - 48;
	MOVFF       WS2812_print_currency_value_sale_simplified_number_L3+0, FSR0
	MOVFF       WS2812_print_currency_value_sale_simplified_number_L3+1, FSR0H
	MOVLW       48
	SUBWF       POSTINC0+0, 0 
	MOVWF       WS2812_print_currency_value_sale_symbol_code_L3+0 
;ws2812.c,928 :: 		}
L_WS2812_print_currency_value_sale198:
;ws2812.c,930 :: 		matrix_element = ALPHABET_NUMBERS[symbol_code * MATRIX_HEIGHT + matrix_row];
	MOVLW       7
	MULWF       WS2812_print_currency_value_sale_symbol_code_L3+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVF        WS2812_print_currency_value_sale_matrix_row_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       R3 
	MOVF        WS2812_print_currency_value_sale_matrix_row_L0+1, 0 
	ADDWFC      R1, 0 
	MOVWF       R4 
	MOVLW       _ALPHABET_NUMBERS+0
	MOVWF       R0 
	MOVLW       hi_addr(_ALPHABET_NUMBERS+0)
	MOVWF       R1 
	MOVLW       higher_addr(_ALPHABET_NUMBERS+0)
	MOVWF       R2 
	MOVF        R3, 0 
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVF        R4, 0 
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, WS2812_print_currency_value_sale_matrix_element_L2+0
;ws2812.c,931 :: 		}
L_WS2812_print_currency_value_sale195:
;ws2812.c,933 :: 		if ((pixel_position / MATRIX_WIDTH) == 1)
	MOVLW       5
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        WS2812_print_currency_value_sale_pixel_position_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_print_currency_value_sale_pixel_position_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_currency_value_sale322
	MOVLW       1
	XORWF       R0, 0 
L__WS2812_print_currency_value_sale322:
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_print_currency_value_sale199
;ws2812.c,935 :: 		char symbol_code = 0; char* simplified_number;
	CLRF        WS2812_print_currency_value_sale_symbol_code_L3_L3+0 
;ws2812.c,937 :: 		if ((current_panel_iteration % 2) == 0)
	MOVLW       1
	ANDWF       _current_panel_iteration+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_print_currency_value_sale200
;ws2812.c,939 :: 		IntToStr(currentRequest.usd_sale[0], current_number); simplified_number = Ltrim(current_number);
	MOVF        _currentRequest+12, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _currentRequest+13, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       WS2812_print_currency_value_sale_current_number_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(WS2812_print_currency_value_sale_current_number_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
	MOVLW       WS2812_print_currency_value_sale_current_number_L0+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(WS2812_print_currency_value_sale_current_number_L0+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
	MOVF        R0, 0 
	MOVWF       WS2812_print_currency_value_sale_simplified_number_L3_L3+0 
	MOVF        R1, 0 
	MOVWF       WS2812_print_currency_value_sale_simplified_number_L3_L3+1 
;ws2812.c,940 :: 		}
	GOTO        L_WS2812_print_currency_value_sale201
L_WS2812_print_currency_value_sale200:
;ws2812.c,943 :: 		IntToStr(currentRequest.eur_sale[0], current_number); simplified_number = Ltrim(current_number);
	MOVF        _currentRequest+4, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _currentRequest+5, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       WS2812_print_currency_value_sale_current_number_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(WS2812_print_currency_value_sale_current_number_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
	MOVLW       WS2812_print_currency_value_sale_current_number_L0+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(WS2812_print_currency_value_sale_current_number_L0+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
	MOVF        R0, 0 
	MOVWF       WS2812_print_currency_value_sale_simplified_number_L3_L3+0 
	MOVF        R1, 0 
	MOVWF       WS2812_print_currency_value_sale_simplified_number_L3_L3+1 
;ws2812.c,944 :: 		}
L_WS2812_print_currency_value_sale201:
;ws2812.c,946 :: 		if (strlen(simplified_number) == 2)
	MOVF        WS2812_print_currency_value_sale_simplified_number_L3_L3+0, 0 
	MOVWF       FARG_strlen_s+0 
	MOVF        WS2812_print_currency_value_sale_simplified_number_L3_L3+1, 0 
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_currency_value_sale323
	MOVLW       2
	XORWF       R0, 0 
L__WS2812_print_currency_value_sale323:
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_print_currency_value_sale202
;ws2812.c,948 :: 		symbol_code = simplified_number[0] - 48;
	MOVFF       WS2812_print_currency_value_sale_simplified_number_L3_L3+0, FSR0
	MOVFF       WS2812_print_currency_value_sale_simplified_number_L3_L3+1, FSR0H
	MOVLW       48
	SUBWF       POSTINC0+0, 0 
	MOVWF       WS2812_print_currency_value_sale_symbol_code_L3_L3+0 
;ws2812.c,949 :: 		}
L_WS2812_print_currency_value_sale202:
;ws2812.c,951 :: 		if (strlen(simplified_number) == 2)
	MOVF        WS2812_print_currency_value_sale_simplified_number_L3_L3+0, 0 
	MOVWF       FARG_strlen_s+0 
	MOVF        WS2812_print_currency_value_sale_simplified_number_L3_L3+1, 0 
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_currency_value_sale324
	MOVLW       2
	XORWF       R0, 0 
L__WS2812_print_currency_value_sale324:
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_print_currency_value_sale203
;ws2812.c,953 :: 		symbol_code = simplified_number[1] - 48;
	MOVLW       1
	ADDWF       WS2812_print_currency_value_sale_simplified_number_L3_L3+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      WS2812_print_currency_value_sale_simplified_number_L3_L3+1, 0 
	MOVWF       FSR0H 
	MOVLW       48
	SUBWF       POSTINC0+0, 0 
	MOVWF       WS2812_print_currency_value_sale_symbol_code_L3_L3+0 
;ws2812.c,954 :: 		}
L_WS2812_print_currency_value_sale203:
;ws2812.c,956 :: 		matrix_element = ALPHABET_NUMBERS[symbol_code * MATRIX_HEIGHT + matrix_row];
	MOVLW       7
	MULWF       WS2812_print_currency_value_sale_symbol_code_L3_L3+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVF        WS2812_print_currency_value_sale_matrix_row_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       R3 
	MOVF        WS2812_print_currency_value_sale_matrix_row_L0+1, 0 
	ADDWFC      R1, 0 
	MOVWF       R4 
	MOVLW       _ALPHABET_NUMBERS+0
	MOVWF       R0 
	MOVLW       hi_addr(_ALPHABET_NUMBERS+0)
	MOVWF       R1 
	MOVLW       higher_addr(_ALPHABET_NUMBERS+0)
	MOVWF       R2 
	MOVF        R3, 0 
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVF        R4, 0 
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, WS2812_print_currency_value_sale_matrix_element_L2+0
;ws2812.c,957 :: 		}
L_WS2812_print_currency_value_sale199:
;ws2812.c,959 :: 		if ((pixel_position / MATRIX_WIDTH) == 2)
	MOVLW       5
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        WS2812_print_currency_value_sale_pixel_position_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_print_currency_value_sale_pixel_position_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_currency_value_sale325
	MOVLW       2
	XORWF       R0, 0 
L__WS2812_print_currency_value_sale325:
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_print_currency_value_sale204
;ws2812.c,961 :: 		char symbol_code = 0; char* simplified_number;
	CLRF        WS2812_print_currency_value_sale_symbol_code_L3_L3_L3+0 
;ws2812.c,963 :: 		if ((current_panel_iteration % 2) == 0)
	MOVLW       1
	ANDWF       _current_panel_iteration+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_print_currency_value_sale205
;ws2812.c,965 :: 		IntToStr(currentRequest.usd_sale[1], current_number); simplified_number = Ltrim(current_number);
	MOVF        _currentRequest+14, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _currentRequest+15, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       WS2812_print_currency_value_sale_current_number_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(WS2812_print_currency_value_sale_current_number_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
	MOVLW       WS2812_print_currency_value_sale_current_number_L0+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(WS2812_print_currency_value_sale_current_number_L0+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
	MOVF        R0, 0 
	MOVWF       WS2812_print_currency_value_sale_simplified_number_L3_L3_L3+0 
	MOVF        R1, 0 
	MOVWF       WS2812_print_currency_value_sale_simplified_number_L3_L3_L3+1 
;ws2812.c,966 :: 		}
	GOTO        L_WS2812_print_currency_value_sale206
L_WS2812_print_currency_value_sale205:
;ws2812.c,969 :: 		IntToStr(currentRequest.eur_sale[1], current_number); simplified_number = Ltrim(current_number);
	MOVF        _currentRequest+6, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _currentRequest+7, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       WS2812_print_currency_value_sale_current_number_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(WS2812_print_currency_value_sale_current_number_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
	MOVLW       WS2812_print_currency_value_sale_current_number_L0+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(WS2812_print_currency_value_sale_current_number_L0+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
	MOVF        R0, 0 
	MOVWF       WS2812_print_currency_value_sale_simplified_number_L3_L3_L3+0 
	MOVF        R1, 0 
	MOVWF       WS2812_print_currency_value_sale_simplified_number_L3_L3_L3+1 
;ws2812.c,970 :: 		}
L_WS2812_print_currency_value_sale206:
;ws2812.c,972 :: 		if (strlen(simplified_number) > 1)
	MOVF        WS2812_print_currency_value_sale_simplified_number_L3_L3_L3+0, 0 
	MOVWF       FARG_strlen_s+0 
	MOVF        WS2812_print_currency_value_sale_simplified_number_L3_L3_L3+1, 0 
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVLW       128
	MOVWF       R2 
	MOVLW       128
	XORWF       R1, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_currency_value_sale326
	MOVF        R0, 0 
	SUBLW       1
L__WS2812_print_currency_value_sale326:
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_print_currency_value_sale207
;ws2812.c,974 :: 		symbol_code = simplified_number[0] - 48;
	MOVFF       WS2812_print_currency_value_sale_simplified_number_L3_L3_L3+0, FSR0
	MOVFF       WS2812_print_currency_value_sale_simplified_number_L3_L3_L3+1, FSR0H
	MOVLW       48
	SUBWF       POSTINC0+0, 0 
	MOVWF       WS2812_print_currency_value_sale_symbol_code_L3_L3_L3+0 
;ws2812.c,975 :: 		}
L_WS2812_print_currency_value_sale207:
;ws2812.c,977 :: 		matrix_element = ALPHABET_NUMBERS[symbol_code * MATRIX_HEIGHT + matrix_row];
	MOVLW       7
	MULWF       WS2812_print_currency_value_sale_symbol_code_L3_L3_L3+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVF        WS2812_print_currency_value_sale_matrix_row_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       R3 
	MOVF        WS2812_print_currency_value_sale_matrix_row_L0+1, 0 
	ADDWFC      R1, 0 
	MOVWF       R4 
	MOVLW       _ALPHABET_NUMBERS+0
	MOVWF       R0 
	MOVLW       hi_addr(_ALPHABET_NUMBERS+0)
	MOVWF       R1 
	MOVLW       higher_addr(_ALPHABET_NUMBERS+0)
	MOVWF       R2 
	MOVF        R3, 0 
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVF        R4, 0 
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, WS2812_print_currency_value_sale_matrix_element_L2+0
;ws2812.c,978 :: 		}
L_WS2812_print_currency_value_sale204:
;ws2812.c,980 :: 		if ((pixel_position / MATRIX_WIDTH) == 3)
	MOVLW       5
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        WS2812_print_currency_value_sale_pixel_position_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_print_currency_value_sale_pixel_position_L0+1, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_currency_value_sale327
	MOVLW       3
	XORWF       R0, 0 
L__WS2812_print_currency_value_sale327:
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_print_currency_value_sale208
;ws2812.c,982 :: 		char symbol_code = 0; char* simplified_number;
	CLRF        WS2812_print_currency_value_sale_symbol_code_L3_L3_L3_L3+0 
;ws2812.c,984 :: 		if ((current_panel_iteration % 2) == 0)
	MOVLW       1
	ANDWF       _current_panel_iteration+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_print_currency_value_sale209
;ws2812.c,986 :: 		IntToStr(currentRequest.usd_sale[1], current_number); simplified_number = Ltrim(current_number);
	MOVF        _currentRequest+14, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _currentRequest+15, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       WS2812_print_currency_value_sale_current_number_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(WS2812_print_currency_value_sale_current_number_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
	MOVLW       WS2812_print_currency_value_sale_current_number_L0+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(WS2812_print_currency_value_sale_current_number_L0+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
	MOVF        R0, 0 
	MOVWF       WS2812_print_currency_value_sale_simplified_number_L3_L3_L3_L3+0 
	MOVF        R1, 0 
	MOVWF       WS2812_print_currency_value_sale_simplified_number_L3_L3_L3_L3+1 
;ws2812.c,987 :: 		}
	GOTO        L_WS2812_print_currency_value_sale210
L_WS2812_print_currency_value_sale209:
;ws2812.c,990 :: 		IntToStr(currentRequest.eur_sale[1], current_number); simplified_number = Ltrim(current_number);
	MOVF        _currentRequest+6, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _currentRequest+7, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       WS2812_print_currency_value_sale_current_number_L0+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(WS2812_print_currency_value_sale_current_number_L0+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
	MOVLW       WS2812_print_currency_value_sale_current_number_L0+0
	MOVWF       FARG_Ltrim_string+0 
	MOVLW       hi_addr(WS2812_print_currency_value_sale_current_number_L0+0)
	MOVWF       FARG_Ltrim_string+1 
	CALL        _Ltrim+0, 0
	MOVF        R0, 0 
	MOVWF       WS2812_print_currency_value_sale_simplified_number_L3_L3_L3_L3+0 
	MOVF        R1, 0 
	MOVWF       WS2812_print_currency_value_sale_simplified_number_L3_L3_L3_L3+1 
;ws2812.c,991 :: 		}
L_WS2812_print_currency_value_sale210:
;ws2812.c,993 :: 		if (strlen(simplified_number) == 1)
	MOVF        WS2812_print_currency_value_sale_simplified_number_L3_L3_L3_L3+0, 0 
	MOVWF       FARG_strlen_s+0 
	MOVF        WS2812_print_currency_value_sale_simplified_number_L3_L3_L3_L3+1, 0 
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_currency_value_sale328
	MOVLW       1
	XORWF       R0, 0 
L__WS2812_print_currency_value_sale328:
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_print_currency_value_sale211
;ws2812.c,995 :: 		symbol_code = simplified_number[0] - 48;
	MOVFF       WS2812_print_currency_value_sale_simplified_number_L3_L3_L3_L3+0, FSR0
	MOVFF       WS2812_print_currency_value_sale_simplified_number_L3_L3_L3_L3+1, FSR0H
	MOVLW       48
	SUBWF       POSTINC0+0, 0 
	MOVWF       WS2812_print_currency_value_sale_symbol_code_L3_L3_L3_L3+0 
;ws2812.c,996 :: 		}
L_WS2812_print_currency_value_sale211:
;ws2812.c,998 :: 		if (strlen(simplified_number) == 2)
	MOVF        WS2812_print_currency_value_sale_simplified_number_L3_L3_L3_L3+0, 0 
	MOVWF       FARG_strlen_s+0 
	MOVF        WS2812_print_currency_value_sale_simplified_number_L3_L3_L3_L3+1, 0 
	MOVWF       FARG_strlen_s+1 
	CALL        _strlen+0, 0
	MOVLW       0
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_currency_value_sale329
	MOVLW       2
	XORWF       R0, 0 
L__WS2812_print_currency_value_sale329:
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_print_currency_value_sale212
;ws2812.c,1000 :: 		symbol_code = simplified_number[1] - 48;
	MOVLW       1
	ADDWF       WS2812_print_currency_value_sale_simplified_number_L3_L3_L3_L3+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      WS2812_print_currency_value_sale_simplified_number_L3_L3_L3_L3+1, 0 
	MOVWF       FSR0H 
	MOVLW       48
	SUBWF       POSTINC0+0, 0 
	MOVWF       WS2812_print_currency_value_sale_symbol_code_L3_L3_L3_L3+0 
;ws2812.c,1001 :: 		}
L_WS2812_print_currency_value_sale212:
;ws2812.c,1003 :: 		matrix_element = ALPHABET_NUMBERS[symbol_code * MATRIX_HEIGHT + matrix_row];
	MOVLW       7
	MULWF       WS2812_print_currency_value_sale_symbol_code_L3_L3_L3_L3+0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        PRODH+0, 0 
	MOVWF       R1 
	MOVF        WS2812_print_currency_value_sale_matrix_row_L0+0, 0 
	ADDWF       R0, 0 
	MOVWF       R3 
	MOVF        WS2812_print_currency_value_sale_matrix_row_L0+1, 0 
	ADDWFC      R1, 0 
	MOVWF       R4 
	MOVLW       _ALPHABET_NUMBERS+0
	MOVWF       R0 
	MOVLW       hi_addr(_ALPHABET_NUMBERS+0)
	MOVWF       R1 
	MOVLW       higher_addr(_ALPHABET_NUMBERS+0)
	MOVWF       R2 
	MOVF        R3, 0 
	ADDWF       R0, 0 
	MOVWF       TBLPTRL 
	MOVF        R4, 0 
	ADDWFC      R1, 0 
	MOVWF       TBLPTRH 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       TBLPTRU 
	TBLRD*+
	MOVFF       TABLAT+0, WS2812_print_currency_value_sale_matrix_element_L2+0
;ws2812.c,1004 :: 		}
L_WS2812_print_currency_value_sale208:
;ws2812.c,1006 :: 		for (matrix_column = 0; matrix_column < MATRIX_WIDTH; ++matrix_column)
	CLRF        WS2812_print_currency_value_sale_matrix_column_L0+0 
	CLRF        WS2812_print_currency_value_sale_matrix_column_L0+1 
L_WS2812_print_currency_value_sale213:
	MOVLW       0
	SUBWF       WS2812_print_currency_value_sale_matrix_column_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_currency_value_sale330
	MOVLW       5
	SUBWF       WS2812_print_currency_value_sale_matrix_column_L0+0, 0 
L__WS2812_print_currency_value_sale330:
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_print_currency_value_sale214
;ws2812.c,1008 :: 		if (matrix_element & 0x80)
	BTFSS       WS2812_print_currency_value_sale_matrix_element_L2+0, 7 
	GOTO        L_WS2812_print_currency_value_sale216
;ws2812.c,1010 :: 		panel_currency_value_sale_pixels[matrix_row][pixel_position + matrix_column].red = current_text_color[0];
	MOVLW       60
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        WS2812_print_currency_value_sale_matrix_row_L0+0, 0 
	MOVWF       R4 
	MOVF        WS2812_print_currency_value_sale_matrix_row_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _panel_currency_value_sale_pixels+0
	ADDWF       R0, 0 
	MOVWF       FLOC__WS2812_print_currency_value_sale+0 
	MOVLW       hi_addr(_panel_currency_value_sale_pixels+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__WS2812_print_currency_value_sale+1 
	MOVF        WS2812_print_currency_value_sale_matrix_column_L0+0, 0 
	ADDWF       WS2812_print_currency_value_sale_pixel_position_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_print_currency_value_sale_matrix_column_L0+1, 0 
	ADDWFC      WS2812_print_currency_value_sale_pixel_position_L0+1, 0 
	MOVWF       R1 
	MOVLW       3
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        FLOC__WS2812_print_currency_value_sale+0, 0 
	ADDWF       R0, 1 
	MOVF        FLOC__WS2812_print_currency_value_sale+1, 0 
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        _current_text_color+0, 0 
	MOVWF       POSTINC1+0 
;ws2812.c,1011 :: 		panel_currency_value_sale_pixels[matrix_row][pixel_position + matrix_column].green = current_text_color[1];
	MOVLW       60
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        WS2812_print_currency_value_sale_matrix_row_L0+0, 0 
	MOVWF       R4 
	MOVF        WS2812_print_currency_value_sale_matrix_row_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _panel_currency_value_sale_pixels+0
	ADDWF       R0, 0 
	MOVWF       FLOC__WS2812_print_currency_value_sale+0 
	MOVLW       hi_addr(_panel_currency_value_sale_pixels+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__WS2812_print_currency_value_sale+1 
	MOVF        WS2812_print_currency_value_sale_matrix_column_L0+0, 0 
	ADDWF       WS2812_print_currency_value_sale_pixel_position_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_print_currency_value_sale_matrix_column_L0+1, 0 
	ADDWFC      WS2812_print_currency_value_sale_pixel_position_L0+1, 0 
	MOVWF       R1 
	MOVLW       3
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        FLOC__WS2812_print_currency_value_sale+0, 0 
	ADDWF       R0, 1 
	MOVF        FLOC__WS2812_print_currency_value_sale+1, 0 
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        _current_text_color+1, 0 
	MOVWF       POSTINC1+0 
;ws2812.c,1012 :: 		panel_currency_value_sale_pixels[matrix_row][pixel_position + matrix_column].blue = current_text_color[2];
	MOVLW       60
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        WS2812_print_currency_value_sale_matrix_row_L0+0, 0 
	MOVWF       R4 
	MOVF        WS2812_print_currency_value_sale_matrix_row_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _panel_currency_value_sale_pixels+0
	ADDWF       R0, 0 
	MOVWF       FLOC__WS2812_print_currency_value_sale+0 
	MOVLW       hi_addr(_panel_currency_value_sale_pixels+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__WS2812_print_currency_value_sale+1 
	MOVF        WS2812_print_currency_value_sale_matrix_column_L0+0, 0 
	ADDWF       WS2812_print_currency_value_sale_pixel_position_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_print_currency_value_sale_matrix_column_L0+1, 0 
	ADDWFC      WS2812_print_currency_value_sale_pixel_position_L0+1, 0 
	MOVWF       R1 
	MOVLW       3
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__WS2812_print_currency_value_sale+0, 0 
	MOVWF       FSR1 
	MOVF        R1, 0 
	ADDWFC      FLOC__WS2812_print_currency_value_sale+1, 0 
	MOVWF       FSR1H 
	MOVF        _current_text_color+2, 0 
	MOVWF       POSTINC1+0 
;ws2812.c,1013 :: 		}
	GOTO        L_WS2812_print_currency_value_sale217
L_WS2812_print_currency_value_sale216:
;ws2812.c,1016 :: 		panel_currency_value_sale_pixels[matrix_row][pixel_position + matrix_column].red = current_background_color[0];
	MOVLW       60
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        WS2812_print_currency_value_sale_matrix_row_L0+0, 0 
	MOVWF       R4 
	MOVF        WS2812_print_currency_value_sale_matrix_row_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _panel_currency_value_sale_pixels+0
	ADDWF       R0, 0 
	MOVWF       FLOC__WS2812_print_currency_value_sale+0 
	MOVLW       hi_addr(_panel_currency_value_sale_pixels+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__WS2812_print_currency_value_sale+1 
	MOVF        WS2812_print_currency_value_sale_matrix_column_L0+0, 0 
	ADDWF       WS2812_print_currency_value_sale_pixel_position_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_print_currency_value_sale_matrix_column_L0+1, 0 
	ADDWFC      WS2812_print_currency_value_sale_pixel_position_L0+1, 0 
	MOVWF       R1 
	MOVLW       3
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        FLOC__WS2812_print_currency_value_sale+0, 0 
	ADDWF       R0, 1 
	MOVF        FLOC__WS2812_print_currency_value_sale+1, 0 
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        _current_background_color+0, 0 
	MOVWF       POSTINC1+0 
;ws2812.c,1017 :: 		panel_currency_value_sale_pixels[matrix_row][pixel_position + matrix_column].green = current_background_color[1];
	MOVLW       60
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        WS2812_print_currency_value_sale_matrix_row_L0+0, 0 
	MOVWF       R4 
	MOVF        WS2812_print_currency_value_sale_matrix_row_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _panel_currency_value_sale_pixels+0
	ADDWF       R0, 0 
	MOVWF       FLOC__WS2812_print_currency_value_sale+0 
	MOVLW       hi_addr(_panel_currency_value_sale_pixels+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__WS2812_print_currency_value_sale+1 
	MOVF        WS2812_print_currency_value_sale_matrix_column_L0+0, 0 
	ADDWF       WS2812_print_currency_value_sale_pixel_position_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_print_currency_value_sale_matrix_column_L0+1, 0 
	ADDWFC      WS2812_print_currency_value_sale_pixel_position_L0+1, 0 
	MOVWF       R1 
	MOVLW       3
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        FLOC__WS2812_print_currency_value_sale+0, 0 
	ADDWF       R0, 1 
	MOVF        FLOC__WS2812_print_currency_value_sale+1, 0 
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        _current_background_color+1, 0 
	MOVWF       POSTINC1+0 
;ws2812.c,1018 :: 		panel_currency_value_sale_pixels[matrix_row][pixel_position + matrix_column].blue = current_background_color[2];
	MOVLW       60
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        WS2812_print_currency_value_sale_matrix_row_L0+0, 0 
	MOVWF       R4 
	MOVF        WS2812_print_currency_value_sale_matrix_row_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _panel_currency_value_sale_pixels+0
	ADDWF       R0, 0 
	MOVWF       FLOC__WS2812_print_currency_value_sale+0 
	MOVLW       hi_addr(_panel_currency_value_sale_pixels+0)
	ADDWFC      R1, 0 
	MOVWF       FLOC__WS2812_print_currency_value_sale+1 
	MOVF        WS2812_print_currency_value_sale_matrix_column_L0+0, 0 
	ADDWF       WS2812_print_currency_value_sale_pixel_position_L0+0, 0 
	MOVWF       R0 
	MOVF        WS2812_print_currency_value_sale_matrix_column_L0+1, 0 
	ADDWFC      WS2812_print_currency_value_sale_pixel_position_L0+1, 0 
	MOVWF       R1 
	MOVLW       3
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       FLOC__WS2812_print_currency_value_sale+0, 0 
	MOVWF       FSR1 
	MOVF        R1, 0 
	ADDWFC      FLOC__WS2812_print_currency_value_sale+1, 0 
	MOVWF       FSR1H 
	MOVF        _current_background_color+2, 0 
	MOVWF       POSTINC1+0 
;ws2812.c,1019 :: 		}
L_WS2812_print_currency_value_sale217:
;ws2812.c,1021 :: 		matrix_element = matrix_element << 1;
	RLCF        WS2812_print_currency_value_sale_matrix_element_L2+0, 1 
	BCF         WS2812_print_currency_value_sale_matrix_element_L2+0, 0 
;ws2812.c,1006 :: 		for (matrix_column = 0; matrix_column < MATRIX_WIDTH; ++matrix_column)
	INFSNZ      WS2812_print_currency_value_sale_matrix_column_L0+0, 1 
	INCF        WS2812_print_currency_value_sale_matrix_column_L0+1, 1 
;ws2812.c,1022 :: 		}
	GOTO        L_WS2812_print_currency_value_sale213
L_WS2812_print_currency_value_sale214:
;ws2812.c,908 :: 		for (matrix_row = 0; matrix_row < MATRIX_HEIGHT; ++matrix_row)
	INFSNZ      WS2812_print_currency_value_sale_matrix_row_L0+0, 1 
	INCF        WS2812_print_currency_value_sale_matrix_row_L0+1, 1 
;ws2812.c,1023 :: 		}
	GOTO        L_WS2812_print_currency_value_sale192
L_WS2812_print_currency_value_sale193:
;ws2812.c,906 :: 		for (pixel_position = 0; pixel_position < PANEL_CURRENCY_VALUE_SALE_WIDTH; pixel_position += MATRIX_WIDTH)
	MOVLW       5
	ADDWF       WS2812_print_currency_value_sale_pixel_position_L0+0, 1 
	MOVLW       0
	ADDWFC      WS2812_print_currency_value_sale_pixel_position_L0+1, 1 
;ws2812.c,1024 :: 		}
	GOTO        L_WS2812_print_currency_value_sale189
L_WS2812_print_currency_value_sale190:
;ws2812.c,1026 :: 		for (panel_row = 0; panel_row < PANEL_CURRENCY_VALUE_SALE_WIDTH; ++panel_row)
	CLRF        WS2812_print_currency_value_sale_panel_row_L0+0 
	CLRF        WS2812_print_currency_value_sale_panel_row_L0+1 
L_WS2812_print_currency_value_sale218:
	MOVLW       0
	SUBWF       WS2812_print_currency_value_sale_panel_row_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_currency_value_sale331
	MOVLW       20
	SUBWF       WS2812_print_currency_value_sale_panel_row_L0+0, 0 
L__WS2812_print_currency_value_sale331:
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_print_currency_value_sale219
;ws2812.c,1029 :: 		unsigned char mask_enable = PANEL_CURRENCY_VALUE_SALE_PORT | (0x01 << panel_row);
	MOVF        WS2812_print_currency_value_sale_panel_row_L0+0, 0 
	MOVWF       R0 
	MOVLW       1
	MOVWF       R2 
	MOVLW       0
	MOVWF       R3 
	MOVF        R0, 0 
L__WS2812_print_currency_value_sale332:
	BZ          L__WS2812_print_currency_value_sale333
	RLCF        R2, 1 
	BCF         R2, 0 
	RLCF        R3, 1 
	ADDLW       255
	GOTO        L__WS2812_print_currency_value_sale332
L__WS2812_print_currency_value_sale333:
	MOVF        R2, 0 
	IORWF       LATH+0, 0 
	MOVWF       R0 
	MOVLW       0
	IORWF       R3, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       WS2812_print_currency_value_sale_mask_enable_L1+0 
;ws2812.c,1031 :: 		unsigned char mask_disable = PANEL_CURRENCY_VALUE_SALE_PORT & ~(0x01 << panel_row);
	COMF        R2, 0 
	MOVWF       R0 
	COMF        R3, 0 
	MOVWF       R1 
	MOVF        LATH+0, 0 
	ANDWF       R0, 1 
	MOVLW       0
	ANDWF       R1, 1 
	MOVF        R0, 0 
	MOVWF       WS2812_print_currency_value_sale_mask_disable_L1+0 
;ws2812.c,1034 :: 		PixelParameter* pixels = panel_currency_value_sale_pixels[panel_row];
	MOVLW       60
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        WS2812_print_currency_value_sale_panel_row_L0+0, 0 
	MOVWF       R4 
	MOVF        WS2812_print_currency_value_sale_panel_row_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       _panel_currency_value_sale_pixels+0
	ADDWF       R0, 0 
	MOVWF       WS2812_print_currency_value_sale_pixels_L1+0 
	MOVLW       hi_addr(_panel_currency_value_sale_pixels+0)
	ADDWFC      R1, 0 
	MOVWF       WS2812_print_currency_value_sale_pixels_L1+1 
;ws2812.c,1036 :: 		for (panel_column = 0; panel_column < PANEL_CURRENCY_VALUE_SALE_WIDTH; ++panel_column)
	CLRF        WS2812_print_currency_value_sale_panel_column_L0+0 
	CLRF        WS2812_print_currency_value_sale_panel_column_L0+1 
L_WS2812_print_currency_value_sale221:
	MOVLW       0
	SUBWF       WS2812_print_currency_value_sale_panel_column_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__WS2812_print_currency_value_sale334
	MOVLW       20
	SUBWF       WS2812_print_currency_value_sale_panel_column_L0+0, 0 
L__WS2812_print_currency_value_sale334:
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_print_currency_value_sale222
;ws2812.c,1039 :: 		current_byte = pixels[panel_column].green;
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        WS2812_print_currency_value_sale_panel_column_L0+0, 0 
	MOVWF       R4 
	MOVF        WS2812_print_currency_value_sale_panel_column_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        WS2812_print_currency_value_sale_pixels_L1+0, 0 
	ADDWF       R0, 1 
	MOVF        WS2812_print_currency_value_sale_pixels_L1+1, 0 
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       WS2812_print_currency_value_sale_current_byte_L0+0 
;ws2812.c,1041 :: 		for (current_bit = 0; current_bit < 8; ++current_bit)
	CLRF        WS2812_print_currency_value_sale_current_bit_L0+0 
L_WS2812_print_currency_value_sale224:
	MOVLW       8
	SUBWF       WS2812_print_currency_value_sale_current_bit_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_print_currency_value_sale225
;ws2812.c,1043 :: 		if (current_byte & 0x80)
	BTFSS       WS2812_print_currency_value_sale_current_byte_L0+0, 7 
	GOTO        L_WS2812_print_currency_value_sale227
;ws2812.c,1045 :: 		PANEL_CURRENCY_VALUE_SALE_PORT = mask_enable;
	MOVF        WS2812_print_currency_value_sale_mask_enable_L1+0, 0 
	MOVWF       LATH+0 
;ws2812.c,1047 :: 		WS2812_delay_long();
	CALL        _WS2812_delay_long+0, 0
;ws2812.c,1049 :: 		PANEL_CURRENCY_VALUE_SALE_PORT = mask_disable;
	MOVF        WS2812_print_currency_value_sale_mask_disable_L1+0, 0 
	MOVWF       LATH+0 
;ws2812.c,1050 :: 		}
	GOTO        L_WS2812_print_currency_value_sale228
L_WS2812_print_currency_value_sale227:
;ws2812.c,1053 :: 		PANEL_CURRENCY_VALUE_SALE_PORT = mask_enable;
	MOVF        WS2812_print_currency_value_sale_mask_enable_L1+0, 0 
	MOVWF       LATH+0 
;ws2812.c,1055 :: 		PANEL_CURRENCY_VALUE_SALE_PORT = mask_disable;
	MOVF        WS2812_print_currency_value_sale_mask_disable_L1+0, 0 
	MOVWF       LATH+0 
;ws2812.c,1056 :: 		}
L_WS2812_print_currency_value_sale228:
;ws2812.c,1058 :: 		current_byte = current_byte << 1;
	RLCF        WS2812_print_currency_value_sale_current_byte_L0+0, 1 
	BCF         WS2812_print_currency_value_sale_current_byte_L0+0, 0 
;ws2812.c,1041 :: 		for (current_bit = 0; current_bit < 8; ++current_bit)
	INCF        WS2812_print_currency_value_sale_current_bit_L0+0, 1 
;ws2812.c,1059 :: 		}
	GOTO        L_WS2812_print_currency_value_sale224
L_WS2812_print_currency_value_sale225:
;ws2812.c,1062 :: 		current_byte = pixels[panel_column].red;
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        WS2812_print_currency_value_sale_panel_column_L0+0, 0 
	MOVWF       R4 
	MOVF        WS2812_print_currency_value_sale_panel_column_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        WS2812_print_currency_value_sale_pixels_L1+0, 0 
	ADDWF       R0, 1 
	MOVF        WS2812_print_currency_value_sale_pixels_L1+1, 0 
	ADDWFC      R1, 1 
	MOVLW       2
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       WS2812_print_currency_value_sale_current_byte_L0+0 
;ws2812.c,1064 :: 		for (current_bit = 0; current_bit < 8; ++current_bit)
	CLRF        WS2812_print_currency_value_sale_current_bit_L0+0 
L_WS2812_print_currency_value_sale229:
	MOVLW       8
	SUBWF       WS2812_print_currency_value_sale_current_bit_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_print_currency_value_sale230
;ws2812.c,1066 :: 		if (current_byte & 0x80)
	BTFSS       WS2812_print_currency_value_sale_current_byte_L0+0, 7 
	GOTO        L_WS2812_print_currency_value_sale232
;ws2812.c,1068 :: 		PANEL_CURRENCY_VALUE_SALE_PORT = mask_enable;
	MOVF        WS2812_print_currency_value_sale_mask_enable_L1+0, 0 
	MOVWF       LATH+0 
;ws2812.c,1070 :: 		WS2812_delay_long();
	CALL        _WS2812_delay_long+0, 0
;ws2812.c,1072 :: 		PANEL_CURRENCY_VALUE_SALE_PORT = mask_disable;
	MOVF        WS2812_print_currency_value_sale_mask_disable_L1+0, 0 
	MOVWF       LATH+0 
;ws2812.c,1073 :: 		}
	GOTO        L_WS2812_print_currency_value_sale233
L_WS2812_print_currency_value_sale232:
;ws2812.c,1076 :: 		PANEL_CURRENCY_VALUE_SALE_PORT = mask_enable;
	MOVF        WS2812_print_currency_value_sale_mask_enable_L1+0, 0 
	MOVWF       LATH+0 
;ws2812.c,1078 :: 		PANEL_CURRENCY_VALUE_SALE_PORT = mask_disable;
	MOVF        WS2812_print_currency_value_sale_mask_disable_L1+0, 0 
	MOVWF       LATH+0 
;ws2812.c,1079 :: 		}
L_WS2812_print_currency_value_sale233:
;ws2812.c,1081 :: 		current_byte = current_byte << 1;
	RLCF        WS2812_print_currency_value_sale_current_byte_L0+0, 1 
	BCF         WS2812_print_currency_value_sale_current_byte_L0+0, 0 
;ws2812.c,1064 :: 		for (current_bit = 0; current_bit < 8; ++current_bit)
	INCF        WS2812_print_currency_value_sale_current_bit_L0+0, 1 
;ws2812.c,1082 :: 		}
	GOTO        L_WS2812_print_currency_value_sale229
L_WS2812_print_currency_value_sale230:
;ws2812.c,1085 :: 		current_byte = pixels[panel_column].blue;
	MOVLW       3
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        WS2812_print_currency_value_sale_panel_column_L0+0, 0 
	MOVWF       R4 
	MOVF        WS2812_print_currency_value_sale_panel_column_L0+1, 0 
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVF        R0, 0 
	ADDWF       WS2812_print_currency_value_sale_pixels_L1+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      WS2812_print_currency_value_sale_pixels_L1+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       WS2812_print_currency_value_sale_current_byte_L0+0 
;ws2812.c,1087 :: 		for (current_bit = 0; current_bit < 8; ++current_bit)
	CLRF        WS2812_print_currency_value_sale_current_bit_L0+0 
L_WS2812_print_currency_value_sale234:
	MOVLW       8
	SUBWF       WS2812_print_currency_value_sale_current_bit_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_WS2812_print_currency_value_sale235
;ws2812.c,1089 :: 		if (current_byte & 0x80)
	BTFSS       WS2812_print_currency_value_sale_current_byte_L0+0, 7 
	GOTO        L_WS2812_print_currency_value_sale237
;ws2812.c,1091 :: 		PANEL_CURRENCY_VALUE_SALE_PORT = mask_enable;
	MOVF        WS2812_print_currency_value_sale_mask_enable_L1+0, 0 
	MOVWF       LATH+0 
;ws2812.c,1093 :: 		WS2812_delay_long();
	CALL        _WS2812_delay_long+0, 0
;ws2812.c,1095 :: 		PANEL_CURRENCY_VALUE_SALE_PORT = mask_disable;
	MOVF        WS2812_print_currency_value_sale_mask_disable_L1+0, 0 
	MOVWF       LATH+0 
;ws2812.c,1096 :: 		}
	GOTO        L_WS2812_print_currency_value_sale238
L_WS2812_print_currency_value_sale237:
;ws2812.c,1099 :: 		PANEL_CURRENCY_VALUE_SALE_PORT = mask_enable;
	MOVF        WS2812_print_currency_value_sale_mask_enable_L1+0, 0 
	MOVWF       LATH+0 
;ws2812.c,1101 :: 		PANEL_CURRENCY_VALUE_SALE_PORT = mask_disable;
	MOVF        WS2812_print_currency_value_sale_mask_disable_L1+0, 0 
	MOVWF       LATH+0 
;ws2812.c,1102 :: 		}
L_WS2812_print_currency_value_sale238:
;ws2812.c,1104 :: 		current_byte = current_byte << 1;
	RLCF        WS2812_print_currency_value_sale_current_byte_L0+0, 1 
	BCF         WS2812_print_currency_value_sale_current_byte_L0+0, 0 
;ws2812.c,1087 :: 		for (current_bit = 0; current_bit < 8; ++current_bit)
	INCF        WS2812_print_currency_value_sale_current_bit_L0+0, 1 
;ws2812.c,1105 :: 		}
	GOTO        L_WS2812_print_currency_value_sale234
L_WS2812_print_currency_value_sale235:
;ws2812.c,1036 :: 		for (panel_column = 0; panel_column < PANEL_CURRENCY_VALUE_SALE_WIDTH; ++panel_column)
	INFSNZ      WS2812_print_currency_value_sale_panel_column_L0+0, 1 
	INCF        WS2812_print_currency_value_sale_panel_column_L0+1, 1 
;ws2812.c,1106 :: 		}
	GOTO        L_WS2812_print_currency_value_sale221
L_WS2812_print_currency_value_sale222:
;ws2812.c,1109 :: 		Delay_us(50);
	MOVLW       2
	MOVWF       R12, 0
	MOVLW       8
	MOVWF       R13, 0
L_WS2812_print_currency_value_sale239:
	DECFSZ      R13, 1, 1
	BRA         L_WS2812_print_currency_value_sale239
	DECFSZ      R12, 1, 1
	BRA         L_WS2812_print_currency_value_sale239
	NOP
;ws2812.c,1026 :: 		for (panel_row = 0; panel_row < PANEL_CURRENCY_VALUE_SALE_WIDTH; ++panel_row)
	INFSNZ      WS2812_print_currency_value_sale_panel_row_L0+0, 1 
	INCF        WS2812_print_currency_value_sale_panel_row_L0+1, 1 
;ws2812.c,1110 :: 		}
	GOTO        L_WS2812_print_currency_value_sale218
L_WS2812_print_currency_value_sale219:
;ws2812.c,1111 :: 		}
L_end_WS2812_print_currency_value_sale:
	RETURN      0
; end of _WS2812_print_currency_value_sale

_WS2812_decrease_time:

;ws2812.c,1114 :: 		void WS2812_decrease_time()
;ws2812.c,1116 :: 		if (currentTime.second == 0)
	MOVF        _currentTime+2, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_decrease_time240
;ws2812.c,1118 :: 		currentTime.second = 59;
	MOVLW       59
	MOVWF       _currentTime+2 
;ws2812.c,1119 :: 		currentTime.minute = currentTime.minute - 1;
	DECF        _currentTime+1, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _currentTime+1 
;ws2812.c,1120 :: 		}
	GOTO        L_WS2812_decrease_time241
L_WS2812_decrease_time240:
;ws2812.c,1123 :: 		currentTime.second = currentTime.second - 1;
	DECF        _currentTime+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _currentTime+2 
;ws2812.c,1124 :: 		}
L_WS2812_decrease_time241:
;ws2812.c,1126 :: 		if (currentTime.minute == 0)
	MOVF        _currentTime+1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_decrease_time242
;ws2812.c,1128 :: 		currentTime.minute = 59;
	MOVLW       59
	MOVWF       _currentTime+1 
;ws2812.c,1129 :: 		currentTime.hour = currentTime.hour - 1;
	DECF        _currentTime+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _currentTime+0 
;ws2812.c,1130 :: 		}
L_WS2812_decrease_time242:
;ws2812.c,1132 :: 		if (currentTime.hour == 0)
	MOVF        _currentTime+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_decrease_time243
;ws2812.c,1134 :: 		currentTime.hour = 23;
	MOVLW       23
	MOVWF       _currentTime+0 
;ws2812.c,1135 :: 		currentTime.minute = 59;
	MOVLW       59
	MOVWF       _currentTime+1 
;ws2812.c,1136 :: 		currentTime.second = 59;
	MOVLW       59
	MOVWF       _currentTime+2 
;ws2812.c,1137 :: 		}
L_WS2812_decrease_time243:
;ws2812.c,1138 :: 		}
L_end_WS2812_decrease_time:
	RETURN      0
; end of _WS2812_decrease_time

_WS2812_increase_time:

;ws2812.c,1141 :: 		void WS2812_increase_time()
;ws2812.c,1143 :: 		currentTime.second = currentTime.second + 1;
	MOVF        _currentTime+2, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _currentTime+2 
;ws2812.c,1145 :: 		if (currentTime.second == 60)
	MOVF        _currentTime+2, 0 
	XORLW       60
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_increase_time244
;ws2812.c,1147 :: 		currentTime.second = 0;
	CLRF        _currentTime+2 
;ws2812.c,1148 :: 		currentTime.minute = currentTime.minute + 1;
	MOVF        _currentTime+1, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _currentTime+1 
;ws2812.c,1149 :: 		}
L_WS2812_increase_time244:
;ws2812.c,1151 :: 		if (currentTime.minute == 60)
	MOVF        _currentTime+1, 0 
	XORLW       60
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_increase_time245
;ws2812.c,1153 :: 		currentTime.minute = 0;
	CLRF        _currentTime+1 
;ws2812.c,1154 :: 		currentTime.hour = currentTime.hour + 1;
	MOVF        _currentTime+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _currentTime+0 
;ws2812.c,1155 :: 		}
L_WS2812_increase_time245:
;ws2812.c,1157 :: 		if (currentTime.hour == 24)
	MOVF        _currentTime+0, 0 
	XORLW       24
	BTFSS       STATUS+0, 2 
	GOTO        L_WS2812_increase_time246
;ws2812.c,1159 :: 		currentTime.hour = 0;
	CLRF        _currentTime+0 
;ws2812.c,1160 :: 		currentTime.minute = 0;
	CLRF        _currentTime+1 
;ws2812.c,1161 :: 		currentTime.second = 0;
	CLRF        _currentTime+2 
;ws2812.c,1162 :: 		}
L_WS2812_increase_time246:
;ws2812.c,1163 :: 		}
L_end_WS2812_increase_time:
	RETURN      0
; end of _WS2812_increase_time

_interrupt:

;ws2812.c,1166 :: 		void interrupt()
;ws2812.c,1168 :: 		if (TMR0IF_bit)
	BTFSS       TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
	GOTO        L_interrupt247
;ws2812.c,1171 :: 		if ((current_panel_iteration % 15) == 0)
	MOVLW       15
	MOVWF       R4 
	MOVF        _current_panel_iteration+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt248
;ws2812.c,1173 :: 		WS2812_print_currency_name();
	CALL        _WS2812_print_currency_name+0, 0
;ws2812.c,1174 :: 		WS2812_print_currency_value_buy();
	CALL        _WS2812_print_currency_value_buy+0, 0
;ws2812.c,1175 :: 		WS2812_print_currency_value_sale();
	CALL        _WS2812_print_currency_value_sale+0, 0
;ws2812.c,1176 :: 		}
L_interrupt248:
;ws2812.c,1179 :: 		if ((current_panel_iteration % 10) == 0)
	MOVLW       10
	MOVWF       R4 
	MOVF        _current_panel_iteration+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt249
;ws2812.c,1181 :: 		WS2812_print_clock(); WS2812_increase_time();
	CALL        _WS2812_print_clock+0, 0
	CALL        _WS2812_increase_time+0, 0
;ws2812.c,1182 :: 		}
L_interrupt249:
;ws2812.c,1184 :: 		++current_panel_iteration;
	INCF        _current_panel_iteration+0, 1 
;ws2812.c,1187 :: 		TMR0IF_bit = 0;
	BCF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
;ws2812.c,1189 :: 		T0CON = 0x87;
	MOVLW       135
	MOVWF       T0CON+0 
;ws2812.c,1191 :: 		TMR0L = 0x48;
	MOVLW       72
	MOVWF       TMR0L+0 
;ws2812.c,1192 :: 		TMR0H = 0xE5;
	MOVLW       229
	MOVWF       TMR0H+0 
;ws2812.c,1194 :: 		GIE_bit = 1;
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;ws2812.c,1196 :: 		TMR0IE_bit = 1;
	BSF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;ws2812.c,1197 :: 		}
L_interrupt247:
;ws2812.c,1198 :: 		}
L_end_interrupt:
L__interrupt338:
	RETFIE      1
; end of _interrupt
