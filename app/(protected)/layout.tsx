import { redirect } from "next/navigation";
import { createServerClient } from "@/lib/supabase/server";
import { signOut } from "@/app/(auth)/login/actions";
import { Trophy, BarChart3, LogOut, User, LayoutGrid } from "lucide-react";
import Link from "next/link";
import Image from "next/image";

export default async function ProtectedLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const supabase = await createServerClient();
  const { data: { user } } = await supabase.auth.getUser();

  if (!user) {
    redirect("/login");
  }

  // Busca dados do perfil
  const { data: profile } = await supabase
    .from("users")
    .select("nome, avatar_url")
    .eq("id", user.id)
    .single();

  const nome = profile?.nome ?? user.email?.split("@")[0] ?? "Usuário";
  const avatarUrl = profile?.avatar_url;

  return (
    <div className="min-h-screen flex flex-col">
      {/* Navbar */}
      <header className="sticky top-0 z-50 bg-slate-900/80 backdrop-blur-md border-b border-slate-800/50">
        <div className="max-w-6xl mx-auto px-4 h-14 flex items-center justify-between gap-4">
          {/* Logo */}
          <Link href="/dashboard" className="flex items-center gap-2 font-bold text-white">
            <div className="w-7 h-7 rounded-lg bg-blue-600 flex items-center justify-center">
              <Trophy className="w-4 h-4 text-white" />
            </div>
            <span className="hidden sm:inline text-sm">Bolão 2026</span>
          </Link>

          {/* Nav links */}
          <nav className="flex items-center gap-1">
            <Link
              href="/dashboard"
              className="flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-sm text-slate-400 hover:text-white hover:bg-slate-800 transition-all"
            >
              <Trophy className="w-4 h-4" />
              <span className="hidden sm:inline">Palpites</span>
            </Link>
            <Link
              href="/classificacao"
              className="flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-sm text-slate-400 hover:text-white hover:bg-slate-800 transition-all"
            >
              <LayoutGrid className="w-4 h-4" />
              <span className="hidden sm:inline">Grupos</span>
            </Link>
            <Link
              href="/ranking"
              className="flex items-center gap-1.5 px-3 py-1.5 rounded-lg text-sm text-slate-400 hover:text-white hover:bg-slate-800 transition-all"
            >
              <BarChart3 className="w-4 h-4" />
              <span className="hidden sm:inline">Ranking</span>
            </Link>
          </nav>

          {/* User menu */}
          <div className="flex items-center gap-2">
            <div className="flex items-center gap-2">
              {avatarUrl ? (
                <Image
                  src={avatarUrl}
                  alt={nome}
                  width={28}
                  height={28}
                  className="rounded-full"
                />
              ) : (
                <div className="w-7 h-7 rounded-full bg-blue-600 flex items-center justify-center">
                  <User className="w-4 h-4 text-white" />
                </div>
              )}
              <span className="hidden sm:inline text-sm text-slate-300 max-w-[120px] truncate">
                {nome}
              </span>
            </div>

            <form action={signOut}>
              <button
                type="submit"
                className="p-1.5 rounded-lg text-slate-400 hover:text-red-400 hover:bg-red-400/10 transition-all"
                title="Sair"
              >
                <LogOut className="w-4 h-4" />
              </button>
            </form>
          </div>
        </div>
      </header>

      {/* Conteúdo */}
      <main className="flex-1 max-w-6xl w-full mx-auto px-4 py-6">
        {children}
      </main>

      {/* Footer */}
      <footer className="border-t border-slate-800/50 py-4">
        <p className="text-center text-xs text-slate-600">
          Copa do Mundo FIFA 2026 · EUA, Canadá e México
        </p>
      </footer>
    </div>
  );
}
