// Taller · Las cinco funciones de partida. Todas MUTAN algo.
// Tu trabajo: escribir cada una en Elixir (ejercicios/lib/sin_mutacion.ex), donde mutar no existe.
// Antes de escribir, contesta en voz alta con tu pareja: ¿que muta aqui, y quien se entera?

type Embarque = { id: string; pesoKg: number; distanciaKm: number; tipo: string; urgente?: boolean };

// 1 · un acumulador que cambia en cada vuelta
export function totalPesos(embarques: Embarque[]): number {
  let total = 0;
  for (const e of embarques) total += e.pesoKg;
  return total;
}

// 2 · modifica los objetos que le prestaron: quien los tenga, ve el cambio
export function marcarUrgentes(embarques: Embarque[]): Embarque[] {
  for (const e of embarques) e.urgente = e.distanciaKm > 500;
  return embarques;
}

// 3 · reescribe el arreglo en su lugar
export function aplicarDescuento(precios: number[], pct: number): number[] {
  for (let i = 0; i < precios.length; i++) {
    precios[i] = precios[i]! - Math.floor((precios[i]! * pct + 50) / 100);
  }
  return precios;
}

// 4 · un objeto contador que crece
export function contarPorTipo(embarques: Embarque[]): Record<string, number> {
  const conteo: Record<string, number> = {};
  for (const e of embarques) conteo[e.tipo] = (conteo[e.tipo] ?? 0) + 1;
  return conteo;
}

// 5 · dos estructuras que crecen a la vez
export function sinDuplicados(ids: string[]): string[] {
  const vistos = new Set<string>();
  const resultado: string[] = [];
  for (const id of ids) {
    if (!vistos.has(id)) {
      vistos.add(id);
      resultado.push(id);
    }
  }
  return resultado;
}
