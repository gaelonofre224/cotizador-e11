# 04 · Sin mutación

Unidad 2 · Paradigma funcional en Elixir

| Sesión | Qué se usa |
|---|---|
| El lenguaje donde no se puede mutar | `fragmentos/lun-28.exs` (se corren en `iex`, uno por uno) |
| Taller: quitar la mutación | `imperativo.ts`, `ejercicios/lib/sin_mutacion.ex` y `respuestas-plantilla.md` |
| Descomponer, no preguntar | `fragmentos/mie-30.exs` y `ejercicios/lib/patrones.ex` |
| Una lista es cabeza y cola | `fragmentos/jue-01.exs` y `ejercicios/lib/recursion.ex` |

## Cómo se trabaja

```bash
cd 04-sin-mutacion/ejercicios
mix test test/sin_mutacion_test.exs    # taller
mix test test/patrones_test.exs        # patrones
mix test test/recursion_test.exs       # recursión
```

Todas arrancan en rojo. Cada función trae un `raise("por implementar")`: reemplázalo.

## Las reglas de cada día

- **Taller:** antes de escribir, di en voz alta qué muta la versión de TypeScript y quién más se entera.
- **Patrones:** ni un solo `if`, `cond` ni `case` sobre el tipo. Cada decisión es una cláusula.
- **Recursión:** nada de `Enum`, `List` ni `length/1`. Solo `[cabeza | cola]`.

La IA está permitida. Al final de cada sesión se le pregunta a alguien, al azar, por qué su versión cumple la regla del día.
