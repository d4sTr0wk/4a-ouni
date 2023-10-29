Dim first_reg As Byte
Dim last_reg As Byte
Dim solution As Byte
Dim display As Byte
Dim flagrb As Bit
flagrb = 0
TRISB = 0x01
OPTION_REG.T0CS = False
OPTION_REG.INTEDG = False  // External interrupt RB0/INT triggered on falling
INTCON.GIE = 1
INTCON.PEIE = 0
INTCON.TMR0IE = 1
INTCON.INTE = 1
INTCON.RBIE = 0
INTCON.T0IF = 0
INTCON.INTF = 0
INTCON.RBIF = 0
TRISC = 0
TRISD = 0
main:
	If flagrb = 1 Then
		last_reg = TMR0
		INTCON.GIE = 0
		If last_reg < first_reg Then
			solution = (255 - first_reg) + (last_reg)
		Else
			solution = last_reg - first_reg
		Endif
		flagrb = 0
		display = solution / 16
		Gosub calculadisplay
		PORTC = display
		display = solution Mod 16
		Gosub calculadisplay
		PORTD = display
		INTCON.GIE = 1
	Endif
	Goto main
End                                               
calculadisplay:
	Select Case display
	Case 0
		display = %00111111
	Case 1
		display = %00000110
	Case 2
		display = %01011011
	Case 3
		display = %01001111
	Case 4
		display = %01100110
	Case 5
		display = %01101101
	Case 6
		display = %01111101
	Case 7
		display = %00000111
	Case 8
		display = %01111111
	Case 9
		display = %01100111
	Case 10
		display = %01110111
	Case 11
		display = %01111100
	Case 12
		display = %00111001
	Case 13
		display = %01011110
	Case 14
		display = %01111001
	Case 15
		display = %01110001
	EndSelect
Return                                            
On Interrupt
	If INTCON.INTF = 1 Then
		first_reg = TMR0
		flagrb = 1
		INTCON.INTF = 0  // external interrupt cleared
	Endif
Resume                                            
	
