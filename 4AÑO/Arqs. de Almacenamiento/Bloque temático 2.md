
![[Pasted image 20231024130914.png| center |700]]


Con la imparcialidad se le concede el bus a otros dispositivos menos prioritarios. Así los dispositivos con más prioridad pero que además necesitan muchas transmisiones de datos no están ocupando el bus constantemente.

Ejemplo:
![[Pasted image 20231024132331.png |800]]

Desde el punto de vista del bus y del dispositivo la transmisión es eficiente porque ha transferido muchos bytes (4 bytes* 3.000 items = 12.000bytes) en una sola tirada. Pero desde el punto de vista del sistema no porque ha tenido ocupado el bus durante mucho tiempo.

![[Pasted image 20231024132709.png | 800]]

Si alguien a parte pide el control de bus, no va a llegar a terminar la transacción completa, pero luego continuará por donde se ha quedado.

LT = 0 indica que en el próximo item de datos debe parar, no quiere decir que tiene que parar inmediatamente y dejar la transacción del actual item de datos.

