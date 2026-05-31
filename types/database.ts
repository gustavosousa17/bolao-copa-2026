export type MatchStatus = "Agendado" | "Ao Vivo" | "Finalizado";

export type MatchFase =
  | "Grupo A" | "Grupo B" | "Grupo C" | "Grupo D"
  | "Grupo E" | "Grupo F" | "Grupo G" | "Grupo H"
  | "Grupo I" | "Grupo J" | "Grupo K" | "Grupo L"
  | "32-avos" | "Oitavas" | "Quartas" | "Semifinal"
  | "Terceiro Lugar" | "Final";

export type User = {
  id: string;
  email: string;
  nome: string | null;
  avatar_url: string | null;
  criado_em: string;
};

export type Match = {
  id: string;
  api_match_id: number | null;
  fase: MatchFase;
  time_casa: string;
  time_fora: string;
  bandeira_casa: string | null;
  bandeira_fora: string | null;
  placar_casa_real: number | null;
  placar_fora_real: number | null;
  data_hora: string;
  status: MatchStatus;
  criado_em: string;
  atualizado_em: string;
};

export type Prediction = {
  id: string;
  user_id: string;
  match_id: string;
  placar_casa_palpite: number;
  placar_fora_palpite: number;
  pontos_ganhos: number;
  atualizado_em: string;
};

export type Ranking = {
  user_id: string;
  pontuacao_total: number;
  total_placar_cheio: number;
  total_apenas_vencedor: number;
  atualizado_em: string;
  // Joins
  users?: User;
};

export type MatchWithPrediction = Match & {
  predictions: Prediction[];
  isLocked: boolean;
};

export type RankingEntry = Ranking & {
  posicao: number;
  users: User;
};

export type Database = {
  public: {
    Tables: {
      users: {
        Row: User;
        Insert: Omit<User, "criado_em">;
        Update: Partial<Omit<User, "id" | "criado_em">>;
        Relationships: [];
      };
      matches: {
        Row: Match;
        Insert: Omit<Match, "id" | "criado_em" | "atualizado_em">;
        Update: Partial<Omit<Match, "id" | "criado_em">>;
        Relationships: [];
      };
      predictions: {
        Row: Prediction;
        Insert: Omit<Prediction, "id" | "pontos_ganhos" | "atualizado_em">;
        Update: Partial<Pick<Prediction, "placar_casa_palpite" | "placar_fora_palpite">>;
        Relationships: [];
      };
      ranking: {
        Row: Ranking;
        Insert: Omit<Ranking, "atualizado_em">;
        Update: Partial<Omit<Ranking, "user_id">>;
        Relationships: [];
      };
    };
    Views: Record<string, never>;
    Functions: Record<string, never>;
    Enums: Record<string, never>;
    CompositeTypes: Record<string, never>;
  };
};
