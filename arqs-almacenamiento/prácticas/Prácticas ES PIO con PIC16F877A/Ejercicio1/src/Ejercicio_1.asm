; Compiled with: PIC Simulator IDE v8.55
; Microcontroller model: PIC16F877A
; Clock frequency: 4.0MHz
;
;       The address of 'd1' (byte) (global) is 0x021
;       The address of 'display' (byte) (global) is 0x020
	ORG 0x0000
	BCF PCLATH,3
	BCF PCLATH,4
	GOTO L0003
	ORG 0x0004
	RETFIE
; User code start
L0003:
; 1: Dim d1 As Byte
; 2: Dim display As Byte
; 3: d1 = 0
	CLRF 0x021
; 4: TRISB = 0
	BSF STATUS,RP0
	CLRF TRISB
	BCF STATUS,RP0
; 5: main:
L0001:
; 6: display = d1
	MOVF 0x021,W
	MOVWF 0x020
; 7: Gosub calculadisplay
	CALL L0002
; 8: PORTB = display
	MOVF 0x020,W
	MOVWF PORTB
; 9: d1 = d1 + 1
	INCF 0x021,F
; 10: If d1 = 10 Then
	MOVF 0x021,W
	SUBLW 0x0A
	BTFSS STATUS,Z
	GOTO L0004
; 11: d1 = 0
	CLRF 0x021
; 12: Endif
L0004:
; 13: Goto main
	GOTO L0001
; 14: End
L0005:	GOTO L0005
; 15: calculadisplay:
L0002:
; 16: Select Case display
; 17: Case 0
	MOVF 0x020,W
	SUBLW 0x00
	BTFSS STATUS,Z
	GOTO L0006
; 18: display = %00111111
	MOVLW 0x3F
	MOVWF 0x020
; 19: Case 1
	GOTO L0007
L0006:
	MOVF 0x020,W
	SUBLW 0x01
	BTFSS STATUS,Z
	GOTO L0008
; 20: display = %00000110
	MOVLW 0x06
	MOVWF 0x020
; 21: Case 2
	GOTO L0009
L0008:
	MOVF 0x020,W
	SUBLW 0x02
	BTFSS STATUS,Z
	GOTO L0010
; 22: display = %01011011
	MOVLW 0x5B
	MOVWF 0x020
; 23: Case 3
	GOTO L0011
L0010:
	MOVF 0x020,W
	SUBLW 0x03
	BTFSS STATUS,Z
	GOTO L0012
; 24: display = %01001111
	MOVLW 0x4F
	MOVWF 0x020
; 25: Case 4
	GOTO L0013
L0012:
	MOVF 0x020,W
	SUBLW 0x04
	BTFSS STATUS,Z
	GOTO L0014
; 26: display = %01100110
	MOVLW 0x66
	MOVWF 0x020
; 27: Case 5
	GOTO L0015
L0014:
	MOVF 0x020,W
	SUBLW 0x05
	BTFSS STATUS,Z
	GOTO L0016
; 28: display = %01101101
	MOVLW 0x6D
	MOVWF 0x020
; 29: Case 6
	GOTO L0017
L0016:
	MOVF 0x020,W
	SUBLW 0x06
	BTFSS STATUS,Z
	GOTO L0018
; 30: display = %01111101
	MOVLW 0x7D
	MOVWF 0x020
; 31: Case 7
	GOTO L0019
L0018:
	MOVF 0x020,W
	SUBLW 0x07
	BTFSS STATUS,Z
	GOTO L0020
; 32: display = %00000111
	MOVLW 0x07
	MOVWF 0x020
; 33: Case 8
	GOTO L0021
L0020:
	MOVF 0x020,W
	SUBLW 0x08
	BTFSS STATUS,Z
	GOTO L0022
; 34: display = %01111111
	MOVLW 0x7F
	MOVWF 0x020
; 35: Case 9
	GOTO L0023
L0022:
	MOVF 0x020,W
	SUBLW 0x09
	BTFSS STATUS,Z
	GOTO L0024
; 36: display = %01100111
	MOVLW 0x67
	MOVWF 0x020
; 37: EndSelect
L0024:
L0023:
L0021:
L0019:
L0017:
L0015:
L0013:
L0011:
L0009:
L0007:
; 38: Return
	RETURN
; 39: 
; 40: 
; End of user code
L0025:	GOTO L0025
;
;
;
;
;
;
; End of listing
	END
