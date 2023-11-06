; Compiled with: PIC Simulator IDE v8.55
; Microcontroller model: PIC16F877A
; Clock frequency: 1.0MHz
;
	R0L EQU 0x020
	R0H EQU 0x021
	R1L EQU 0x022
	R1H EQU 0x023
	R2L EQU 0x024
	R0HL EQU 0x020
	R1HL EQU 0x022
	R1HL0HL EQU 0x020
;       The address of 'i' (byte) (global) is 0x025
;       The address of 'auxiliar' (byte) (global) is 0x026
;       The address of 'check' (bit) (global) is 0x027,0
	ORG 0x0000
	BCF PCLATH,3
	BCF PCLATH,4
	GOTO L0002
	ORG 0x0004
	RETFIE
; User code start
L0002:
; 1: TRISB = 1
	MOVLW 0x01
	BSF STATUS,RP0
	MOVWF TRISB
; 2: TRISD = 0
	CLRF TRISD
	BCF STATUS,RP0
; 3: PORTB = 0
	CLRF PORTB
; 4: PORTD = 0
	CLRF PORTD
; 5: INTCON = 0
	CLRF INTCON
; 6: Dim i As Byte
; 7: Dim auxiliar As Byte
; 8: Dim check As Bit
; 9: check = 0
	BCF 0x027,0
; 10: main:
L0001:
; 11: For i = 0 To 5 Step 1
	CLRF 0x025
L0003:
	MOVF 0x025,W
	SUBLW 0x05
	BTFSS STATUS,C
	GOTO L0004
; 12: auxiliar = (1 << i)
	MOVLW 0x01
	MOVWF R0L
	CLRF R0H
	MOVF 0x025,W
	CALL SL00
	MOVF R0L,W
	MOVWF 0x026
; 13: If (PORTB And auxiliar) = auxiliar Then
	oshonsoft_temp_b1 EQU 0x028
	MOVF PORTB,W
	MOVWF R0L
	MOVF 0x026,W
	ANDWF R0L,W
	MOVWF 0x028
;       oshonsoft_temp_bit2 EQU 0x029,0
	BCF 0x029,0
	MOVF 0x028,W
	SUBWF 0x026,W
	BTFSS STATUS,Z
	GOTO L0006
	BSF 0x029,0
L0006:
	BTFSS 0x029,0
	GOTO L0005
; 14: PORTD = (1 << i)
	MOVLW 0x01
	MOVWF R0L
	CLRF R0H
	MOVF 0x025,W
	CALL SL00
	MOVF R0L,W
	MOVWF PORTD
; 15: While PORTB.i = 1
L0007:
	MOVF PORTB,W
	MOVWF R1L
	CLRF R1H
	MOVF 0x025,W
	MOVWF R0H
	CALL BI01
	BTFSS R1L,0
	GOTO L0008
; 16: Wend
	GOTO L0007
L0008:
; 17: Else
	GOTO L0009
L0005:
; 18: PORTD.7 = 1
	BSF PORTD,7
; 19: Endif
L0009:
; 20: Next i
	MOVLW 0x01
	ADDWF 0x025,F
	BTFSS STATUS,C
	GOTO L0003
L0004:
; 21: Goto main
	GOTO L0001
; 22: End
L0010:	GOTO L0010
; End of user code
L0011:	GOTO L0011
;
;
; Bit Index Routine
BI01:	INCF R0H,F
	RLF R1L,F
	RLF R1H,F
BI02:	RRF R1H,F
	RRF R1L,F
	DECFSZ R0H,F
	GOTO BI02
	RETURN
BI10:	MOVLW 0x11
	MOVWF R2L
	INCF R1H,F
	RLF R0L,F
	RLF R0H,F
	GOTO BI11
BI12:	BCF STATUS,C
	BTFSC R0L,0
	BSF STATUS,C
BI11:	RRF R0H,F
	RRF R0L,F
	DECF R1H,F
	BTFSC STATUS,Z
	CALL BI13
	DECFSZ R2L,F
	GOTO BI12
	RETURN
BI13:	BCF R0L,0
	BTFSC R1L,0
	BSF R0L,0
	RETURN
;
;
; Word ShiftLeft Routine
SL01:	BCF STATUS,C
	RLF R0L,F
	RLF R0H,F
SL00:	ADDLW 0xFF
	BTFSC STATUS,C
	GOTO SL01
	RETURN
;
;
; End of listing
	END
