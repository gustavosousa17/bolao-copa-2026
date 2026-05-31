/**
 * Wrapper para API-Football (RapidAPI)
 * Copa do Mundo FIFA 2026 — League ID: 1, Season: 2026
 */

const API_BASE = "https://v3.football.api-sports.io";
const LEAGUE_ID = 1;
const SEASON = 2026;

interface ApiFixture {
  fixture: {
    id: number;
    date: string;
    status: { short: string; long: string };
  };
  teams: {
    home: { id: number; name: string; logo: string };
    away: { id: number; name: string; logo: string };
  };
  goals: {
    home: number | null;
    away: number | null;
  };
}

function getHeaders() {
  return {
    "x-apisports-key": process.env.FOOTBALL_API_KEY!,
  };
}

export async function fetchLiveFixtures(): Promise<ApiFixture[]> {
  const res = await fetch(
    `${API_BASE}/fixtures?league=${LEAGUE_ID}&season=${SEASON}&live=all`,
    { headers: getHeaders(), next: { revalidate: 60 } }
  );
  const data = await res.json();
  return data.response ?? [];
}

export async function fetchTodayFixtures(): Promise<ApiFixture[]> {
  const today = new Date().toISOString().split("T")[0];
  const res = await fetch(
    `${API_BASE}/fixtures?league=${LEAGUE_ID}&season=${SEASON}&date=${today}`,
    { headers: getHeaders(), next: { revalidate: 300 } }
  );
  const data = await res.json();
  return data.response ?? [];
}

export async function fetchAllFixtures(): Promise<ApiFixture[]> {
  const res = await fetch(
    `${API_BASE}/fixtures?league=${LEAGUE_ID}&season=${SEASON}`,
    { headers: getHeaders(), next: { revalidate: 3600 } }
  );
  const data = await res.json();
  return data.response ?? [];
}

export function mapApiStatusToDb(
  apiStatus: string
): "Agendado" | "Ao Vivo" | "Finalizado" {
  const liveStatuses = ["1H", "HT", "2H", "ET", "BT", "P", "SUSP", "INT", "LIVE"];
  const finishedStatuses = ["FT", "AET", "PEN"];

  if (liveStatuses.includes(apiStatus)) return "Ao Vivo";
  if (finishedStatuses.includes(apiStatus)) return "Finalizado";
  return "Agendado";
}
