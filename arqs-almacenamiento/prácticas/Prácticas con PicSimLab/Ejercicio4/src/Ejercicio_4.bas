TRISB = %00111111
TRISD = %00000000
PORTB = 0
PORTD = 0
INTCON = %00000000
Dim i As Byte
Dim auxiliar As Byte
main:
	For i = 0 To 5 Step 1
		If PORTB.i = 0 Then
			PORTD = (1 << i)
			While PORTB.i = 0
			Wend
		Else
			PORTD = %10000000
		Endif
	Next i
	Goto main
End                                               
