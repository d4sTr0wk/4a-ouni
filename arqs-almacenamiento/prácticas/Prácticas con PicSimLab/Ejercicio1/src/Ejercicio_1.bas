Dim d1 As Byte
Dim display As Byte
d1 = 0
TRISB = 0
main:
	display = d1
	Gosub calculadisplay
	PORTB = display
	d1 = d1 + 1
	If d1 = 8 Then
		d1 = 0
	Endif
	WaitMs 500
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

	
