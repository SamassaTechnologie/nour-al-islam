/** Motif de l'etoile a huit branches, trace uniquement avec des formes geometriques. */
export function Lattice({ id, className = "" }: { id: string; className?: string }) {
  return (
    <svg aria-hidden="true" className={`pointer-events-none absolute inset-0 h-full w-full ${className}`}>
      <defs>
        <pattern id={id} width="48" height="48" patternUnits="userSpaceOnUse">
          <path
            d="M24 7 41 24 24 41 7 24ZM12 12h24v24H12ZM0 0l12 12M48 0 36 12M0 48l12-12M48 48 36 36M24 0v7M24 41v7M0 24h7M41 24h7"
            fill="none"
            stroke="var(--gold)"
            strokeWidth="0.75"
          />
        </pattern>
      </defs>
      <rect width="100%" height="100%" fill={`url(#${id})`} />
    </svg>
  );
}

export function Star({ className = "" }: { className?: string }) {
  return (
    <svg aria-hidden="true" viewBox="0 0 24 24" className={className}>
      <path fill="currentColor" d="M12 1.5 15.2 4.8h4v4L22.5 12l-3.3 3.2v4h-4L12 22.5l-3.2-3.3h-4v-4L1.5 12l3.3-3.2v-4h4Z" />
    </svg>
  );
}

const stroke = {
  fill: "none",
  stroke: "currentColor",
  strokeWidth: 1.6,
  strokeLinecap: "round" as const,
  strokeLinejoin: "round" as const,
};

export type IconName = "home" | "quran" | "learn" | "prayer" | "profile" | "sun" | "moon" | "auto";

export function Icon({ name, className = "h-6 w-6" }: { name: IconName; className?: string }) {
  const paths: Record<IconName, React.ReactNode> = {
    home: <path d="M4 21V11.5C4 8 8.5 6 12 2.5 15.5 6 20 8 20 11.5V21ZM9.5 21v-5.5a2.5 2.5 0 0 1 5 0V21" />,
    quran: <path d="M12 6.5C10 4.8 7 4.3 3 4.5v14c4-.2 7 .3 9 2 2-1.7 5-2.2 9-2v-14c-4-.2-7 .3-9 2Zm0 0v14" />,
    learn: <path d="M4 4.5h16v12H10l-4.5 3.5v-3.5H4ZM8.5 9h7M8.5 12.5h4.5" />,
    prayer: <path d="M12 2v3M9 8c0-1.7 1.3-3 3-3s3 1.3 3 3M8 8h8l1 3H7ZM8.5 11v10M15.5 11v10M5 21h14" />,
    profile: <path d="M12 12a4 4 0 1 0 0-8 4 4 0 0 0 0 8ZM4.5 21c.6-4 3.5-6 7.5-6s6.9 2 7.5 6" />,
    sun: <path d="M12 16.5a4.5 4.5 0 1 0 0-9 4.5 4.5 0 0 0 0 9ZM12 2v2M12 20v2M2 12h2M20 12h2M5 5l1.4 1.4M17.6 17.6 19 19M19 5l-1.4 1.4M6.4 17.6 5 19" />,
    moon: <path d="M20 14.5A8.5 8.5 0 0 1 9.5 4 8.5 8.5 0 1 0 20 14.5Z" />,
    auto: <path d="M12 3a9 9 0 1 0 0 18 9 9 0 0 0 0-18Zm0 0v18M12 8l4.5-3.5M12 13l8-5M12 18l7-4" />,
  };
  return (
    <svg aria-hidden="true" viewBox="0 0 24 24" className={className} {...stroke}>
      {paths[name]}
    </svg>
  );
}
