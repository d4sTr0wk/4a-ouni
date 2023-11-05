; Compiled with: PIC Simulator IDE v8.55
; Microcontroller model: PIC16F877A
; Clock frequency: 1.0MHz
;
	R0L EQU 0x020
	R0H EQU 0x021
	R0HL EQU 0x020
	W_TEMP EQU 0x07F
	STATUS_TEMP EQU 0x07E
;       The address of 'first_reg' (byte) (global) is 0x023
;       The address of 'last_reg' (byte) (global) is 0x024
;       The address of 'solution' (byte) (global) is 0x026
;       The address of 'display' (byte) (global) is 0x022
;       The address of 'flagrb' (bit) (global) is 0x025,0
	ORG 0x0000
	BCF PCLATH,3
	BCF PCLATH,4
	GOTO L0003
	ORG 0x0004
	MOVWF W_TEMP
	SWAPF STATUS,W
	CLRF STATUS
	MOVWF STATUS_TEMP
	CALL L0004
	SWAPF STATUS_TEMP,W
	MOVWF STATUS
	SWAPF W_TEMP,F
	SWAPF W_TEMP,W
	RETFIE
; User code start
L0003:
; 1: Dim first_reg As Byte
; 2: Dim last_reg As Byte
; 3: Dim solution As Byte
; 4: Dim display As Byte
; 5: Dim flagrb As Bit
; 6: flagrb = 0
	BCF 0x025,0
; 7: TRISB = 0x01
	MOVLW 0x01
	BSF STATUS,RP0
	MOVWF TRISB
; 8: OPTION_REG.T0CS = False
	BCF OPTION_REG,5
; 9: OPTION_REG.INTEDG = False  // External interrupt RB0/INT triggered on falling
	BCF OPTION_REG,6
	BCF STATUS,RP0
; 10: INTCON.GIE = 1
	BSF INTCON,7
; 11: INTCON.PEIE = 0
	BCF INTCON,6
; 12: INTCON.TMR0IE = 0
	BCF INTCON,5
; 13: INTCON.INTE = 1
	BSF INTCON,4
; 14: INTCON.RBIE = 0
	BCF INTCON,3
; 15: INTCON.T0IF = 0
	BCF INTCON,2
; 16: INTCON.INTF = 0
	BCF INTCON,1
; 17: INTCON.RBIF = 0
	BCF INTCON,0
; 18: TRISC = 0
	BSF STATUS,RP0
	CLRF TRISC
; 19: TRISD = 0
	CLRF TRISD
	BCF STATUS,RP0
; 20: main:
L0001:
; 21: If flagrb = 1 Then
	BTFSS 0x025,0
	GOTO L0005
; 22: last_reg = TMR0
	MOVF TMR0,W
	MOVWF 0x024
; 23: INTCON.GIE = 0
	BCF INTCON,7
; 24: If last_reg < first_reg Then
	MOVF 0x023,W
	SUBWF 0x024,W
	BTFSC STATUS,C
	GOTO L0006
; 25: solution = (255 - first_reg) + (last_reg)
	oshonsoft_temp_b1 EQU 0x027
	MOVF 0x023,W
	SUBLW 0xFF
	MOVWF 0x027
	MOVF 0x027,W
	ADDWF 0x024,W
	MOVWF 0x026
; 26: Else
	GOTO L0007
L0006:
; 27: solution = last_reg - first_reg
	MOVF 0x023,W
	SUBWF 0x024,W
	MOVWF 0x026
; 28: Endif
L0007:
; 29: flagrb = 0
	BCF 0x025,0
; 30: display = solution >> 4
	MOVF 0x026,W
	MOVWF R0L
	CLRF R0H
	MOVLW 0x04
	CALL SR00
	MOVF R0L,W
	MOVWF 0x022
; 31: Gosub calculadisplay
	CALL L0002
; 32: PORTC = display
	MOVF 0x022,W
	MOVWF PORTC
; 33: display = solution And 0x0f
	MOVF 0x026,W
	MOVWF R0L
	MOVLW 0x0F
	ANDWF R0L,W
	MOVWF 0x022
; 34: Gosub calculadisplay
	CALL L0002
; 35: PORTD = display
	MOVF 0x022,W
	MOVWF PORTD
; 36: INTCON.GIE = 1
	BSF INTCON,7
; 37: Endif
L0005:
; 38: Goto main
	GOTO L0001
; 39: End
L0008:	GOTO L0008
; 40: calculadisplay:
L0002:
; 41: Select Case display
; 42: Case 0
	MOVF 0x022,W
	SUBLW 0x00
	BTFSS STATUS,Z
	GOTO L0009
; 43: display = %00111111
	MOVLW 0x3F
	MOVWF 0x022
; 44: Case 1
	GOTO L0010
L0009:
	MOVF 0x022,W
	SUBLW 0x01
	BTFSS STATUS,Z
	GOTO L0011
; 45: display = %00000110
	MOVLW 0x06
	MOVWF 0x022
; 46: Case 2
	GOTO L0012
L0011:
	MOVF 0x022,W
	SUBLW 0x02
	BTFSS STATUS,Z
	GOTO L0013
; 47: display = %01011011
	MOVLW 0x5B
	MOVWF 0x022
; 48: Case 3
	GOTO L0014
L0013:
	MOVF 0x022,W
	SUBLW 0x03
	BTFSS STATUS,Z
	GOTO L0015
; 49: display = %01001111
	MOVLW 0x4F
	MOVWF 0x022
; 50: Case 4
	GOTO L0016
L0015:
	MOVF 0x022,W
	SUBLW 0x04
	BTFSS STATUS,Z
	GOTO L0017
; 51: display = %01100110
	MOVLW 0x66
	MOVWF 0x022
; 52: Case 5
	GOTO L0018
L0017:
	MOVF 0x022,W
	SUBLW 0x05
	BTFSS STATUS,Z
	GOTO L0019
; 53: display = %01101101
	MOVLW 0x6D
	MOVWF 0x022
; 54: Case 6
	GOTO L0020
L0019:
	MOVF 0x022,W
	SUBLW 0x06
	BTFSS STATUS,Z
	GOTO L0021
; 55: display = %01111101
	MOVLW 0x7D
	MOVWF 0x022
; 56: Case 7
	GOTO L0022
L0021:
	MOVF 0x022,W
	SUBLW 0x07
	BTFSS STATUS,Z
	GOTO L0023
; 57: display = %00000111
	MOVLW 0x07
	MOVWF 0x022
; 58: Case 8
	GOTO L0024
L0023:
	MOVF 0x022,W
	SUBLW 0x08
	BTFSS STATUS,Z
	GOTO L0025
; 59: display = %01111111
	MOVLW 0x7F
	MOVWF 0x022
; 60: Case 9
	GOTO L0026
L0025:
	MOVF 0x022,W
	SUBLW 0x09
	BTFSS STATUS,Z
	GOTO L0027
; 61: display = %01100111
	MOVLW 0x67
	MOVWF 0x022
; 62: Case 10
	GOTO L0028
L0027:
	MOVF 0x022,W
	SUBLW 0x0A
	BTFSS STATUS,Z
	GOTO L0029
; 63: display = %01110111
	MOVLW 0x77
	MOVWF 0x022
; 64: Case 11
	GOTO L0030
L0029:
	MOVF 0x022,W
	SUBLW 0x0B
	BTFSS STATUS,Z
	GOTO L0031
; 65: display = %01111100
	MOVLW 0x7C
	MOVWF 0x022
; 66: Case 12
	GOTO L0032
L0031:
	MOVF 0x022,W
	SUBLW 0x0C
	BTFSS STATUS,Z
	GOTO L0033
; 67: display = %00111001
	MOVLW 0x39
	MOVWF 0x022
; 68: Case 13
	GOTO L0034
L0033:
	MOVF 0x022,W
	SUBLW 0x0D
	BTFSS STATUS,Z
	GOTO L0035
; 69: display = %01011110
	MOVLW 0x5E
	MOVWF 0x022
; 70: Case 14
	GOTO L0036
L0035:
	MOVF 0x022,W
	SUBLW 0x0E
	BTFSS STATUS,Z
	GOTO L0037
; 71: display = %01111001
	MOVLW 0x79
	MOVWF 0x022
; 72: Case 15
	GOTO L0038
L0037:
	MOVF 0x022,W
	SUBLW 0x0F
	BTFSS STATUS,Z
	GOTO L0039
; 73: display = %01110001
	MOVLW 0x71
	MOVWF 0x022
; 74: EndSelect
L0039:
L0038:
L0036:
L0034:
L0032:
L0030:
L0028:
L0026:
L0024:
L0022:
L0020:
L0018:
L0016:
L0014:
L0012:
L0010:
; 75: Return
	RETURN
; 76: On Interrupt
L0004:
; 77: If INTCON.INTF = 1 Then
	BTFSS 0x00B,1
	GOTO L0040
; 78: first_reg = TMR0
	MOVF TMR0,W
	MOVWF 0x023
; 79: flagrb = 1
	BSF 0x025,0
; 80: INTCON.INTF = 0  // external interrupt cleared
	BCF INTCON,1
; 81: Else
	GOTO L0041
L0040:
; 82: INTCON = %10010000
	MOVLW 0x90
	MOVWF INTCON
; 83: Endif
L0041:
; 84: Resume
	RETURN
; 85: 
; End of user code
L0042:	GOTO L0042
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
