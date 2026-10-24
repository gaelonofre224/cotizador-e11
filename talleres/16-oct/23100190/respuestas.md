# Taller 3 · La mutación escondida

Nombre: Gael Onofre García
Número de control: 23100190
Equipo: E11

Copia este archivo a `talleres/16-oct/<tu número de control>/respuestas.md` en el repositorio de tu
equipo, junto con tu `escondida.ex`. Entrega: viernes 16 de octubre, 23:59.

## 1 · Antes y después de ejecutar

Llena "Predigo" **antes** de correr `npx tsx escondida.ts`. No borres las predicciones que fallaron.

| Línea | Predigo | Salió |
|---|---|---|
| 1 · | A,B false | B,A true |
| 2 · | 5 false | 10 true |
| 3 · | 1 false | 2 true |
| 4 · | null false | SCT-77 false |
| 5 · | 12 15 | 15 15 |

## 2 · Qué se muta y quién se entera

| # | Función | ¿Qué línea muta, y qué cambia? | ¿Quién más se entera del cambio? |
|---|---|---|---|
| 1 | ordenarPorPeso | Línea 12: `embarques.sort(...)` reordena los elementos en el mismo arreglo original en memoria en lugar de crear uno nuevo. | Cualquier parte del programa que conserve una referencia a ese arreglo (por ejemplo `lote`). |
| 2 | conDescuento | Línea 17: `reglas.descuentoPct = pct` modifica directamente la propiedad del objeto recibido. | Quien haya creado o compartido el objeto de reglas (por ejemplo `base`), afectando a todos los clientes que usen esas reglas. |
| 3 | registrar | Línea 24: `vistos.push(id)` muta el arreglo global `vistos` agregando un elemento y devolviendo la referencia compartida. | Cualquier invocación posterior a `registrar` y cualquier variable que guardó el resultado previo (`primera` y `segunda` apuntan a la misma lista). |
| 4 | conPermiso | Línea 31: `copia.documentos.permiso = permiso` muta el objeto anidado `documentos` que no fue clonado en profundidad por el spread. | El objeto `original`, ya que `original.documentos` y `copia.documentos` apuntan exactamente al mismo objeto en memoria. |
| 5 | fechaDeEntrega | Línea 37: `salida.setDate(...)` altera directamente el estado interno de la instancia de `Date` recibida. | Cualquier variable que referencie la fecha original (`salida`), que ahora refleja la fecha de entrega en vez de la de salida. |

## 3 · Tres preguntas cortas

**a)** En la línea 4 salió `false` en `original === conP`, y aun así el original cambió. ¿Cómo es
posible? (dos líneas)
Se realiza una copia sin embargo se sigue referenciado al antiguo.

**b)** ¿Por qué `registrar` no es una función pura? (una línea)
Hace referencia a un estado externo y lo modifica

**c)** En tus pruebas de Elixir, la última aserción de cada una revisa que el original sigue igual.
¿Por qué en Elixir esa aserción no puede fallar? (dos líneas)
En Elixir los datos son inmutables y solo se pueden crear nuevos a partir de funciones
