# Taller 5 · Composición o herencia

Nombre: Gael Onofre García
Número de control: 23100190
Equipo: E11

Copia este archivo a `talleres/27-oct/<tu número de control>/respuestas.md` en el repositorio de tu
equipo, junto con tu `composicion.ts`. Entrega: martes 27 de octubre, 23:59.

## Paso 1 · La herencia

**a)** ¿En qué dos clases está escrito el cálculo del seguro? ¿Por qué no se pudo escribir una sola
vez?

En ConSeguro y en RefrigeradaConSeguro. No se pudo escribir una sola vez porque TypeScript solo admite herencia simple.

**b)** Con un tercer extra (express), ¿cuántas clases hacen falta para todas las combinaciones?
¿Cuántas son nuevas? Muestra la cuenta.

Cada extra es independiente y puede estar o no ($2$ posibilidades por extra). Con $3$ extras hay $2^3 = 2 \times 2 \times 2 = 8$ combinaciones y clases en total. Como ya existían $4$ clases, hacen falta $8 - 4 = 4$ clases nuevas.

## Paso 2 · La composición

**c)** Para agregar express a `composicion.ts`, ¿qué agregaste? ¿Cambió `cotizar`?

Solo se agregó la función de ajuste: `export const express: Ajuste = (monto) => monto + 50000;`. La función `cotizar` no cambió en absoluto porque procesa genéricamente la lista de ajustes mediante `reduce`, sin importar cuántos ni cuáles sean.

## Paso 3 · El orden

| Llamada | Predigo | Salió |
|---|---|---|
| `cotizar(100, 1000, [express, seguro])` | 153000 | 153000 |
| `cotizar(100, 1000, [seguro, express])` | 152000 | 152000 |

**d)** ¿Por qué salen distintos? (dos líneas)

Con `[express, seguro]` el cargo fijo de 500 se suma primero, por lo que el 2% de seguro se calcula también sobre ese cargo adicional ($150000 \times 1.02 = 153000$).
Con `[seguro, express]` el 2% se aplica únicamente sobre el flete base ($100000 \times 1.02 = 102000$) y posteriormente se agregan los $500 fijos ($152000$).

## Paso 4 · Sostén la decisión

**e)** En su modelo del proyecto, ¿cómo están escritos los pasos del cálculo: con herencia o con
composición? Cita el archivo y la función.

Con composición. En el motor funcional de Elixir vive en `motor/lib/cotizador.ex`, en la función `calcular/2`, y en el modelo de TypeScript en `src/modelo.ts`, en la función `cotizar(borrador, reglas)`, encadenando transformaciones de datos puras e inmutables (flete base, descuento, cuota y recargos) sin jerarquías de clases.

**f)** Da **un** caso, en su proyecto o fuera de él, donde sí usarías herencia, y di por qué ahí no
hay explosión de combinaciones. (tres líneas)

Para modelar clases de error especializadas que extienden de la clase nativa Error.
En este escenario la herencia es adecuada porque existe una relación "es un" unívoca y una sola dimensión de variación.
No hay explosión combinatoria porque los errores son categorías discretas y excluyentes de fallos, no combinaciones acumulativas de comportamientos ortogonales.
