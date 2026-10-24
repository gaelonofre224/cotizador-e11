defmodule SinMutacion do
  @moduledoc """
  Martes 29 · Taller: quitar la mutacion.

  Cada funcion es la traduccion de una funcion imperativa de TypeScript que esta en
  `../imperativo.ts`. Alla mutan. Aqui no se puede. Reemplaza cada `raise` y corre:

      mix test test/sin_mutacion_test.exs
  """

  # 1 · Total pesos
  def total_pesos(embarques) do
    Enum.sum_by(embarques, fn e ->
      Map.get(e, :peso_kg, Map.get(e, :pesoKg, 0))
    end)
  end

  # 2 · Marcar urgentes
  def marcar_urgentes(embarques) do
    Enum.map(embarques, fn e ->
      distancia = Map.get(e, :distancia_km, Map.get(e, :distanciaKm, 0))
      Map.put(e, :urgente, distancia > 500)
    end)
  end

  # 3 · Aplicar descuento
  def aplicar_descuento(precios, pct) do
    Enum.map(precios, fn precio ->
      descuento = floor((precio * pct + 50) / 100)
      precio - descuento
    end)
  end

  # 4 · Contar por tipo
  def contar_por_tipo(embarques) do
    Enum.frequencies_by(embarques, fn e ->
      Map.get(e, :tipo)
    end)
  end

  # 5 · Sin duplicados
  def sin_duplicados(ids) do
    Enum.uniq(ids)
  end
end