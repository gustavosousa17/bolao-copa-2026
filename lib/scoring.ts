/**
 * Motor de pontuação do Bolão Copa 2026
 * (Espelho da função SQL calcular_pontos para uso client-side)
 */
export function calcularPontos(
  pCasa: number,
  pFora: number,
  rCasa: number,
  rFora: number
): number {
  const saldoPalpite = pCasa - pFora;
  const saldoReal = rCasa - rFora;
  const vencPalpite = Math.sign(saldoPalpite);
  const vencReal = Math.sign(saldoReal);

  if (pCasa === rCasa && pFora === rFora) return 25;
  if (vencPalpite === vencReal && saldoPalpite === saldoReal) return 18;
  if (vencPalpite === vencReal) return 10;
  return 0;
}

export function getPontosLabel(pontos: number): string {
  switch (pontos) {
    case 25: return "Placar exato";
    case 18: return "Vencedor + saldo";
    case 10: return "Apenas vencedor";
    default: return "Errou";
  }
}

export function getPontosBadgeColor(pontos: number): string {
  switch (pontos) {
    case 25: return "bg-yellow-500/20 text-yellow-400 border-yellow-500/30";
    case 18: return "bg-blue-500/20 text-blue-400 border-blue-500/30";
    case 10: return "bg-green-500/20 text-green-400 border-green-500/30";
    default: return "bg-red-500/20 text-red-400 border-red-500/30";
  }
}
