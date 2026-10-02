defmodule SinMutacion do
  @moduledoc """
  Martes 29 · Taller: quitar la mutacion.

  Cada funcion es la traduccion de una funcion imperativa de TypeScript que esta en
  `../imperativo.ts`. Alla mutan. Aqui no se puede. Reemplaza cada `raise` y corre:

      mix test test/sin_mutacion_test.exs
  """

  def total_pesos(_embarques), do: raise("por implementar")
  def marcar_urgentes(_embarques), do: raise("por implementar")
  def aplicar_descuento(_precios, _pct), do: raise("por implementar")
  def contar_por_tipo(_embarques), do: raise("por implementar")
  def sin_duplicados(_ids), do: raise("por implementar")
end
