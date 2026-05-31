"use server";

import { revalidatePath } from "next/cache";
import { createServerClient } from "@/lib/supabase/server";

export async function salvarPalpite(matchId: string, placarcasa: number, placarFora: number) {
  const supabase = await createServerClient();
  const { data: { user } } = await supabase.auth.getUser();

  if (!user) return { error: "Não autenticado" };

  if (placarcasa < 0 || placarFora < 0 || !Number.isInteger(placarcasa) || !Number.isInteger(placarFora)) {
    return { error: "Placar inválido" };
  }

  const { error } = await supabase
    .from("predictions")
    .upsert(
      {
        user_id: user.id,
        match_id: matchId,
        placar_casa_palpite: placarcasa,
        placar_fora_palpite: placarFora,
      },
      { onConflict: "user_id,match_id" }
    );

  if (error) return { error: error.message };

  revalidatePath("/dashboard");
  return { success: true };
}
