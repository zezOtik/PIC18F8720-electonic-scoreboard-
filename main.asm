
_main:

;main.c,7 :: 		void main()
;main.c,10 :: 		PIC18F26K20_init();
	CALL        _PIC18F26K20_init+0, 0
;main.c,12 :: 		ENC28J60_init();
	CALL        _ENC28J60_init+0, 0
;main.c,14 :: 		DS1302_init();
	CALL        _DS1302_init+0, 0
;main.c,16 :: 		WS2812_init();
	CALL        _WS2812_init+0, 0
;main.c,18 :: 		while (1)
L_main0:
;main.c,21 :: 		if (ENC28J60_had_request())
	CALL        _ENC28J60_had_request+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main2
;main.c,23 :: 		WS2812_prepare_data();
	CALL        _WS2812_prepare_data+0, 0
;main.c,24 :: 		}
L_main2:
;main.c,25 :: 		}
	GOTO        L_main0
;main.c,26 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_PIC18F26K20_init:

;main.c,28 :: 		void PIC18F26K20_init()
;main.c,31 :: 		TRISB = 0x00;
	CLRF        TRISB+0 
;main.c,32 :: 		TRISE = 0x00;
	CLRF        TRISE+0 
;main.c,33 :: 		TRISF = 0x00;
	CLRF        TRISF+0 
;main.c,34 :: 		TRISH = 0x00;
	CLRF        TRISH+0 
;main.c,35 :: 		TRISJ = 0x00;
	CLRF        TRISJ+0 
;main.c,37 :: 		PORTB = 0x00;
	CLRF        PORTB+0 
;main.c,38 :: 		PORTE = 0x00;
	CLRF        PORTE+0 
;main.c,39 :: 		PORTF = 0x00;
	CLRF        PORTF+0 
;main.c,40 :: 		PORTH = 0x00;
	CLRF        PORTH+0 
;main.c,41 :: 		PORTJ = 0x00;
	CLRF        PORTJ+0 
;main.c,44 :: 		SPI1_Init_Advanced(_SPI_MASTER_OSC_DIV16,
	MOVLW       1
	MOVWF       FARG_SPI1_Init_Advanced_master+0 
;main.c,45 :: 		_SPI_DATA_SAMPLE_MIDDLE,
	CLRF        FARG_SPI1_Init_Advanced_data_sample+0 
;main.c,46 :: 		_SPI_CLK_IDLE_LOW,
	CLRF        FARG_SPI1_Init_Advanced_clock_idle+0 
;main.c,47 :: 		_SPI_HIGH_2_LOW);
	CLRF        FARG_SPI1_Init_Advanced_transmit_edge+0 
	CALL        _SPI1_Init_Advanced+0, 0
;main.c,48 :: 		}
L_end_PIC18F26K20_init:
	RETURN      0
; end of _PIC18F26K20_init
