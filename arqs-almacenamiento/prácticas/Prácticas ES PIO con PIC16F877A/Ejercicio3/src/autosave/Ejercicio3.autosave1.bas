Dim d1 As Byte
Dim flagtimer As Bit
Dim display1 As Byte
Dim display2 As Byte
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
	display1 = d1
	display2 = d2
	Gosub calculadisplay
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
	Select Case display1
	Case 
Return                                            
On Interrupt
	If INTCON.T0IF = 1 Then
		flagtimer = 1
		TMR0 = 127
		INTCON.T0IF = 0
	Endif
Resume                                            
	
