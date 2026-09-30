defmodule RecursionTest do
  use ExUnit.Case, async: true
  # Regla del dia: nada de Enum, nada de List, nada de length/1. Cabeza y cola.

  test "1 · longitud" do
    assert Recursion.longitud([]) == 0
    assert Recursion.longitud([:a, :b, :c]) == 3
  end

  test "2 · suma" do
    assert Recursion.suma([]) == 0
    assert Recursion.suma([1200, 800, 15_000]) == 17_000
  end

  test "3 · maximo, y que hacer con la lista vacia" do
    assert Recursion.maximo([]) == nil
    assert Recursion.maximo([7]) == 7
    assert Recursion.maximo([3, 99, -4, 12]) == 99
  end

  test "4 · contar los que cumplen una condicion (esto va a ser filter el lunes)" do
    assert Recursion.contar([1200, 800, 15_000], fn kg -> kg >= 1000 end) == 2
    assert Recursion.contar([], fn _ -> true end) == 0
  end

  test "5 · invertir con acumulador" do
    assert Recursion.invertir([1, 2, 3]) == [3, 2, 1]
    assert Recursion.invertir([]) == []
  end

  test "5b · invertir aguanta un millon de elementos (recursion de cola)" do
    grande = Enum.to_list(1..1_000_000)
    assert hd(Recursion.invertir(grande)) == 1_000_000
  end
end
