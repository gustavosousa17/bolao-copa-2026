import { createServerClient } from "@/lib/supabase/server";
import { Trophy } from "lucide-react";
import { Match, Prediction, MatchFase } from "@/types/database";
import { DashboardTabs } from "@/components/matches/DashboardTabs";

export const metadata = { title: "Meus Palpites | Bolão Copa 2026" };

const FASE_ORDER: MatchFase[] = [
  "Grupo A", "Grupo B", "Grupo C", "Grupo D",
  "Grupo E", "Grupo F", "Grupo G", "Grupo H",
  "Grupo I", "Grupo J", "Grupo K", "Grupo L",
  "32-avos", "Oitavas", "Quartas", "Semifinal", "Terceiro Lugar", "Final",
];

export default async function DashboardPage() {
  const supabase = await createServerClient();
  const { data: { user } } = await supabase.auth.getUser();

  const [rankingResult, totalPalpitesResult, matchesResult, predictionsResult] = await Promise.all([
    supabase.from("ranking").select("pontuacao_total, total_placar_cheio").eq("user_id", user!.id).single(),
    supabase.from("predictions").select("id", { count: "exact", head: true }).eq("user_id", user!.id),
    supabase.from("matches").select("*").order("data_hora", { ascending: true }),
    supabase.from("predictions").select("*").eq("user_id", user!.id),
  ]);

  type RankingRow = { pontuacao_total: number; total_placar_cheio: number };
  const ranking = rankingResult.data as RankingRow | null;
  const totalPalpites = totalPalpitesResult.count ?? 0;
  const matches = (matchesResult.data ?? []) as unknown as Match[];
  const predictionsRaw = (predictionsResult.data ?? []) as unknown as Prediction[];
  const predictionsMap = new Map<string, Prediction>(
    predictionsRaw.map((p) => [p.match_id, p])
  );

  // Agrupa jogos por fase mantendo a ordem correta (array serializável)
  const matchesByFase: { fase: MatchFase; matches: Match[] }[] = FASE_ORDER
    .map((fase) => ({ fase, matches: matches.filter((m) => m.fase === fase) }))
    .filter((g) => g.matches.length > 0);

  // Map de palpites como array serializável
  const predictionsArray = predictionsRaw;

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-xl font-bold text-white flex items-center gap-2">
            <Trophy className="w-5 h-5 text-yellow-400" />
            Meus Palpites
          </h1>
          <p className="text-sm text-slate-400 mt-0.5">Copa do Mundo FIFA 2026</p>
        </div>

        <div className="flex gap-3">
          <div className="text-center px-4 py-2 bg-slate-800/50 rounded-xl border border-slate-700/50">
            <p className="text-2xl font-bold text-yellow-400">{ranking?.pontuacao_total ?? 0}</p>
            <p className="text-xs text-slate-400">Pontos</p>
          </div>
          <div className="text-center px-4 py-2 bg-slate-800/50 rounded-xl border border-slate-700/50">
            <p className="text-2xl font-bold text-blue-400">{totalPalpites}</p>
            <p className="text-xs text-slate-400">Palpites</p>
          </div>
          <div className="text-center px-4 py-2 bg-slate-800/50 rounded-xl border border-slate-700/50">
            <p className="text-2xl font-bold text-green-400">{ranking?.total_placar_cheio ?? 0}</p>
            <p className="text-xs text-slate-400">Exatos</p>
          </div>
        </div>
      </div>

      {/* Abas por fase */}
      <DashboardTabs matchesByFase={matchesByFase} predictions={predictionsArray} />
    </div>
  );
}
