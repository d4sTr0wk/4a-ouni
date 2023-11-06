Dim d1 As Byte
Dim flagtimer As Bit
Dim display As Byte
Dim display1 As Byte
Dim display2 As Byte
d1 = 0
flagtimer = 0
OPTION_REG.T0CS = False
INTCON = %10110000
TRISB = %00000001
TRISC = 0
TRISD = 0
// PORTA = %00110000  //Displays 3 y 4 activados
main:
	// Mientras se calcula el número no pueden haber interrupciones
	INTCON.GIE = 0
	display = d1 >> 4
	Gosub calculadisplay
	display1 = display
	display = d1 And 0x0f
	Gosub calculadisplay
	display2 = display
	INTCON.GIE = 1
	TMR0 = 0
	While flagtimer = 0
		PORTD = display1
		PORTC = display2
	Wend
	If flagtimer = 1 Then
		Gosub nextd1
	Endif
	Goto main
End                                               
nextd1:
	If d1 = 32 Then
		d1 = 0
	Else
		d1 = d1 + 1
	Endif
	flagtimer = 0
Return                                            
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
		Toggle INTCON.TMR0IE
		flagtimer = 0
		INTCON.INTF = 0
	Endif
	If INTCON.T0IF = 1 Then
		flagtimer = 1
		INTCON.TMR0IF = 0
	Endif
Resume                                            