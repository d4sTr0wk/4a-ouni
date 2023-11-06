; Compiled with: PIC Simulator IDE v8.55
; Microcontroller model: PIC16F877A
; Clock frequency: 4.0MHz
;
	R0L EQU 0x020
	R0H EQU 0x021
	R0HL EQU 0x020
	W_TEMP EQU 0x07F
	STATUS_TEMP EQU 0x07E
;       The address of 'd1' (byte) (global) is 0x023
;       The address of 'flagtimer' (bit) (global) is 0x024,0
;       The address of 'display' (byte) (global) is 0x022
;       The address of 'display1' (byte) (global) is 0x025
;       The address of 'display2' (byte) (global) is 0x026
	ORG 0x0000
	BCF PCLATH,3
	BCF PCLATH,4
	GOTO L0004
	ORG 0x0004
	MOVWF W_TEMP
	SWAPF STATUS,W
	CLRF STATUS
	MOVWF STATUS_TEMP
	CALL L0005
	SWAPF STATUS_TEMP,W
	MOVWF STATUS
	SWAPF W_TEMP,F
	SWAPF W_TEMP,W
	RETFIE
; User code start
L0004:
; 1: Dim d1 As Byte
; 2: Dim flagtimer As Bit
; 3: Dim display As Byte
; 4: Dim display1 As Byte
; 5: Dim display2 As Byte
; 6: d1 = 0
	CLRF 0x023
; 7: flagtimer = 0
	BCF 0x024,0
; 8: OPTION_REG.T0CS = False
	BSF STATUS,RP0
	BCF OPTION_REG,5
	BCF STATUS,RP0
; 9: INTCON = %10110000
	MOVLW 0xB0
	MOVWF INTCON
; 10: TRISB = %00000001
	MOVLW 0x01
	BSF STATUS,RP0
	MOVWF TRISB
; 11: TRISA = 0
	CLRF TRISA
; 12: TRISD = 0
	CLRF TRISD
	BCF STATUS,RP0
; 13: PORTA = %00110000  //Displays 3 y 4 activados
	MOVLW 0x30
	MOVWF PORTA
; 14: main:
L0001:
; 15: // Mientras se calcula el número no pueden haber interrupciones
; 16: INTCON.GIE = 0
	BCF INTCON,7
; 17: display = d1 >> 4
	MOVF 0x023,W
	MOVWF R0L
	CLRF R0H
	MOVLW 0x04
	CALL SR00
	MOVF R0L,W
	MOVWF 0x022
; 18: Gosub calculadisplay
	CALL L0003
; 19: display1 = display
	MOVF 0x022,W
	MOVWF 0x025
; 20: display = d1 And 0x0f
	MOVF 0x023,W
	MOVWF R0L
	MOVLW 0x0F
	ANDWF R0L,W
	MOVWF 0x022
; 21: Gosub calculadisplay
	CALL L0003
; 22: display2 = display
	MOVF 0x022,W
	MOVWF 0x026
; 23: INTCON.GIE = 1
	BSF INTCON,7
; 24: TMR0 = 0
	CLRF TMR0
; 25: While flagtimer = 0
L0006:
	BTFSC 0x024,0
	GOTO L0007
; 26: PORTA = %00100000
	MOVLW 0x20
	MOVWF PORTA
; 27: PORTD = display1
	MOVF 0x025,W
	MOVWF PORTD
; 28: PORTA = %00010000
	MOVLW 0x10
	MOVWF PORTA
; 29: PORTD = display2
	MOVF 0x026,W
	MOVWF PORTD
; 30: Wend
	GOTO L0006
L0007:
; 31: If flagtimer = 1 Then
	BTFSS 0x024,0
	GOTO L0008
; 32: Gosub nextd1
	CALL L0002
; 33: Endif
L0008:
; 34: Goto main
	GOTO L0001
; 35: End
L0009:	GOTO L0009
; 36: nextd1:
L0002:
; 37: If d1 = 32 Then
	MOVF 0x023,W
	SUBLW 0x20
	BTFSS STATUS,Z
	GOTO L0010
; 38: d1 = 0
	CLRF 0x023
; 39: Else
	GOTO L0011
L0010:
; 40: d1 = d1 + 1
	INCF 0x023,F
; 41: Endif
L0011:
; 42: flagtimer = 0
	BCF 0x024,0
; 43: Return
	RETURN
; 44: calculadisplay:
L0003:
; 45: Select Case display
; 46: Case 0
	MOVF 0x022,W
	SUBLW 0x00
	BTFSS STATUS,Z
	GOTO L0012
; 47: display = %00111111
	MOVLW 0x3F
	MOVWF 0x022
; 48: Case 1
	GOTO L0013
L0012:
	MOVF 0x022,W
	SUBLW 0x01
	BTFSS STATUS,Z
	GOTO L0014
; 49: display = %00000110
	MOVLW 0x06
	MOVWF 0x022
; 50: Case 2
	GOTO L0015
L0014:
	MOVF 0x022,W
	SUBLW 0x02
	BTFSS STATUS,Z
	GOTO L0016
; 51: display = %01011011
	MOVLW 0x5B
	MOVWF 0x022
; 52: Case 3
	GOTO L0017
L0016:
	MOVF 0x022,W
	SUBLW 0x03
	BTFSS STATUS,Z
	GOTO L0018
; 53: display = %01001111
	MOVLW 0x4F
	MOVWF 0x022
; 54: Case 4
	GOTO L0019
L0018:
	MOVF 0x022,W
	SUBLW 0x04
	BTFSS STATUS,Z
	GOTO L0020
; 55: display = %01100110
	MOVLW 0x66
	MOVWF 0x022
; 56: Case 5
	GOTO L0021
L0020:
	MOVF 0x022,W
	SUBLW 0x05
	BTFSS STATUS,Z
	GOTO L0022
; 57: display = %01101101
	MOVLW 0x6D
	MOVWF 0x022
; 58: Case 6
	GOTO L0023
L0022:
	MOVF 0x022,W
	SUBLW 0x06
	BTFSS STATUS,Z
	GOTO L0024
; 59: display = %01111101
	MOVLW 0x7D
	MOVWF 0x022
; 60: Case 7
	GOTO L0025
L0024:
	MOVF 0x022,W
	SUBLW 0x07
	BTFSS STATUS,Z
	GOTO L0026
; 61: display = %00000111
	MOVLW 0x07
	MOVWF 0x022
; 62: Case 8
	GOTO L0027
L0026:
	MOVF 0x022,W
	SUBLW 0x08
	BTFSS STATUS,Z
	GOTO L0028
; 63: display = %01111111
	MOVLW 0x7F
	MOVWF 0x022
; 64: Case 9
	GOTO L0029
L0028:
	MOVF 0x022,W
	SUBLW 0x09
	BTFSS STATUS,Z
	GOTO L0030
; 65: display = %01100111
	MOVLW 0x67
	MOVWF 0x022
; 66: Case 10
	GOTO L0031
L0030:
	MOVF 0x022,W
	SUBLW 0x0A
	BTFSS STATUS,Z
	GOTO L0032
; 67: display = %01110111
	MOVLW 0x77
	MOVWF 0x022
; 68: Case 11
	GOTO L0033
L0032:
	MOVF 0x022,W
	SUBLW 0x0B
	BTFSS STATUS,Z
	GOTO L0034
; 69: display = %01111100
	MOVLW 0x7C
	MOVWF 0x022
; 70: Case 12
	GOTO L0035
L0034:
	MOVF 0x022,W
	SUBLW 0x0C
	BTFSS STATUS,Z
	GOTO L0036
; 71: display = %00111001
	MOVLW 0x39
	MOVWF 0x022
; 72: Case 13
	GOTO L0037
L0036:
	MOVF 0x022,W
	SUBLW 0x0D
	BTFSS STATUS,Z
	GOTO L0038
; 73: display = %01011110
	MOVLW 0x5E
	MOVWF 0x022
; 74: Case 14
	GOTO L0039
L0038:
	MOVF 0x022,W
	SUBLW 0x0E
	BTFSS STATUS,Z
	GOTO L0040
; 75: display = %01111001
	MOVLW 0x79
	MOVWF 0x022
; 76: Case 15
	GOTO L0041
L0040:
	MOVF 0x022,W
	SUBLW 0x0F
	BTFSS STATUS,Z
	GOTO L0042
; 77: display = %01110001
	MOVLW 0x71
	MOVWF 0x022
; 78: EndSelect
L0042:
L0041:
L0039:
L0037:
L0035:
L0033:
L0031:
L0029:
L0027:
L0025:
L0023:
L0021:
L0019:
L0017:
L0015:
L0013:
; 79: Return
	RETURN
; 80: On Interrupt
L0005:
; 81: If INTCON.INTF = 1 Then
	BTFSS 0x00B,1
	GOTO L0043
; 82: Toggle INTCON.TMR0IE
	MOVLW 0x20
	XORWF INTCON,F
; 83: flagtimer = 0
	BCF 0x024,0
; 84: INTCON.INTF = 0
	BCF INTCON,1
; 85: Endif
L0043:
; 86: If INTCON.T0IF = 1 Then
	BTFSS 0x00B,2
	GOTO L0044
; 87: flagtimer = 1
	BSF 0x024,0
; 88: INTCON.TMR0IF = 0
	BCF INTCON,2
; 89: Endif
L0044:
; 90: Resume
	RETURN
; End of user code
L0045:	GOTO L0045
;
;
;
;
; Word ShiftRight Routine
SR01:	BCF STATUS,C
	RRF R0H,F
	RRF R0L,F
SR00:	ADDLW 0xFF
	BTFSC STATUS,C
	GOTO SR01
	RETURN
;
;
; End of listing
	END
