# Lunes 28 · Ocho fragmentos. Prediccion por escrito ANTES de ejecutar cada uno.
# Se corren uno por uno en iex, copiando y pegando.

# --- Fragmento 1 (la tarea de la guia de instalacion)
a = [1, 2, 3]
b = a
a = [9 | a]
IO.inspect(b, label: "F1 b")

# --- Fragmento 2
m = %{peso: 1000}
Map.put(m, :peso, 2000)
IO.inspect(m, label: "F2 m")

# --- Fragmento 3
lista = [3, 1, 2]
ordenada = Enum.sort(lista)
IO.inspect({lista, ordenada}, label: "F3")

# --- Fragmento 4
x = 1
f = fn -> x end
x = 2
IO.inspect({f.(), x}, label: "F4")

# --- Fragmento 5
{origen, destino} = {"nld", "sat"}
IO.inspect(destino, label: "F5")

# --- Fragmento 6
peso = 1000
IO.inspect(1000 = peso, label: "F6")

# --- Fragmento 7  (truena: se ejecuta aparte)
# 2000 = peso

# --- Fragmento 8  (truena: se ejecuta aparte)
# {a, b} = {1, 2, 3}
