Dim d1 As Byte
Dim flagtimer As Bit
Dim display As Byte
Dim display1 As Byte
Dim display2 As Byte
d1 = 0
flagtimer = 0
TRISB = 0x01
OPTION_REG.T0CS = False
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
	display = d1 / 10
	Gosub calculadisplay
	display1 = display
	display = d1 Mod 10
	Gosub calculadisplay
	display2 = display
	PORTC = display1
	PORTD = display2
	loop:
		If flagtimer = 1 Then
			flagtimer = 0
			If d1 = 19 Then
				d1 = 0
			Else
				d1 = d1 + 1
			Endif
			Goto main
		Else
			Goto loop
		Endif
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
	EndSelect
Return                                            
On Interrupt
	If INTCON.INTF = 1 Then
		Toggle INTCON.TMR0IE
		INTCON.INTF = 0
		flagtimer = 0
	Endif
	If INTCON.T0IF = 1 Then
		If flagtimer = 0 Then
			flagtimer = 1
		Endif
		TMR0 = 127
		INTCON.T0IF = 0
	Endif
Resume                                            
	
