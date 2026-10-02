defmodule SinMutacionTest do
  use ExUnit.Case, async: true

  @embarques [
    %{id: "A", peso_kg: 1200, distancia_km: 650, tipo: :general},
    %{id: "B", peso_kg: 800, distancia_km: 120, tipo: :refrigerada},
    %{id: "C", peso_kg: 15_000, distancia_km: 500, tipo: :general}
  ]

  test "1 · total_pesos suma el peso de todos los embarques" do
    assert SinMutacion.total_pesos(@embarques) == 17_000
    assert SinMutacion.total_pesos([]) == 0
  end

  test "2 · marcar_urgentes regresa embarques NUEVOS con :urgente (mas de 500 km)" do
    marcados = SinMutacion.marcar_urgentes(@embarques)
    assert Enum.map(marcados, & &1.urgente) == [true, false, false]
    # la lista original no se entera: no hay forma de que se entere
    refute Map.has_key?(hd(@embarques), :urgente)
  end

  test "3 · aplicar_descuento redondea al centavo, mitades hacia arriba" do
    assert SinMutacion.aplicar_descuento([10_000, 2_550, 1], 10) == [9_000, 2_295, 1]
    assert SinMutacion.aplicar_descuento([125], 10) == [112]
  end

  test "4 · contar_por_tipo cuenta cuantos embarques hay de cada tipo" do
    assert SinMutacion.contar_por_tipo(@embarques) == %{general: 2, refrigerada: 1}
    assert SinMutacion.contar_por_tipo([]) == %{}
  end

  test "5 · sin_duplicados conserva la primera aparicion y el orden" do
    assert SinMutacion.sin_duplicados(["B", "A", "B", "C", "A"]) == ["B", "A", "C"]
    assert SinMutacion.sin_duplicados([]) == []
  end
end
