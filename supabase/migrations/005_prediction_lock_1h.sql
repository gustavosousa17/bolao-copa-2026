-- ============================================================
-- BOLÃO COPA 2026 — Atualiza bloqueio de palpites para 1 hora
-- Antes: 5 minutos | Agora: 1 hora antes do início do jogo
-- ============================================================

DROP POLICY IF EXISTS "predictions_insert_own" ON public.predictions;
DROP POLICY IF EXISTS "predictions_update_own" ON public.predictions;

-- Usuário cria palpite apenas se:
-- 1. É o próprio usuário
-- 2. Faltam mais de 1 hora para o início do jogo
-- 3. O jogo está Agendado
CREATE POLICY "predictions_insert_own"
  ON public.predictions FOR INSERT
  WITH CHECK (
    auth.uid() = user_id
    AND EXISTS (
      SELECT 1 FROM public.matches m
      WHERE m.id = match_id
        AND m.data_hora > (NOW() + INTERVAL '1 hour')
        AND m.status = 'Agendado'
    )
  );

-- Usuário atualiza palpite apenas se faltam mais de 1 hora
CREATE POLICY "predictions_update_own"
  ON public.predictions FOR UPDATE
  USING (
    auth.uid() = user_id
    AND EXISTS (
      SELECT 1 FROM public.matches m
      WHERE m.id = match_id
        AND m.data_hora > (NOW() + INTERVAL '1 hour')
        AND m.status = 'Agendado'
    )
  );
