-- ============================================================
-- BOLÃO COPA 2026 — Seed: 104 Jogos da Copa do Mundo 2026
-- Copa realizada em: EUA, Canadá e México (Junho/Julho 2026)
-- Formato: 48 seleções, 104 jogos totais
-- Execute APÓS 003_functions.sql
-- ============================================================

-- Jogos da Fase de Grupos (72 jogos — 48 equipes, 12 grupos de 4)
-- Datas aproximadas baseadas no calendário oficial FIFA 2026
-- Os horários estão em UTC-3 (horário de Brasília)

INSERT INTO public.matches (fase, time_casa, time_fora, data_hora, status) VALUES

-- ============================================================
-- GRUPO A
-- ============================================================
('Grupo A', 'México', 'Uruguai',         '2026-06-11 21:00:00-03'::timestamptz, 'Agendado'),
('Grupo A', 'EUA',    'Panamá',          '2026-06-12 15:00:00-03'::timestamptz, 'Agendado'),
('Grupo A', 'México', 'EUA',             '2026-06-19 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo A', 'Panamá', 'Uruguai',         '2026-06-19 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo A', 'EUA',    'Uruguai',         '2026-06-25 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo A', 'Panamá', 'México',          '2026-06-25 22:00:00-03'::timestamptz, 'Agendado'),

-- ============================================================
-- GRUPO B
-- ============================================================
('Grupo B', 'Argentina', 'Sérvia',       '2026-06-12 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo B', 'Chile',     'Austrália',    '2026-06-12 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo B', 'Argentina', 'Chile',        '2026-06-20 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo B', 'Austrália', 'Sérvia',       '2026-06-20 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo B', 'Argentina', 'Austrália',    '2026-06-26 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo B', 'Sérvia',    'Chile',        '2026-06-26 22:00:00-03'::timestamptz, 'Agendado'),

-- ============================================================
-- GRUPO C
-- ============================================================
('Grupo C', 'Brasil',   'Croácia',       '2026-06-13 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo C', 'Japão',    'Alemanha',      '2026-06-13 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo C', 'Brasil',   'Japão',         '2026-06-21 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo C', 'Alemanha', 'Croácia',       '2026-06-21 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo C', 'Brasil',   'Alemanha',      '2026-06-27 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo C', 'Croácia',  'Japão',         '2026-06-27 22:00:00-03'::timestamptz, 'Agendado'),

-- ============================================================
-- GRUPO D
-- ============================================================
('Grupo D', 'França',   'Senegal',       '2026-06-14 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo D', 'Dinamarca','Polônia',        '2026-06-14 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo D', 'França',   'Dinamarca',     '2026-06-22 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo D', 'Polônia',  'Senegal',       '2026-06-22 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo D', 'França',   'Polônia',       '2026-06-28 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo D', 'Senegal',  'Dinamarca',     '2026-06-28 22:00:00-03'::timestamptz, 'Agendado'),

-- ============================================================
-- GRUPO E
-- ============================================================
('Grupo E', 'Espanha',  'Egito',         '2026-06-15 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo E', 'Portugal', 'Iraque',        '2026-06-15 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo E', 'Espanha',  'Portugal',      '2026-06-23 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo E', 'Iraque',   'Egito',         '2026-06-23 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo E', 'Espanha',  'Iraque',        '2026-06-29 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo E', 'Egito',    'Portugal',      '2026-06-29 22:00:00-03'::timestamptz, 'Agendado'),

-- ============================================================
-- GRUPO F
-- ============================================================
('Grupo F', 'Inglaterra','Nicarágua',    '2026-06-16 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo F', 'Holanda',   'Argélia',      '2026-06-16 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo F', 'Inglaterra','Holanda',      '2026-06-24 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo F', 'Argélia',   'Nicarágua',    '2026-06-24 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo F', 'Inglaterra','Argélia',      '2026-06-30 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo F', 'Nicarágua', 'Holanda',      '2026-06-30 22:00:00-03'::timestamptz, 'Agendado'),

-- ============================================================
-- GRUPO G
-- ============================================================
('Grupo G', 'Colômbia', 'Costa Rica',    '2026-06-17 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo G', 'Bélgica',  'Israel',        '2026-06-17 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo G', 'Colômbia', 'Bélgica',       '2026-06-25 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo G', 'Israel',   'Costa Rica',    '2026-06-25 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo G', 'Colômbia', 'Israel',        '2026-07-01 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo G', 'Costa Rica','Bélgica',      '2026-07-01 22:00:00-03'::timestamptz, 'Agendado'),

-- ============================================================
-- GRUPO H
-- ============================================================
('Grupo H', 'Uruguai',  'África do Sul', '2026-06-17 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo H', 'Equador',  'Suíça',         '2026-06-17 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo H', 'Uruguai',  'Equador',       '2026-06-25 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo H', 'Suíça',    'África do Sul', '2026-06-25 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo H', 'Uruguai',  'Suíça',         '2026-07-01 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo H', 'África do Sul','Equador',   '2026-07-01 22:00:00-03'::timestamptz, 'Agendado'),

-- ============================================================
-- GRUPO I
-- ============================================================
('Grupo I', 'Itália',   'Nova Zelândia', '2026-06-18 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo I', 'Coreia do Sul','Gana',      '2026-06-18 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo I', 'Itália',   'Coreia do Sul', '2026-06-26 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo I', 'Gana',     'Nova Zelândia', '2026-06-26 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo I', 'Itália',   'Gana',          '2026-07-02 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo I', 'Nova Zelândia','Coreia do Sul','2026-07-02 22:00:00-03'::timestamptz,'Agendado'),

-- ============================================================
-- GRUPO J
-- ============================================================
('Grupo J', 'Alemanha', 'Arábia Saudita','2026-06-18 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo J', 'Portugal', 'Indonésia',     '2026-06-18 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo J', 'Alemanha', 'Portugal',      '2026-06-26 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo J', 'Indonésia','Arábia Saudita','2026-06-26 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo J', 'Alemanha', 'Indonésia',     '2026-07-02 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo J', 'Arábia Saudita','Portugal', '2026-07-02 22:00:00-03'::timestamptz, 'Agendado'),

-- ============================================================
-- GRUPO K
-- ============================================================
('Grupo K', 'Holanda',  'Peru',          '2026-06-19 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo K', 'Nigéria',  'Marrocos',      '2026-06-19 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo K', 'Holanda',  'Nigéria',       '2026-06-27 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo K', 'Marrocos', 'Peru',          '2026-06-27 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo K', 'Holanda',  'Marrocos',      '2026-07-03 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo K', 'Peru',     'Nigéria',       '2026-07-03 22:00:00-03'::timestamptz, 'Agendado'),

-- ============================================================
-- GRUPO L
-- ============================================================
('Grupo L', 'Camarões', 'Canadá',        '2026-06-19 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo L', 'Turquia',  'Bolívia',       '2026-06-19 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo L', 'Camarões', 'Turquia',       '2026-06-27 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo L', 'Bolívia',  'Canadá',        '2026-06-27 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo L', 'Camarões', 'Bolívia',       '2026-07-03 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo L', 'Canadá',   'Turquia',       '2026-07-03 22:00:00-03'::timestamptz, 'Agendado'),

-- ============================================================
-- FASE ELIMINATÓRIA — 32-avos de Final (32 jogos)
-- Times representados como "1A vs 2B" (definidos após grupos)
-- ============================================================
('32-avos', '1º Grupo A', '2º Grupo B',  '2026-07-07 22:00:00-03'::timestamptz, 'Agendado'),
('32-avos', '1º Grupo C', '2º Grupo D',  '2026-07-07 18:00:00-03'::timestamptz, 'Agendado'),
('32-avos', '1º Grupo E', '2º Grupo F',  '2026-07-08 22:00:00-03'::timestamptz, 'Agendado'),
('32-avos', '1º Grupo G', '2º Grupo H',  '2026-07-08 18:00:00-03'::timestamptz, 'Agendado'),
('32-avos', '1º Grupo I', '2º Grupo J',  '2026-07-09 22:00:00-03'::timestamptz, 'Agendado'),
('32-avos', '1º Grupo K', '2º Grupo L',  '2026-07-09 18:00:00-03'::timestamptz, 'Agendado'),
('32-avos', '1º Grupo B', '2º Grupo A',  '2026-07-10 22:00:00-03'::timestamptz, 'Agendado'),
('32-avos', '1º Grupo D', '2º Grupo C',  '2026-07-10 18:00:00-03'::timestamptz, 'Agendado'),
('32-avos', '1º Grupo F', '2º Grupo E',  '2026-07-11 22:00:00-03'::timestamptz, 'Agendado'),
('32-avos', '1º Grupo H', '2º Grupo G',  '2026-07-11 18:00:00-03'::timestamptz, 'Agendado'),
('32-avos', '1º Grupo J', '2º Grupo I',  '2026-07-12 22:00:00-03'::timestamptz, 'Agendado'),
('32-avos', '1º Grupo L', '2º Grupo K',  '2026-07-12 18:00:00-03'::timestamptz, 'Agendado'),
('32-avos', '3º Melhor 1','3º Melhor 2', '2026-07-13 22:00:00-03'::timestamptz, 'Agendado'),
('32-avos', '3º Melhor 3','3º Melhor 4', '2026-07-13 18:00:00-03'::timestamptz, 'Agendado'),
('32-avos', '3º Melhor 5','3º Melhor 6', '2026-07-14 22:00:00-03'::timestamptz, 'Agendado'),
('32-avos', '3º Melhor 7','3º Melhor 8', '2026-07-14 18:00:00-03'::timestamptz, 'Agendado'),

-- ============================================================
-- OITAVAS DE FINAL (8 jogos)
-- ============================================================
('Oitavas', 'Vencedor R1',  'Vencedor R2',  '2026-07-18 22:00:00-03'::timestamptz, 'Agendado'),
('Oitavas', 'Vencedor R3',  'Vencedor R4',  '2026-07-18 18:00:00-03'::timestamptz, 'Agendado'),
('Oitavas', 'Vencedor R5',  'Vencedor R6',  '2026-07-19 22:00:00-03'::timestamptz, 'Agendado'),
('Oitavas', 'Vencedor R7',  'Vencedor R8',  '2026-07-19 18:00:00-03'::timestamptz, 'Agendado'),
('Oitavas', 'Vencedor R9',  'Vencedor R10', '2026-07-20 22:00:00-03'::timestamptz, 'Agendado'),
('Oitavas', 'Vencedor R11', 'Vencedor R12', '2026-07-20 18:00:00-03'::timestamptz, 'Agendado'),
('Oitavas', 'Vencedor R13', 'Vencedor R14', '2026-07-21 22:00:00-03'::timestamptz, 'Agendado'),
('Oitavas', 'Vencedor R15', 'Vencedor R16', '2026-07-21 18:00:00-03'::timestamptz, 'Agendado'),

-- ============================================================
-- QUARTAS DE FINAL (4 jogos)
-- ============================================================
('Quartas', 'Vencedor Oitavas 1', 'Vencedor Oitavas 2', '2026-07-25 22:00:00-03'::timestamptz, 'Agendado'),
('Quartas', 'Vencedor Oitavas 3', 'Vencedor Oitavas 4', '2026-07-25 18:00:00-03'::timestamptz, 'Agendado'),
('Quartas', 'Vencedor Oitavas 5', 'Vencedor Oitavas 6', '2026-07-26 22:00:00-03'::timestamptz, 'Agendado'),
('Quartas', 'Vencedor Oitavas 7', 'Vencedor Oitavas 8', '2026-07-26 18:00:00-03'::timestamptz, 'Agendado'),

-- ============================================================
-- SEMIFINAIS (2 jogos)
-- ============================================================
('Semifinal', 'Vencedor Quartas 1', 'Vencedor Quartas 2', '2026-07-29 22:00:00-03'::timestamptz, 'Agendado'),
('Semifinal', 'Vencedor Quartas 3', 'Vencedor Quartas 4', '2026-07-30 22:00:00-03'::timestamptz, 'Agendado'),

-- ============================================================
-- TERCEIRO LUGAR (1 jogo)
-- ============================================================
('Terceiro Lugar', 'Perdedor SF 1', 'Perdedor SF 2', '2026-08-01 17:00:00-03'::timestamptz, 'Agendado'),

-- ============================================================
-- FINAL (1 jogo) — MetLife Stadium, Nova Jersey, EUA
-- ============================================================
('Final', 'Vencedor SF 1', 'Vencedor SF 2', '2026-08-02 17:00:00-03'::timestamptz, 'Agendado');

-- Verificação: deve retornar 104 linhas
SELECT COUNT(*), fase
FROM public.matches
GROUP BY fase
ORDER BY MIN(data_hora);
