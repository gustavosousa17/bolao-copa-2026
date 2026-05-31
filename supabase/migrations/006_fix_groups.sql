-- ============================================================
-- BOLÃO COPA 2026 — Corrige grupos da fase de grupos
-- Fonte: sorteio oficial FIFA (05/12/2025, Washington D.C.)
-- Grupos A–L com os 48 times corretos
-- ============================================================

-- Remove apenas os jogos da fase de grupos (mantém eliminatórias)
DELETE FROM public.matches WHERE fase::text LIKE 'Grupo %';

-- ============================================================
-- GRUPO A: México, Coreia do Sul, África do Sul, República Tcheca
-- ============================================================
INSERT INTO public.matches (fase, time_casa, time_fora, data_hora, status) VALUES
('Grupo A', 'México',          'Coreia do Sul',    '2026-06-11 21:00:00-03'::timestamptz, 'Agendado'),
('Grupo A', 'África do Sul',   'República Tcheca', '2026-06-12 15:00:00-03'::timestamptz, 'Agendado'),
('Grupo A', 'México',          'África do Sul',    '2026-06-19 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo A', 'República Tcheca','Coreia do Sul',    '2026-06-19 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo A', 'México',          'República Tcheca', '2026-06-25 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo A', 'Coreia do Sul',   'África do Sul',    '2026-06-25 22:00:00-03'::timestamptz, 'Agendado'),

-- ============================================================
-- GRUPO B: Canadá, Suíça, Qatar, Bósnia-Herzegovina
-- ============================================================
('Grupo B', 'Canadá',           'Bósnia-Herzegovina','2026-06-12 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo B', 'Suíça',            'Qatar',             '2026-06-12 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo B', 'Canadá',           'Suíça',             '2026-06-20 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo B', 'Qatar',            'Bósnia-Herzegovina','2026-06-20 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo B', 'Canadá',           'Qatar',             '2026-06-26 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo B', 'Bósnia-Herzegovina','Suíça',            '2026-06-26 22:00:00-03'::timestamptz, 'Agendado'),

-- ============================================================
-- GRUPO C: Brasil, Marrocos, Escócia, Haiti
-- ============================================================
('Grupo C', 'Brasil',   'Marrocos', '2026-06-13 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo C', 'Escócia',  'Haiti',    '2026-06-13 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo C', 'Brasil',   'Escócia',  '2026-06-21 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo C', 'Haiti',    'Marrocos', '2026-06-21 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo C', 'Brasil',   'Haiti',    '2026-06-27 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo C', 'Marrocos', 'Escócia',  '2026-06-27 22:00:00-03'::timestamptz, 'Agendado'),

-- ============================================================
-- GRUPO D: EUA, Paraguai, Austrália, Turquia
-- ============================================================
('Grupo D', 'EUA',      'Paraguai', '2026-06-14 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo D', 'Austrália','Turquia',  '2026-06-14 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo D', 'EUA',      'Austrália','2026-06-22 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo D', 'Turquia',  'Paraguai', '2026-06-22 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo D', 'EUA',      'Turquia',  '2026-06-28 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo D', 'Paraguai', 'Austrália','2026-06-28 22:00:00-03'::timestamptz, 'Agendado'),

-- ============================================================
-- GRUPO E: Alemanha, Equador, Costa do Marfim, Curaçao
-- ============================================================
('Grupo E', 'Alemanha',       'Equador',        '2026-06-15 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo E', 'Costa do Marfim','Curaçao',        '2026-06-15 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo E', 'Alemanha',       'Costa do Marfim','2026-06-23 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo E', 'Curaçao',        'Equador',        '2026-06-23 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo E', 'Alemanha',       'Curaçao',        '2026-06-29 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo E', 'Equador',        'Costa do Marfim','2026-06-29 22:00:00-03'::timestamptz, 'Agendado'),

-- ============================================================
-- GRUPO F: Holanda, Japão, Tunísia, Suécia
-- ============================================================
('Grupo F', 'Holanda', 'Japão',   '2026-06-16 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo F', 'Tunísia', 'Suécia',  '2026-06-16 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo F', 'Holanda', 'Tunísia', '2026-06-24 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo F', 'Suécia',  'Japão',   '2026-06-24 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo F', 'Holanda', 'Suécia',  '2026-06-30 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo F', 'Japão',   'Tunísia', '2026-06-30 22:00:00-03'::timestamptz, 'Agendado'),

-- ============================================================
-- GRUPO G: Bélgica, Irã, Egito, Nova Zelândia
-- ============================================================
('Grupo G', 'Bélgica',     'Egito',       '2026-06-17 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo G', 'Irã',         'Nova Zelândia','2026-06-17 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo G', 'Bélgica',     'Irã',         '2026-06-25 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo G', 'Nova Zelândia','Egito',       '2026-06-25 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo G', 'Bélgica',     'Nova Zelândia','2026-07-01 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo G', 'Egito',       'Irã',         '2026-07-01 22:00:00-03'::timestamptz, 'Agendado'),

-- ============================================================
-- GRUPO H: Espanha, Uruguai, Arábia Saudita, Cabo Verde
-- ============================================================
('Grupo H', 'Espanha',       'Uruguai',      '2026-06-17 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo H', 'Arábia Saudita','Cabo Verde',   '2026-06-18 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo H', 'Espanha',       'Arábia Saudita','2026-06-25 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo H', 'Cabo Verde',    'Uruguai',      '2026-06-25 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo H', 'Espanha',       'Cabo Verde',   '2026-07-01 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo H', 'Uruguai',       'Arábia Saudita','2026-07-01 22:00:00-03'::timestamptz, 'Agendado'),

-- ============================================================
-- GRUPO I: França, Senegal, Noruega, Iraque
-- ============================================================
('Grupo I', 'França',  'Senegal', '2026-06-18 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo I', 'Noruega', 'Iraque',  '2026-06-18 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo I', 'França',  'Noruega', '2026-06-26 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo I', 'Iraque',  'Senegal', '2026-06-26 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo I', 'França',  'Iraque',  '2026-07-02 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo I', 'Senegal', 'Noruega', '2026-07-02 22:00:00-03'::timestamptz, 'Agendado'),

-- ============================================================
-- GRUPO J: Argentina, Áustria, Argélia, Jordânia
-- ============================================================
('Grupo J', 'Argentina', 'Argélia', '2026-06-18 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo J', 'Áustria',   'Jordânia','2026-06-19 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo J', 'Argentina', 'Áustria', '2026-06-26 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo J', 'Jordânia',  'Argélia', '2026-06-26 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo J', 'Argentina', 'Jordânia','2026-07-02 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo J', 'Argélia',   'Áustria', '2026-07-02 22:00:00-03'::timestamptz, 'Agendado'),

-- ============================================================
-- GRUPO K: Portugal, Colômbia, Uzbequistão, Rep. Dem. Congo
-- ============================================================
('Grupo K', 'Portugal',        'Colômbia',        '2026-06-19 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo K', 'Uzbequistão',     'Rep. Dem. Congo', '2026-06-19 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo K', 'Portugal',        'Uzbequistão',     '2026-06-27 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo K', 'Rep. Dem. Congo', 'Colômbia',        '2026-06-27 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo K', 'Portugal',        'Rep. Dem. Congo', '2026-07-03 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo K', 'Colômbia',        'Uzbequistão',     '2026-07-03 22:00:00-03'::timestamptz, 'Agendado'),

-- ============================================================
-- GRUPO L: Inglaterra, Croácia, Panamá, Gana
-- ============================================================
('Grupo L', 'Inglaterra', 'Panamá',  '2026-06-19 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo L', 'Croácia',    'Gana',    '2026-06-20 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo L', 'Inglaterra', 'Croácia', '2026-06-27 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo L', 'Gana',       'Panamá',  '2026-06-27 18:00:00-03'::timestamptz, 'Agendado'),
('Grupo L', 'Inglaterra', 'Gana',    '2026-07-03 22:00:00-03'::timestamptz, 'Agendado'),
('Grupo L', 'Panamá',     'Croácia', '2026-07-03 22:00:00-03'::timestamptz, 'Agendado');
