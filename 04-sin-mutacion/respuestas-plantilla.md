# Taller · quitar la mutación

Nombre:Gael Onofre García
Número de control: 23100190
Equipo: 11

Copia este archivo a `talleres/01-oct/<tu número de control>/respuestas.md` en el repositorio de tu equipo,
junto con tu `sin_mutacion.ex`, y llena la tabla. Entrega: hoy antes de las 23:59.

| # | Función | ¿Qué muta la versión de TypeScript? | ¿Quién más se entera del cambio? |
|---|---|---|---|
| 1 | total_pesos | La variable total/el contador | Nadie más ya que la variable es local | 
| 2 | marcar_urgentes | Embarque/ Los objetos prestados | quien tenga acceso al objeto |
| 3 | aplicar_descuento | PreciosY el arreglo | Quien lo mandó |
| 4 | contar_por_tipo | conteo/contador local | nadie se entera por se local |
| 5 | sin_duplicados | Vistos y resultados/set y el arreglo | Nadie se entera al ser locales |

¿Cuál de las cinco era la más peligrosa en TypeScript, y por qué? (dos líneas)
La segunda ya que el acceso al objeto no esta controlado por lo que no tiene control sobre la mutacion haciendo que se pierda el valor original y no se pueda recuperar en caso de ser necesario



