import { createServerClient } from "@/lib/supabase/server";
import { BarChart3, Trophy, Medal } from "lucide-react";
import Image from "next/image";

export const metadata = { title: "Ranking | Bolão Copa 2026" };

export default async function RankingPage() {
  const supabase = await createServerClient();

  const { data: rankingData } = await supabase
    .from("ranking")
    .select(`
      user_id,
      pontuacao_total,
      total_placar_cheio,
      total_apenas_vencedor,
      users (nome, avatar_url)
    `)
    .order("pontuacao_total", { ascending: false })
    .order("total_placar_cheio", { ascending: false })
    .limit(100);

  const positionIcons: Record<number, string> = {
    1: "🥇",
    2: "🥈",
    3: "🥉",
  };

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-xl font-bold text-white flex items-center gap-2">
          <BarChart3 className="w-5 h-5 text-blue-400" />
          Ranking Geral
        </h1>
        <p className="text-sm text-slate-400 mt-0.5">
          {rankingData?.length ?? 0} participantes
        </p>
      </div>

      {/* Tabela */}
      <div className="bg-slate-800/40 border border-slate-700/50 rounded-2xl overflow-hidden">
        {/* Header da tabela */}
        <div className="grid grid-cols-[auto_1fr_auto_auto] gap-4 px-4 py-3 border-b border-slate-700/50 text-xs font-semibold text-slate-400 uppercase tracking-wider">
          <span className="w-8 text-center">#</span>
          <span>Participante</span>
          <span className="text-center">Exatos</span>
          <span className="text-center w-16">Pontos</span>
        </div>

        {/* Linhas */}
        {rankingData && rankingData.length > 0 ? (
          rankingData.map((entry, index) => {
            const posicao = index + 1;
            const user = Array.isArray(entry.users) ? entry.users[0] : entry.users;
            return (
              <div
                key={entry.user_id}
                className={`grid grid-cols-[auto_1fr_auto_auto] gap-4 px-4 py-3.5 items-center border-b border-slate-700/30 last:border-0 transition-colors hover:bg-slate-800/40 ${
                  posicao === 1 ? "bg-yellow-500/5" : ""
                }`}
              >
                {/* Posição */}
                <div className="w-8 text-center">
                  {positionIcons[posicao] ? (
                    <span className="text-lg">{positionIcons[posicao]}</span>
                  ) : (
                    <span className="text-sm font-bold text-slate-500">{posicao}</span>
                  )}
                </div>

                {/* Avatar + Nome */}
                <div className="flex items-center gap-3 min-w-0">
                  {user?.avatar_url ? (
                    <Image
                      src={user.avatar_url}
                      alt={user.nome ?? ""}
                      width={32}
                      height={32}
                      className="rounded-full flex-shrink-0"
                    />
                  ) : (
                    <div className="w-8 h-8 rounded-full bg-blue-600 flex items-center justify-center flex-shrink-0 text-white text-xs font-bold">
                      {(user?.nome ?? "?")[0].toUpperCase()}
                    </div>
                  )}
                  <span className="text-sm text-white font-medium truncate">
                    {user?.nome ?? "Usuário"}
                  </span>
                </div>

                {/* Total placar exato */}
                <div className="flex items-center justify-center gap-1">
                  <Trophy className="w-3.5 h-3.5 text-yellow-400" />
                  <span className="text-sm text-slate-300">{entry.total_placar_cheio}</span>
                </div>

                {/* Pontuação */}
                <div className="w-16 text-center">
                  <span
                    className={`text-sm font-bold ${
                      posicao === 1
                        ? "text-yellow-400"
                        : posicao <= 3
                        ? "text-white"
                        : "text-slate-300"
                    }`}
                  >
                    {entry.pontuacao_total}
                  </span>
                </div>
              </div>
            );
          })
        ) : (
          <div className="py-16 text-center">
            <Medal className="w-10 h-10 text-slate-600 mx-auto mb-3" />
            <p className="text-slate-400 text-sm">
              Nenhum palpite registrado ainda
            </p>
            <p className="text-slate-600 text-xs mt-1">
              O ranking será atualizado conforme os jogos terminarem
            </p>
          </div>
        )}
      </div>

      {/* Sistema de pontuação */}
      <div className="p-4 bg-slate-800/30 border border-slate-700/30 rounded-xl space-y-4">
        <p className="text-xs font-semibold text-slate-400 uppercase tracking-wider">
          Sistema de Pontuação
        </p>
        <div className="grid grid-cols-2 sm:grid-cols-4 gap-3">
          {[
            { pts: 25, desc: "Placar exato", color: "text-yellow-400" },
            { pts: 18, desc: "Vencedor + saldo", color: "text-blue-400" },
            { pts: 10, desc: "Apenas vencedor", color: "text-green-400" },
            { pts: 0, desc: "Errou tudo", color: "text-slate-500" },
          ].map((item) => (
            <div key={item.pts} className="text-center">
              <span className={`text-lg font-bold ${item.color}`}>{item.pts}pts</span>
              <p className="text-xs text-slate-500 mt-0.5">{item.desc}</p>
            </div>
          ))}
        </div>

        {/* Regras */}
        <div className="border-t border-slate-700/40 pt-4 space-y-2">
          <p className="text-xs font-semibold text-slate-400 uppercase tracking-wider mb-3">Regras</p>
          {[
            { icon: "🥇", text: "25 pts — Placar exato: você acertou o placar completo (ex: palpitou 2×1 e foi 2×1)" },
            { icon: "🥈", text: "18 pts — Vencedor + saldo: acertou quem ganhou e a diferença de gols (ex: palpitou 3×1 e foi 2×0 — ambos vitória por 2)" },
            { icon: "🥉", text: "10 pts — Apenas vencedor: acertou quem ganhou ou que seria empate, mas errou o placar" },
            { icon: "❌", text: "0 pts — Errou tudo: não acertou nem o resultado" },
            { icon: "🔒", text: "Palpites ficam travados 1 hora antes do jogo começar — sem alterações após esse prazo" },
            { icon: "🏆", text: "Desempate no ranking: quem tiver mais placares exatos (25 pts) fica à frente" },
          ].map((rule, i) => (
            <div key={i} className="flex items-start gap-2 text-xs text-slate-400">
              <span className="text-sm flex-shrink-0">{rule.icon}</span>
              <span>{rule.text}</span>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}
