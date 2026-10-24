# Taller 4 · De condicionales a despacho

Nombre: Gael Onofre García
Número de control: 23100190
Equipo: 11

Copia este archivo a `talleres/23-oct/<tu número de control>/respuestas.md` en el repositorio de tu
equipo, junto con tu `despacho.ts`. Entrega: viernes 23 de octubre, 23:59.

## Paso 1 · La versión con switch

**a)** Antes de tocar nada: ¿cuántos lugares de `condicionales.ts` hay que cambiar para agregar
`perecedera`?
4 lugares: la unión de tipos `Tipo` y los 3 `switch` dentro de las funciones (`recargo`, `documentoRequerido` y `etiqueta`).

**b)** Después de agregar `'perecedera'` solo al tipo: ¿qué dijo `tsc`, y qué imprimió la
demostración para perecedera?
tsc no marcó ningún error. La demostración imprimió:
perecedera 0 null General

**c)** ¿Por qué el compilador no te avisó? (una línea)
Porque las tres funciones cuentan con una cláusula default que absorbe en silencio cualquier tipo no contemplado.

## Paso 3 · La versión con tabla

**d)** Después de agregar `'perecedera'` al tipo: ¿qué dijo `tsc`? Copia el mensaje.
Property 'perecedera' is missing in type '{ general: Politica; refrigerada: Politica; peligrosa: Politica; sobredimensionada: Politica; }' but required in type 'Record<Tipo, Politica>'.

**e)** ¿Cuántos lugares cambiaste en `despacho.ts` para agregar perecedera?
2 lugares: agregar 'perecedera' al tipo Tipo y añadir su objeto de configuración a la tabla POLITICAS.

## Los dos lenguajes

**f)** En su motor de Elixir, ¿qué pasa si llega un tipo de carga para el que no hay cláusula? ¿Y en
`despacho.ts`, si a la tabla le falta un tipo? ¿Cuál de los dos te avisa antes, y cuándo? (dos líneas)
En Elixir falla en tiempo de ejecución lanzando un FunctionClauseError. En TypeScript con Record<Tipo, Politica>, tsc avisa antes en tiempo de compilación impidiendo compilar si a la tabla le falta alguna llave.
