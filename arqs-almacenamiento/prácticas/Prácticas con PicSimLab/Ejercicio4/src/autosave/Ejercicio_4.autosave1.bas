TRISB = 1
TRISD = 0
PORTB = 0
PORTD = 0
INTCON = 0
Dim i As Byte
do
	For i = 0 To 5 Step 1
		If PORTB.i = 1 Then
			PORTD = (1 << i)
		Else
			PORTD.7 = 1
		Endif
	Next i
loop