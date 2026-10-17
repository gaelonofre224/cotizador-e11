defmodule Escondida do
  # Taller 3 · La mutación escondida, en Elixir.

  # 1 · Del más ligero al más pesado.
  def ordenar_por_peso(embarques) do
    Enum.sort_by(embarques, & &1.peso_kg)
  end

  # 2 · Las mismas reglas con otro descuento_pct.
  def con_descuento(reglas, pct) do
    %{reglas | descuento_pct: pct}
  end

  # 3 · La lista entra como argumento y sale una nueva con el id al final.
  def registrar(vistos, id) do
    vistos ++ [id]
  end

  # 4 · Nuevo mapa en los dos niveles: embarque y documentos.
  def con_permiso(embarque, permiso) do
    %{embarque | documentos: %{embarque.documentos | permiso: permiso}}
  end

  # 5 · La fecha de salida más unos días.
  def fecha_de_entrega(salida, dias) do
    Date.add(salida, dias)
  end
end