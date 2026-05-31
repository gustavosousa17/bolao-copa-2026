-- ============================================================
-- Migration 007: Tabela completa e correta Copa 2026
-- Fonte: FIFA oficial — horários em Brasília (UTC-3)
-- ============================================================

TRUNCATE public.predictions CASCADE;
TRUNCATE public.ranking CASCADE;
TRUNCATE public.matches CASCADE;

-- ============================================================
-- FASE DE GRUPOS — 72 jogos
-- ============================================================
INSERT INTO public.matches (fase, time_casa, time_fora, data_hora, status) VALUES

-- GRUPO A: México, Coreia do Sul, África do Sul, República Tcheca
('Grupo A', 'México',          'África do Sul',    '2026-06-11 16:00:00-03'::timestamptz, 'Agendado'),
('Grupo A', 'Coreia do Sul',   'República Tcheca', '2026-06-11 23:00:00-03'::timestamptz, 'Agendado'),
('Grupo A', 'República Tcheca','África do Sul',     '2026-06-18 13:00:00-03'::timestamptz, 'Agendado'),
('Grupo A', 'México',          'Coreia do Sul',     '2026-06-18 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo A', 'República Tcheca','México',            '2026-06-24 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo A', 'África do Sul',   'Coreia do Sul',     '2026-06-24 22:00:00-03'::timestamptz, 'Agendado'),

-- GRUPO B: Canadá, Qatar, Suíça, Bósnia-Herzegovina
('Grupo B', 'Canadá',            'Bósnia-Herzegovina', '2026-06-12 16:00:00-03'::timestamptz, 'Agendado'),
('Grupo B', 'Qatar',             'Suíça',              '2026-06-13 16:00:00-03'::timestamptz, 'Agendado'),
('Grupo B', 'Suíça',             'Bósnia-Herzegovina', '2026-06-18 16:00:00-03'::timestamptz, 'Agendado'),
('Grupo B', 'Canadá',            'Qatar',              '2026-06-18 19:00:00-03'::timestamptz, 'Agendado'),
('Grupo B', 'Suíça',             'Canadá',             '2026-06-24 16:00:00-03'::timestamptz, 'Agendado'),
('Grupo B', 'Bósnia-Herzegovina','Qatar',              '2026-06-24 16:00:00-03'::timestamptz, 'Agendado'),

-- GRUPO C: Brasil, Marrocos, Escócia, Haiti
('Grupo C', 'Brasil',   'Marrocos', '2026-06-13 19:00:00-03'::timestamptz, 'Agendado'),
('Grupo C', 'Haiti',    'Escócia',  '2026-06-13 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo C', 'Escócia',  'Marrocos', '2026-06-19 19:00:00-03'::timestamptz, 'Agendado'),
('Grupo C', 'Brasil',   'Haiti',    '2026-06-19 21:30:00-03'::timestamptz, 'Agendado'),
('Grupo C', 'Escócia',  'Brasil',   '2026-06-24 19:00:00-03'::timestamptz, 'Agendado'),
('Grupo C', 'Marrocos', 'Haiti',    '2026-06-24 19:00:00-03'::timestamptz, 'Agendado'),

-- GRUPO D: EUA, Paraguai, Austrália, Turquia
('Grupo D', 'EUA',      'Paraguai',  '2026-06-12 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo D', 'Austrália','Turquia',   '2026-06-14 01:00:00-03'::timestamptz, 'Agendado'),
('Grupo D', 'Turquia',  'Paraguai',  '2026-06-19 00:00:00-03'::timestamptz, 'Agendado'),
('Grupo D', 'EUA',      'Austrália', '2026-06-19 16:00:00-03'::timestamptz, 'Agendado'),
('Grupo D', 'Turquia',  'EUA',       '2026-06-25 23:00:00-03'::timestamptz, 'Agendado'),
('Grupo D', 'Paraguai', 'Austrália', '2026-06-25 23:00:00-03'::timestamptz, 'Agendado'),

-- GRUPO E: Alemanha, Equador, Costa do Marfim, Curaçao
('Grupo E', 'Alemanha',       'Curaçao',         '2026-06-14 14:00:00-03'::timestamptz, 'Agendado'),
('Grupo E', 'Costa do Marfim','Equador',          '2026-06-14 20:00:00-03'::timestamptz, 'Agendado'),
('Grupo E', 'Alemanha',       'Costa do Marfim', '2026-06-20 17:00:00-03'::timestamptz, 'Agendado'),
('Grupo E', 'Equador',        'Curaçao',         '2026-06-20 21:00:00-03'::timestamptz, 'Agendado'),
('Grupo E', 'Equador',        'Alemanha',        '2026-06-25 17:00:00-03'::timestamptz, 'Agendado'),
('Grupo E', 'Curaçao',        'Costa do Marfim', '2026-06-25 17:00:00-03'::timestamptz, 'Agendado'),

-- GRUPO F: Holanda, Japão, Tunísia, Suécia
('Grupo F', 'Holanda', 'Japão',   '2026-06-14 17:00:00-03'::timestamptz, 'Agendado'),
('Grupo F', 'Suécia',  'Tunísia', '2026-06-14 23:00:00-03'::timestamptz, 'Agendado'),
('Grupo F', 'Holanda', 'Suécia',  '2026-06-20 14:00:00-03'::timestamptz, 'Agendado'),
('Grupo F', 'Tunísia', 'Japão',   '2026-06-20 23:00:00-03'::timestamptz, 'Agendado'),
('Grupo F', 'Japão',   'Suécia',  '2026-06-25 20:00:00-03'::timestamptz, 'Agendado'),
('Grupo F', 'Tunísia', 'Holanda', '2026-06-25 20:00:00-03'::timestamptz, 'Agendado'),

-- GRUPO G: Bélgica, Irã, Egito, Nova Zelândia
('Grupo G', 'Bélgica',      'Egito',         '2026-06-15 16:00:00-03'::timestamptz, 'Agendado'),
('Grupo G', 'Irã',          'Nova Zelândia', '2026-06-15 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo G', 'Bélgica',      'Irã',           '2026-06-21 16:00:00-03'::timestamptz, 'Agendado'),
('Grupo G', 'Nova Zelândia','Egito',          '2026-06-21 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo G', 'Egito',        'Irã',           '2026-06-27 00:00:00-03'::timestamptz, 'Agendado'),
('Grupo G', 'Nova Zelândia','Bélgica',        '2026-06-27 00:00:00-03'::timestamptz, 'Agendado'),

-- GRUPO H: Espanha, Uruguai, Arábia Saudita, Cabo Verde
('Grupo H', 'Espanha',       'Cabo Verde',    '2026-06-15 13:00:00-03'::timestamptz, 'Agendado'),
('Grupo H', 'Arábia Saudita','Uruguai',        '2026-06-15 19:00:00-03'::timestamptz, 'Agendado'),
('Grupo H', 'Espanha',       'Arábia Saudita','2026-06-21 13:00:00-03'::timestamptz, 'Agendado'),
('Grupo H', 'Uruguai',       'Cabo Verde',    '2026-06-21 19:00:00-03'::timestamptz, 'Agendado'),
('Grupo H', 'Cabo Verde',    'Arábia Saudita','2026-06-26 21:00:00-03'::timestamptz, 'Agendado'),
('Grupo H', 'Uruguai',       'Espanha',       '2026-06-26 21:00:00-03'::timestamptz, 'Agendado'),

-- GRUPO I: França, Senegal, Noruega, Iraque
('Grupo I', 'França',  'Senegal', '2026-06-16 16:00:00-03'::timestamptz, 'Agendado'),
('Grupo I', 'Iraque',  'Noruega', '2026-06-16 19:00:00-03'::timestamptz, 'Agendado'),
('Grupo I', 'França',  'Iraque',  '2026-06-22 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo I', 'Noruega', 'Senegal', '2026-06-22 21:00:00-03'::timestamptz, 'Agendado'),
('Grupo I', 'Noruega', 'França',  '2026-06-26 16:00:00-03'::timestamptz, 'Agendado'),
('Grupo I', 'Senegal', 'Iraque',  '2026-06-26 16:00:00-03'::timestamptz, 'Agendado'),

-- GRUPO J: Argentina, Áustria, Argélia, Jordânia
('Grupo J', 'Argentina', 'Argélia',   '2026-06-16 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo J', 'Áustria',   'Jordânia',  '2026-06-17 01:00:00-03'::timestamptz, 'Agendado'),
('Grupo J', 'Argentina', 'Áustria',   '2026-06-22 14:00:00-03'::timestamptz, 'Agendado'),
('Grupo J', 'Jordânia',  'Argélia',   '2026-06-23 00:00:00-03'::timestamptz, 'Agendado'),
('Grupo J', 'Argélia',   'Áustria',   '2026-06-27 23:00:00-03'::timestamptz, 'Agendado'),
('Grupo J', 'Jordânia',  'Argentina', '2026-06-28 23:00:00-03'::timestamptz, 'Agendado'),

-- GRUPO K: Portugal, Colômbia, Uzbequistão, Rep. Dem. Congo
('Grupo K', 'Portugal',       'Rep. Dem. Congo', '2026-06-17 14:00:00-03'::timestamptz, 'Agendado'),
('Grupo K', 'Uzbequistão',    'Colômbia',        '2026-06-17 21:00:00-03'::timestamptz, 'Agendado'),
('Grupo K', 'Portugal',       'Uzbequistão',     '2026-06-23 14:00:00-03'::timestamptz, 'Agendado'),
('Grupo K', 'Colômbia',       'Rep. Dem. Congo', '2026-06-23 23:00:00-03'::timestamptz, 'Agendado'),
('Grupo K', 'Colômbia',       'Portugal',        '2026-06-27 20:30:00-03'::timestamptz, 'Agendado'),
('Grupo K', 'Rep. Dem. Congo','Uzbequistão',     '2026-06-27 20:30:00-03'::timestamptz, 'Agendado'),

-- GRUPO L: Inglaterra, Croácia, Panamá, Gana
('Grupo L', 'Inglaterra', 'Croácia',    '2026-06-17 17:00:00-03'::timestamptz, 'Agendado'),
('Grupo L', 'Gana',       'Panamá',     '2026-06-17 20:00:00-03'::timestamptz, 'Agendado'),
('Grupo L', 'Inglaterra', 'Gana',       '2026-06-23 17:00:00-03'::timestamptz, 'Agendado'),
('Grupo L', 'Panamá',     'Croácia',    '2026-06-23 20:00:00-03'::timestamptz, 'Agendado'),
('Grupo L', 'Panamá',     'Inglaterra', '2026-06-27 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo L', 'Croácia',    'Gana',       '2026-06-27 18:00:00-03'::timestamptz, 'Agendado'),

-- ============================================================
-- 32-AVOS DE FINAL — 16 jogos (28/06 a 03/07)
-- ============================================================
('32-avos', '2º Grupo A',  '2º Grupo B',  '2026-06-28 16:00:00-03'::timestamptz, 'Agendado'),
('32-avos', '1º Grupo C',  '2º Grupo F',  '2026-06-29 14:00:00-03'::timestamptz, 'Agendado'),
('32-avos', '1º Grupo E',  '3º A/B/C/D/F','2026-06-29 17:30:00-03'::timestamptz, 'Agendado'),
('32-avos', '1º Grupo F',  '2º Grupo C',  '2026-06-29 22:00:00-03'::timestamptz, 'Agendado'),
('32-avos', '2º Grupo E',  '2º Grupo I',  '2026-06-30 14:00:00-03'::timestamptz, 'Agendado'),
('32-avos', '1º Grupo I',  '3º C/D/F/G/H','2026-06-30 18:00:00-03'::timestamptz, 'Agendado'),
('32-avos', '1º Grupo A',  '3º C/E/F/H/I','2026-06-30 22:00:00-03'::timestamptz, 'Agendado'),
('32-avos', '1º Grupo L',  '3º E/H/I/J/K','2026-07-01 13:00:00-03'::timestamptz, 'Agendado'),
('32-avos', '1º Grupo G',  '3º A/E/H/I/J','2026-07-01 17:00:00-03'::timestamptz, 'Agendado'),
('32-avos', '1º Grupo D',  '3º B/E/F/I/J','2026-07-01 21:00:00-03'::timestamptz, 'Agendado'),
('32-avos', '1º Grupo H',  '2º Grupo J',  '2026-07-02 16:00:00-03'::timestamptz, 'Agendado'),
('32-avos', '2º Grupo K',  '2º Grupo L',  '2026-07-02 20:00:00-03'::timestamptz, 'Agendado'),
('32-avos', '1º Grupo B',  '3º E/F/G/I/J','2026-07-03 00:00:00-03'::timestamptz, 'Agendado'),
('32-avos', '2º Grupo D',  '2º Grupo G',  '2026-07-03 15:00:00-03'::timestamptz, 'Agendado'),
('32-avos', '1º Grupo J',  '2º Grupo H',  '2026-07-03 19:00:00-03'::timestamptz, 'Agendado'),
('32-avos', '1º Grupo K',  '3º D/E/I/J/L','2026-07-03 22:30:00-03'::timestamptz, 'Agendado'),

-- ============================================================
-- OITAVAS DE FINAL — 8 jogos (04/07 a 07/07)
-- ============================================================
('Oitavas', 'Venc. SF3',  'Venc. SF4',  '2026-07-04 14:00:00-03'::timestamptz, 'Agendado'),
('Oitavas', 'Venc. SF1',  'Venc. SF2',  '2026-07-04 18:00:00-03'::timestamptz, 'Agendado'),
('Oitavas', 'Venc. SF9',  'Venc. SF10', '2026-07-05 17:00:00-03'::timestamptz, 'Agendado'),
('Oitavas', 'Venc. SF11', 'Venc. SF12', '2026-07-05 21:00:00-03'::timestamptz, 'Agendado'),
('Oitavas', 'Venc. SF5',  'Venc. SF6',  '2026-07-06 16:00:00-03'::timestamptz, 'Agendado'),
('Oitavas', 'Venc. SF7',  'Venc. SF8',  '2026-07-06 21:00:00-03'::timestamptz, 'Agendado'),
('Oitavas', 'Venc. SF13', 'Venc. SF14', '2026-07-07 13:00:00-03'::timestamptz, 'Agendado'),
('Oitavas', 'Venc. SF15', 'Venc. SF16', '2026-07-07 17:00:00-03'::timestamptz, 'Agendado'),

-- ============================================================
-- QUARTAS DE FINAL — 4 jogos (09/07, 10/07, 11/07)
-- ============================================================
('Quartas', 'Venc. O1', 'Venc. O2', '2026-07-09 17:00:00-03'::timestamptz, 'Agendado'),
('Quartas', 'Venc. O3', 'Venc. O4', '2026-07-10 16:00:00-03'::timestamptz, 'Agendado'),
('Quartas', 'Venc. O5', 'Venc. O6', '2026-07-11 18:00:00-03'::timestamptz, 'Agendado'),
('Quartas', 'Venc. O7', 'Venc. O8', '2026-07-11 22:00:00-03'::timestamptz, 'Agendado'),

-- ============================================================
-- SEMIFINAIS — 2 jogos (14/07 e 15/07)
-- ============================================================
('Semifinal', 'Venc. Q1', 'Venc. Q2', '2026-07-14 16:00:00-03'::timestamptz, 'Agendado'),
('Semifinal', 'Venc. Q3', 'Venc. Q4', '2026-07-15 16:00:00-03'::timestamptz, 'Agendado'),

-- ============================================================
-- TERCEIRO LUGAR — 1 jogo (18/07)
-- ============================================================
('Terceiro Lugar', 'Perdedor SF1', 'Perdedor SF2', '2026-07-18 18:00:00-03'::timestamptz, 'Agendado'),

-- ============================================================
-- FINAL — 1 jogo (19/07) — MetLife Stadium, Nova Jersey
-- ============================================================
('Final', 'Vencedor SF1', 'Vencedor SF2', '2026-07-19 16:00:00-03'::timestamptz, 'Agendado');

-- Verificação: deve retornar 104 linhas
SELECT COUNT(*) as total, fase::text
FROM public.matches
GROUP BY fase::text
ORDER BY MIN(data_hora);
