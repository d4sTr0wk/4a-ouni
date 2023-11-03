Dim d1 As Byte
Dim flagtimer As Bit
d1 = 0
flagtimer = 0
TRISB = 0x01
OPTION_REG.T0CS = False
INTCON.T0IE = 1
INTCON.INTE = 1
INTCON.GIE = 1
main:
	loop:
		If flagtimer = 1 Then
		flagtimer = 0
		If d1 = 19 Then
			d1 = 0
		Else
			d1 = d1 + 1
		Endif
	Endif
	Goto loop
End                                               
On Interrupt
	If INTCON.T0IF = 1 Then
		flagtimer = 1
		TMR0 = 127
		INTCON.T0IF = 0
	Endif
Resume                                            
	
