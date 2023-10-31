Dim display As Byte
Dim i As Byte
Dim j As Byte

OPTION_REG = 0
INTCON = 0
TRISB = %11110000  ' Las filas (4-7) como entradas, las columnas (0-3) como salidas
TRISC = 0

main:
	For i = 0 To 3 Step 1  ' Recorre las columnas
		PORTB = 1 << i  ' Activa la columna i
		For j = 4 To 7 Step 1  ' Recorre las filas
			If PORTB.j = 1 Then  ' Si la fila j está en alto, se pulsó una tecla
				display = i + (4 * (j - 4))
				Gosub calculadisplay
				PORTC = display
				' Puedes agregar un pequeño retardo aquí para evitar la detección de rebotes
			Endif
		Next j
		PORTB = 0  ' Desactiva la columna i
	Next i
	Goto main
End                                               
calculadisplay:
	Select Case display
		Case 0
			display = %00111111
		Case 1
			display = %00000110
		Case 2
			display = %01011011
		Case 3
			display = %01001111
		Case 4
			display = %01100110
		Case 5
			display = %01101101
		Case 6
			display = %01111101
		Case 7
			display = %00000111
		Case 8
			display = %01111111
		Case 9
			display = %01100111
		Case 10
			display = %01110111
		Case 11
			display = %01111100
		Case 12
			display = %00111001
		Case 13
			display = %01011110
		Case 14
			display = %01111001
		Case 15
			display = %01110001
	EndSelect
Return                                            