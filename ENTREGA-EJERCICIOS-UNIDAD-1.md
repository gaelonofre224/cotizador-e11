# Entrega de los ejercicios de la unidad 1

**Fecha límite: domingo 27 de septiembre, 23:59.** Valen el 50 % del primer parcial.

Los tres ejercicios se entregan juntos, en el repositorio de su equipo, dentro de una carpeta
`ejercicios/`. Son **individuales**: cada quien sube sus archivos con su número de control en el
nombre, aunque el repositorio sea del equipo.

```
ejercicios/
  cuatro-estilos-22100167.md
  sintaxis-y-semantica-22100167.md
  ci-en-rojo-22100167.md
  parser-postfijo-22100167.js
```

Entra por rama y pull request, como todo lo demás. Un solo PR por persona basta.

## 1 · Cuatro estilos  (`cuatro-estilos-<control>.md`)

Del jueves 27 de agosto, carpeta `01-cuatro-estilos`.

1. La tabla de predicción: para cada estilo, cuántos archivos tocaste y si modificaste código que
   ya funcionaba.
2. Qué pasó al implementar el **primer** cambio (carga sobredimensionada, 22 %) y el **segundo**
   (destino `colombia`, 8 % adicional).
3. Las tres preguntas de la parte 4: qué estilo absorbió mejor cada cambio, y qué te dice que no
   haya sido el mismo.

## 2 · Sintaxis y semántica  (`sintaxis-y-semantica-<control>.md` + `parser-postfijo-<control>.js`)

Del lunes 21, carpeta `02-sintaxis-y-semantica`.

1. `parser-postfijo.js`: lee `2 3 4 * +` y produce **el mismo árbol** que los otros dos parsers.
   Compruébalo comparando con `JSON.stringify`.
2. Las tres preguntas: qué archivos tocaste al agregar una semántica nueva, qué archivos al
   agregar una sintaxis nueva, y qué separa el árbol para que esas dos cosas no se estorben.

## 3 · CI en rojo  (`ci-en-rojo-<control>.md`)

Del martes 22, carpeta `03-ci-en-rojo`.

1. Los tres defectos: qué era cada uno y **cuál puerta lo detectó**.
2. Tus tres mensajes de commit, uno por defecto.
3. La pregunta del pull request: de los tres, ¿cuál habría llegado a producción y por qué ese?

## Cómo se califica cada uno

| | Qué significa |
|---|---|
| **2** | Completo, con las preguntas contestadas |
| **1** | Entregado pero incompleto, o sin contestar las preguntas |
| **0** | No entregado |

Contestar "sí" o "no" a una pregunta no cuenta como contestarla: se pide el porqué.
