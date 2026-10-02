# Jueves 1 · Recursion. Prediccion antes de ejecutar.

defmodule R do
  # --- Fragmento 1
  def f1([]), do: 0
  def f1([_ | t]), do: 1 + f1(t)

  # --- Fragmento 2
  def f2([]), do: []
  def f2([h | t]), do: [h * 2 | f2(t)]

  # --- Fragmento 3
  def f3([], acc), do: acc
  def f3([h | t], acc), do: f3(t, [h | acc])

  # --- Fragmento 4
  def f4([]), do: []
  def f4([h | t]) when h > 1000, do: [h | f4(t)]
  def f4([_ | t]), do: f4(t)

  # --- Fragmento 5  (la que no termina bien)
  def f5([h | t]), do: h + f5(t)
end

IO.inspect(R.f1([:a, :b, :c]), label: "F1")
IO.inspect(R.f2([1, 2, 3]), label: "F2")
IO.inspect(R.f3([1, 2, 3], []), label: "F3")
IO.inspect(R.f4([800, 1200, 15_000, 999]), label: "F4")
# R.f5([1, 2, 3])
