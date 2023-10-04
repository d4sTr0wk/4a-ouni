Dim d1 As Byte
Dim d2 As Byte
Dim display As Byte
d1 = 0
d2 = 0
TRISB = 0x01
TRISC = 0
main:
	display = d1
	Gosub calculadisplay
	PORTC = display
bucle:
	d1 = PORTB
	If d2 = d1 Then Goto bucle
	d2 = d1
	Goto main
	End
calculadisplay:
	Select Case display
	Case 0
		display = %00111111
	Case 1
		display = %01000000
	EndSelect
Return                                            

	
