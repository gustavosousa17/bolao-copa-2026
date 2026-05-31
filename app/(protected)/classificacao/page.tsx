import { createServerClient } from "@/lib/supabase/server";
import { getFlagUrl } from "@/lib/flags";
import { LayoutGrid } from "lucide-react";

export const metadata = { title: "Classificação | Bolão Copa 2026" };

const GROUP_ORDER = [
  "Grupo A", "Grupo B", "Grupo C", "Grupo D",
  "Grupo E", "Grupo F", "Grupo G", "Grupo H",
  "Grupo I", "Grupo J", "Grupo K", "Grupo L",
];

type TeamStanding = {
  team: string;
  played: number;
  won: number;
  drawn: number;
  lost: number;
  goalsFor: number;
  goalsAgainst: number;
  goalDiff: number;
  points: number;
};

function initTeam(name: string): TeamStanding {
  return { team: name, played: 0, won: 0, drawn: 0, lost: 0, goalsFor: 0, goalsAgainst: 0, goalDiff: 0, points: 0 };
}

// eslint-disable-next-line @typescript-eslint/no-explicit-any
function calculateStandings(matches: any[]) {
  const standings: Record<string, Record<string, TeamStanding>> = {};

  for (const match of matches) {
    const grupo = String(match.fase);
    if (!standings[grupo]) standings[grupo] = {};
    if (!standings[grupo][match.time_casa]) standings[grupo][match.time_casa] = initTeam(match.time_casa);
    if (!standings[grupo][match.time_fora]) standings[grupo][match.time_fora] = initTeam(match.time_fora);

    if (match.status === "Finalizado" && match.placar_casa_real !== null && match.placar_fora_real !== null) {
      const home = standings[grupo][match.time_casa];
      const away = standings[grupo][match.time_fora];

      home.played++; away.played++;
      home.goalsFor += match.placar_casa_real;
      home.goalsAgainst += match.placar_fora_real;
      away.goalsFor += match.placar_fora_real;
      away.goalsAgainst += match.placar_casa_real;

      if (match.placar_casa_real > match.placar_fora_real) {
        home.won++; home.points += 3; away.lost++;
      } else if (match.placar_fora_real > match.placar_casa_real) {
        away.won++; away.points += 3; home.lost++;
      } else {
        home.drawn++; home.points++; away.drawn++; away.points++;
      }

      home.goalDiff = home.goalsFor - home.goalsAgainst;
      away.goalDiff = away.goalsFor - away.goalsAgainst;
    }
  }

  return standings;
}

function sortTeams(teams: TeamStanding[]): TeamStanding[] {
  return [...teams].sort((a, b) => {
    if (b.points !== a.points) return b.points - a.points;
    if (b.goalDiff !== a.goalDiff) return b.goalDiff - a.goalDiff;
    return b.goalsFor - a.goalsFor;
  });
}

export default async function ClassificacaoPage() {
  const supabase = await createServerClient();

  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const { data: allMatches } = await (supabase as any)
    .from("matches")
    .select("fase, time_casa, time_fora, placar_casa_real, placar_fora_real, status");

  const groupMatches = (allMatches ?? []).filter((m: any) =>
    String(m.fase).startsWith("Grupo ")
  );

  const standingsData = calculateStandings(groupMatches);

  const groups = GROUP_ORDER.map((fase) => ({
    fase,
    teams: sortTeams(Object.values(standingsData[fase] ?? {})),
  }));

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-xl font-bold text-white flex items-center gap-2">
          <LayoutGrid className="w-5 h-5 text-blue-400" />
          Classificação dos Grupos
        </h1>
        <p className="text-sm text-slate-400 mt-0.5">
          Atualizada conforme os jogos são finalizados
        </p>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-5">
        {groups.map(({ fase, teams }) => (
          <GroupTable key={fase} fase={fase} teams={teams} />
        ))}
      </div>

      <div className="flex items-center gap-6 text-xs text-slate-500">
        <div className="flex items-center gap-2">
          <div className="w-3 h-3 rounded-sm bg-green-500/20 border border-green-500/40" />
          <span>Classificado direto (1º e 2º)</span>
        </div>
        <div className="flex items-center gap-2">
          <div className="w-3 h-3 rounded-sm bg-yellow-500/20 border border-yellow-500/40" />
          <span>Possível classificado (melhor 3º)</span>
        </div>
      </div>
    </div>
  );
}

function GroupTable({ fase, teams }: { fase: string; teams: TeamStanding[] }) {
  const hasStarted = teams.some((t) => t.played > 0);

  return (
    <div className="bg-slate-800/40 border border-slate-700/50 rounded-xl overflow-hidden">
      <div className="px-4 py-2.5 bg-slate-700/30 border-b border-slate-700/50">
        <h2 className="text-sm font-bold text-white">{fase}</h2>
      </div>

      <table className="w-full text-xs">
        <thead>
          <tr className="text-slate-500 uppercase tracking-wider border-b border-slate-700/30">
            <th className="px-3 py-2 text-left w-6">#</th>
            <th className="px-3 py-2 text-left">Seleção</th>
            <th className="px-2 py-2 text-center" title="Jogos">J</th>
            <th className="px-2 py-2 text-center" title="Vitórias">V</th>
            <th className="px-2 py-2 text-center" title="Empates">E</th>
            <th className="px-2 py-2 text-center" title="Derrotas">D</th>
            <th className="px-2 py-2 text-center" title="Saldo de Gols">SG</th>
            <th className="px-3 py-2 text-center font-semibold text-slate-400" title="Pontos">Pts</th>
          </tr>
        </thead>
        <tbody>
          {teams.map((team, idx) => {
            const isQualified = idx < 2;
            const isMayQualify = idx === 2;
            const flagUrl = getFlagUrl(team.team);

            return (
              <tr
                key={team.team}
                className={`border-t border-slate-700/20 transition-colors ${
                  isQualified
                    ? "bg-green-500/5 hover:bg-green-500/10"
                    : isMayQualify
                    ? "bg-yellow-500/5 hover:bg-yellow-500/10"
                    : "hover:bg-slate-700/20"
                }`}
              >
                <td className="px-3 py-3">
                  <span className={`font-bold text-xs ${
                    isQualified ? "text-green-400" : isMayQualify ? "text-yellow-400" : "text-slate-600"
                  }`}>
                    {idx + 1}
                  </span>
                </td>
                <td className="px-3 py-3">
                  <div className="flex items-center gap-2 min-w-0">
                    {flagUrl ? (
                      // eslint-disable-next-line @next/next/no-img-element
                      <img src={flagUrl} alt={team.team} width={20} height={14} className="rounded-sm object-cover flex-shrink-0" />
                    ) : (
                      <div className="w-5 h-3.5 bg-slate-700 rounded-sm flex-shrink-0" />
                    )}
                    <span className={`truncate font-medium ${isQualified ? "text-white" : "text-slate-300"}`}>
                      {team.team}
                    </span>
                  </div>
                </td>
                <td className="px-2 py-3 text-center text-slate-400">{team.played}</td>
                <td className="px-2 py-3 text-center text-slate-400">{team.won}</td>
                <td className="px-2 py-3 text-center text-slate-400">{team.drawn}</td>
                <td className="px-2 py-3 text-center text-slate-400">{team.lost}</td>
                <td className="px-2 py-3 text-center text-slate-400">
                  {team.goalDiff > 0 ? `+${team.goalDiff}` : team.goalDiff}
                </td>
                <td className="px-3 py-3 text-center">
                  <span className={`font-bold text-sm ${isQualified ? "text-white" : "text-slate-300"}`}>
                    {team.points}
                  </span>
                </td>
              </tr>
            );
          })}
        </tbody>
      </table>

      {!hasStarted && (
        <div className="py-3 text-center text-xs text-slate-600 border-t border-slate-700/20">
          Aguardando início dos jogos — 11 de junho
        </div>
      )}
    </div>
  );
}
