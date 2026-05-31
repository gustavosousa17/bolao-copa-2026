import type { Metadata } from "next";
import { Inter } from "next/font/google";
import "./globals.css";
import { Toaster } from "@/components/ui/toaster";

const inter = Inter({ subsets: ["latin"] });

export const metadata: Metadata = {
  title: "Bolão Copa 2026 | FIFA World Cup",
  description: "Faça seus palpites para a Copa do Mundo FIFA 2026 e dispute com amigos!",
  manifest: "/manifest.json",
  themeColor: "#1d4ed8",
  viewport: "width=device-width, initial-scale=1, maximum-scale=1",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="pt-BR" suppressHydrationWarning>
      <body className={`${inter.className} min-h-screen bg-gradient-to-br from-slate-900 via-blue-950 to-slate-900`}>
        {children}
        <Toaster />
      </body>
    </html>
  );
}
