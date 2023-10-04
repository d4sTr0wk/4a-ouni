; Compiled with: PIC Simulator IDE v8.55
; Microcontroller model: PIC16F877A
; Clock frequency: 4.0MHz
;
;       The address of 'd1' (byte) (global) is 0x021
;       The address of 'd2' (byte) (global) is 0x022
;       The address of 'display' (byte) (global) is 0x020
	ORG 0x0000
	BCF PCLATH,3
	BCF PCLATH,4
	GOTO L0004
	ORG 0x0004
	RETFIE
; User code start
L0004:
; 1: Dim d1 As Byte
; 2: Dim d2 As Byte
; 3: Dim display As Byte
; 4: d1 = 0
	CLRF 0x021
; 5: d2 = 0
	CLRF 0x022
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
	MOVF 0x021,W
	MOVWF 0x020
; 10: Gosub calculadisplay
	CALL L0003
; 11: PORTC = display
	MOVF 0x020,W
	MOVWF PORTC
; 12: bucle:
L0002:
; 13: d1 = PORTB
	MOVF PORTB,W
	MOVWF 0x021
; 14: If d2 = d1 Then Goto bucle
	MOVF 0x022,W
	SUBWF 0x021,W
	BTFSS STATUS,Z
	GOTO L0005
	GOTO L0002
L0005:
; 15: d2 = d1
	MOVF 0x021,W
	MOVWF 0x022
; 16: Goto main
	GOTO L0001
; 17: End
L0006:	GOTO L0006
; 18: calculadisplay:
L0003:
; 19: Select Case display
; 20: Case 0
	MOVF 0x020,W
	SUBLW 0x00
	BTFSS STATUS,Z
	GOTO L0007
; 21: display = %00111111
	MOVLW 0x3F
	MOVWF 0x020
; 22: Case 1
	GOTO L0008
L0007:
	MOVF 0x020,W
	SUBLW 0x01
	BTFSS STATUS,Z
	GOTO L0009
; 23: display = %01000000
	MOVLW 0x40
	MOVWF 0x020
; 24: EndSelect
L0009:
L0008:
; 25: Return
	RETURN
; 26: 
; 27: 
; End of user code
L0010:	GOTO L0010
;
;
;
;
;
;
; End of listing
	END
