import { Match, Prediction } from "@/types/database";
import { MatchCard } from "./MatchCard";

type Props = {
  fase: string;
  matches: Match[];
  predictions: Map<string, Prediction>;
};

export function MatchGroup({ fase, matches, predictions }: Props) {
  const total = matches.length;
  const feitos = matches.filter((m) => predictions.has(m.id)).length;

  return (
    <div>
      <div className="flex items-center justify-between mb-3">
        <h2 className="text-sm font-semibold text-slate-400 uppercase tracking-wider">
          {fase}
        </h2>
        <span className="text-xs text-slate-600">
          {feitos}/{total} palpites
        </span>
      </div>
      <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
        {matches.map((match) => (
          <MatchCard
            key={match.id}
            match={match}
            prediction={predictions.get(match.id) ?? null}
          />
        ))}
      </div>
    </div>
  );
}
