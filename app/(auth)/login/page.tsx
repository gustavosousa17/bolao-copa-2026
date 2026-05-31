import { Suspense } from "react";
import LoginClient from "./LoginClient";

export const metadata = {
  title: "Entrar | Bolão Copa 2026",
};

export default function LoginPage() {
  return (
    <Suspense fallback={<div className="min-h-screen flex items-center justify-center"><div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-400" /></div>}>
      <LoginClient />
    </Suspense>
  );
}
