
_DS1302_init:

;ds1302.c,28 :: 		void DS1302_init()
;ds1302.c,30 :: 		DS1302_RST = 0;
	BCF         RB5_bit+0, BitPos(RB5_bit+0) 
;ds1302.c,31 :: 		DS1302_CLK = 0;
	BCF         RB6_bit+0, BitPos(RB6_bit+0) 
;ds1302.c,33 :: 		Delay_ms(5);
	MOVLW       104
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_DS1302_init0:
	DECFSZ      R13, 1, 1
	BRA         L_DS1302_init0
	DECFSZ      R12, 1, 1
	BRA         L_DS1302_init0
	NOP
;ds1302.c,35 :: 		DS1302_write(CONTROL_WREG, 0x00);
	MOVLW       142
	MOVWF       FARG_DS1302_write_address+0 
	CLRF        FARG_DS1302_write_value+0 
	CALL        _DS1302_write+0, 0
;ds1302.c,36 :: 		DS1302_write(CHARGE_WREG, 0xA9);
	MOVLW       144
	MOVWF       FARG_DS1302_write_address+0 
	MOVLW       169
	MOVWF       FARG_DS1302_write_value+0 
	CALL        _DS1302_write+0, 0
;ds1302.c,37 :: 		}
L_end_DS1302_init:
	RETURN      0
; end of _DS1302_init

_DS1302_get_date:

;ds1302.c,40 :: 		void DS1302_get_date(Date* current_date)
;ds1302.c,43 :: 		current_date->year = DS1302_read(YEAR_RREG);
	MOVLW       2
	ADDWF       FARG_DS1302_get_date_current_date+0, 0 
	MOVWF       FLOC__DS1302_get_date+0 
	MOVLW       0
	ADDWFC      FARG_DS1302_get_date_current_date+1, 0 
	MOVWF       FLOC__DS1302_get_date+1 
	MOVLW       141
	MOVWF       FARG_DS1302_read_address+0 
	CALL        _DS1302_read+0, 0
	MOVFF       FLOC__DS1302_get_date+0, FSR1
	MOVFF       FLOC__DS1302_get_date+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;ds1302.c,45 :: 		current_date->year = bcd_to_decimal((0xFF & current_date->year));
	MOVLW       2
	ADDWF       FARG_DS1302_get_date_current_date+0, 0 
	MOVWF       FLOC__DS1302_get_date+0 
	MOVLW       0
	ADDWFC      FARG_DS1302_get_date_current_date+1, 0 
	MOVWF       FLOC__DS1302_get_date+1 
	MOVFF       FLOC__DS1302_get_date+0, FSR2
	MOVFF       FLOC__DS1302_get_date+1, FSR2H
	MOVLW       255
	ANDWF       POSTINC2+0, 0 
	MOVWF       FARG_bcd_to_decimal_value+0 
	CALL        _bcd_to_decimal+0, 0
	MOVFF       FLOC__DS1302_get_date+0, FSR1
	MOVFF       FLOC__DS1302_get_date+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;ds1302.c,48 :: 		current_date->month = DS1302_read(MONTH_RREG);
	MOVLW       1
	ADDWF       FARG_DS1302_get_date_current_date+0, 0 
	MOVWF       FLOC__DS1302_get_date+0 
	MOVLW       0
	ADDWFC      FARG_DS1302_get_date_current_date+1, 0 
	MOVWF       FLOC__DS1302_get_date+1 
	MOVLW       137
	MOVWF       FARG_DS1302_read_address+0 
	CALL        _DS1302_read+0, 0
	MOVFF       FLOC__DS1302_get_date+0, FSR1
	MOVFF       FLOC__DS1302_get_date+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;ds1302.c,50 :: 		current_date->month = bcd_to_decimal((0x1F & current_date->month));
	MOVLW       1
	ADDWF       FARG_DS1302_get_date_current_date+0, 0 
	MOVWF       FLOC__DS1302_get_date+0 
	MOVLW       0
	ADDWFC      FARG_DS1302_get_date_current_date+1, 0 
	MOVWF       FLOC__DS1302_get_date+1 
	MOVFF       FLOC__DS1302_get_date+0, FSR2
	MOVFF       FLOC__DS1302_get_date+1, FSR2H
	MOVLW       31
	ANDWF       POSTINC2+0, 0 
	MOVWF       FARG_bcd_to_decimal_value+0 
	CALL        _bcd_to_decimal+0, 0
	MOVFF       FLOC__DS1302_get_date+0, FSR1
	MOVFF       FLOC__DS1302_get_date+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;ds1302.c,53 :: 		current_date->day = DS1302_read(DAY_RREG);
	MOVF        FARG_DS1302_get_date_current_date+0, 0 
	MOVWF       FLOC__DS1302_get_date+0 
	MOVF        FARG_DS1302_get_date_current_date+1, 0 
	MOVWF       FLOC__DS1302_get_date+1 
	MOVLW       135
	MOVWF       FARG_DS1302_read_address+0 
	CALL        _DS1302_read+0, 0
	MOVFF       FLOC__DS1302_get_date+0, FSR1
	MOVFF       FLOC__DS1302_get_date+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;ds1302.c,55 :: 		current_date->day = bcd_to_decimal((0x3F & current_date->day));
	MOVF        FARG_DS1302_get_date_current_date+0, 0 
	MOVWF       FLOC__DS1302_get_date+0 
	MOVF        FARG_DS1302_get_date_current_date+1, 0 
	MOVWF       FLOC__DS1302_get_date+1 
	MOVFF       FARG_DS1302_get_date_current_date+0, FSR0
	MOVFF       FARG_DS1302_get_date_current_date+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVLW       63
	ANDWF       R0, 0 
	MOVWF       FARG_bcd_to_decimal_value+0 
	CALL        _bcd_to_decimal+0, 0
	MOVFF       FLOC__DS1302_get_date+0, FSR1
	MOVFF       FLOC__DS1302_get_date+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;ds1302.c,56 :: 		}
L_end_DS1302_get_date:
	RETURN      0
; end of _DS1302_get_date

_DS1302_set_date:

;ds1302.c,59 :: 		void DS1302_set_date(Date* current_date)
;ds1302.c,62 :: 		DS1302_write(YEAR_WREG, decimal_to_bcd(current_date->year));
	MOVLW       2
	ADDWF       FARG_DS1302_set_date_current_date+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DS1302_set_date_current_date+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_decimal_to_bcd_value+0 
	CALL        _decimal_to_bcd+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_DS1302_write_value+0 
	MOVLW       140
	MOVWF       FARG_DS1302_write_address+0 
	CALL        _DS1302_write+0, 0
;ds1302.c,65 :: 		DS1302_write(MONTH_WREG, decimal_to_bcd(current_date->month));
	MOVLW       1
	ADDWF       FARG_DS1302_set_date_current_date+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DS1302_set_date_current_date+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_decimal_to_bcd_value+0 
	CALL        _decimal_to_bcd+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_DS1302_write_value+0 
	MOVLW       136
	MOVWF       FARG_DS1302_write_address+0 
	CALL        _DS1302_write+0, 0
;ds1302.c,68 :: 		DS1302_write(DAY_WREG, decimal_to_bcd(current_date->day));
	MOVFF       FARG_DS1302_set_date_current_date+0, FSR0
	MOVFF       FARG_DS1302_set_date_current_date+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_decimal_to_bcd_value+0 
	CALL        _decimal_to_bcd+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_DS1302_write_value+0 
	MOVLW       134
	MOVWF       FARG_DS1302_write_address+0 
	CALL        _DS1302_write+0, 0
;ds1302.c,69 :: 		}
L_end_DS1302_set_date:
	RETURN      0
; end of _DS1302_set_date

_DS1302_get_time:

;ds1302.c,72 :: 		void DS1302_get_time(Time* current_time)
;ds1302.c,75 :: 		current_time->hour = DS1302_read(HOUR_RREG);
	MOVF        FARG_DS1302_get_time_current_time+0, 0 
	MOVWF       FLOC__DS1302_get_time+0 
	MOVF        FARG_DS1302_get_time_current_time+1, 0 
	MOVWF       FLOC__DS1302_get_time+1 
	MOVLW       133
	MOVWF       FARG_DS1302_read_address+0 
	CALL        _DS1302_read+0, 0
	MOVFF       FLOC__DS1302_get_time+0, FSR1
	MOVFF       FLOC__DS1302_get_time+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;ds1302.c,77 :: 		current_time->hour = bcd_to_decimal((0x3F & current_time->hour));
	MOVF        FARG_DS1302_get_time_current_time+0, 0 
	MOVWF       FLOC__DS1302_get_time+0 
	MOVF        FARG_DS1302_get_time_current_time+1, 0 
	MOVWF       FLOC__DS1302_get_time+1 
	MOVFF       FARG_DS1302_get_time_current_time+0, FSR0
	MOVFF       FARG_DS1302_get_time_current_time+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVLW       63
	ANDWF       R0, 0 
	MOVWF       FARG_bcd_to_decimal_value+0 
	CALL        _bcd_to_decimal+0, 0
	MOVFF       FLOC__DS1302_get_time+0, FSR1
	MOVFF       FLOC__DS1302_get_time+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;ds1302.c,80 :: 		current_time->minute = DS1302_read(MINUTE_RREG);
	MOVLW       1
	ADDWF       FARG_DS1302_get_time_current_time+0, 0 
	MOVWF       FLOC__DS1302_get_time+0 
	MOVLW       0
	ADDWFC      FARG_DS1302_get_time_current_time+1, 0 
	MOVWF       FLOC__DS1302_get_time+1 
	MOVLW       131
	MOVWF       FARG_DS1302_read_address+0 
	CALL        _DS1302_read+0, 0
	MOVFF       FLOC__DS1302_get_time+0, FSR1
	MOVFF       FLOC__DS1302_get_time+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;ds1302.c,82 :: 		current_time->minute = bcd_to_decimal((0x7F & current_time->minute));
	MOVLW       1
	ADDWF       FARG_DS1302_get_time_current_time+0, 0 
	MOVWF       FLOC__DS1302_get_time+0 
	MOVLW       0
	ADDWFC      FARG_DS1302_get_time_current_time+1, 0 
	MOVWF       FLOC__DS1302_get_time+1 
	MOVFF       FLOC__DS1302_get_time+0, FSR2
	MOVFF       FLOC__DS1302_get_time+1, FSR2H
	MOVLW       127
	ANDWF       POSTINC2+0, 0 
	MOVWF       FARG_bcd_to_decimal_value+0 
	CALL        _bcd_to_decimal+0, 0
	MOVFF       FLOC__DS1302_get_time+0, FSR1
	MOVFF       FLOC__DS1302_get_time+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;ds1302.c,85 :: 		current_time->second = DS1302_read(SECOND_RREG);
	MOVLW       2
	ADDWF       FARG_DS1302_get_time_current_time+0, 0 
	MOVWF       FLOC__DS1302_get_time+0 
	MOVLW       0
	ADDWFC      FARG_DS1302_get_time_current_time+1, 0 
	MOVWF       FLOC__DS1302_get_time+1 
	MOVLW       129
	MOVWF       FARG_DS1302_read_address+0 
	CALL        _DS1302_read+0, 0
	MOVFF       FLOC__DS1302_get_time+0, FSR1
	MOVFF       FLOC__DS1302_get_time+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;ds1302.c,87 :: 		current_time->second = bcd_to_decimal((0x7F & current_time->second));
	MOVLW       2
	ADDWF       FARG_DS1302_get_time_current_time+0, 0 
	MOVWF       FLOC__DS1302_get_time+0 
	MOVLW       0
	ADDWFC      FARG_DS1302_get_time_current_time+1, 0 
	MOVWF       FLOC__DS1302_get_time+1 
	MOVFF       FLOC__DS1302_get_time+0, FSR2
	MOVFF       FLOC__DS1302_get_time+1, FSR2H
	MOVLW       127
	ANDWF       POSTINC2+0, 0 
	MOVWF       FARG_bcd_to_decimal_value+0 
	CALL        _bcd_to_decimal+0, 0
	MOVFF       FLOC__DS1302_get_time+0, FSR1
	MOVFF       FLOC__DS1302_get_time+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;ds1302.c,88 :: 		}
L_end_DS1302_get_time:
	RETURN      0
; end of _DS1302_get_time

_DS1302_set_time:

;ds1302.c,91 :: 		void DS1302_set_time(Time* current_time)
;ds1302.c,94 :: 		DS1302_write(HOUR_WREG, decimal_to_bcd(current_time->hour));
	MOVFF       FARG_DS1302_set_time_current_time+0, FSR0
	MOVFF       FARG_DS1302_set_time_current_time+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_decimal_to_bcd_value+0 
	CALL        _decimal_to_bcd+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_DS1302_write_value+0 
	MOVLW       132
	MOVWF       FARG_DS1302_write_address+0 
	CALL        _DS1302_write+0, 0
;ds1302.c,97 :: 		DS1302_write(MINUTE_WREG, decimal_to_bcd(current_time->minute));
	MOVLW       1
	ADDWF       FARG_DS1302_set_time_current_time+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DS1302_set_time_current_time+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_decimal_to_bcd_value+0 
	CALL        _decimal_to_bcd+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_DS1302_write_value+0 
	MOVLW       130
	MOVWF       FARG_DS1302_write_address+0 
	CALL        _DS1302_write+0, 0
;ds1302.c,100 :: 		DS1302_write(SECOND_WREG, decimal_to_bcd(current_time->second));
	MOVLW       2
	ADDWF       FARG_DS1302_set_time_current_time+0, 0 
	MOVWF       FSR0 
	MOVLW       0
	ADDWFC      FARG_DS1302_set_time_current_time+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_decimal_to_bcd_value+0 
	CALL        _decimal_to_bcd+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_DS1302_write_value+0 
	MOVLW       128
	MOVWF       FARG_DS1302_write_address+0 
	CALL        _DS1302_write+0, 0
;ds1302.c,101 :: 		}
L_end_DS1302_set_time:
	RETURN      0
; end of _DS1302_set_time

_DS1302_serial_read:

;ds1302.c,104 :: 		unsigned char DS1302_serial_read()
;ds1302.c,106 :: 		unsigned char value = 0;
	CLRF        DS1302_serial_read_value_L0+0 
	CLRF        DS1302_serial_read_byte_L0+0 
	MOVLW       1
	MOVWF       DS1302_serial_read_mask_L0+0 
;ds1302.c,112 :: 		DS1302_IO_DIRECTION = 1;
	BSF         TRISB7_bit+0, BitPos(TRISB7_bit+0) 
;ds1302.c,114 :: 		for (byte = 0; byte < 8; ++byte)
	CLRF        DS1302_serial_read_byte_L0+0 
L_DS1302_serial_read1:
	MOVLW       8
	SUBWF       DS1302_serial_read_byte_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_DS1302_serial_read2
;ds1302.c,116 :: 		if (DS1302_IO_VALUE)
	BTFSS       RB7_bit+0, BitPos(RB7_bit+0) 
	GOTO        L_DS1302_serial_read4
;ds1302.c,118 :: 		value |= mask;
	MOVF        DS1302_serial_read_mask_L0+0, 0 
	IORWF       DS1302_serial_read_value_L0+0, 1 
;ds1302.c,119 :: 		}
L_DS1302_serial_read4:
;ds1302.c,121 :: 		DS1302_CLK = 1;
	BSF         RB6_bit+0, BitPos(RB6_bit+0) 
;ds1302.c,122 :: 		DS1302_CLK = 0;
	BCF         RB6_bit+0, BitPos(RB6_bit+0) 
;ds1302.c,124 :: 		mask <<= 1;
	RLCF        DS1302_serial_read_mask_L0+0, 1 
	BCF         DS1302_serial_read_mask_L0+0, 0 
;ds1302.c,114 :: 		for (byte = 0; byte < 8; ++byte)
	INCF        DS1302_serial_read_byte_L0+0, 1 
;ds1302.c,125 :: 		}
	GOTO        L_DS1302_serial_read1
L_DS1302_serial_read2:
;ds1302.c,127 :: 		return value;
	MOVF        DS1302_serial_read_value_L0+0, 0 
	MOVWF       R0 
;ds1302.c,128 :: 		}
L_end_DS1302_serial_read:
	RETURN      0
; end of _DS1302_serial_read

_DS1302_serial_write:

;ds1302.c,131 :: 		void DS1302_serial_write(unsigned char value)
;ds1302.c,133 :: 		unsigned char byte = 0;
	CLRF        DS1302_serial_write_byte_L0+0 
	MOVLW       1
	MOVWF       DS1302_serial_write_mask_L0+0 
;ds1302.c,137 :: 		DS1302_IO_DIRECTION = 0;
	BCF         TRISB7_bit+0, BitPos(TRISB7_bit+0) 
;ds1302.c,139 :: 		for (byte = 0; byte < 8; ++byte)
	CLRF        DS1302_serial_write_byte_L0+0 
L_DS1302_serial_write5:
	MOVLW       8
	SUBWF       DS1302_serial_write_byte_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_DS1302_serial_write6
;ds1302.c,141 :: 		if (mask & value)
	MOVF        FARG_DS1302_serial_write_value+0, 0 
	ANDWF       DS1302_serial_write_mask_L0+0, 0 
	MOVWF       R0 
	BTFSC       STATUS+0, 2 
	GOTO        L_DS1302_serial_write8
;ds1302.c,143 :: 		DS1302_IO_VALUE = 1;
	BSF         RB7_bit+0, BitPos(RB7_bit+0) 
;ds1302.c,144 :: 		}
	GOTO        L_DS1302_serial_write9
L_DS1302_serial_write8:
;ds1302.c,147 :: 		DS1302_IO_VALUE = 0;
	BCF         RB7_bit+0, BitPos(RB7_bit+0) 
;ds1302.c,148 :: 		}
L_DS1302_serial_write9:
;ds1302.c,150 :: 		DS1302_CLK = 1;
	BSF         RB6_bit+0, BitPos(RB6_bit+0) 
;ds1302.c,151 :: 		DS1302_CLK = 0;
	BCF         RB6_bit+0, BitPos(RB6_bit+0) 
;ds1302.c,153 :: 		mask <<= 1;
	RLCF        DS1302_serial_write_mask_L0+0, 1 
	BCF         DS1302_serial_write_mask_L0+0, 0 
;ds1302.c,139 :: 		for (byte = 0; byte < 8; ++byte)
	INCF        DS1302_serial_write_byte_L0+0, 1 
;ds1302.c,154 :: 		}
	GOTO        L_DS1302_serial_write5
L_DS1302_serial_write6:
;ds1302.c,155 :: 		}
L_end_DS1302_serial_write:
	RETURN      0
; end of _DS1302_serial_write

_DS1302_read:

;ds1302.c,158 :: 		unsigned char DS1302_read(unsigned char address)
;ds1302.c,160 :: 		unsigned char value = 0;
;ds1302.c,162 :: 		DS1302_RST = 1;
	BSF         RB5_bit+0, BitPos(RB5_bit+0) 
;ds1302.c,164 :: 		DS1302_serial_write(address); value = DS1302_serial_read();
	MOVF        FARG_DS1302_read_address+0, 0 
	MOVWF       FARG_DS1302_serial_write_value+0 
	CALL        _DS1302_serial_write+0, 0
	CALL        _DS1302_serial_read+0, 0
;ds1302.c,166 :: 		DS1302_RST = 0;
	BCF         RB5_bit+0, BitPos(RB5_bit+0) 
;ds1302.c,168 :: 		return value;
;ds1302.c,169 :: 		}
L_end_DS1302_read:
	RETURN      0
; end of _DS1302_read

_DS1302_write:

;ds1302.c,172 :: 		void DS1302_write(unsigned char address, unsigned char value)
;ds1302.c,174 :: 		DS1302_RST = 1;
	BSF         RB5_bit+0, BitPos(RB5_bit+0) 
;ds1302.c,176 :: 		DS1302_serial_write(address); DS1302_serial_write(value);
	MOVF        FARG_DS1302_write_address+0, 0 
	MOVWF       FARG_DS1302_serial_write_value+0 
	CALL        _DS1302_serial_write+0, 0
	MOVF        FARG_DS1302_write_value+0, 0 
	MOVWF       FARG_DS1302_serial_write_value+0 
	CALL        _DS1302_serial_write+0, 0
;ds1302.c,178 :: 		DS1302_RST = 0;
	BCF         RB5_bit+0, BitPos(RB5_bit+0) 
;ds1302.c,179 :: 		}
L_end_DS1302_write:
	RETURN      0
; end of _DS1302_write

_bcd_to_decimal:

;ds1302.c,182 :: 		unsigned char bcd_to_decimal(unsigned char value)
;ds1302.c,184 :: 		return ((value & 0x0F) + (((value & 0xF0) >> 4) * 10));
	MOVLW       15
	ANDWF       FARG_bcd_to_decimal_value+0, 0 
	MOVWF       R3 
	MOVLW       240
	ANDWF       FARG_bcd_to_decimal_value+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVLW       10
	MULWF       R0 
	MOVF        PRODL+0, 0 
	MOVWF       R0 
	MOVF        R3, 0 
	ADDWF       R0, 1 
;ds1302.c,185 :: 		}
L_end_bcd_to_decimal:
	RETURN      0
; end of _bcd_to_decimal

_decimal_to_bcd:

;ds1302.c,188 :: 		unsigned char decimal_to_bcd(unsigned char value)
;ds1302.c,190 :: 		return ((((value / 10) << 4) & 0xF0) | ((value % 10) & 0x0F));
	MOVLW       10
	MOVWF       R4 
	MOVF        FARG_decimal_to_bcd_value+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R0, 0 
	MOVWF       R1 
	RLCF        R1, 1 
	BCF         R1, 0 
	RLCF        R1, 1 
	BCF         R1, 0 
	RLCF        R1, 1 
	BCF         R1, 0 
	RLCF        R1, 1 
	BCF         R1, 0 
	MOVLW       240
	ANDWF       R1, 0 
	MOVWF       FLOC__decimal_to_bcd+0 
	MOVLW       10
	MOVWF       R4 
	MOVF        FARG_decimal_to_bcd_value+0, 0 
	MOVWF       R0 
	CALL        _Div_8X8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVLW       15
	ANDWF       R0, 1 
	MOVF        FLOC__decimal_to_bcd+0, 0 
	IORWF       R0, 1 
;ds1302.c,191 :: 		}
L_end_decimal_to_bcd:
	RETURN      0
; end of _decimal_to_bcd
