; Compiled with: PIC Simulator IDE v8.55
; Microcontroller model: PIC16F877A
; Clock frequency: 4.0MHz
;
	R0L EQU 0x020
;       The address of 'd1' (byte) (global) is 0x022
;       The address of 'punto' (byte) (global) is 0x023
;       The address of 'display' (byte) (global) is 0x021
	ORG 0x0000
	BCF PCLATH,3
	BCF PCLATH,4
	GOTO L0003
	ORG 0x0004
	RETFIE
; User code start
L0003:
; 1: Dim d1 As Byte
; 2: Dim punto As Byte
; 3: Dim display As Byte
; 4: d1 = 0
	CLRF 0x022
; 5: punto = 0
	CLRF 0x023
; 6: TRISB = 0x01
	MOVLW 0x01
	BSF STATUS,RP0
	MOVWF TRISB
; 7: TRISC = 0
	CLRF TRISC
	BCF STATUS,RP0
; 8: main:
L0001:
; 9: display = d1
	MOVF 0x022,W
	MOVWF 0x021
; 10: Gosub calculadisplay
	CALL L0002
; 11: PORTC = display
	MOVF 0x021,W
	MOVWF PORTC
; 12: d1 = PORTB
	MOVF PORTB,W
	MOVWF 0x022
; 13: Toggle punto.7
	MOVLW 0x80
	XORWF 0x023,F
; 14: Goto main
	GOTO L0001
; 15: End
L0004:	GOTO L0004
; 16: calculadisplay:
L0002:
; 17: Select Case display
; 18: Case 0
	MOVF 0x021,W
	SUBLW 0x00
	BTFSS STATUS,Z
	GOTO L0005
; 19: display = %00111111
	MOVLW 0x3F
	MOVWF 0x021
; 20: Case 1
	GOTO L0006
L0005:
	MOVF 0x021,W
	SUBLW 0x01
	BTFSS STATUS,Z
	GOTO L0007
; 21: display = %01000000
	MOVLW 0x40
	MOVWF 0x021
; 22: EndSelect
L0007:
L0006:
; 23: display = display Or punto
	MOVF 0x021,W
	MOVWF R0L
	MOVF 0x023,W
	IORWF R0L,W
	MOVWF 0x021
; 24: Return
	RETURN
; 25: 
; 26: 
; End of user code
L0008:	GOTO L0008
;
;
;
;
;
;
; End of listing
	END
