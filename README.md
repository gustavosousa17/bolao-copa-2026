# Bolão Copa do Mundo FIFA 2026 ⚽🏆

Sistema de palpites para a Copa do Mundo FIFA 2026 (EUA, Canadá e México).

## Stack

- **Frontend:** Next.js 15 (App Router), React 19, TypeScript, Tailwind CSS
- **UI:** Shadcn/ui, Lucide React
- **Backend/DB/Auth:** Supabase (PostgreSQL + Auth + Realtime)
- **API de Futebol:** API-Football (RapidAPI)
- **Deploy:** Vercel

---

## Passo 1: Instalar Node.js

Baixe e instale o Node.js LTS em: https://nodejs.org

Verifique a instalação:
```bash
node --version  # >= 18
npm --version
```

---

## Passo 2: Configurar Supabase

1. Acesse [supabase.com](https://supabase.com) e crie uma conta
2. Crie um novo projeto
3. Vá em **Settings → API** e copie:
   - `Project URL`
   - `anon public` key
   - `service_role` key (mantenha secreta!)
4. Vá em **Authentication → Providers → Google** e habilite:
   - Crie um projeto no Google Cloud Console
   - Copie `Client ID` e `Client Secret` para o Supabase
5. Execute as migrations SQL no **SQL Editor** do Supabase:
   - `supabase/migrations/001_schema.sql`
   - `supabase/migrations/002_rls.sql`
   - `supabase/migrations/003_functions.sql`
   - `supabase/migrations/004_seed_matches.sql`

---

## Passo 3: Configurar Variáveis de Ambiente

Edite o arquivo `.env.local` com suas chaves:

```env
NEXT_PUBLIC_SUPABASE_URL=https://SEU_PROJETO.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJ...
SUPABASE_SERVICE_ROLE_KEY=eyJ...
NEXT_PUBLIC_APP_URL=http://localhost:3000
FOOTBALL_API_KEY=SEU_RAPID_API_KEY
CRON_SECRET=gere-uma-chave-secreta
```

---

## Passo 4: Instalar Dependências e Rodar

```bash
# Na pasta do projeto:
cd "Projetos Claude/bolao-copa-2026"

# Instalar dependências
npm install

# Rodar em desenvolvimento
npm run dev
```

Acesse: http://localhost:3000

---

## Funcionalidades Implementadas

- ✅ Schema completo do banco de dados (4 tabelas + tipos)
- ✅ Row Level Security (RLS) com regra de trava 5 min antes do jogo
- ✅ Motor de pontuação via trigger PostgreSQL (25/18/10/0 pts)
- ✅ Trigger automático de criação de usuário público
- ✅ Seed com os 104 jogos da Copa 2026
- ✅ Autenticação: Email/Senha + Google OAuth
- ✅ Proteção de rotas via middleware Next.js
- ✅ Layout responsivo com navbar
- ✅ Página de Ranking com tabela de posições
- ✅ Wrapper para API-Football (RapidAPI)
- ✅ Rota de Cron para atualização automática de resultados

## Próximos Passos

- [ ] Dashboard de palpites com os 104 jogos agrupados
- [ ] Componente MatchCard com inputs e trava visual (🔒)
- [ ] Salvamento automático de palpites (debounce)
- [ ] Realtime do Supabase no ranking
- [ ] Bandeiras dos países
- [ ] Deploy na Vercel com Cron Jobs configurado

---

## Sistema de Pontuação

| Pontos | Critério |
|--------|----------|
| **25** | Placar exato (ex: 2x1 = 2x1) |
| **18** | Acertou vencedor e diferença de gols (ex: 3x1 = 2x0) |
| **10** | Acertou apenas o vencedor ou empate |
| **0** | Errou tudo |

**Desempate:** Total de placares exatos (25 pts)
