Dim d1 As Byte
Dim punto As Byte
Dim display As Byte
d1 = 0
punto = 0
TRISB = 0x01
TRISC = 0
main:
	display = d1
	Gosub calculadisplay
	PORTC = display
	d1 = PORTB
	Toggle punto.7
	Goto main
	End
calculadisplay:
	Select Case display
	Case 0
		display = %00111111
	Case 1
		display = %01000000
	EndSelect
	display = display Or punto
Return                                            

	
