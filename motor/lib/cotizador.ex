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

  defp calcular(embarque, reglas) do
    flete_bruto = embarque.distancia_km * reglas.tarifa_km
    descuento = calcular_descuento(flete_bruto, embarque.peso_kg, reglas.descuento)
    flete = flete_bruto - descuento
    cuota_puente = Map.fetch!(reglas.cuota_puente, embarque.puente)

    base = base_para_recargo(reglas.base_recargo, flete, cuota_puente)
    %{pct: p_recargo, fija: cuota_fija} = Map.fetch!(reglas.recargo, embarque.tipo)
    recargo = pct(base, p_recargo) + cuota_fija

    subtotal = flete + cuota_puente + recargo
    total = max(subtotal, reglas.minimo)
    ajuste_minimo = total - subtotal

    %{
      id: embarque.id,
      flete_bruto: flete_bruto,
      descuento: descuento,
      flete: flete,
      cuota_puente: cuota_puente,
      recargo: recargo,
      ajuste_minimo: ajuste_minimo,
      total: total
    }
  end

  # Base del recargo según la variante (sin if)
  defp base_para_recargo(:flete, flete, _cuota_puente), do: flete
  defp base_para_recargo(:subtotal, flete, cuota_puente), do: flete + cuota_puente

  # Redondeo de porcentaje al centavo más cercano (las mitades hacia arriba)
  defp pct(monto, p), do: div(monto * p + 50, 100)

  # Descuento según criterio de las reglas (sin if)
  defp calcular_descuento(flete_bruto, peso, %{criterio: :a_partir_de, umbral_kg: u, pct: p})
       when peso >= u do
    pct(flete_bruto, p)
  end

  defp calcular_descuento(flete_bruto, peso, %{criterio: :mas_de, umbral_kg: u, pct: p})
       when peso > u do
    pct(flete_bruto, p)
  end

  defp calcular_descuento(_flete_bruto, _peso, _descuento), do: 0
end
