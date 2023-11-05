TRISB = 1
TRISD = 0
PORTB = 0
PORTD = 0
INTCON = 0
main:
	// Consulta periódica
	If PORTB.0 = 1 Then
		PORTD.0
	Goto main
End                                               
calculadisplay:
	Select Case display
	Case 0
		display = %00000001
	Case 1
		display = %00000010
	Case 2
		display = %00000100
	Case 3
		display = %00001000
	Case 4
		display = %00010000
	Case 5
		display = %00100000
	Case 6
		display = %01000000
	Case 7
		display = %10000000
	EndSelect
Return                                            

	
