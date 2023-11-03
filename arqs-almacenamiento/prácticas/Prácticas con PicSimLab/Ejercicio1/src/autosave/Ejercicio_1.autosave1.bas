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
	EndSelect
Return                                            

	
