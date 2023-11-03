All_Digital
Dim d1 As Byte
Dim display As Byte
d1 = 0
TRISD = 0
TRISA = 0
main:
	PORTA.2 = 1
loop:
	display = d1
	Gosub calculadisplay
	PORTD = display
	d1 = d1 + 1
	If d1 = 2 Then
		d1 = 0
	Endif
	WaitMs 500
	Goto loop
	End
	
	
calculadisplay:
	Select Case display
	Case 0
		display = %01000000
	Case 1
		display = %10000000
	EndSelect
Return                                            

	
