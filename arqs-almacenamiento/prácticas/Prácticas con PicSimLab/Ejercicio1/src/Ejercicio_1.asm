; Compiled with: PIC Simulator IDE v8.55
; Microcontroller model: PIC16F877A
; Clock frequency: 1.0MHz
;
	R0L EQU 0x020
	R0H EQU 0x021
	R4L EQU 0x028
	R4H EQU 0x029
	R0HL EQU 0x020
	R4HL EQU 0x028
;       The address of 'd1' (byte) (global) is 0x023
;       The address of 'display' (byte) (global) is 0x022
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
	CLRF 0x023
; 4: TRISB = 0
	BSF STATUS,RP0
	CLRF TRISB
	BCF STATUS,RP0
; 5: main:
L0001:
; 6: display = d1
	MOVF 0x023,W
	MOVWF 0x022
; 7: Gosub calculadisplay
	CALL L0002
; 8: PORTB = display
	MOVF 0x022,W
	MOVWF PORTB
; 9: d1 = d1 + 1
	INCF 0x023,F
; 10: If d1 = 8 Then
	MOVF 0x023,W
	SUBLW 0x08
	BTFSS STATUS,Z
	GOTO L0004
; 11: d1 = 0
	CLRF 0x023
; 12: Endif
L0004:
; 13: WaitMs 500
	MOVLW 0xD2
	MOVWF R4L
	MOVLW 0x30
	MOVWF R4H
	CALL DL02
; 14: Goto main
	GOTO L0001
; 15: End
L0005:	GOTO L0005
; 16: calculadisplay:
L0002:
; 17: Select Case display
; 18: Case 0
	MOVF 0x022,W
	SUBLW 0x00
	BTFSS STATUS,Z
	GOTO L0006
; 19: display = %00000001
	MOVLW 0x01
	MOVWF 0x022
; 20: Case 1
	GOTO L0007
L0006:
	MOVF 0x022,W
	SUBLW 0x01
	BTFSS STATUS,Z
	GOTO L0008
; 21: display = %00000010
	MOVLW 0x02
	MOVWF 0x022
; 22: Case 2
	GOTO L0009
L0008:
	MOVF 0x022,W
	SUBLW 0x02
	BTFSS STATUS,Z
	GOTO L0010
; 23: display = %00000100
	MOVLW 0x04
	MOVWF 0x022
; 24: Case 3
	GOTO L0011
L0010:
	MOVF 0x022,W
	SUBLW 0x03
	BTFSS STATUS,Z
	GOTO L0012
; 25: display = %00001000
	MOVLW 0x08
	MOVWF 0x022
; 26: Case 4
	GOTO L0013
L0012:
	MOVF 0x022,W
	SUBLW 0x04
	BTFSS STATUS,Z
	GOTO L0014
; 27: display = %00010000
	MOVLW 0x10
	MOVWF 0x022
; 28: Case 5
	GOTO L0015
L0014:
	MOVF 0x022,W
	SUBLW 0x05
	BTFSS STATUS,Z
	GOTO L0016
; 29: display = %00100000
	MOVLW 0x20
	MOVWF 0x022
; 30: Case 6
	GOTO L0017
L0016:
	MOVF 0x022,W
	SUBLW 0x06
	BTFSS STATUS,Z
	GOTO L0018
; 31: display = %01000000
	MOVLW 0x40
	MOVWF 0x022
; 32: Case 7
	GOTO L0019
L0018:
	MOVF 0x022,W
	SUBLW 0x07
	BTFSS STATUS,Z
	GOTO L0020
; 33: display = %10000000
	MOVLW 0x80
	MOVWF 0x022
; 34: EndSelect
L0020:
L0019:
L0017:
L0015:
L0013:
L0011:
L0009:
L0007:
; 35: Return
	RETURN
; 36: 
; 37: 
; End of user code
L0021:	GOTO L0021
;
;
; Delay Routine Byte
; minimal routine execution time: 32탎
; routine execution time step: 12탎
; maximal routine execution time: 3080탎
DL01:
	DECFSZ R4L,F
	GOTO DL01
	RETURN
; Delay Routine Word
; minimal routine execution time: 60탎
; routine execution time step: 40탎
; maximal routine execution time: 2621460탎
DL02:
	MOVLW 0x01
	SUBWF R4L,F
	CLRW
	BTFSS STATUS,C
	ADDLW 0x01
	SUBWF R4H,F
	BTFSS STATUS,C
	RETURN
	GOTO DL02
; Waitms Routine
W001:	MOVLW 0x01
	SUBWF R0L,F
	CLRW
	BTFSS STATUS,C
	ADDLW 0x01
	SUBWF R0H,F
	BTFSS STATUS,C
	RETURN
	MOVLW 0x4E
	MOVWF R4L
	CALL DL01
	GOTO W001
;
;
;
;
; End of listing
	END
