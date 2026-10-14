# Taller · coincidencia de patrones

Nombre: Gael Onofre García
Número de control: 23100190
Equipo: E11

Copia este archivo a `talleres/06-oct/<tu número de control>/respuestas.md` en el repositorio de tu pareja,
junto con tu `patrones.ex`. Entrega: el mismo día del taller, antes de las 23:59.

## 1. ¿Por qué importa el orden de las cláusulas?

Elixir evalúa las cláusulas de arriba hacia abajo y ejecuta la primera que coincida con los argumentos.

## 2. ¿Qué pasa cuando ninguna cláusula coincide?
Elixir detiene la ejcución por completo y lanza un error, esto es una gran ventaja ya que permite detectar datos erroneos antes de que sigan avanzando por el programa.

## 3. Escribiste `documentos_completos?` sin un solo `if`. ¿Cuántas cláusulas usaste y en qué orden?

1. Atrapa carga peligrosa en caso de que numero un sea nulo
`def documentos_completos?(%{tipo: :peligrosa, numero_un: nil}), do: false`
2. Atrapa carga de tipo sobredimensionada
`def documentos_completos?(%{tipo: :sobredimensionada, permiso: nil}), do: false`
3. Clausula para los embarques que si tengan sus documentos o no necesiten permisos adicionales
`def documentos_completos?(%{}), do: true`