
export type Puente = 'comercio_mundial' | 'colombia';

export type Carga =
  | { tipo: 'general' }
  | { tipo: 'refrigerada' }
  | { tipo: 'peligrosa'; numeroUn: string }
  | { tipo: 'sobredimensionada'; permiso: string };

type Datos = { id: string; pesoKg: number; distanciaKm: number; puente: Puente };
export type Embarque = Datos & Carga;

export type Cotizacion = {
  id: string;
  fleteBruto: number;
  descuento: number;
  flete: number;
  cuotaPuente: number;
  recargo: number;
  ajusteMinimo: number;
  total: number;
};

export type Motivo = 'peso_invalido' | 'distancia_invalida' | 'excede_peso_maximo';

export type Reglas = {
  tarifaKm: number;
  pesoMaximoKg: number;
  minimo: number;
  descuento: { criterio: 'a_partir_de' | 'mas_de'; umbralKg: number; pct: number };
  cuotaPuente: Record<Puente, number>;
  baseRecargo: 'flete' | 'subtotal';
  recargo: Record<Carga['tipo'], { pct: number; fija: number }>;
};

// ───────── Estados ─────────
export type Borrador = { estado: 'borrador'; embarque: Embarque };
export type Cotizado = { estado: 'cotizado'; embarque: Embarque; cotizacion: Cotizacion };
export type Rechazado = { estado: 'rechazado'; embarque: Embarque; motivo: Motivo };
export type Despachado = {
  estado: 'despachado';
  embarque: Embarque;
  cotizacion: Cotizacion;
  folio: string;
};

export type Resultado<T, E> = { ok: true; valor: T } | { ok: false; error: E };

// ───────── Tabla de políticas (en vez de if sobre el tipo) ─────────
const politicas: Record<Carga['tipo'], { aplicaPesoMaximo: boolean }> = {
  general: { aplicaPesoMaximo: true },
  refrigerada: { aplicaPesoMaximo: true },
  peligrosa: { aplicaPesoMaximo: true },
  sobredimensionada: { aplicaPesoMaximo: false },
};

// ───────── Validación ─────────
function validar(e: Embarque, r: Reglas): Resultado<Embarque, Motivo> {
  if (e.pesoKg <= 0) return { ok: false, error: 'peso_invalido' };
  if (e.distanciaKm <= 0) return { ok: false, error: 'distancia_invalida' };
  if (politicas[e.tipo].aplicaPesoMaximo && e.pesoKg > r.pesoMaximoKg) {
    return { ok: false, error: 'excede_peso_maximo' };
  }
  return { ok: true, valor: e };
}

// ───────── Cálculo─────────
// Redondeo al centavo, mitades hacia arriba (equivale a div(monto * p + 50, 100))
const pct = (monto: number, p: number): number => Math.floor((monto * p + 50) / 100);

function calcularDescuento(fleteBruto: number, pesoKg: number, d: Reglas['descuento']): number {
  const aplica = d.criterio === 'a_partir_de' ? pesoKg >= d.umbralKg : pesoKg > d.umbralKg;
  return aplica ? pct(fleteBruto, d.pct) : 0;
}

function baseParaRecargo(base: Reglas['baseRecargo'], flete: number, cuotaPuente: number): number {
  return base === 'flete' ? flete : flete + cuotaPuente;
}

function calcular(e: Embarque, r: Reglas): Cotizacion {
  const fleteBruto = e.distanciaKm * r.tarifaKm;
  const descuento = calcularDescuento(fleteBruto, e.pesoKg, r.descuento);
  const flete = fleteBruto - descuento;
  const cuotaPuente = r.cuotaPuente[e.puente];

  const base = baseParaRecargo(r.baseRecargo, flete, cuotaPuente);
  const { pct: pRecargo, fija } = r.recargo[e.tipo];
  const recargo = pct(base, pRecargo) + fija;

  const subtotal = flete + cuotaPuente + recargo;
  const total = Math.max(subtotal, r.minimo);

  return {
    id: e.id,
    fleteBruto,
    descuento,
    flete,
    cuotaPuente,
    recargo,
    ajusteMinimo: total - subtotal,
    total,
  };
}

// ───────── API pública ─────────
export function cotizar(b: Borrador, r: Reglas): Cotizado | Rechazado {
  const v = validar(b.embarque, r);
  if (!v.ok) return { estado: 'rechazado', embarque: b.embarque, motivo: v.error };
  return { estado: 'cotizado', embarque: b.embarque, cotizacion: calcular(v.valor, r) };
}

export function despachar(c: Cotizado, folio: string): Despachado {
  return { estado: 'despachado', embarque: c.embarque, cotizacion: c.cotizacion, folio };
}