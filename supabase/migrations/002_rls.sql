-- ============================================================
-- BOLÃO COPA 2026 — Row Level Security (RLS)
-- Execute APÓS 001_schema.sql
-- ============================================================

-- ============================================================
-- Habilitar RLS em todas as tabelas
-- ============================================================
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.matches ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.predictions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.ranking ENABLE ROW LEVEL SECURITY;

-- ============================================================
-- POLÍTICAS: users
-- ============================================================

-- Usuário vê apenas seu próprio perfil
CREATE POLICY "users_select_own"
  ON public.users FOR SELECT
  USING (auth.uid() = id);

-- Usuário pode atualizar apenas seu próprio perfil
CREATE POLICY "users_update_own"
  ON public.users FOR UPDATE
  USING (auth.uid() = id);

-- Service role pode inserir (trigger de criação automática)
CREATE POLICY "users_insert_service"
  ON public.users FOR INSERT
  WITH CHECK (true); -- Controlado pelo trigger SECURITY DEFINER

-- ============================================================
-- POLÍTICAS: matches
-- ============================================================

-- Todos os usuários autenticados podem LER os jogos
CREATE POLICY "matches_select_all"
  ON public.matches FOR SELECT
  USING (true);

-- Apenas service_role pode modificar jogos (via cron/API)
-- (Sem política de INSERT/UPDATE/DELETE = apenas service_role pode)

-- ============================================================
-- POLÍTICAS: predictions
-- ============================================================

-- Usuário lê apenas seus palpites
CREATE POLICY "predictions_select_own"
  ON public.predictions FOR SELECT
  USING (auth.uid() = user_id);

-- Usuário cria palpite apenas se:
-- 1. É o próprio usuário
-- 2. O jogo ainda não começou (mais de 5 minutos de margem)
-- 3. O jogo está Agendado
CREATE POLICY "predictions_insert_own"
  ON public.predictions FOR INSERT
  WITH CHECK (
    auth.uid() = user_id
    AND EXISTS (
      SELECT 1 FROM public.matches m
      WHERE m.id = match_id
        AND m.data_hora > (NOW() + INTERVAL '5 minutes')
        AND m.status = 'Agendado'
    )
  );

-- Usuário atualiza palpite apenas se jogo ainda não começou
CREATE POLICY "predictions_update_own"
  ON public.predictions FOR UPDATE
  USING (
    auth.uid() = user_id
    AND EXISTS (
      SELECT 1 FROM public.matches m
      WHERE m.id = match_id
        AND m.data_hora > (NOW() + INTERVAL '5 minutes')
        AND m.status = 'Agendado'
    )
  );

-- ============================================================
-- POLÍTICAS: ranking
-- ============================================================

-- Qualquer pessoa (inclusive não autenticada) pode ver o ranking
CREATE POLICY "ranking_select_all"
  ON public.ranking FOR SELECT
  USING (true);

-- Apenas service_role atualiza o ranking (via trigger)
-- (Sem política de INSERT/UPDATE = apenas service_role)
