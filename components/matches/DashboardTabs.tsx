"use client";

import { useState, useMemo } from "react";
import { Match, Prediction, MatchFase } from "@/types/database";
import { MatchGroup } from "./MatchGroup";
import { MatchCard } from "./MatchCard";

const GROUP_FASES: MatchFase[] = [
  "Grupo A", "Grupo B", "Grupo C", "Grupo D",
  "Grupo E", "Grupo F", "Grupo G", "Grupo H",
  "Grupo I", "Grupo J", "Grupo K", "Grupo L",
];

const TABS = [
  { id: "grupos",    label: "Grupos",  fases: GROUP_FASES },
  { id: "32avos",    label: "32-avos", fases: ["32-avos"] as MatchFase[] },
  { id: "oitavas",   label: "Oitavas", fases: ["Oitavas"] as MatchFase[] },
  { id: "quartas",   label: "Quartas", fases: ["Quartas"] as MatchFase[] },
  { id: "semis",     label: "Semis",   fases: ["Semifinal", "Terceiro Lugar"] as MatchFase[] },
  { id: "final",     label: "Final",   fases: ["Final"] as MatchFase[] },
];

type FaseGroup = { fase: MatchFase; matches: Match[] };

type Props = {
  matchesByFase: FaseGroup[];
  predictions: Prediction[];
};

export function DashboardTabs({ matchesByFase, predictions }: Props) {
  const [activeTab, setActiveTab] = useState("grupos");

  const predictionsMap = useMemo(
    () => new Map(predictions.map((p) => [p.match_id, p])),
    [predictions]
  );

  const faseMap = useMemo(
    () => new Map(matchesByFase.map((g) => [g.fase, g.matches])),
    [matchesByFase]
  );

  const currentTab = TABS.find((t) => t.id === activeTab)!;

  return (
    <div className="space-y-6">
      {/* Tab bar */}
      <div className="flex gap-1 bg-slate-800/50 p-1 rounded-xl border border-slate-700/40 overflow-x-auto">
        {TABS.map((tab) => {
          const total = tab.fases.reduce((sum, f) => sum + (faseMap.get(f)?.length ?? 0), 0);
          if (total === 0) return null;

          const isActive = activeTab === tab.id;
          return (
            <button
              key={tab.id}
              onClick={() => setActiveTab(tab.id)}
              className={`flex-1 min-w-fit px-3 py-2 rounded-lg text-sm font-medium transition-all whitespace-nowrap ${
                isActive
                  ? "bg-blue-600 text-white shadow-sm"
                  : "text-slate-400 hover:text-white hover:bg-slate-700/60"
              }`}
            >
              {tab.label}
            </button>
          );
        })}
      </div>

      {/* Tab content */}
      <div className="space-y-10">
        {activeTab === "grupos" ? (
          GROUP_FASES
            .filter((f) => faseMap.has(f))
            .map((fase) => (
              <MatchGroup
                key={fase}
                fase={fase}
                matches={faseMap.get(fase)!}
                predictions={predictionsMap}
              />
            ))
        ) : (
          currentTab.fases
            .filter((f) => faseMap.has(f))
            .map((fase) => (
              <div key={fase}>
                {currentTab.fases.length > 1 && (
                  <h2 className="text-sm font-semibold text-slate-400 uppercase tracking-wider mb-3">
                    {fase}
                  </h2>
                )}
                <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
                  {faseMap.get(fase)!.map((match) => (
                    <MatchCard
                      key={match.id}
                      match={match}
                      prediction={predictionsMap.get(match.id) ?? null}
                    />
                  ))}
                </div>
              </div>
            ))
        )}
      </div>
    </div>
  );
}
