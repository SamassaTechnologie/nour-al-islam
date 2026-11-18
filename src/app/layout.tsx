import type { Metadata, Viewport } from "next";
import type { ReactNode } from "react";
import { AppHeader, BottomNav } from "@/components/shell";
import { getPreferences } from "@/lib/preferences";
import { getSession } from "@/lib/supabase/server";
import "./globals.css";

export const metadata: Metadata = {
  title: { default: "NOUR AL-ISLAM by SAMASSA TECHNOLOGIE", template: "%s | NOUR AL-ISLAM" },
  description: "Apprendre, comprendre et pratiquer l’Islam à la lumière du Coran et de la Sounnah.",
  applicationName: "NOUR AL-ISLAM",
  appleWebApp: { capable: true, title: "Nour al-Islam", statusBarStyle: "black-translucent" },
  icons: {
    icon: [{ url: "/favicon.svg", type: "image/svg+xml" }],
    apple: [{ url: "/icons/apple-touch-icon.png", sizes: "180x180" }],
  },
  formatDetection: { telephone: false },
};

export const viewport: Viewport = {
  width: "device-width",
  initialScale: 1,
  viewportFit: "cover",
  themeColor: [
    { media: "(prefers-color-scheme: light)", color: "#06382c" },
    { media: "(prefers-color-scheme: dark)", color: "#041b15" },
  ],
};

export default async function RootLayout({ children }: { children: ReactNode }) {
  const [{ locale, theme, t }, session] = await Promise.all([getPreferences(), getSession()]);
  return (
    <html lang={locale} dir={locale === "ar" ? "rtl" : "ltr"} data-theme={theme}>
      <body className="min-h-dvh">
        <AppHeader t={t} locale={locale} theme={theme} signedIn={Boolean(session)} />
        <div className="page-bottom">{children}</div>
        <BottomNav t={t} signedIn={Boolean(session)} />
      </body>
    </html>
  );
}
