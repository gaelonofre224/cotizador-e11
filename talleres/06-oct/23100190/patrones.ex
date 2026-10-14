defmodule Patrones do
  @moduledoc """
  Miercoles 30 · Coincidencia de patrones.

  Regla del dia: ni un solo `if`, `cond` ni `case` sobre el tipo. Cada decision es una
  clausula de funcion. Puedes escribir cuantas clausulas quieras de cada funcion.

      mix test test/patrones_test.exs
  """

  # 1 · descripcion: una cláusula por tipo
  def descripcion(%{tipo: :general}), do: "Carga general"
  def descripcion(%{tipo: :refrigerada}), do: "Carga refrigerada"
  def descripcion(%{tipo: :peligrosa, numero_un: un}), do: "Carga peligrosa (#{un})"
  def descripcion(%{tipo: :sobredimensionada}), do: "Carga sobredimensionada"

  # 2 · documentos_completos? sin un solo if (casos específicos primero, comodín al final)
  def documentos_completos?(%{tipo: :peligrosa, numero_un: nil}), do: false
  def documentos_completos?(%{tipo: :sobredimensionada, permiso: nil}), do: false
  def documentos_completos?(%{}), do: true

  # 3 · clasificar_peso con guardas y fronteras exactas
  def clasificar_peso(kg) when kg <= 0, do: :invalido
  def clasificar_peso(kg) when kg < 1_000, do: :ligero
  def clasificar_peso(kg) when kg < 10_000, do: :medio
  def clasificar_peso(_kg), do: :pesado

  # 4 · mensaje descompone el resultado
  def mensaje({:ok, total}), do: "Total: #{total}"
  def mensaje({:error, motivo}), do: "Rechazado: #{motivo}"

  # 5 · primer_id de una lista, o :vacio
  def primer_id([]), do: :vacio
  def primer_id([%{id: id} | _resto]), do: id
end