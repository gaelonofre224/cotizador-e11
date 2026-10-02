defmodule PatronesTest do
  use ExUnit.Case, async: true

  test "1 · descripcion: una clausula por tipo; la peligrosa trae su numero UN" do
    assert Patrones.descripcion(%{tipo: :general}) == "Carga general"
    assert Patrones.descripcion(%{tipo: :refrigerada}) == "Carga refrigerada"

    assert Patrones.descripcion(%{tipo: :peligrosa, numero_un: "UN1203"}) ==
             "Carga peligrosa (UN1203)"

    assert Patrones.descripcion(%{tipo: :sobredimensionada, permiso: "SCT-1"}) ==
             "Carga sobredimensionada"
  end

  test "2 · documentos_completos? sin un solo if" do
    assert Patrones.documentos_completos?(%{tipo: :general, numero_un: nil, permiso: nil})
    refute Patrones.documentos_completos?(%{tipo: :peligrosa, numero_un: nil, permiso: nil})
    assert Patrones.documentos_completos?(%{tipo: :peligrosa, numero_un: "UN1203", permiso: nil})

    refute Patrones.documentos_completos?(%{
             tipo: :sobredimensionada,
             numero_un: nil,
             permiso: nil
           })

    assert Patrones.documentos_completos?(%{
             tipo: :sobredimensionada,
             numero_un: nil,
             permiso: "SCT-9"
           })
  end

  test "3 · clasificar_peso con guardas, y las fronteras exactas" do
    assert Patrones.clasificar_peso(0) == :invalido
    assert Patrones.clasificar_peso(999) == :ligero
    assert Patrones.clasificar_peso(1000) == :medio
    assert Patrones.clasificar_peso(9_999) == :medio
    assert Patrones.clasificar_peso(10_000) == :pesado
  end

  test "4 · mensaje descompone el resultado" do
    assert Patrones.mensaje({:ok, 950_150}) == "Total: 950150"
    assert Patrones.mensaje({:error, :peso_invalido}) == "Rechazado: peso_invalido"
  end

  test "5 · primer_id de una lista, o :vacio" do
    assert Patrones.primer_id([]) == :vacio
    assert Patrones.primer_id([%{id: "X1", peso_kg: 1}, %{id: "X2", peso_kg: 2}]) == "X1"
  end
end
