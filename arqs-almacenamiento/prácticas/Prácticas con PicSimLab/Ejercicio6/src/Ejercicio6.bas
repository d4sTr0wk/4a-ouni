#define LCD_BITS = 8
#define LCD_DREG = PORTD
#define LCD_RSREG = PORTE
#define LCD_RSBIT = 2
#define LCD_EREG = PORTE
#define LCD_EBIT = 1

AllDigital

Dim cuenta As Byte
Dim dir As Byte

TRISD = 0
TRISE = 0
TRISB = 0xc0


Lcdinit 0
WaitMs 1000
Lcdout "Inicializando"
WaitMs 3000
Lcdcmdout LcdClear
WaitMs 100

main:

cuenta = 12
PORTB.3 = 0
PORTB.4 = 1
PORTB.5 = 0

loop1:

Lcdout "Girando antihorario"
WaitMs 200
PORTB.3 = 1
WaitMs 140
PORTB.3 = 0
Lcdcmdout LcdClear
WaitMs 2000

cuenta = cuenta - 1
If cuenta = 0 Then Goto sigue
Goto loop1

sigue:
cuenta = 12
PORTB.3 = 0
PORTB.4 = 0
PORTB.5 = 1

loop2:
Lcdout "Girando horario"
WaitMs 200
PORTB.3 = 1
WaitMs 140
PORTB.3 = 0
Lcdcmdout LcdClear
WaitMs 2000

cuenta = cuenta - 1
If cuenta = 0 Then Goto main
Goto loop2




