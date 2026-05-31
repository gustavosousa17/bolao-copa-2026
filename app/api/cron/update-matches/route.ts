import { NextRequest, NextResponse } from "next/server";
import { fetchLiveFixtures, fetchTodayFixtures, fetchAllFixtures, mapApiStatusToDb } from "@/lib/football-api";
import { createServiceClient } from "@/lib/supabase/server";

export const maxDuration = 60;

export async function GET(request: NextRequest) {
  const authHeader = request.headers.get("authorization");
  if (authHeader !== `Bearer ${process.env.CRON_SECRET}`) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  try {
    const supabase = await createServiceClient();

    // Busca jogos ao vivo, de hoje e todos da Copa (para vincular eliminatórias)
    const [liveFixtures, todayFixtures, allFixtures] = await Promise.all([
      fetchLiveFixtures(),
      fetchTodayFixtures(),
      fetchAllFixtures(),
    ]);

    // Mapa único de todos os fixtures por ID
    const fixtureMap = new Map(allFixtures.map((f) => [f.fixture.id, f]));
    for (const f of [...liveFixtures, ...todayFixtures]) {
      fixtureMap.set(f.fixture.id, f); // prioriza ao vivo/hoje
    }

    // Busca todos os jogos do banco
    const { data: dbMatches } = await supabase
      .from("matches")
      .select("id, api_match_id, data_hora, fase");

    if (!dbMatches) throw new Error("Falha ao buscar partidas do banco");

    // Mapa por api_match_id para lookup rápido
    const byApiId = new Map(
      dbMatches.filter((m) => m.api_match_id).map((m) => [m.api_match_id, m])
    );

    // Jogos sem api_match_id (eliminatórias ou grupo ainda não vinculados)
    const unassigned = dbMatches.filter((m) => !m.api_match_id);

    let updated = 0;

    for (const fixture of fixtureMap.values()) {
      let dbMatch = byApiId.get(fixture.fixture.id);

      // Se não encontrou pelo ID, tenta vincular pelo horário (±1 hora)
      if (!dbMatch && unassigned.length > 0) {
        const fixtureTime = new Date(fixture.fixture.date).getTime();
        const idx = unassigned.findIndex((m) => {
          const dbTime = new Date(m.data_hora).getTime();
          return Math.abs(dbTime - fixtureTime) < 2 * 60 * 60 * 1000;
        });

        if (idx !== -1) {
          dbMatch = unassigned[idx];
          unassigned.splice(idx, 1); // remove para não vincular duas vezes
        }
      }

      if (!dbMatch) continue;

      const isKnockout = !String(dbMatch.fase).startsWith("Grupo");

      const updateData: Record<string, unknown> = {
        api_match_id: fixture.fixture.id,
        status: mapApiStatusToDb(fixture.fixture.status.short),
        bandeira_casa: fixture.teams.home.logo,
        bandeira_fora: fixture.teams.away.logo,
      };

      // Atualiza nomes dos times nas eliminatórias (onde eram genéricos)
      if (isKnockout) {
        updateData.time_casa = fixture.teams.home.name;
        updateData.time_fora = fixture.teams.away.name;
      }

      if (fixture.goals.home !== null && fixture.goals.away !== null) {
        updateData.placar_casa_real = fixture.goals.home;
        updateData.placar_fora_real = fixture.goals.away;
      }

      const { error } = await supabase
        .from("matches")
        .update(updateData)
        .eq("id", dbMatch.id);

      if (!error) updated++;
    }

    return NextResponse.json({
      success: true,
      processed: fixtureMap.size,
      updated,
      timestamp: new Date().toISOString(),
    });
  } catch (error) {
    console.error("[CRON] Erro ao atualizar partidas:", error);
    return NextResponse.json({ error: "Internal server error" }, { status: 500 });
  }
}
