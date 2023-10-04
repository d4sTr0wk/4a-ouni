Dim d1 As Byte
Dim flagtimer As Bit
Dim display1 As Byte
d1 = 0
flagtimer = 0
TRISB = 0x01
OPTION_REG.T0CS = False
INTCON.TMR0IE = 1
INTCON.INTE = 1
INTCON.GIE = 1
TRISC = 0
TRISD = 0
main:
	display = d1
	Gosub calculadisplay
	PORTC = display
	display = d1
	Gosub calculadisplay
	PORTD = display
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
		display = %00000000
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
Return                                            
On Interrupt
	If INTCON.T0IF = 1 Then
		flagtimer = 1
		TMR0 = 127
		INTCON.T0IF = 0
	Endif
Resume                                            
	
