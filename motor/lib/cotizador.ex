defmodule Cotizador do
  @tipos [:general, :refrigerada, :peligrosa, :sobredimensionada]

  def cotizar(embarque, reglas) do
    with :ok <- validar(embarque, reglas) do
      {:ok, calcular(embarque, reglas)}
    end
  end

  def resumen(lote, reglas) do
    puentes_cero = Map.new(reglas.cuota_puente, fn {puente, _cuota} -> {puente, 0} end)

    inicial = %{
      cotizados: 0,
      rechazados: [],
      cotizaciones: [],
      por_puente: puentes_cero
    }

    resultado =
      lote
      |> Enum.map(fn e -> {e, cotizar(e, reglas)} end)
      |> Enum.reduce(inicial, &acumular/2)

    %{
      cotizados: resultado.cotizados,
      rechazados: Enum.reverse(resultado.rechazados),
      total: sumar_totales(resultado.cotizaciones),
      por_puente: resultado.por_puente
    }
  end

  defp acumular({embarque, {:ok, c}}, acc) do
    %{
      acc
      | cotizados: acc.cotizados + 1,
        cotizaciones: [c | acc.cotizaciones],
        por_puente: Map.update!(acc.por_puente, embarque.puente, &(&1 + c.total))
    }
  end

  defp acumular({embarque, {:error, motivo}}, acc) do
    %{acc | rechazados: [{embarque.id, motivo} | acc.rechazados]}
  end

  # Función recursiva pura a mano sobre lista sin Enum (Receta de las 3 preguntas)
  # Caso base: lista vacía suma 0
  # Caso recursivo: cabeza + llamada sobre la cola
  defp sumar_totales([]), do: 0
  defp sumar_totales([c | resto]), do: c.total + sumar_totales(resto)

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
