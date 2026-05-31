import { NextRequest, NextResponse } from "next/server";
import { fetchLiveFixtures, fetchTodayFixtures, mapApiStatusToDb } from "@/lib/football-api";
import { createServiceClient } from "@/lib/supabase/server";

export const maxDuration = 60;

export async function GET(request: NextRequest) {
  // Verificação de segurança com CRON_SECRET
  const authHeader = request.headers.get("authorization");
  if (authHeader !== `Bearer ${process.env.CRON_SECRET}`) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  try {
    const supabase = await createServiceClient();

    // Busca jogos ao vivo e de hoje na API
    const [liveFixtures, todayFixtures] = await Promise.all([
      fetchLiveFixtures(),
      fetchTodayFixtures(),
    ]);

    const allFixtures = [...liveFixtures, ...todayFixtures];
    const uniqueFixtures = Array.from(
      new Map(allFixtures.map((f) => [f.fixture.id, f])).values()
    );

    let updated = 0;

    for (const fixture of uniqueFixtures) {
      const status = mapApiStatusToDb(fixture.fixture.status.short);

      const updateData: Record<string, unknown> = { status };

      if (fixture.goals.home !== null && fixture.goals.away !== null) {
        updateData.placar_casa_real = fixture.goals.home;
        updateData.placar_fora_real = fixture.goals.away;
      }

      const { error } = await supabase
        .from("matches")
        .update(updateData)
        .eq("api_match_id", fixture.fixture.id);

      if (!error) updated++;
    }

    return NextResponse.json({
      success: true,
      processed: uniqueFixtures.length,
      updated,
      timestamp: new Date().toISOString(),
    });
  } catch (error) {
    console.error("[CRON] Erro ao atualizar partidas:", error);
    return NextResponse.json({ error: "Internal server error" }, { status: 500 });
  }
}
