-- pg_net dans le schema extensions (recommandation de securite de Supabase) ; ses fonctions restent dans net.
drop extension if exists pg_net;
create extension pg_net with schema extensions;
