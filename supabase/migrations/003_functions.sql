-- ============================================================
-- BOLÃO COPA 2026 — Funções, Triggers e Motor de Pontuação
-- Execute APÓS 002_rls.sql
-- ============================================================

-- ============================================================
-- FUNÇÃO: calcular_pontos
-- Retorna pontos com base no palpite vs resultado real
-- Regras:
--   25pts → Placar exato
--   18pts → Acertou vencedor E diferença de gols
--   10pts → Acertou apenas vencedor (ou empate)
--    0pts → Errou tudo
-- ============================================================
CREATE OR REPLACE FUNCTION public.calcular_pontos(
  p_casa INTEGER,  -- palpite: gols do time da casa
  p_fora INTEGER,  -- palpite: gols do time visitante
  r_casa INTEGER,  -- resultado real: gols do time da casa
  r_fora INTEGER   -- resultado real: gols do time visitante
)
RETURNS INTEGER
LANGUAGE plpgsql
IMMUTABLE
AS $$
DECLARE
  saldo_palpite INTEGER;
  saldo_real    INTEGER;
  venc_palpite  INTEGER;
  venc_real     INTEGER;
BEGIN
  -- Retorna 0 se resultados reais não disponíveis
  IF r_casa IS NULL OR r_fora IS NULL THEN
    RETURN 0;
  END IF;

  saldo_palpite := p_casa - p_fora;
  saldo_real    := r_casa - r_fora;
  venc_palpite  := SIGN(saldo_palpite);
  venc_real     := SIGN(saldo_real);

  -- Placar exato: 25 pontos
  IF p_casa = r_casa AND p_fora = r_fora THEN
    RETURN 25;
  END IF;

  -- Acertou vencedor E saldo de gols: 18 pontos
  -- Ex: Palpite 3x1, Resultado 2x0 (ambos diferença +2, mesmo vencedor)
  IF venc_palpite = venc_real AND saldo_palpite = saldo_real THEN
    RETURN 18;
  END IF;

  -- Acertou apenas o vencedor ou empate comum: 10 pontos
  IF venc_palpite = venc_real THEN
    RETURN 10;
  END IF;

  -- Errou tudo: 0 pontos
  RETURN 0;
END;
$$;

-- ============================================================
-- FUNÇÃO: processar_jogo_finalizado
-- Trigger chamado quando match.status muda para 'Finalizado'
-- Calcula pontos de todas as predictions e atualiza ranking
-- ============================================================
CREATE OR REPLACE FUNCTION public.processar_jogo_finalizado()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  -- Apenas quando status muda PARA 'Finalizado'
  IF NEW.status = 'Finalizado' AND OLD.status <> 'Finalizado'
     AND NEW.placar_casa_real IS NOT NULL
     AND NEW.placar_fora_real IS NOT NULL
  THEN
    -- 1. Atualizar pontos de todas as predictions deste jogo
    UPDATE public.predictions p
    SET
      pontos_ganhos = public.calcular_pontos(
        p.placar_casa_palpite,
        p.placar_fora_palpite,
        NEW.placar_casa_real,
        NEW.placar_fora_real
      ),
      atualizado_em = NOW()
    WHERE p.match_id = NEW.id;

    -- 2. Recalcular ranking completo para usuários afetados
    INSERT INTO public.ranking (
      user_id,
      pontuacao_total,
      total_placar_cheio,
      total_apenas_vencedor,
      atualizado_em
    )
    SELECT
      p_afetado.user_id,
      COALESCE(SUM(p_total.pontos_ganhos), 0),
      COUNT(*) FILTER (WHERE p_total.pontos_ganhos = 25),
      COUNT(*) FILTER (WHERE p_total.pontos_ganhos = 10),
      NOW()
    FROM public.predictions p_afetado
    JOIN public.predictions p_total ON p_total.user_id = p_afetado.user_id
    WHERE p_afetado.match_id = NEW.id
    GROUP BY p_afetado.user_id
    ON CONFLICT (user_id) DO UPDATE SET
      pontuacao_total        = EXCLUDED.pontuacao_total,
      total_placar_cheio     = EXCLUDED.total_placar_cheio,
      total_apenas_vencedor  = EXCLUDED.total_apenas_vencedor,
      atualizado_em          = NOW();

  END IF;

  RETURN NEW;
END;
$$;

-- Trigger disparado após UPDATE na tabela matches
DROP TRIGGER IF EXISTS trigger_jogo_finalizado ON public.matches;
CREATE TRIGGER trigger_jogo_finalizado
  AFTER UPDATE ON public.matches
  FOR EACH ROW
  EXECUTE FUNCTION public.processar_jogo_finalizado();

-- ============================================================
-- FUNÇÃO: criar_usuario_publico
-- Trigger: ao registrar via Supabase Auth, cria entrada pública
-- ============================================================
CREATE OR REPLACE FUNCTION public.criar_usuario_publico()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  INSERT INTO public.users (id, email, nome, avatar_url)
  VALUES (
    NEW.id,
    NEW.email,
    COALESCE(
      NEW.raw_user_meta_data->>'full_name',
      NEW.raw_user_meta_data->>'name',
      SPLIT_PART(NEW.email, '@', 1)
    ),
    NEW.raw_user_meta_data->>'avatar_url'
  )
  ON CONFLICT (id) DO UPDATE SET
    nome       = COALESCE(EXCLUDED.nome, public.users.nome),
    avatar_url = COALESCE(EXCLUDED.avatar_url, public.users.avatar_url);

  -- Cria entrada inicial no ranking
  INSERT INTO public.ranking (user_id, pontuacao_total, total_placar_cheio, total_apenas_vencedor)
  VALUES (NEW.id, 0, 0, 0)
  ON CONFLICT (user_id) DO NOTHING;

  RETURN NEW;
END;
$$;

-- Trigger no schema auth (criação de usuário)
DROP TRIGGER IF EXISTS trigger_novo_usuario ON auth.users;
CREATE TRIGGER trigger_novo_usuario
  AFTER INSERT ON auth.users
  FOR EACH ROW
  EXECUTE FUNCTION public.criar_usuario_publico();

-- ============================================================
-- FUNÇÃO AUXILIAR: atualizar_timestamp
-- Mantém atualizado_em sempre atual
-- ============================================================
CREATE OR REPLACE FUNCTION public.atualizar_timestamp()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
  NEW.atualizado_em = NOW();
  RETURN NEW;
END;
$$;

-- Trigger de timestamp automático para matches
DROP TRIGGER IF EXISTS trigger_matches_timestamp ON public.matches;
CREATE TRIGGER trigger_matches_timestamp
  BEFORE UPDATE ON public.matches
  FOR EACH ROW
  EXECUTE FUNCTION public.atualizar_timestamp();

-- Trigger de timestamp automático para predictions
DROP TRIGGER IF EXISTS trigger_predictions_timestamp ON public.predictions;
CREATE TRIGGER trigger_predictions_timestamp
  BEFORE UPDATE ON public.predictions
  FOR EACH ROW
  EXECUTE FUNCTION public.atualizar_timestamp();
