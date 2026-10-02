# Miercoles 30 · Coincidencia de patrones. Prediccion antes de ejecutar.

# --- Fragmento 1
[primero | resto] = ["nld", "mty", "sat"]
IO.inspect({primero, resto}, label: "F1")

# --- Fragmento 2
%{tipo: t} = %{id: "E1", tipo: :peligrosa, peso_kg: 900}
IO.inspect(t, label: "F2")

# --- Fragmento 3
defmodule Carga3 do
  def cuota(%{tipo: :peligrosa}), do: 750
  def cuota(%{tipo: _}), do: 0
end
IO.inspect(Carga3.cuota(%{tipo: :peligrosa, numero_un: "UN1203"}), label: "F3")

# --- Fragmento 4  (el orden de las clausulas)
defmodule Carga4 do
  def cuota(%{tipo: _}), do: 0
  def cuota(%{tipo: :peligrosa}), do: 750
end
IO.inspect(Carga4.cuota(%{tipo: :peligrosa}), label: "F4")

# --- Fragmento 5  (guardas)
defmodule Peso5 do
  def clase(kg) when kg > 10_000, do: :pesado
  def clase(kg) when kg > 1_000, do: :medio
  def clase(_), do: :ligero
end
IO.inspect(Enum.map([500, 1_000, 10_000, 10_001], &Peso5.clase/1), label: "F5")

# --- Fragmento 6
resultado = {:error, :peso_invalido}
mensaje =
  case resultado do
    {:ok, total} -> "cotizado en #{total}"
    {:error, motivo} -> "rechazado por #{motivo}"
  end
IO.inspect(mensaje, label: "F6")

# --- Fragmento 7  (truena: ninguna clausula coincide)
defmodule Carga7 do
  def cuota(%{tipo: :general}), do: 0
  def cuota(%{tipo: :refrigerada}), do: 150
end
# Carga7.cuota(%{tipo: :granel})
