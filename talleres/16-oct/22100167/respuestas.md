# Taller 3 · La mutación escondida

Nombre:Angel David Bautista Gomez
Número de control:22100167
Equipo:e11

Copia este archivo a `talleres/16-oct/<tu número de control>/respuestas.md` en el repositorio de tu
equipo, junto con tu `escondida.ex`. Entrega: viernes 16 de octubre, 23:59.

## 1 · Antes y después de ejecutar

Llena "Predigo" **antes** de correr `npx tsx escondida.ts`. No borres las predicciones que fallaron.

| Línea | Predigo | Salió |
|---|---|---|
| 1 · |A,B false |B,A true |
| 2 · |10 true |10 true |
| 3 · |2 true |2 true |
| 4 · |c,3000,sct-77 false |sct-77 false |
| 5 · |2026-9-15 | 15 |

## 2 · Qué se muta y quién se entera

| # | Función | ¿Qué línea muta, y qué cambia? | ¿Quién más se entera del cambio? |
|---|---|---|---|
| 1 | ordenarPorPeso |embarque.sort porque reerdonea el arreglo recibido ensu lugar de a,b - b,a | todos los que tienen referencia del lote |
| 2 | conDescuento |reglas.descuentoPct = pct cambia de 5 a 10 |Quien tenga base o promo |
| 3 | registrar |vistos.push(id) agrega elementos al arreglo global vistos |Cualquier código del módulo que lea vistos, y todos los que recibieron el valor de retorno |
| 4 | conPermiso |copia.documentos.permiso = permiso escribe en documentos y agrega SCT-77 |El original y cualquier otra copia hecha con spread de ese mismo embarque, porque todos comparten |
| 5 | fechaDeEntrega |salida.setDate(...) modifica la fecha recibida de salida pasa de 12 al 15 de octubre. | Quien tenga salida o entrega |

## 3 · Tres preguntas cortas

**a)** En la línea 4 salió `false` en `original === conP`, y aun así el original cambió. ¿Cómo es
posible? (dos líneas)
Realiza una copia artifical, si bien se crea un objeto nuevo el apuntador de la propiedad de documentos sigue en el antiguo 
**b)** ¿Por qué `registrar` no es una función pura? (una línea)
Porque depende de estado externo y lo modifica
**c)** En tus pruebas de Elixir, la última aserción de cada una revisa que el original sigue igual.
¿Por qué en Elixir esa aserción no puede fallar? (dos líneas)
porque en elixir los datos son inmutables, una funcion solo puede construir valores nuevos a partir de los que recibe