TRISB = %00111111
TRISD = %00000000
PORTB = 0
PORTD = 0
INTCON = %00000000
Dim i As Byte
Dim auxiliar As Byte
main:
	For i = 0 To 5 Step 1
		auxiliar = (1 << i)
		If (PORTB And auxiliar) = auxiliar Then
			PORTD = (1 << i)
			While PORTB.i = 1
			Wend
		Else
			PORTD = %10000000
		Endif
	Next i
	Goto main
End                                               