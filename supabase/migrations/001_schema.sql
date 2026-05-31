-- ============================================================
-- BOLÃO COPA 2026 — Schema Principal
-- Execute no SQL Editor do Supabase Dashboard
-- ============================================================

-- Extensões necessárias
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ============================================================
-- TIPOS ENUM
-- ============================================================
DO $$ BEGIN
  CREATE TYPE match_status AS ENUM ('Agendado', 'Ao Vivo', 'Finalizado');
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

DO $$ BEGIN
  CREATE TYPE match_fase AS ENUM (
    'Grupo A','Grupo B','Grupo C','Grupo D','Grupo E','Grupo F',
    'Grupo G','Grupo H','Grupo I','Grupo J','Grupo K','Grupo L',
    '32-avos','Oitavas','Quartas','Semifinal','Terceiro Lugar','Final'
  );
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

-- ============================================================
-- TABELA: users
-- Complementa auth.users do Supabase com dados públicos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.users (
  id          UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email       TEXT NOT NULL UNIQUE,
  nome        TEXT,
  avatar_url  TEXT,
  criado_em   TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

-- ============================================================
-- TABELA: matches (104 jogos da Copa 2026)
-- ============================================================
CREATE TABLE IF NOT EXISTS public.matches (
  id                   UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  api_match_id         INTEGER UNIQUE,
  fase                 match_fase NOT NULL,
  time_casa            TEXT NOT NULL,
  time_fora            TEXT NOT NULL,
  bandeira_casa        TEXT,
  bandeira_fora        TEXT,
  placar_casa_real     INTEGER CHECK (placar_casa_real >= 0),
  placar_fora_real     INTEGER CHECK (placar_fora_real >= 0),
  data_hora            TIMESTAMPTZ NOT NULL,
  status               match_status DEFAULT 'Agendado' NOT NULL,
  criado_em            TIMESTAMPTZ DEFAULT NOW() NOT NULL,
  atualizado_em        TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

-- Index para buscas por status e data
CREATE INDEX IF NOT EXISTS idx_matches_status ON public.matches(status);
CREATE INDEX IF NOT EXISTS idx_matches_data_hora ON public.matches(data_hora);
CREATE INDEX IF NOT EXISTS idx_matches_fase ON public.matches(fase);

-- ============================================================
-- TABELA: predictions (palpites dos usuários)
-- ============================================================
CREATE TABLE IF NOT EXISTS public.predictions (
  id                      UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id                 UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
  match_id                UUID NOT NULL REFERENCES public.matches(id) ON DELETE CASCADE,
  placar_casa_palpite     INTEGER NOT NULL CHECK (placar_casa_palpite >= 0),
  placar_fora_palpite     INTEGER NOT NULL CHECK (placar_fora_palpite >= 0),
  pontos_ganhos           INTEGER DEFAULT 0 NOT NULL,
  atualizado_em           TIMESTAMPTZ DEFAULT NOW() NOT NULL,
  UNIQUE(user_id, match_id)
);

-- Index para buscas frequentes
CREATE INDEX IF NOT EXISTS idx_predictions_user_id ON public.predictions(user_id);
CREATE INDEX IF NOT EXISTS idx_predictions_match_id ON public.predictions(match_id);

-- ============================================================
-- TABELA: ranking
-- Atualizado automaticamente via trigger ao finalizar jogos
-- ============================================================
CREATE TABLE IF NOT EXISTS public.ranking (
  user_id                UUID PRIMARY KEY REFERENCES public.users(id) ON DELETE CASCADE,
  pontuacao_total        INTEGER DEFAULT 0 NOT NULL,
  total_placar_cheio     INTEGER DEFAULT 0 NOT NULL,
  total_apenas_vencedor  INTEGER DEFAULT 0 NOT NULL,
  atualizado_em          TIMESTAMPTZ DEFAULT NOW() NOT NULL
);
