"use client";

import { useState } from "react";
import Image from "next/image";
import { Match, Prediction } from "@/types/database";
import { calcularPontos, getPontosLabel, getPontosBadgeColor } from "@/lib/scoring";
import { salvarPalpite } from "@/app/(protected)/dashboard/actions";
import { getFlagUrl } from "@/lib/flags";

type Props = {
  match: Match;
  prediction: Prediction | null;
};

function FlagImage({ name, url }: { name: string; url: string | null }) {
  const src = url || getFlagUrl(name);
  if (!src) return null;
  return (
    <Image
      src={src}
      alt={name}
      width={24}
      height={16}
      className="rounded-sm shrink-0 object-cover"
      unoptimized
    />
  );
}

export function MatchCard({ match, prediction }: Props) {
  const isLocked =
    match.status !== "Agendado" ||
    new Date(match.data_hora) <= new Date(Date.now() + 60 * 60 * 1000);

  const [casa, setCasa] = useState<string>(
    prediction?.placar_casa_palpite !== undefined ? String(prediction.placar_casa_palpite) : ""
  );
  const [fora, setFora] = useState<string>(
    prediction?.placar_fora_palpite !== undefined ? String(prediction.placar_fora_palpite) : ""
  );
  const [saving, setSaving] = useState(false);
  const [saved, setSaved] = useState(false);
  const [error, setError] = useState("");

  const handleSave = async () => {
    const c = Number(casa);
    const f = Number(fora);
    if (casa === "" || fora === "" || c < 0 || f < 0) return;

    setSaving(true);
    setError("");
    const result = await salvarPalpite(match.id, c, f);
    setSaving(false);

    if (result?.error) {
      setError(result.error);
    } else {
      setSaved(true);
      setTimeout(() => setSaved(false), 2000);
    }
  };

  const pontos =
    match.status === "Finalizado" &&
    prediction &&
    match.placar_casa_real !== null &&
    match.placar_fora_real !== null
      ? calcularPontos(
          prediction.placar_casa_palpite,
          prediction.placar_fora_palpite,
          match.placar_casa_real,
          match.placar_fora_real
        )
      : null;

  const dataHora = new Date(match.data_hora);
  const dataFormatada = dataHora.toLocaleDateString("pt-BR", { day: "2-digit", month: "2-digit" });
  const horaFormatada = dataHora.toLocaleTimeString("pt-BR", { hour: "2-digit", minute: "2-digit" });

  return (
    <div className="bg-slate-800/40 border border-slate-700/40 rounded-xl p-4 hover:border-slate-600/60 transition-colors">
      {/* Date + Status */}
      <div className="flex items-center justify-between mb-3">
        <span className="text-xs text-slate-500">
          {dataFormatada} · {horaFormatada}
        </span>
        <StatusBadge status={match.status} />
      </div>

      {/* Teams + Scores */}
      <div className="flex items-center gap-3">
        {/* Home */}
        <div className="flex-1 flex items-center gap-2 justify-end">
          <span className="text-sm font-medium text-white text-right leading-tight">
            {match.time_casa}
          </span>
          <FlagImage name={match.time_casa} url={match.bandeira_casa} />
        </div>

        {/* Score area */}
        <div className="shrink-0 flex items-center gap-1.5">
          {match.status === "Finalizado" ? (
            <>
              <span className="text-lg font-bold text-white w-8 text-center">
                {match.placar_casa_real}
              </span>
              <span className="text-slate-500 text-sm">×</span>
              <span className="text-lg font-bold text-white w-8 text-center">
                {match.placar_fora_real}
              </span>
            </>
          ) : isLocked ? (
            <>
              <span className="text-lg font-bold text-slate-400 w-8 text-center">
                {prediction?.placar_casa_palpite ?? "–"}
              </span>
              <span className="text-slate-500 text-sm">×</span>
              <span className="text-lg font-bold text-slate-400 w-8 text-center">
                {prediction?.placar_fora_palpite ?? "–"}
              </span>
            </>
          ) : (
            <>
              <input
                type="number"
                min={0}
                max={99}
                value={casa}
                onChange={(e) => { setCasa(e.target.value); setSaved(false); }}
                className="w-10 h-9 text-center text-white font-bold bg-slate-700/60 border border-slate-600/60 rounded-lg focus:outline-none focus:border-blue-500 text-sm [appearance:textfield] [&::-webkit-outer-spin-button]:appearance-none [&::-webkit-inner-spin-button]:appearance-none"
              />
              <span className="text-slate-500 text-sm">×</span>
              <input
                type="number"
                min={0}
                max={99}
                value={fora}
                onChange={(e) => { setFora(e.target.value); setSaved(false); }}
                className="w-10 h-9 text-center text-white font-bold bg-slate-700/60 border border-slate-600/60 rounded-lg focus:outline-none focus:border-blue-500 text-sm [appearance:textfield] [&::-webkit-outer-spin-button]:appearance-none [&::-webkit-inner-spin-button]:appearance-none"
              />
            </>
          )}
        </div>

        {/* Away */}
        <div className="flex-1 flex items-center gap-2">
          <FlagImage name={match.time_fora} url={match.bandeira_fora} />
          <span className="text-sm font-medium text-white leading-tight">
            {match.time_fora}
          </span>
        </div>
      </div>

      {/* Bottom row */}
      <div className="mt-3">
        {match.status === "Finalizado" && prediction && (
          <div className="flex items-center justify-between">
            <span className="text-xs text-slate-500">
              Seu palpite: {prediction.placar_casa_palpite} × {prediction.placar_fora_palpite}
            </span>
            {pontos !== null && (
              <span className={`text-xs px-2 py-0.5 rounded-full border font-medium ${getPontosBadgeColor(pontos)}`}>
                {pontos > 0 ? `+${pontos}` : "0"} pts · {getPontosLabel(pontos)}
              </span>
            )}
          </div>
        )}

        {match.status === "Finalizado" && !prediction && (
          <span className="text-xs text-red-400/60">Sem palpite</span>
        )}

        {!isLocked && (
          <div className="flex items-center gap-2">
            <button
              onClick={handleSave}
              disabled={saving || casa === "" || fora === ""}
              className="flex-1 h-8 text-xs font-medium rounded-lg bg-blue-600 hover:bg-blue-500 disabled:opacity-40 disabled:cursor-not-allowed text-white transition-colors"
            >
              {saving ? "Salvando..." : saved ? "✓ Salvo" : prediction ? "Atualizar" : "Salvar palpite"}
            </button>
            {error && <span className="text-xs text-red-400 shrink-0">{error}</span>}
          </div>
        )}

        {isLocked && match.status === "Agendado" && (
          <span className="text-xs text-slate-600">
            🔒 {prediction ? "Palpite registrado" : "Sem palpite — jogo bloqueado"}
          </span>
        )}
      </div>
    </div>
  );
}

function StatusBadge({ status }: { status: Match["status"] }) {
  if (status === "Ao Vivo") {
    return (
      <span className="flex items-center gap-1 text-xs font-medium text-red-400 bg-red-400/10 border border-red-400/20 px-2 py-0.5 rounded-full">
        <span className="w-1.5 h-1.5 rounded-full bg-red-400 animate-pulse" />
        Ao Vivo
      </span>
    );
  }
  if (status === "Finalizado") {
    return (
      <span className="text-xs text-slate-500 bg-slate-700/40 border border-slate-600/30 px-2 py-0.5 rounded-full">
        Finalizado
      </span>
    );
  }
  return null;
}
