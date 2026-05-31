import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  typescript: {
    ignoreBuildErrors: true,
  },
  images: {
    remotePatterns: [
      { hostname: "lh3.googleusercontent.com" },
      { hostname: "avatars.githubusercontent.com" },
      { hostname: "media.api-sports.io" },
      { hostname: "*.supabase.co" },
      { hostname: "flagcdn.com" },
    ],
  },
};

export default nextConfig;
