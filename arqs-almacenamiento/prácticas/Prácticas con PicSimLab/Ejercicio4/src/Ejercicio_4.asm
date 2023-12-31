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
	ORG 0x0000
	BCF PCLATH,3
	BCF PCLATH,4
	GOTO L0002
	ORG 0x0004
	RETFIE
; User code start
L0002:
; 1: TRISB = %00111111
	MOVLW 0x3F
	BSF STATUS,RP0
	MOVWF TRISB
; 2: TRISD = %00000000
	CLRF TRISD
	BCF STATUS,RP0
; 3: PORTB = 0
	CLRF PORTB
; 4: PORTD = 0
	CLRF PORTD
; 5: INTCON = %00000000
	CLRF INTCON
; 6: Dim i As Byte
; 7: Dim auxiliar As Byte
; 8: main:
L0001:
; 9: For i = 0 To 5 Step 1
	CLRF 0x025
L0003:
	MOVF 0x025,W
	SUBLW 0x05
	BTFSS STATUS,C
	GOTO L0004
; 10: auxiliar = (1 << i)
	MOVLW 0x01
	MOVWF R0L
	CLRF R0H
	MOVF 0x025,W
	CALL SL00
	MOVF R0L,W
	MOVWF 0x026
; 11: If PORTB.i = 0 Then
	MOVF PORTB,W
	MOVWF R1L
	CLRF R1H
	MOVF 0x025,W
	MOVWF R0H
	CALL BI01
	BTFSC R1L,0
	GOTO L0005
; 12: PORTD = (1 << i)
	MOVLW 0x01
	MOVWF R0L
	CLRF R0H
	MOVF 0x025,W
	CALL SL00
	MOVF R0L,W
	MOVWF PORTD
; 13: While PORTB.i = 0
L0006:
	MOVF PORTB,W
	MOVWF R1L
	CLRF R1H
	MOVF 0x025,W
	MOVWF R0H
	CALL BI01
	BTFSC R1L,0
	GOTO L0007
; 14: Wend
	GOTO L0006
L0007:
; 15: Else
	GOTO L0008
L0005:
; 16: PORTD = %10000000
	MOVLW 0x80
	MOVWF PORTD
; 17: Endif
L0008:
; 18: Next i
	MOVLW 0x01
	ADDWF 0x025,F
	BTFSS STATUS,C
	GOTO L0003
L0004:
; 19: Goto main
	GOTO L0001
; 20: End
L0009:	GOTO L0009
; End of user code
L0010:	GOTO L0010
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
