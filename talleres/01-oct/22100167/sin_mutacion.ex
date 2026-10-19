#actividad de sin mutaciones.ex 
def total_pesos(embarques) do
  Enum.reduce(embarques, 0, fn e, total -> total + e.peso_kg end)
end

def marcar_urgentes(embarques) do
  Enum.map(embarques, fn e -> Map.put(e, :urgente, e.distancia_km > 500) end)
end

def aplicar_descuento(precios, pct) do
  Enum.map(precios, fn p -> p - Integer.floor_div(p * pct + 50, 100) end)
end

def contar_por_tipo(embarques) do
  Enum.frequencies_by(embarques, & &1.tipo)
end

def sin_duplicados(ids), do: Enum.uniq(ids)

#actividades de imperativo.ts

defmodule Embarques do
  defmodule Embarque do
    @enforce_keys [:id, :peso_kg, :distancia_km, :tipo]
    defstruct [:id, :peso_kg, :distancia_km, :tipo, urgente: nil]

    @type t :: %__MODULE__{
            id: String.t(),
            peso_kg: number(),
            distancia_km: number(),
            tipo: String.t(),
            urgente: boolean() | nil
          }
  end

  # 1 · el acumulador pasa a ser un argumento de reduce, sin contador mutable
  @spec total_pesos([Embarque.t()]) :: number()
  def total_pesos(embarques) do
    Enum.reduce(embarques, 0, fn e, total -> total + e.peso_kg end)
  end

  # 2 · devuelve structs nuevos; los originales quedan intactos
  @spec marcar_urgentes([Embarque.t()]) :: [Embarque.t()]
  def marcar_urgentes(embarques) do
    Enum.map(embarques, fn e -> %{e | urgente: e.distancia_km > 500} end)
  end

  # 3 · devuelve una lista nueva (asume precios enteros, p. ej. centavos)
  @spec aplicar_descuento([integer()], integer()) :: [integer()]
  def aplicar_descuento(precios, pct) do
    Enum.map(precios, fn p ->
      p - Integer.floor_div(p * pct + 50, 100)
    end)
  end

  # 4 · Enum.frequencies_by ya hace exactamente este conteo
  @spec contar_por_tipo([Embarque.t()]) :: %{String.t() => non_neg_integer()}
  def contar_por_tipo(embarques) do
    Enum.frequencies_by(embarques, & &1.tipo)
  end

  # 5 · Enum.uniq conserva el orden de la primera aparición
  @spec sin_duplicados([String.t()]) :: [String.t()]
  def sin_duplicados(ids), do: Enum.uniq(ids)
end