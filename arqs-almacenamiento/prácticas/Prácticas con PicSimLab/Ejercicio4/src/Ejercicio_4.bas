TRISB = 1
TRISD = 0
PORTB = 0
PORTD = 0
INTCON = 0
Dim i As Byte
Dim auxiliar As Byte
main:
	For i = 0 To 5 Step 1
		auxiliar = (1 << i)
		If (PORTB And auxiliar) = auxiliar Then
			PORTD = (1 << i)
		Else
			PORTD.7 = 1
		Endif
	Next i
	Goto main
End                                               