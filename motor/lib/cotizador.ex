defmodule Cotizador do
  @tipos [:general, :refrigerada, :peligrosa, :sobredimensionada]

  def cotizar(embarque, reglas) do
    with :ok <- validar(embarque, reglas) do
      {:ok, calcular(embarque, reglas)}
    end
  end

  # 1 · peso inválido
  defp validar(%{peso_kg: p}, _reglas) when p <= 0, do: {:error, :peso_invalido}

  # 2 · distancia inválida
  defp validar(%{distancia_km: d}, _reglas) when d <= 0, do: {:error, :distancia_invalida}

  # 3 · tipo desconocido
  defp validar(%{tipo: t}, _reglas) when t not in @tipos, do: {:error, :tipo_desconocido}

  # 4 · puente desconocido
  defp validar(%{puente: p}, reglas) when not is_map_key(reglas.cuota_puente, p),
    do: {:error, :puente_desconocido}

  # 5 · peligrosa sin número UN
  defp validar(%{tipo: :peligrosa, numero_un: nil}, _reglas), do: {:error, :falta_numero_un}

  # 6 · sobredimensionada sin permiso
  defp validar(%{tipo: :sobredimensionada, permiso: nil}, _reglas), do: {:error, :falta_permiso}

  # 7 · peso máximo (sobredimensionada no tiene límite de peso)
  defp validar(%{tipo: :sobredimensionada}, _reglas), do: :ok

  defp validar(%{peso_kg: p}, reglas) when p > reglas.peso_maximo_kg,
    do: {:error, :excede_peso_maximo}

  # Embarque válido
  defp validar(_embarque, _reglas), do: :ok

  defp calcular(_embarque, _reglas), do: %{}
end
