# 04 · Sin mutación

Unidad 2 · Paradigma funcional en Elixir · semana del 28 de septiembre

| Sesión | Qué se usa |
|---|---|
| Lunes 28 · El lenguaje donde no se puede mutar | `fragmentos/lun-28.exs` (se corren en `iex`, uno por uno) |
| Martes 29 · Taller: quitar la mutación | `imperativo.ts` y `ejercicios/lib/sin_mutacion.ex` |
| Miércoles 30 · Descomponer, no preguntar | `fragmentos/mie-30.exs` y `ejercicios/lib/patrones.ex` |
| Jueves 1 · Una lista es cabeza y cola | `fragmentos/jue-01.exs` y `ejercicios/lib/recursion.ex` |

## Cómo se trabaja

```bash
cd 04-sin-mutacion/ejercicios
mix test test/sin_mutacion_test.exs    # martes
mix test test/patrones_test.exs        # miércoles
mix test test/recursion_test.exs       # jueves
```

Todas arrancan en rojo. Cada función trae un `raise("por implementar")`: reemplázalo.

## Las reglas de cada día

- **Martes:** antes de escribir, di en voz alta qué muta la versión de TypeScript y quién más se entera.
- **Miércoles:** ni un solo `if`, `cond` ni `case` sobre el tipo. Cada decisión es una cláusula.
- **Jueves:** nada de `Enum`, `List` ni `length/1`. Solo `[cabeza | cola]`.

La IA está permitida. Al final de cada sesión se le pregunta a alguien, al azar, por qué su versión cumple la regla del día.
