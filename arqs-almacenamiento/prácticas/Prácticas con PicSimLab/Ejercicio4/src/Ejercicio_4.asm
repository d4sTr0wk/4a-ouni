; Compiled with: PIC Simulator IDE v8.55
; Microcontroller model: PIC16F877A
; Clock frequency: 1.0MHz
;
	R0L EQU 0x020
	R0H EQU 0x021
	R0HL EQU 0x020
;       The address of 'i' (byte) (global) is 0x022
;       The address of 'auxiliar' (byte) (global) is 0x023
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
; 8: main:
L0001:
; 9: For i = 0 To 5 Step 1
	CLRF 0x022
L0003:
	MOVF 0x022,W
	SUBLW 0x05
	BTFSS STATUS,C
	GOTO L0004
; 10: auxiliar = (1 << i)
	MOVLW 0x01
	MOVWF R0L
	CLRF R0H
	MOVF 0x022,W
	CALL SL00
	MOVF R0L,W
	MOVWF 0x023
; 11: If (PORTB And auxiliar) = auxiliar Then
	oshonsoft_temp_b1 EQU 0x024
	MOVF PORTB,W
	MOVWF R0L
	MOVF 0x023,W
	ANDWF R0L,W
	MOVWF 0x024
;       oshonsoft_temp_bit2 EQU 0x025,0
	BCF 0x025,0
	MOVF 0x024,W
	SUBWF 0x023,W
	BTFSS STATUS,Z
	GOTO L0006
	BSF 0x025,0
L0006:
	BTFSS 0x025,0
	GOTO L0005
; 12: PORTD = (1 << i)
	MOVLW 0x01
	MOVWF R0L
	CLRF R0H
	MOVF 0x022,W
	CALL SL00
	MOVF R0L,W
	MOVWF PORTD
; 13: Else
	GOTO L0007
L0005:
; 14: PORTD.7 = 1
	BSF PORTD,7
; 15: Endif
L0007:
; 16: Next i
	MOVLW 0x01
	ADDWF 0x022,F
	BTFSS STATUS,C
	GOTO L0003
L0004:
; 17: Goto main
	GOTO L0001
; 18: End
L0008:	GOTO L0008
; End of user code
L0009:	GOTO L0009
;
;
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
